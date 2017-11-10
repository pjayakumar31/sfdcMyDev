global class ContactCreateBatch implements Database.Batchable<sObject>{

public string query='select Id,name from Account where Id not In (select accountid from Contact)';
public Database.QueryLocator start(Database.BatchableContext bc)
{
return Database.getQueryLocator(query);
}

public void Execute(Database.BatchableContext bc, list<Account> acclist)
{
contact[] conlist = new list<contact>();
for(Account a : acclist)
{
Contact c = new Contact(LastName='testing',AccountId=a.id,email='con@domain.com');
conlist.add(c);
}
insert conlist;
}

public void finish(Database.BatchableContext BC){
   // Get the ID of the AsyncApexJob representing this batch job
   // from Database.BatchableContext.
   // Query the AsyncApexJob object to retrieve the current job's information.
   AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
      TotalJobItems, CreatedBy.Email
      FROM AsyncApexJob WHERE Id =
      :BC.getJobId()];
   // Send an email to the Apex job's submitter notifying of job completion.
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
   String[] toAddresses = new String[] {a.CreatedBy.Email};
   mail.setToAddresses(toAddresses);
   mail.setSubject('Apex Sharing Recalculation ' + a.Status);
   mail.setPlainTextBody
   ('The batch Apex job processed ' + a.TotalJobItems +
   ' batches with '+ a.NumberOfErrors + ' failures.');
   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}

}