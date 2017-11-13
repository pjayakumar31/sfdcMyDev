trigger ClientTrigger on Client__c (before insert,after insert, before update, after update, after delete) {
    if(Trigger.isbefore){
       // ClientUtil.updateOpptyHandoffAttached(Trigger.New);
       //ClientUtil.updateOpportunityHandoffAttached(Trigger.New, Trigger.oldMap, Trigger.newMap, Trigger.IsInsert, Trigger.isUpdate, Trigger.isDelete);
       //ExceptionLogUtil.createExceptionLog('Testing Exception Log');
       Database.executeBatch(new ExceptionCreationBatch());
       //Trigger.New[0].addError('Testing exception log creation');
       
    }
}