open ByteCoverage
open E2j_Json

let data2json (data:data) =
  `O [
    "size" , to_hex data.size;
    "tag" , `String (tag_to_string data.tag);
    "range_start", to_hex data.range_start;
    "range_end", to_hex data.range_end;
    "extra", `String data.extra;
    "understood", `Bool data.understood;
  ]

let to_json coverage =
  let dataset:data list = ByteCoverage.to_list coverage.data in
  let data = `A (List.map (fun data -> data2json data) dataset) in
  `O
    [
      "data", data;
      "size", to_hex coverage.size;
      "tags", `A (List.map (fun a -> `String a) coverage.tags);
      "totalCoverage", to_hex coverage.total_coverage;
      "totalUnderstood", to_hex coverage.total_understood;
      "percentCoverage", `Float coverage.percent_coverage;
      "percentUnderstood", `Float coverage.percent_understood;
    ]
