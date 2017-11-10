public with sharing class OpportunityObjectTriggerClass2 {
	
	public static void assignTask(list<Account> acc)
	{
		list<Task> task=new list<Task>();
		for(Account aa:acc){
    		
    		if(aa.CreateTask__c){
    		Task tt=new Task();
    		tt.Subject='new account';
    		tt.Status='Not Started';
    		tt.Priority='High';
    		tt.OwnerId=aa.OwnerId;
    		//tt.WhoId=aa.OwnerId;
    		tt.WhatId=aa.Id;
    		task.add(tt);
    		}
    		
    	}
    	insert task;
    	
    }
		
		
	}