open Elf.SectionHeader
open E2j_Json

let section_header2json sh =
  `O [
    "sh_type" , to_float sh.sh_type;
    "sh_flags", to_float sh.sh_flags;
    "sh_addr", to_float sh.sh_addr;
    "sh_offset", to_float sh.sh_offset;
    "sh_size", to_float sh.sh_size;
    "sh_link", to_float sh.sh_link;
    "sh_info", to_float sh.sh_info;
    "sh_addralign", to_float sh.sh_addralign;
    "sh_entsize", to_float sh.sh_entsize;
    "name", `String sh.name;
    "type", `String (shtype_to_string sh.sh_type);
  ]

let to_json ~raw:raw shs = 
  let json = Array.map section_header2json shs |> Array.to_list in
  let raw = if (raw) then 
      `String (Elf.SectionHeader.to_bytes shs)
    else
      `Null
  in
  let meta = 
    [
      "bytes", to_byte_array [4; 4; 8; 8; 8; 8; 4; 4; 8; 8;];
      "prefix", `String "sh_";
    ] in
  `O [
    "value",`A json;
    "raw", raw;
    "meta", `O meta;
  ]

