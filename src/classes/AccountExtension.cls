public with sharing class AccountExtension {
 public Account acct{get;set;}
    public AccountExtension(ApexPages.StandardController controller) {
      acct=[select Name,Rating,Test_Amount__c from Account where Id=:controller.getId()];
    }
 public pagereference home(){
 Pagereference url=new Pagereference('/home/home.jsp');
 return url;
 }

}