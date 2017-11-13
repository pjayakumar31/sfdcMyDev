public with sharing class AccountsExtension {
 public Account acct{get;set;}
    public AccountsExtension(ApexPages.StandardController controller) {
      acct=[select Name,Rating,Test_Amount__c from Account where Id=:controller.getId()];
    }
 public pagereference home(){
 Pagereference url=new Pagereference('/home/home.jsp');
 return url;
 }



}