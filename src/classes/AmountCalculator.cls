global with sharing class AmountCalculator implements Database.Batchable<sObject> {
    global String query='select AccountId,Amount from Opportunity where AccountId!=null and Amount>0';   
    global Map<Id, Account> accountmap; 
    global AmountCalculator(){  
         accountmap = new Map<Id, Account> ();  
          } 
          
          global Database.QueryLocator start(Database.BatchableContext BC){      
            System.debug('Test');
            return Database.getQueryLocator(query);  
             }    
            
            global void execute(Database.BatchableContext BC, List<sObject> scope){  
                 List<Opportunity> ops = (List<Opportunity>)scope;  
                  for (Opportunity o : ops) {   
                    if (accountmap.containskey(o.AccountId)) { 
                          Account a = accountmap.get(o.AccountId);   
                          a.Test_Amount__c += o.Amount;  
                           accountmap.put(o.AccountId, a);   }  
                            else{  
                                 accountmap.put(o.AccountId, new Account (Id = o.AccountId, Test_Amount__c = o.Amount));  
                                  }  
                                   }  
                                    update accountmap.values();   
                                    }
                                    
                                    
                global void finish(Database.BatchableContext BC){  
                     AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,      TotalJobItems, CreatedBy.Email      FROM AsyncApexJob WHERE Id =      :BC.getJobId()];   
                     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();   
                     String[] toAddresses = new String[] {'pjayakumar31@gmail.com'};  
                      mail.setToAddresses(toAddresses);  
                       mail.setSubject('Opportunity Amount Calculation ' + a.Status);     
                       list<Account> accmaplist=accountmap.values();  
                       String mesgbody='<html><body><table border=1><tr><td>AccountId</td><td>Total Amount</td></tr>';
                       for(Account acc:accountmap.values()){
                        mesgbody+='<tr><td>';
                        mesgbody+=acc.Id+'</td><td>'+acc.Test_Amount__c+'</td></tr>';}
                        mesgbody+='</table></body></html>';  
                         /*mail.setHtmlBody(mesgbody);*/
                         mail.setPlainTextBody(mesgbody);   
                         Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  
                          }
                }