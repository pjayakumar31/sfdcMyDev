@isTest
Public class ExceptionLogUtilTest{

    public static testmethod void testExceptionLogsCreation(){
        
        // Using Exception Log records to generate the errors because this object do not have any mandatory fields. We can use any object for insertion.
        List<Exception_Log__c> insertList = new List<Exception_Log__c>();
        List<Exception_Log__c> excLogList = new List<Exception_Log__c>();
        for(Integer i=0; i<5; i++){
            insertList.add(new Exception_Log__c());
        }    
        insert insertList;
        Database.saveResult[] saveResults = Database.insert(insertList, false);
        ExceptionLogUtil.createExceptionLogs(saveResults, insertList, 'TestClass');
        excLogList = [Select id, Object_Name__c, Record_Id__c from Exception_Log__c where Object_Name__c = 'Exception_Log__c']; 
        System.assert(excLogList.size()==5);
        System.assert(excLogList[0].Object_Name__c == 'Exception_Log__c');
        System.assert(excLogList[0].Record_Id__c != null);
    }
    
    public static testmethod void testExceptionLogCreation(){
        
        List<Exception_Log__c> excLogList = new List<Exception_Log__c>();
        try{
            List<Exception_Log__c> insertList = new List<Exception_Log__c>();
            String name = insertList[0].Name;
        }
        Catch(Exception e){
            ExceptionLogUtil.createExceptionLog(e);
            excLogList = [Select id, Error_Message__c, Error_Details__c from Exception_Log__c];
            System.assert(excLogList.size()>0);
            System.assert(excLogList[0].Error_Message__c != null);
            System.assert(excLogList[0].Error_Details__c != null);
        }
    }
}