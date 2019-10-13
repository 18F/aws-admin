variable "dest_account_numbers" {
  description = "The account numbers you want to be able to switch into."
  # should include everything in
  # https://docs.google.com/spreadsheets/d/1DedSCiU9AsCAAVvAFZT0_Ii7AFIKlI-JNifzlpHNbDg/edit#gid=0
  default = [
    "001907687576",
    "034795980528",
    "096224847349",
    "133032889584",
    "144433228153",
    "195022191070",
    "213305845712",
    "312530187933",
    "340731855345",
    "405436375165",
    "461353137281",
    "469931042344",
    "541873662368",
    "555546682965",
    "560284223511",
    "570696747145",
    "587807691409",
    "699351240001",
    "765358534566",
    "894947205914",
    "992476103436",
  ]
}

variable "role_name" {
  default = "CrossAccountAdmin"
}
