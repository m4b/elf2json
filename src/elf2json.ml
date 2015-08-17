open LibRdr.Utils

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

let minify = ref false
let raw = ref false
let include_code = ref false
let include_bytes = ref false
let binary = ref ""
let set_anon_argument string =
  binary := string

type config = {
  minify: bool;
  raw: bool;
  include_code: bool;
  include_bytes: bool;
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
    raw = !raw; 
    include_code = !include_code; 
    include_bytes = !include_bytes; 
    install_name; 
    name
  }

let to_raw binary = 
  (Array.init  (Bytes.length binary) (fun i ->
       Bytes.get binary i 
       |> Char.code
       |> E2j.Json.to_hex
     )) |> Array.to_list

let to_json config =
  let binary = get_bytes config.install_name in
  let elf = Elf.get ~meta_only:config.include_code binary in
  let header = E2j.Header.to_json config.raw elf.Elf.header in
  let program_headers = E2j.ProgramHeader.to_json config.raw elf.Elf.program_headers in
  let section_headers = E2j.SectionHeader.to_json config.raw elf.Elf.section_headers in
  let _dynamic = E2j.Dynamic.to_json config.raw elf.Elf._dynamic in
  let dynamic_symbols = E2j.Dynamic.dynamic_symbols2json config.raw elf.Elf.dynamic_symbols in
  let symbol_table = E2j.SymbolTable.to_json config.raw elf.Elf.symbol_table in
  let relocs = E2j.Reloc.to_json config.raw elf.Elf.relocations in
  let libraries = `A (List.map (fun lib -> `String lib)
                        elf.Elf.libraries)
  in
  let coverage = E2j.Coverage.to_json elf.Elf.byte_coverage in
  let raw = if (config.include_bytes) then
      (*       `A (to_raw binary) *)
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
      "libraries", libraries;
      "soname", `String elf.Elf.soname;
      "interpreter", `String elf.Elf.interpreter;
      "isLib", `Bool elf.Elf.is_lib;
      "is64", `Bool elf.Elf.is_64;
      "size", E2j_Json.to_number elf.Elf.size;
      "coverage", coverage;
      "raw", raw;
    ] in
  E2j.Json.print ~minify:config.minify json

let main =
  let speclist = 
    [("-m", Arg.Set minify, "Minify the json output; default false");
     ("--minify", Arg.Set minify, "Minify the json output; default false");
     ("-r", Arg.Set raw, "Output raw header and symbol bytes; default false");
     ("--raw", Arg.Set raw, "Output raw header and symbol bytes;; default false");
     ("-b", Arg.Set include_bytes, "Include all raw binary bytes; default false");
     ("--bytes", Arg.Set include_bytes, "Include all raw binary bytes; default false");
     ("-c", Arg.Set include_code, "Output raw code bytes; default false");
     ("--code", Arg.Set include_code, "Output raw code bytes; default false");
    ] in
  let usage_msg = "usage: elf2json [-r --raw] [-m --minify] [-c --code] <path_to_binary>\noptions:" in
  Arg.parse speclist set_anon_argument usage_msg;
  let config = init_config() in
  if (!binary = "") then
    begin
      Printf.eprintf "Error: no path to binary given\n";
      Arg.usage speclist usage_msg;
      exit 1
    end
  else
    to_json config
