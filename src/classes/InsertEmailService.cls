Global class InsertEmailService  implements Messaging.InboundEmailHandler{
Global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope env ){
Case newcase = new Case();
newcase.subject = 'tester1';
newcase.description = 'Tester description';
insert newcase;

String obj = email.subject;
obj = 'position__c';
//Schema.SObjectDescribeResult sch = Schema.GetGlobalDescribe().  

Schema.SObjectType t = position__c.sobjecttype;//(Sobject)obj.SObjectType;
Schema.DescribeSObjectResult d = t.getDescribe();//Account.SObjectType.getDescribe();


Messaging.singleemailmessage mail = new Messaging.singleemailmessage();
//String addresses[];// = new String[]();
String[] address = new list<String>{'jayakumar.pillala@cognizant.com'};
mail.settoaddresses(address);
mail.setsubject('Sent from email handler');
mail.setHtmlBody('tester Description');
list<Messaging.SingleEmailMessage> mails = new list<Messaging.SingleEmailMessage>();
mails.add(mail);
Messaging.SendEmail(mails);
return new Messaging.InboundEmailResult();
}
}