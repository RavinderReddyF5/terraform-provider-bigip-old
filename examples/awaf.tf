
data "bigip_waf_entity_parameter" "Param1" {
  name            = "Param1"
  type            = "explicit"
  data_type       = "alpha-numeric"
  perform_staging = true
}

data "bigip_waf_entity_parameter" "Param2" {
  name            = "Param2"
  type            = "explicit"
  data_type       = "alpha-numeric"
  perform_staging = true
}

data "bigip_waf_entity_parameter" "Param3" {
  name            = "Param3"
  type            = "explicit"
  data_type       = "alpha-numeric"
  perform_staging = true
}

data "bigip_waf_entity_url" "URL" {
  name     = "URL1"
  protocol = "http"
}

data "bigip_waf_entity_url" "URL2" {
  name = "URL2"
}

data "bigip_waf_entity_url" "URL3" {
  name = "URL3"
}

data "bigip_waf_entity_url" "URL4" {
  name = "URL4"
}

data "bigip_waf_signatures" "WAFSIG1" {
  signature_id = 200101595
  perform_staging = false
  enabled = true
}

data "bigip_waf_signatures" "WAFSIG2" {
  signature_id = 200101559
  perform_staging = false
  enabled = true
}

//
//data "bigip_waf_signatures" "WAFSIG1" {
//  signature_id = 123456
//  perform_staging = true
//  enabled = true
//}


resource "bigip_waf_policy" "test-awaf" {
  name                 = "/Common/testpolicyravi"
  template_name        = "POLICY_TEMPLATE_API_SECURITY"
  application_language = "utf-8"
  enforcement_mode     = "blocking"
  description          = "Rapid Deployment-2"
  server_technologies  = ["MySQL", "Unix/Linux", "MongoDB"]
//  signatures = [data.bigip_waf_signatures.WAFSIG1.json]
  signatures = [data.bigip_waf_signatures.WAFSIG1.json,data.bigip_waf_signatures.WAFSIG2.json]
//  parameters           = [data.bigip_waf_entity_parameter.Param1.json, data.bigip_waf_entity_parameter.Param2.json]
//  urls                 = [data.bigip_waf_entity_url.URL.json, data.bigip_waf_entity_url.URL2.json]
//  open_api_files = ["https://api.swaggerhub.com/apis/F5EMEASSA/Arcadia-OAS3/2.0.0-oas3"]
//  open_api_files = ["https://app.swaggerhub.com/apis/Masmovil/mas-ticketing-api/2.0.3"]
  //  urls                 = [data.bigip_waf_entity_url.URL.json, data.bigip_waf_entity_url.URL2.json, data.bigip_waf_entity_url.URL3.json]
  //  modifications        = [data.bigip_waf_entity_url.URL3.json]
  //  policy_json          = bigip_waf_policy.test-awaf-import.policy_json
}


//
//data "bigip_waf_pb_suggestions" "PBWAF1" {
//  policy_name            = "testpolicyravi"
//  partition              = "Common"
//  minimum_learning_score = 20
//}

//


data "bigip_waf_policy" "policyexist" {
  policy_id = bigip_waf_policy.test-awaf.id
}

// ### EXAMPLE 2
resource "bigip_waf_policy" "test-awaf-new" {
  name               = "/Common/testpolicyravinew"
  template_name      = "POLICY_TEMPLATE_RAPID_DEPLOYMENT"
  parameters           = [data.bigip_waf_entity_parameter.Param3.json]
  urls               = [data.bigip_waf_entity_url.URL3.json,data.bigip_waf_entity_url.URL4.json]
  policy_import_json = data.bigip_waf_policy.policyexist.policy_json
}
