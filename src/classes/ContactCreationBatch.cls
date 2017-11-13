global class ContactCreationBatch implements Database.Batchable<SObject> {
String query='select id,(select id,name from contacts ) from account';
Public Database.querylocator start(Database.batchableContext bc){
return Database.getQueryLocator(query);
}
Public void Execute(Database.batchableContext bc, list<Account> acclist)
{
list<Contact> contactlist=new list<contact>();
for(account a: acclist){
if(a.contacts==null)
{
Contact c = new contact();
c.accountId=a.id;
contactlist.add(c);
}
}
if(contactlist.size()>0){
insert contactlist;
}
}

Public void finish(database.batchableContext bc)
{
    List<string> maillist=new list<String>();
    maillist.add('jayakumar.pillala@cognizant.com');
    messaging.SingleEmailMessage mail= new Messaging.SingleEmailMessage();
        mail.settoAddresses(maillist);         
        mail.setSubject('Mail from Salesforce');
        mail.setplaintextbody('Testing mail from your developer account buddy');
        Messaging.sendEmail(new messaging.SingleEmailMessage[]{mail} );
    
}

}