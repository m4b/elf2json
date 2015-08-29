# elf2json

Converts an ELF binary to a JSON representation, because it's 2015 and everything should be converted to JSON, and why not?

**New Features**

* `elf2json -o symbolTable` : selectively print keys from the JSON representation
* `symbolTable` and `dynamicSymbols` are now sorted by address.
* `slideSectors` key added, which is an object with `begin`, `end`, and `slide` fields which give values to subtract from the VM address of a symbol, to give its binary on-disk offset location (if it has one).

# Install

Easy:

```bash
opam install elf2json
```

Build and Install:

```bash
make && make install
```

or:

```bash
ocaml setup.ml -configure && ocaml setup.ml -build && sudo ocaml setup.ml -install
```

# Usage

Most basic:

`elf2json <path/to/binary>`

Minified:

`elf2json -m <binary>`

With base64 encoded binary:

`elf2json -b <binary>`

With byte-coverage analysis:

`elf2json -c <binary>`

# Example

```json
{
  "header": {
    "value": {
      "e_ident": {
        "ei_magic": "0x464c457f",
        "ei_class": "0x2",
        "ei_data": "0x1",
        "ei_version": "0x1",
        "ei_osabi": "0x0",
        "ei_abiversion": "0x0",
        "ei_pad": "0x0"
      },
      "e_type": "0x2",
      "e_machine": "0x3e",
      "e_version": "0x1",
      "e_entry": "0x400420",
      "e_phoff": "0x40",
      "e_shoff": "0x12f8",
      "e_flags": "0x0",
      "e_ehsize": "0x40",
      "e_phentsize": "0x38",
      "e_phnum": "0x8",
      "e_shentsize": "0x40",
      "e_shnum": "0x1e",
      "e_shstrndx": "0x1b",
      "machine": "X86_64",
      "type": "EXEC"
    },
    "meta": {
      "bytes": [
        16,
        2,
        2,
        4,
        8,
        8,
        8,
        4,
        2,
        2,
        2,
        2,
        2,
        2
      ],
      "prefix": "e_"
    }
  },
  "programHeaders": {
    "value": [
      {
        "p_type": "0x6",
        "p_flags": "0x5",
        "p_offset": "0x40",
        "p_vaddr": "0x400040",
        "p_paddr": "0x400040",
        "p_filesz": "0x1c0",
        "p_memsz": "0x1c0",
        "p_align": "0x8",
        "type": "PT_PHDR",
        "flags": "R+X"
      },
      {
        "p_type": "0x3",
        "p_flags": "0x4",
        "p_offset": "0x200",
        "p_vaddr": "0x400200",
        "p_paddr": "0x400200",
        "p_filesz": "0x1c",
        "p_memsz": "0x1c",
        "p_align": "0x1",
        "type": "PT_INTERP",
        "flags": "R"
      },
      {
        "p_type": "0x1",
        "p_flags": "0x5",
        "p_offset": "0x0",
        "p_vaddr": "0x400000",
        "p_paddr": "0x400000",
        "p_filesz": "0x714",
        "p_memsz": "0x714",
        "p_align": "0x200000",
        "type": "PT_LOAD",
        "flags": "R+X"
      },
      {
        "p_type": "0x1",
        "p_flags": "0x6",
        "p_offset": "0x718",
        "p_vaddr": "0x600718",
        "p_paddr": "0x600718",
        "p_filesz": "0x240",
        "p_memsz": "0x248",
        "p_align": "0x200000",
        "type": "PT_LOAD",
        "flags": "RW"
      },
      {
        "p_type": "0x2",
        "p_flags": "0x6",
        "p_offset": "0x730",
        "p_vaddr": "0x600730",
        "p_paddr": "0x600730",
        "p_filesz": "0x1e0",
        "p_memsz": "0x1e0",
        "p_align": "0x8",
        "type": "PT_DYNAMIC",
        "flags": "RW"
      },
      {
        "p_type": "0x4",
        "p_flags": "0x4",
        "p_offset": "0x21c",
        "p_vaddr": "0x40021c",
        "p_paddr": "0x40021c",
        "p_filesz": "0x44",
        "p_memsz": "0x44",
        "p_align": "0x4",
        "type": "PT_NOTE",
        "flags": "R"
      },
      {
        "p_type": "0x6474e550",
        "p_flags": "0x4",
        "p_offset": "0x5e8",
        "p_vaddr": "0x4005e8",
        "p_paddr": "0x4005e8",
        "p_filesz": "0x34",
        "p_memsz": "0x34",
        "p_align": "0x4",
        "type": "PT_GNU_EH_FRAME",
        "flags": "R"
      },
      {
        "p_type": "0x6474e551",
        "p_flags": "0x6",
        "p_offset": "0x0",
        "p_vaddr": "0x0",
        "p_paddr": "0x0",
        "p_filesz": "0x0",
        "p_memsz": "0x0",
        "p_align": "0x10",
        "type": "PT_GNU_STACK",
        "flags": "RW"
      }
    ],
    "meta": {
      "bytes": [
        4,
        4,
        8,
        8,
        8,
        8,
        8,
        8
      ],
      "prefix": "p_"
    }
  },
  "sectionHeaders": {
    "value": [
      {
        "sh_type": "0x0",
        "sh_flags": "0x0",
        "sh_addr": "0x0",
        "sh_offset": "0x0",
        "sh_size": "0x0",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x0",
        "sh_entsize": "0x0",
        "name": "",
        "type": "NULL"
      },
      {
        "sh_type": "0x1",
        "sh_flags": "0x2",
        "sh_addr": "0x400200",
        "sh_offset": "0x200",
        "sh_size": "0x1c",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x1",
        "sh_entsize": "0x0",
        "name": ".interp",
        "type": "PROGBITS"
      },
      {
        "sh_type": "0x7",
        "sh_flags": "0x2",
        "sh_addr": "0x40021c",
        "sh_offset": "0x21c",
        "sh_size": "0x20",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x4",
        "sh_entsize": "0x0",
        "name": ".note.ABI-tag",
        "type": "NOTE"
      },
      {
        "sh_type": "0x7",
        "sh_flags": "0x2",
        "sh_addr": "0x40023c",
        "sh_offset": "0x23c",
        "sh_size": "0x24",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x4",
        "sh_entsize": "0x0",
        "name": ".note.gnu.build-id",
        "type": "NOTE"
      },
      {
        "sh_type": "0x6ffffff6",
        "sh_flags": "0x2",
        "sh_addr": "0x400260",
        "sh_offset": "0x260",
        "sh_size": "0x1c",
        "sh_link": "0x5",
        "sh_info": "0x0",
        "sh_addralign": "0x8",
        "sh_entsize": "0x0",
        "name": ".gnu.hash",
        "type": "GNU_HASH"
      },
      {
        "sh_type": "0xb",
        "sh_flags": "0x2",
        "sh_addr": "0x400280",
        "sh_offset": "0x280",
        "sh_size": "0x60",
        "sh_link": "0x6",
        "sh_info": "0x1",
        "sh_addralign": "0x8",
        "sh_entsize": "0x18",
        "name": ".dynsym",
        "type": "DYNSYM"
      },
      {
        "sh_type": "0x3",
        "sh_flags": "0x2",
        "sh_addr": "0x4002e0",
        "sh_offset": "0x2e0",
        "sh_size": "0x54",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x1",
        "sh_entsize": "0x0",
        "name": ".dynstr",
        "type": "STRTAB"
      },
      {
        "sh_type": "0x6fffffff",
        "sh_flags": "0x2",
        "sh_addr": "0x400334",
        "sh_offset": "0x334",
        "sh_size": "0x8",
        "sh_link": "0x5",
        "sh_info": "0x0",
        "sh_addralign": "0x2",
        "sh_entsize": "0x2",
        "name": ".gnu.version",
        "type": "GNU_versym"
      },
      {
        "sh_type": "0x6ffffffe",
        "sh_flags": "0x2",
        "sh_addr": "0x400340",
        "sh_offset": "0x340",
        "sh_size": "0x20",
        "sh_link": "0x6",
        "sh_info": "0x1",
        "sh_addralign": "0x8",
        "sh_entsize": "0x0",
        "name": ".gnu.version_r",
        "type": "GNU_verneed"
      },
      {
        "sh_type": "0x4",
        "sh_flags": "0x2",
        "sh_addr": "0x400360",
        "sh_offset": "0x360",
        "sh_size": "0x18",
        "sh_link": "0x5",
        "sh_info": "0x0",
        "sh_addralign": "0x8",
        "sh_entsize": "0x18",
        "name": ".rela.dyn",
        "type": "RELA"
      },
      {
        "sh_type": "0x4",
        "sh_flags": "0x42",
        "sh_addr": "0x400378",
        "sh_offset": "0x378",
        "sh_size": "0x48",
        "sh_link": "0x5",
        "sh_info": "0xc",
        "sh_addralign": "0x8",
        "sh_entsize": "0x18",
        "name": ".rela.plt",
        "type": "RELA"
      },
      {
        "sh_type": "0x1",
        "sh_flags": "0x6",
        "sh_addr": "0x4003c0",
        "sh_offset": "0x3c0",
        "sh_size": "0x1a",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x4",
        "sh_entsize": "0x0",
        "name": ".init",
        "type": "PROGBITS"
      },
      {
        "sh_type": "0x1",
        "sh_flags": "0x6",
        "sh_addr": "0x4003e0",
        "sh_offset": "0x3e0",
        "sh_size": "0x40",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x10",
        "sh_entsize": "0x10",
        "name": ".plt",
        "type": "PROGBITS"
      },
      {
        "sh_type": "0x1",
        "sh_flags": "0x6",
        "sh_addr": "0x400420",
        "sh_offset": "0x420",
        "sh_size": "0x1a2",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x10",
        "sh_entsize": "0x0",
        "name": ".text",
        "type": "PROGBITS"
      },
      {
        "sh_type": "0x1",
        "sh_flags": "0x6",
        "sh_addr": "0x4005c4",
        "sh_offset": "0x5c4",
        "sh_size": "0x9",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x4",
        "sh_entsize": "0x0",
        "name": ".fini",
        "type": "PROGBITS"
      },
      {
        "sh_type": "0x1",
        "sh_flags": "0x2",
        "sh_addr": "0x4005d0",
        "sh_offset": "0x5d0",
        "sh_size": "0x15",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x4",
        "sh_entsize": "0x0",
        "name": ".rodata",
        "type": "PROGBITS"
      },
      {
        "sh_type": "0x1",
        "sh_flags": "0x2",
        "sh_addr": "0x4005e8",
        "sh_offset": "0x5e8",
        "sh_size": "0x34",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x4",
        "sh_entsize": "0x0",
        "name": ".eh_frame_hdr",
        "type": "PROGBITS"
      },
      {
        "sh_type": "0x1",
        "sh_flags": "0x2",
        "sh_addr": "0x400620",
        "sh_offset": "0x620",
        "sh_size": "0xf4",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x8",
        "sh_entsize": "0x0",
        "name": ".eh_frame",
        "type": "PROGBITS"
      },
      {
        "sh_type": "0xe",
        "sh_flags": "0x3",
        "sh_addr": "0x600718",
        "sh_offset": "0x718",
        "sh_size": "0x8",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x8",
        "sh_entsize": "0x0",
        "name": ".init_array",
        "type": "INIT_ARRAY"
      },
      {
        "sh_type": "0xf",
        "sh_flags": "0x3",
        "sh_addr": "0x600720",
        "sh_offset": "0x720",
        "sh_size": "0x8",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x8",
        "sh_entsize": "0x0",
        "name": ".fini_array",
        "type": "FINI_ARRAY"
      },
      {
        "sh_type": "0x1",
        "sh_flags": "0x3",
        "sh_addr": "0x600728",
        "sh_offset": "0x728",
        "sh_size": "0x8",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x8",
        "sh_entsize": "0x0",
        "name": ".jcr",
        "type": "PROGBITS"
      },
      {
        "sh_type": "0x6",
        "sh_flags": "0x3",
        "sh_addr": "0x600730",
        "sh_offset": "0x730",
        "sh_size": "0x1e0",
        "sh_link": "0x6",
        "sh_info": "0x0",
        "sh_addralign": "0x8",
        "sh_entsize": "0x10",
        "name": ".dynamic",
        "type": "DYNAMIC"
      },
      {
        "sh_type": "0x1",
        "sh_flags": "0x3",
        "sh_addr": "0x600910",
        "sh_offset": "0x910",
        "sh_size": "0x8",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x8",
        "sh_entsize": "0x8",
        "name": ".got",
        "type": "PROGBITS"
      },
      {
        "sh_type": "0x1",
        "sh_flags": "0x3",
        "sh_addr": "0x600918",
        "sh_offset": "0x918",
        "sh_size": "0x30",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x8",
        "sh_entsize": "0x8",
        "name": ".got.plt",
        "type": "PROGBITS"
      },
      {
        "sh_type": "0x1",
        "sh_flags": "0x3",
        "sh_addr": "0x600948",
        "sh_offset": "0x948",
        "sh_size": "0x10",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x8",
        "sh_entsize": "0x0",
        "name": ".data",
        "type": "PROGBITS"
      },
      {
        "sh_type": "0x8",
        "sh_flags": "0x3",
        "sh_addr": "0x600958",
        "sh_offset": "0x958",
        "sh_size": "0x8",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x1",
        "sh_entsize": "0x0",
        "name": ".bss",
        "type": "NOBITS"
      },
      {
        "sh_type": "0x1",
        "sh_flags": "0x30",
        "sh_addr": "0x0",
        "sh_offset": "0x958",
        "sh_size": "0x27",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x1",
        "sh_entsize": "0x1",
        "name": ".comment",
        "type": "PROGBITS"
      },
      {
        "sh_type": "0x3",
        "sh_flags": "0x0",
        "sh_addr": "0x0",
        "sh_offset": "0x97f",
        "sh_size": "0x108",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x1",
        "sh_entsize": "0x0",
        "name": ".shstrtab",
        "type": "STRTAB"
      },
      {
        "sh_type": "0x2",
        "sh_flags": "0x0",
        "sh_addr": "0x0",
        "sh_offset": "0xa88",
        "sh_size": "0x630",
        "sh_link": "0x1d",
        "sh_info": "0x2e",
        "sh_addralign": "0x8",
        "sh_entsize": "0x18",
        "name": ".symtab",
        "type": "SYMTAB"
      },
      {
        "sh_type": "0x3",
        "sh_flags": "0x0",
        "sh_addr": "0x0",
        "sh_offset": "0x10b8",
        "sh_size": "0x240",
        "sh_link": "0x0",
        "sh_info": "0x0",
        "sh_addralign": "0x1",
        "sh_entsize": "0x0",
        "name": ".strtab",
        "type": "STRTAB"
      }
    ],
    "meta": {
      "bytes": [
        4,
        4,
        8,
        8,
        8,
        8,
        4,
        4,
        8,
        8
      ],
      "prefix": "sh_"
    }
  },
  "_dynamic": {
    "value": [
      {
        "d_tag": "0x1",
        "d_un": "0x1",
        "name": "NEEDED"
      },
      {
        "d_tag": "0x1",
        "d_un": "0x16",
        "name": "NEEDED"
      },
      {
        "d_tag": "0xc",
        "d_un": "0x4003c0",
        "name": "INIT "
      },
      {
        "d_tag": "0xd",
        "d_un": "0x4005c4",
        "name": "FINI "
      },
      {
        "d_tag": "0x19",
        "d_un": "0x600718",
        "name": "INIT_ARRAY"
      },
      {
        "d_tag": "0x1b",
        "d_un": "0x8",
        "name": "INIT_ARRAYSZ"
      },
      {
        "d_tag": "0x1a",
        "d_un": "0x600720",
        "name": "FINI_ARRAY"
      },
      {
        "d_tag": "0x1c",
        "d_un": "0x8",
        "name": "FINI_ARRAYSZ"
      },
      {
        "d_tag": "0x6ffffef5",
        "d_un": "0x400260",
        "name": "GNU_HASH"
      },
      {
        "d_tag": "0x5",
        "d_un": "0x4002e0",
        "name": "STRTAB "
      },
      {
        "d_tag": "0x6",
        "d_un": "0x400280",
        "name": "SYMTAB "
      },
      {
        "d_tag": "0xa",
        "d_un": "0x54",
        "name": "STRSZ"
      },
      {
        "d_tag": "0xb",
        "d_un": "0x18",
        "name": "SYMENT "
      },
      {
        "d_tag": "0x15",
        "d_un": "0x0",
        "name": "DEBUG"
      },
      {
        "d_tag": "0x3",
        "d_un": "0x600918",
        "name": "PLTGOT "
      },
      {
        "d_tag": "0x2",
        "d_un": "0x48",
        "name": "PLTRELSZ"
      },
      {
        "d_tag": "0x14",
        "d_un": "0x7",
        "name": "PLTREL"
      },
      {
        "d_tag": "0x17",
        "d_un": "0x400378",
        "name": "JMPREL"
      },
      {
        "d_tag": "0x7",
        "d_un": "0x400360",
        "name": "RELA"
      },
      {
        "d_tag": "0x8",
        "d_un": "0x18",
        "name": "RELASZ "
      },
      {
        "d_tag": "0x9",
        "d_un": "0x18",
        "name": "RELAENT "
      },
      {
        "d_tag": "0x6ffffffe",
        "d_un": "0x400340",
        "name": "VERNEED"
      },
      {
        "d_tag": "0x6fffffff",
        "d_un": "0x1",
        "name": "VERNEEDNUM"
      },
      {
        "d_tag": "0x6ffffff0",
        "d_un": "0x400334",
        "name": "VERSYM"
      }
    ],
    "meta": {
      "bytes": [
        8,
        8
      ],
      "prefix": "d_"
    }
  },
  "dynamicSymbols": {
    "value": [
      {
        "st_name": "0x0",
        "st_info": "0x0",
        "st_other": "0x0",
        "st_shndx": "0x0",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "NOTYPE"
      },
      {
        "st_name": "0x20",
        "st_info": "0x12",
        "st_other": "0x0",
        "st_shndx": "0x0",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "printf",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "FUNC"
      },
      {
        "st_name": "0x27",
        "st_info": "0x12",
        "st_other": "0x0",
        "st_shndx": "0x0",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "__libc_start_main",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "FUNC"
      },
      {
        "st_name": "0x39",
        "st_info": "0x20",
        "st_other": "0x0",
        "st_shndx": "0x0",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "__gmon_start__",
        "visibility": "DEFAULT",
        "bind": "WEAK",
        "type": "NOTYPE"
      }
    ],
    "meta": {
      "bytes": [
        4,
        1,
        1,
        2,
        8,
        8
      ],
      "prefix": "st_"
    }
  },
  "symbolTable": {
    "value": [
      {
        "st_name": "0x23a",
        "st_info": "0x12",
        "st_other": "0x0",
        "st_shndx": "0xb",
        "st_value": "0x4003c0",
        "st_size": "0x0",
        "name": "_init",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "FUNC"
      },
      {
        "st_name": "0x220",
        "st_info": "0x20",
        "st_other": "0x0",
        "st_shndx": "0x0",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "_ITM_registerTMCloneTable",
        "visibility": "DEFAULT",
        "bind": "WEAK",
        "type": "NOTYPE"
      },
      {
        "st_name": "0x214",
        "st_info": "0x11",
        "st_other": "0x2",
        "st_shndx": "0x18",
        "st_value": "0x600958",
        "st_size": "0x0",
        "name": "__TMC_END__",
        "visibility": "HIDDEN",
        "bind": "GLOBAL",
        "type": "OBJECT"
      },
      {
        "st_name": "0x200",
        "st_info": "0x20",
        "st_other": "0x0",
        "st_shndx": "0x0",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "_Jv_RegisterClasses",
        "visibility": "DEFAULT",
        "bind": "WEAK",
        "type": "NOTYPE"
      },
      {
        "st_name": "0x1fb",
        "st_info": "0x12",
        "st_other": "0x0",
        "st_shndx": "0xd",
        "st_value": "0x400516",
        "st_size": "0x2d",
        "name": "main",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "FUNC"
      },
      {
        "st_name": "0x1ef",
        "st_info": "0x10",
        "st_other": "0x0",
        "st_shndx": "0x19",
        "st_value": "0x600958",
        "st_size": "0x0",
        "name": "__bss_start",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "NOTYPE"
      },
      {
        "st_name": "0x1e8",
        "st_info": "0x12",
        "st_other": "0x0",
        "st_shndx": "0xd",
        "st_value": "0x400420",
        "st_size": "0x2a",
        "name": "_start",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "FUNC"
      },
      {
        "st_name": "0x1e3",
        "st_info": "0x10",
        "st_other": "0x0",
        "st_shndx": "0x19",
        "st_value": "0x600960",
        "st_size": "0x0",
        "name": "_end",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "NOTYPE"
      },
      {
        "st_name": "0x1d3",
        "st_info": "0x12",
        "st_other": "0x0",
        "st_shndx": "0xd",
        "st_value": "0x400550",
        "st_size": "0x65",
        "name": "__libc_csu_init",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "FUNC"
      },
      {
        "st_name": "0x1c4",
        "st_info": "0x11",
        "st_other": "0x0",
        "st_shndx": "0xf",
        "st_value": "0x4005d0",
        "st_size": "0x4",
        "name": "_IO_stdin_used",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "OBJECT"
      },
      {
        "st_name": "0x1b7",
        "st_info": "0x11",
        "st_other": "0x2",
        "st_shndx": "0x18",
        "st_value": "0x600950",
        "st_size": "0x0",
        "name": "__dso_handle",
        "visibility": "HIDDEN",
        "bind": "GLOBAL",
        "type": "OBJECT"
      },
      {
        "st_name": "0x1a8",
        "st_info": "0x20",
        "st_other": "0x0",
        "st_shndx": "0x0",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "__gmon_start__",
        "visibility": "DEFAULT",
        "bind": "WEAK",
        "type": "NOTYPE"
      },
      {
        "st_name": "0x19b",
        "st_info": "0x10",
        "st_other": "0x0",
        "st_shndx": "0x18",
        "st_value": "0x600948",
        "st_size": "0x0",
        "name": "__data_start",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "NOTYPE"
      },
      {
        "st_name": "0x17c",
        "st_info": "0x12",
        "st_other": "0x0",
        "st_shndx": "0x0",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "__libc_start_main@@GLIBC_2.2.5",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "FUNC"
      },
      {
        "st_name": "0x168",
        "st_info": "0x12",
        "st_other": "0x0",
        "st_shndx": "0x0",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "printf@@GLIBC_2.2.5",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "FUNC"
      },
      {
        "st_name": "0x162",
        "st_info": "0x12",
        "st_other": "0x0",
        "st_shndx": "0xe",
        "st_value": "0x4005c4",
        "st_size": "0x0",
        "name": "_fini",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "FUNC"
      },
      {
        "st_name": "0x15b",
        "st_info": "0x10",
        "st_other": "0x0",
        "st_shndx": "0x18",
        "st_value": "0x600958",
        "st_size": "0x0",
        "name": "_edata",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "NOTYPE"
      },
      {
        "st_name": "0x150",
        "st_info": "0x20",
        "st_other": "0x0",
        "st_shndx": "0x18",
        "st_value": "0x600948",
        "st_size": "0x0",
        "name": "data_start",
        "visibility": "DEFAULT",
        "bind": "WEAK",
        "type": "NOTYPE"
      },
      {
        "st_name": "0x134",
        "st_info": "0x20",
        "st_other": "0x0",
        "st_shndx": "0x0",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "_ITM_deregisterTMCloneTable",
        "visibility": "DEFAULT",
        "bind": "WEAK",
        "type": "NOTYPE"
      },
      {
        "st_name": "0x124",
        "st_info": "0x12",
        "st_other": "0x0",
        "st_shndx": "0xd",
        "st_value": "0x4005c0",
        "st_size": "0x2",
        "name": "__libc_csu_fini",
        "visibility": "DEFAULT",
        "bind": "GLOBAL",
        "type": "FUNC"
      },
      {
        "st_name": "0x10e",
        "st_info": "0x1",
        "st_other": "0x0",
        "st_shndx": "0x17",
        "st_value": "0x600918",
        "st_size": "0x0",
        "name": "_GLOBAL_OFFSET_TABLE_",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "OBJECT"
      },
      {
        "st_name": "0xfb",
        "st_info": "0x0",
        "st_other": "0x0",
        "st_shndx": "0x12",
        "st_value": "0x600718",
        "st_size": "0x0",
        "name": "__init_array_start",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "NOTYPE"
      },
      {
        "st_name": "0xf2",
        "st_info": "0x1",
        "st_other": "0x0",
        "st_shndx": "0x15",
        "st_value": "0x600730",
        "st_size": "0x0",
        "name": "_DYNAMIC",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "OBJECT"
      },
      {
        "st_name": "0xe1",
        "st_info": "0x0",
        "st_other": "0x0",
        "st_shndx": "0x12",
        "st_value": "0x600720",
        "st_size": "0x0",
        "name": "__init_array_end",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "NOTYPE"
      },
      {
        "st_name": "0x0",
        "st_info": "0x4",
        "st_other": "0x0",
        "st_shndx": "0xfff1",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "FILE"
      },
      {
        "st_name": "0xd5",
        "st_info": "0x1",
        "st_other": "0x0",
        "st_shndx": "0x14",
        "st_value": "0x600728",
        "st_size": "0x0",
        "name": "__JCR_END__",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "OBJECT"
      },
      {
        "st_name": "0xc7",
        "st_info": "0x1",
        "st_other": "0x0",
        "st_shndx": "0x11",
        "st_value": "0x400710",
        "st_size": "0x0",
        "name": "__FRAME_END__",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "OBJECT"
      },
      {
        "st_name": "0x8",
        "st_info": "0x4",
        "st_other": "0x0",
        "st_shndx": "0xfff1",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "crtstuff.c",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "FILE"
      },
      {
        "st_name": "0xbf",
        "st_info": "0x4",
        "st_other": "0x0",
        "st_shndx": "0xfff1",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "other.c",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "FILE"
      },
      {
        "st_name": "0xa0",
        "st_info": "0x1",
        "st_other": "0x0",
        "st_shndx": "0x12",
        "st_value": "0x600718",
        "st_size": "0x0",
        "name": "__frame_dummy_init_array_entry",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "OBJECT"
      },
      {
        "st_name": "0x94",
        "st_info": "0x2",
        "st_other": "0x0",
        "st_shndx": "0xd",
        "st_value": "0x4004f0",
        "st_size": "0x0",
        "name": "frame_dummy",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "FUNC"
      },
      {
        "st_name": "0x6d",
        "st_info": "0x1",
        "st_other": "0x0",
        "st_shndx": "0x13",
        "st_value": "0x600720",
        "st_size": "0x0",
        "name": "__do_global_dtors_aux_fini_array_entry",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "OBJECT"
      },
      {
        "st_name": "0x5e",
        "st_info": "0x1",
        "st_other": "0x0",
        "st_shndx": "0x19",
        "st_value": "0x600958",
        "st_size": "0x1",
        "name": "completed.6650",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "OBJECT"
      },
      {
        "st_name": "0x48",
        "st_info": "0x2",
        "st_other": "0x0",
        "st_shndx": "0xd",
        "st_value": "0x4004d0",
        "st_size": "0x0",
        "name": "__do_global_dtors_aux",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "FUNC"
      },
      {
        "st_name": "0x35",
        "st_info": "0x2",
        "st_other": "0x0",
        "st_shndx": "0xd",
        "st_value": "0x400490",
        "st_size": "0x0",
        "name": "register_tm_clones",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "FUNC"
      },
      {
        "st_name": "0x20",
        "st_info": "0x2",
        "st_other": "0x0",
        "st_shndx": "0xd",
        "st_value": "0x400450",
        "st_size": "0x0",
        "name": "deregister_tm_clones",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "FUNC"
      },
      {
        "st_name": "0x13",
        "st_info": "0x1",
        "st_other": "0x0",
        "st_shndx": "0x14",
        "st_value": "0x600728",
        "st_size": "0x0",
        "name": "__JCR_LIST__",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "OBJECT"
      },
      {
        "st_name": "0x8",
        "st_info": "0x4",
        "st_other": "0x0",
        "st_shndx": "0xfff1",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "crtstuff.c",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "FILE"
      },
      {
        "st_name": "0x1",
        "st_info": "0x4",
        "st_other": "0x0",
        "st_shndx": "0xfff1",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "init.c",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "FILE"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x1a",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x19",
        "st_value": "0x600958",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x18",
        "st_value": "0x600948",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x17",
        "st_value": "0x600918",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x16",
        "st_value": "0x600910",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x15",
        "st_value": "0x600730",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x14",
        "st_value": "0x600728",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x13",
        "st_value": "0x600720",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x12",
        "st_value": "0x600718",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x11",
        "st_value": "0x400620",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x10",
        "st_value": "0x4005e8",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0xf",
        "st_value": "0x4005d0",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0xe",
        "st_value": "0x4005c4",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0xd",
        "st_value": "0x400420",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0xc",
        "st_value": "0x4003e0",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0xb",
        "st_value": "0x4003c0",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0xa",
        "st_value": "0x400378",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x9",
        "st_value": "0x400360",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x8",
        "st_value": "0x400340",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x7",
        "st_value": "0x400334",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x6",
        "st_value": "0x4002e0",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x5",
        "st_value": "0x400280",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x4",
        "st_value": "0x400260",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x3",
        "st_value": "0x40023c",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x2",
        "st_value": "0x40021c",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x3",
        "st_other": "0x0",
        "st_shndx": "0x1",
        "st_value": "0x400200",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "SECTION"
      },
      {
        "st_name": "0x0",
        "st_info": "0x0",
        "st_other": "0x0",
        "st_shndx": "0x0",
        "st_value": "0x0",
        "st_size": "0x0",
        "name": "",
        "visibility": "DEFAULT",
        "bind": "LOCAL",
        "type": "NOTYPE"
      }
    ],
    "meta": {
      "bytes": [
        4,
        1,
        1,
        2,
        8,
        8
      ],
      "prefix": "st_"
    }
  },
  "relocations": {
    "value": [
      {
        "r_offset": "0x600910",
        "r_info": "0x300000006",
        "r_addend": "0x0",
        "index": "0x3",
        "type": "0x6"
      },
      {
        "r_offset": "0x600930",
        "r_info": "0x100000007",
        "r_addend": "0x0",
        "index": "0x1",
        "type": "0x7"
      },
      {
        "r_offset": "0x600938",
        "r_info": "0x200000007",
        "r_addend": "0x0",
        "index": "0x2",
        "type": "0x7"
      },
      {
        "r_offset": "0x600940",
        "r_info": "0x300000007",
        "r_addend": "0x0",
        "index": "0x3",
        "type": "0x7"
      }
    ],
    "meta": {
      "bytes": [
        8,
        8,
        8
      ],
      "prefix": "r_"
    }
  },
  "libraries": [
    "libc.so.6",
    "lib/libc.so.6.sstrip"
  ],
  "soname": "",
  "interpreter": "/lib64/ld-linux-x86-64.so.2",
  "isLib": false,
  "is64": true,
  "size": 6776,
  "coverage": null,
  "base64": null
}
```
