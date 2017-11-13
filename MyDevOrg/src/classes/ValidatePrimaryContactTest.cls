@isTest
private class ValidatePrimaryContactTest {

    static testMethod void validationTest() {        
        Account newAccount=new Account(
        	Name = 'Testing Account');
        
        insert newAccount;
        
        Contact newContact1=new Contact(FirstName='Mic',
        LastName='Jsns',
        AccountId=newAccount.Id,
        Is_Primary__c=true);
        
        insert newContact1;
        
        test.startTest();
        
        Contact newContact=new Contact(
        FirstName='Michea',
        LastName='Js',
        AccountId=newAccount.Id,
        Is_Primary__c=true);
        
        Boolean dmlException=false;
       try{
        insert newContact;
       }
       catch(system.DMLException ex){
       	dmlException=true;
       }
       system.assertEquals(true,dmlException);
        
        test.stopTest();
        List<contact> assertList= [select Id from Contact where Id= :newContact.Id];
        system.assertEquals(true,assertList.isEmpty());
    }
    
    
    static testMethod void validationTest2() {        
        Account newAccount=new Account(
        	Name = 'Testing Account');
        
        insert newAccount;
        
        Contact newContact1=new Contact(FirstName='Mic',
        LastName='Jsns',
        AccountId=newAccount.Id,
        Is_Primary__c=true);
        
        insert newContact1;
        
        test.startTest();
        
        Contact newContact=new Contact(
        FirstName='Michea',
        LastName='Js',
        AccountId=newAccount.Id,
        Is_Primary__c=true);
        
        Boolean dmlException=false;
      // try{
        insert newContact;
     //  }
       //catch(system.DMLException ex){
       //	dmlException=true;
       //}
       list<Contact> assertList=[select Contact.Id from Contact where Id=:newContact.Id];
       system.assertEquals(true,assertList.isEmpty());
        
        //test.stopTest();
    }
    
    
    
    
    
    
}