public class uriRedirectJavaScript {
    
    public String targetPage{get;set;}
    public Position__c position{get;set;}
    public String type{get;set;}
    public Id positionId{get;set;}
    
    public uriRedirectJavaScript(ApexPages.StandardController controller) {
        this.position = (Position__c)controller.getRecord();
        this.position = [select id,type__c from Position__c where id = :position.Id];
        type = position.Type__c;
        positionId = position.Id;
    }

}