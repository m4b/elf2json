open Elf.Header
open E2j_Json

let ident2json ident =
  let json = 
    [
      "ei_magic", to_float ident.ei_magic;
      "ei_class", to_float ident.ei_class;
      "ei_data", to_float ident.ei_data;
      "ei_version", to_float ident.ei_version;
      "ei_osabi", to_float ident.ei_osabi;
      "ei_abiversion", to_float ident.ei_abiversion;
      "ei_pad", to_float ident.ei_pad;
    ] in
  `O json

let to_json ~raw:raw header = 
  let ident = "e_ident", ident2json header.e_ident in
  let raw = if (raw) then 
      `String (Elf.Header.to_bytes header)
    else
      `Null
  in
  let meta = 
    [
      "bytes", to_byte_array
        [16; 2; 2; 4; 8; 8;
         8; 4; 2; 2; 2; 2; 2; 2;];
      "prefix", `String "e_";
    ] in
  let json =
    [
      ident;
      "e_type" , to_float header.e_type;
      "e_machine", to_float header.e_machine;
      "e_version", to_float header.e_version;
      "e_entry", to_float header.e_entry;
      "e_phoff", to_float header.e_phoff;
      "e_shoff", to_float header.e_shoff;
      "e_flags", to_float header.e_flags;
      "e_ehsize", to_float header.e_ehsize;
      "e_phentsize", to_float header.e_phentsize;
      "e_phnum", to_float header.e_phnum;
      "e_shentsize", to_float header.e_shentsize;
      "e_shnum", to_float header.e_shnum;
      "e_shstrndx", to_float header.e_shstrndx;
      "machine", `String (Elf.Constants.machine_to_string header.e_machine);
      "type", `String (Elf.Constants.etype_to_string header.e_type);
    ] in
  `O [
    "value", `O json;
    "raw", raw;
    "meta", `O meta;
  ]
