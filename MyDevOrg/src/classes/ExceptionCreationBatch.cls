global class ExceptionCreationBatch implements Database.Batchable<SObject>{

    global Database.QueryLocator start(Database.BatchableContext bc){
    
        return Database.getQueryLocator('select id from Account limit 5');
    }
    
    global void execute(Database.BatchableContext bc, List<SObject> scope){
    
        insert new Exception_Log__c(Error_Message__c = 'Testing Exception creation');
    }
    
    global void finish(Database.BatchableContext bc){
    
        
    }
}