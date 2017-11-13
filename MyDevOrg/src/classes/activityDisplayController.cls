public class activityDisplayController {
    public Account acc{get;set;}
    public List<Task> actList{get;set;}
    public List<ActivityHistory> actHist{get;set;}
    
    public activityDisplayController(ApexPages.StandardController controller) {
        This.acc =(Account)controller.getRecord();
        acc = [select id,name from account where id = :acc.id];
        System.debug('Test '+acc);
        actList = new List<Task>();
        Id uid = UserInfo.getUserId();
        User usr = new User();
        usr = [select id, User_Territory__c from user where id = :uid];
        actList = [select id, Activity_Territory__c from Task where Activity_Territory__c = :usr.User_Territory__c and Accountid = :acc.id ];
    }

}