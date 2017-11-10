public with sharing class candidateinsertfieldsetcontroller {

public candidate__c obj{get;set;}
public candidateinsertfieldsetcontroller(){
obj=new candidate__c();
}
    public PageReference save() {
    insert obj;
    pagereference pf=new pagereference('/'+obj.id);
    
                   return pf;
                   
    }

}