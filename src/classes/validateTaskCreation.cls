@isTest
private class validateTaskCreation {

   
    	static testMethod void myUnitTest2() {
        // TO DO: implement unit test
        List<Account> accountList = new List<Account>();
        for(integer i=0;i<100;i++){
        	Account newAccount=new Account(Name ='Test Account'+i,CreateTask__c=false);
        	accountList.add(newAccount);
        }
        
        test.startTest();
        insert accountList;
        test.stopTest();
        List<Task> assertList=[select Id from Task where Task.WhatId IN :accountList];
        System.assertEquals(true,assertList.isEmpty());
    }
    
    
   static testMethod void myUnitTest3() {
        // TO DO: implement unit test
        List<Account> accountList = new List<Account>();
        for(integer i=0;i<100;i++){
        	Account newAccount=new Account(Name ='Test Account'+i,CreateTask__c=true);
        	accountList.add(newAccount);
        }
        
        test.startTest();
        insert accountList;
        test.stopTest();
        List<Task> assertList=[select Id from Task where Task.WhatId IN :accountList];
        System.assertEquals(accountList.size(),assertList.size());
    }
     
    
}