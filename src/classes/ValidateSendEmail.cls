@isTest
private class ValidateSendEmail {

    static testMethod void validationTest1() {
	Account newAccount=new Account(
	Name='HDFC' );
	 
	 test.startTest();
	 insert newAccount;
	 test.stopTest();
	list<Task> taskList=[select Id from Task where WhatId=:newAccount.Id]; 
	system.assertEquals(false,taskList.isEmpty());
	    	
        
    }
    
    
    
    static testMethod void validationTest2() {
	
	 List<Account> accountList = new List<Account>();
	 integer i=0;
        for(i=0;i<100;i++){
        	Account newAccount=new Account(Name ='Test Account'+i);
        	accountList.add(newAccount);
        }
	 test.startTest();
	 insert accountList;
	 test.stopTest();
	 
	 
	list<Task> taskList=[select Id from Task where WhatId IN :accountList]; 
	
	system.assertEquals(accountList.size(),taskList.size()); }
	    	
        
    
    
    
    
    
}