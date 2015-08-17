open Elf.ProgramHeader
open E2j_Json

let program_header2json ph =
  `O [
    "p_type" , to_float ph.p_type;
    "p_flags", to_float ph.p_flags;
    "p_offset", to_float ph.p_offset;
    "p_vaddr", to_float ph.p_vaddr;
    "p_paddr", to_float ph.p_paddr;
    "p_filesz", to_float ph.p_filesz;
    "p_memsz", to_float ph.p_memsz;
    "p_align", to_float ph.p_align;
    "type", `String (ptype_to_string ph.p_type);
    "flags", `String (flags_to_string ph.p_flags);
  ]

let to_json ~raw:raw phs = 
  let json = List.map program_header2json phs in
  let raw = if (raw) then 
      `String (Elf.ProgramHeader.to_bytes phs)
    else
      `Null 
  in
  let meta = 
    [   
      "bytes", to_byte_array [4; 4; 8; 8; 8; 8; 8; 8;];
      "prefix", `String "p_";
    ] in
  `O [
    "value",`A json;
    "raw", raw;
    "meta", `O meta;
  ]

