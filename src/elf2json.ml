open LibRdr.Utils

let version = "v1.0.0"

let goblin = Goblin.Symbol.Export

let get_bytes filename = 
  let ic = open_in_bin filename in
  if (in_channel_length ic < 4) then
    begin
      E2j.Json.print ~minify:false
        (`O ["error",
             `String "File too small (< 4 bytes)\n"]);
      exit 1
    end
  else
    let magic = if (Sys.big_endian) then 
        Input.input_i32 ic
      else 
        Input.input_i32be ic in
    if (magic <> Elf.Header.kMAGIC_ELF) then
      begin
        E2j.Json.print ~minify:false 
          (`O ["error",
               `String "This is _not_ an ELF binary!\n"]);
        exit 1
      end
    else
      begin
        seek_in ic 0;
        let binary = Bytes.create (in_channel_length ic) in
        really_input ic binary 0 (in_channel_length ic);
        close_in ic;
        if (Elf.Header.check_64bit binary) then
          binary
        else
          begin
            E2j.Json.print ~minify:false 
              (`O ["error",
                   `String "Not a 64-bit ELF binary, sorry\n"]);
            exit 1
          end
      end

let print_version = ref false
let minify = ref false
let include_coverage = ref false
let include_base64 = ref false
let binary = ref ""
let set_anon_argument string =
  binary := string

type config = {
  minify: bool;
  include_coverage: bool;
  include_base64: bool;
  install_name: string;
  name: string;
}

let init_config () =
  let install_name =
    if (Filename.is_relative !binary) then
      (Sys.getcwd()) ^ Filename.dir_sep ^ !binary
    else
      !binary
  in
  let name = Filename.basename install_name in
  {
    minify = !minify; 
    include_coverage = !include_coverage; 
    include_base64 = !include_base64;
    install_name; 
    name
  }

let sort symbols =
  List.sort (fun a b ->
      Pervasives.compare a.Elf.SymbolTable.st_value b.Elf.SymbolTable.st_value
    ) symbols

let slide_sectors_to_json ss =
  `A (List.map (fun elem ->
      `O [("begin", E2j.Json.to_hex elem.Elf.ProgramHeader.start_sector);
          ("end", E2j.Json.to_hex elem.Elf.ProgramHeader.end_sector);
          ("slide", E2j.Json.to_hex elem.Elf.ProgramHeader.slide);
         ]
    ) ss)

let to_json config =
  let binary = get_bytes config.install_name in
  let elf = Elf.get ~meta_only:true binary in
  let header = E2j.Header.to_json elf.Elf.header in
  let program_headers = E2j.ProgramHeader.to_json elf.Elf.program_headers in
  let section_headers = E2j.SectionHeader.to_json  elf.Elf.section_headers in
  let _dynamic = E2j.Dynamic.to_json elf.Elf._dynamic in
  let dynamic_symbols = E2j.Dynamic.dynamic_symbols2json (elf.Elf.dynamic_symbols |> sort) in
  let symbol_table = E2j.SymbolTable.to_json (elf.Elf.symbol_table |> sort)in
  let relocs = E2j.Reloc.to_json elf.Elf.relocations in
  let libraries = `A (List.map (fun lib -> `String lib)
                        elf.Elf.libraries)
  in
  let slide_sectors = Elf.ProgramHeader.get_slide_sectors elf.Elf.program_headers
                    |> slide_sectors_to_json in
  let coverage = if (config.include_coverage) then
                   E2j.Coverage.to_json elf.Elf.byte_coverage
                 else
                   `Null
  in
  let b64 = if (config.include_base64) then
      `String (B64.encode binary)
    else
      `Null
  in
  let json =
    `O [
      "header", header;
      "programHeaders", program_headers;
      "sectionHeaders", section_headers;
      "_dynamic", _dynamic;
      "dynamicSymbols", dynamic_symbols;
      "symbolTable", symbol_table;
      "relocations", relocs;
      "slideSectors", slide_sectors;
      "libraries", libraries;
      "soname", `String elf.Elf.soname;
      "interpreter", `String elf.Elf.interpreter;
      "isLib", `Bool elf.Elf.is_lib;
      "is64", `Bool elf.Elf.is_64;
      "size", E2j_Json.to_number elf.Elf.size;
      "coverage", coverage;
      "base64", b64;
    ] in
  E2j.Json.print ~minify:config.minify json

let main =
  let speclist = 
    [("-m", Arg.Set minify, "Minify the json output; default false");
     ("--minify", Arg.Set minify, "Minify the json output; default false");
     ("-b", Arg.Set include_base64, "Include the binary as a base64 encoded string; default false");
     ("--base64", Arg.Set include_base64, "Include the binary as a base64 encoded string; default false");
     ("-c", Arg.Set include_coverage, "Output data from the byte coverage algorithm; default false");
     ("--coverage", Arg.Set include_coverage, "Output data from the byte coverage algorithm; default false");
     ("-v", Arg.Set print_version, "Prints the version");     
    ] in
  let usage_msg = "usage: elf2json [-m --minify] [-b --base64] [-c --coverage] <path_to_binary>\noptions:" in
  Arg.parse speclist set_anon_argument usage_msg;
  let config = init_config() in
  if (!print_version) then
      Printf.printf "%s\n" @@ version
  else
    if (!binary = "") then
    begin
      Printf.eprintf "Error: no path to binary given\n";
      Arg.usage speclist usage_msg;
      exit 1
    end
  else
    to_json config
