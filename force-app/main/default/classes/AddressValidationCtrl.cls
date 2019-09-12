public with sharing class AddressValidationCtrl {
    public AddressValidationCtrl() {

    }

  /*  public void validateAddressBySmartyStreetAPI(BillingAddress billingAddress){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        let authId = '4975f34a-2bc6-beba-1e66-b36c34b489f2';
        let token = 'doEAytIKWFoaHLCNsn8W';
        request.setEndpoint('https://us-street.api.smartystreets.com/street-address?auth-id='+authId
        +'&auth-token='+token);
        request.setMethod('GET');
        HttpResponse response = new HttpResponse();

        if(response.getStatusCode() == '200')
        {
            system.debug(response.getbody());
        }
    }*/

    @AuraEnabled
public static String validateAddressBySmartyStreetAPI(BillingAddress__c billingAddress){
    String message = '';
    Http http = new Http();
     String authId = '4975f34a-2bc6-beba-1e66-b36c34b489f2';
        String token = 'doEAytIKWFoaHLCNsn8W';
HttpRequest request = new HttpRequest();
request.setEndpoint('https://us-street.api.smartystreets.com/street-address?auth-id='+authId
+'&auth-token='+token+'&'
+'street='+EncodingUtil.urlEncode(billingAddress.Street__c, 'UTF-8')
+'&state='+billingAddress.State__c
+'&zipcode='+billingAddress.Zip_Code__c
+'&candidates=10&match=invalid');

request.setMethod('GET');
HttpResponse response = http.send(request);
   
if (response.getStatusCode() == 200) {

List<Object> results = (List<Object>)JSON.deserializeUntyped(response.getBody());

     for (Object obj: results) {
         APIResponse res = (APIResponse)APIResponse.parse(JSON.serialize(obj));
        
         billingAddress.City__c = res.components.city_name;
         billingAddress.State__c = res.components.state_abbreviation;
         billingAddress.Street__c = res.delivery_line_1+' '+res.last_line;
         if(res.analysis.dpv_match_code == 'Y'){
             message = 'Confirmed; entire address was DPV confirmed deliverable.';
         } else if(res.analysis.dpv_match_code == 'N'){
             message = 'Not Confirmed; address could not be DPV confirmed as deliverable.';
         } else if(res.analysis.dpv_match_code == 'S'){
             message = 'Confirmed By Dropping Secondary; address was DPV confirmed by dropping all or part of the secondary info (apartment, suite, etc.).';
         } else if(res.analysis.dpv_match_code == 'D'){
             message = 'Confirmed - Missing Secondary Info; the address was DPV confirmed, but it is missing secondary information (apartment, suite, etc.).';
         } else{
             message = 'The address was not submitted for DPV. This is usually because the address does not have a ZIP Code and a +4 add-on code, or the address has already been determined to be Not Deliverable (only returned as part of the XML response).';
         }
    
     }
      insert billingAddress;

return message;
}
return '';
}
}
