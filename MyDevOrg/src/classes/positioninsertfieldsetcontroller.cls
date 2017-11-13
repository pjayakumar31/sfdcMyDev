public with sharing class positioninsertfieldsetcontroller {
public position__c obj{get;set;}
public positioninsertfieldsetcontroller(){
obj=new position__c();
}
public pagereference save()
{
insert obj;
return null;
}


}