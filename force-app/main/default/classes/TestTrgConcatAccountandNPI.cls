@isTest
private class TestTrgConcatAccountandNPI {
    @isTest static void TrgConcatText(){
        Account acct = new Account(Name='Test Account',NPI__c='12345678',InActive__C = true);
        Contact con = new Contact(LastName='Test Contact for trg');
        //insert acct;
        
        test.starttest();
        insert(acct);
        con.AccountId = acct.Id;
        insert(con);
        test.stopTest();
        Account a = [select AccountNPI__c from account where Name='Test Account' and NPI__c='12345678' limit 1];
        
        //System.assert(!res.isSuccess());
        system.assertEquals(a.AccountNPI__c,'Test Account 12345678');
        
    }
    
    @istest static void testInActiveContact(){
        Account acct = new Account(Name='Test Account 1',NPI__c='123456789');
        Contact con = new Contact(LastName='Test Contact for trg');
        insert(acct);
        con.AccountId = acct.Id;
        insert(con);
        
        acct.InActive__c = true;
        acct.NPI__c = '1234567890';
        test.startTest();
        update acct;
        test.stopTest();
        Contact c = [select IsActive__C from contact where LastName='Test Contact for trg' limit 1];
        Account a = [select AccountNPI__c from account where Name='Test Account 1' and NPI__c='1234567890' limit 1];
        system.assertEquals(c.IsActive__C,true);
        system.assertEquals(a.AccountNPI__c,'Test Account 1 1234567890');
        
        acct.InActive__c = false;
        update acct;
        c = [select IsActive__C from contact where LastName='Test Contact for trg' limit 1];
        system.assertEquals(c.IsActive__C,false);
        
    }
}