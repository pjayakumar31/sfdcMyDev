public class ExceptionLogUtil{

    //@future
    public static void createExceptionLog(String errorMessage){
        System.debug('&&& in create Exception log method');
        insert New Exception_Log__c(Error_Message__c = errorMessage);
    }
    
    public static void createExceptionLog(Exception e){
        
        Exception_Log__c eLog = new Exception_Log__c();
        eLog.Error_Message__c = e.getMessage();
        eLog.Error_Details__c = e.getStackTraceString();
        eLog.Exception_Type__c = e.getTypeName();
        
        insert eLog;
    }
    
    public static void createExceptionLogs(Database.SaveResult[] saveResults, List<SObject> records, String ClassMethodName){
    
        List<Exception_Log__c> excLogList = new List<Exception_Log__c>();
        String objectApiName;
        if(!records.isEmpty()){
            String objectToken = String.valueOf(records[0].getSObjectType());
            Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            objectApiName = String.valueOf(schemaMap.get(objectToken));
        }
        for(Integer i=0; i<saveResults.size(); i++){
            if(!saveResults[i].success){
                Exception_Log__c eLog = new Exception_Log__c();
                eLog.Object_Name__c = objectApiName;
                eLog.Record_Id__c = records[i].Id;
                eLog.Class_Method_Name__c = ClassMethodName;
                eLog.Exception_Type__c = 'System.DMLException';
                eLog.Error_Message__c = '';
                for(Database.Error err : saveResults[i].getErrors()) {
                    eLog.Error_Message__c += err.getStatusCode() +' : '+err.getMessage();
                }
                excLogList.add(eLog);
            }
        }
        Database.insert(excLogList, false);
    }
    
}