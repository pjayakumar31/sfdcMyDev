public with sharing class SetContactToPrimary {
	
	public static void primaryContactSetter(list<Contact> newlist){
		list<Contact> conList=new list<Contact>();
		set<Id> idSet=new set<Id>();		
	
	//here we will have contacts for which is_primary__c is true for the same account
	for(Contact c:newList)
		{
			if(c.Is_Primary__c==true)
			{
		    conList.add(c);
			idSet.add(c.AccountId);
			}
		}
		
	//In this map we add accounts which has a primary contact
	//If the contact is not present in this map then its account  has no primary contact and we can make it primary contact 		
	map<Id,Contact> contactMap = new map<Id,Contact>();
	for(Contact c :[ select AccountId,Is_Primary__c from Contact 
				where Contact.AccountId IN :idSet and Contact.Is_Primary__c=true ]){
		contactMap.put(c.AccountId, c);				
	}				
	//returns all the primary contacts of the accountids present in the idset
	
	for(Contact c:conList)
	{	
		if(contactMap.containsKey(c.AccountId))
		{
		c.Is_Primary__c.addError('Primary Contact is already present for the contact ');
		}
	}		
	}

}