trigger TrgChangeLeadOwner on Lead_Assignment__c (before insert,before update) {
    
    List<Lead_Assignment__c> leadAssignments = trigger.new;
    List<string> postalCodeList = new List<string>();
    
    for(Lead_Assignment__c al : leadAssignments)
    {
        postalCodeList.add(al.zip_code__c);
    }
    List<lead> leads = [select Id,OwnerId,postalCode from Lead where postalCode in :postalCodeList ];
   
        if(leads.size()>0){
            for(Lead_Assignment__c la : leadAssignments)
            {
                for(lead l : leads)
                {
                    if(la.zip_code__c == l.postalCode &&  l.ownerid != la.user__C)
                        l.ownerid = la.user__C;
                }
            }
            upsert leads;
        }
     
}