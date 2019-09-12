trigger TrgLeadAssignment on Lead (before insert,before update) {
    List<Lead> leads = trigger.new;
    List<string> postalCodeList = new List<string>();
    for(lead l : leads)
    {
        postalCodeList.add(l.postalCode);
    }
    List<Lead_Assignment__c> leadAssignmentList = [select User__c,zip_code__c from Lead_Assignment__c where Zip_Code__c in :postalCodeList];
    
    if(leadAssignmentList.size() > 0){
        for(Lead l : leads )
        {
            for(Lead_Assignment__c la :leadAssignmentList)
            {
                 if(la.zip_code__c == l.postalCode &&  l.ownerid != la.user__C)
                l.OwnerId = la.User__c;
            }
        }
    }
    
}