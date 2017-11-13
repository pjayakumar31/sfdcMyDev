public with sharing class Sending {

public static void changeEmailOnChangeOfStage(list<Opportunity> newList,map<Id,Opportunity> oldMap)
{
	/*map<Id,User> userMap;
	list<User>	userList=[select Id,Email from User];
		for(User us:userList)
		userMap.put(us.Id,us.Email);*/
		
		//Messaging.Singleemailmessage[] mailList=new Messaging.Singleemailmessage[]{};
		list<Opportunity> processList =new list<Opportunity>();
		set<Id> ownerIdset=new set<Id>();
		for(Opportunity newOpp:newList){
			Opportunity oldOpp=oldMap.get(newOpp.Id);
			if(newOpp.StageName!=oldOpp.StageName)
			{
				processList.add(newOpp);
				
				
			}
		}
		
		
		
		
	for(Opportunity newOpp:newList){
		
		Opportunity oldOpp=oldMap.get(newOpp.Id);
		if(oldMap==null)
		{
			continue;
		}
		if(oldOpp.StageName!=newOpp.StageName)
		{
			
			            
			Messaging.reserveSingleEmailCapacity(1);
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            
          // String[] toAddresses = new String[] {(userMap.get(oldOpp.OwnerId)).Email};
             String[] toAddresses = new String[] {'pjayakumar31@gmail.com'};
            String[] ccAddress=new String[] {'maheshnaidu555@gmail.com'};
            

  mail.setToAddresses(toAddresses);
            mail.setCcAddresses(ccAddress);
            
            mail.setReplyTo('jayakumarpillala@gmail.com');
            
            mail.setSenderDisplayName('Support');
            
            mail.setSubject('Status changed : ');
            
            mail.setBccSender(false);
            
            mail.setUseSignature(false);
            
            mail.setPlainTextBody('Status changed from  ' + oldOpp.StageName +' to '+newOpp.StageName);
            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
       
		}
	}
}
}