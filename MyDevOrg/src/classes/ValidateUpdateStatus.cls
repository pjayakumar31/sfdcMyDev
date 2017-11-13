@isTest
private class ValidateUpdateStatus {

    static testMethod void sendingEmails() 
    {
    	
	Opportunity opp=new Opportunity(Name='Engineer',CloseDate=Date.today(),StageName='Prospecting');
	list<Opportunity> oppList=new list<Opportunity>();
	oppList.add(opp);
	insert oppList;
	
	Opportunity oppnew=new Opportunity(Name='Engineer',CloseDate=Date.valueOf('2013-03-09'),StageName='Qualification');
	list<Opportunity> oppLists=new list<Opportunity>();
	oppLists.add(oppnew);
	upsert oppLists;
	 
	//oppLists.remove();
	list<Opportunity> oppListss=new list<Opportunity>();
	oppListss=[select Name from Opportunity where Name='Engineer' and StageName='Qualification'];
    
    system.assertEquals(1, oppListss.size());
    
    }
}