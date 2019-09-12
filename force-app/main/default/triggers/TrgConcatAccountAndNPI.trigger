trigger TrgConcatAccountAndNPI on Account (before insert,before update) {
    List<Account> accounts = trigger.New;
    List<Contact> con = [select Id,IsActive__c,AccountId from Contact where accountid = :accounts];
    
    if(trigger.isInsert){
        for(Account a : accounts)
        {
            if(a.Name != '' && a.NPI__c != '')
            {
                a.AccountNPI__c = a.Name +' '+a.NPI__c;
            }
        }
    }
    else if(trigger.isupdate)
    {
        for(account a : accounts){
            Account ac = Trigger.oldMap.get( a.Id );
            
            if( ac.Name != a.Name || ac.NPI__c != a.NPI__c)
            {
                a.AccountNPI__c = a.Name +' '+a.NPI__c;
            }
            if(ac.InActive__c != a.InActive__c ){
                if(a.InActive__c == true)
                {
                    for(contact co : con){
                        if(co.AccountId == a.Id)
                            co.IsActive__c = true;
                    }
                }
                else if(a.InActive__c == false)
                {
                    for(contact co : con){
                        if(co.AccountId == a.Id)
                            co.IsActive__c = false;
                    }
                }
                update con;
            }
            
        }
    }
}