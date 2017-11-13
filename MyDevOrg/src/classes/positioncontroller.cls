public with sharing class positioncontroller {
public Position__c sam{get;set;}
public  String positionId{get;set;}

public positioncontroller()
{
sam=new position__c();
}
public list<Selectoption> getPos(){
  list<selectoption> options=new list<selectoption>();
  options.add(new selectoption('','--None--'));
    
    for(position__c p:[select id,Name from position__c ])   
    {
 options.add(new selectoption(p.id,p.name))       ;
    }
    return options;    
}


 public List<Schema.FieldSetMember> getFields() {  
    return SObjectType.Position__c.FieldSets.sample.getFields();  
 } 
 
 public pagereference showDetail() { 
system.debug(positionId+'line 8 ------------------------------------');

 this.sam=positiondetail(positionId);

          return null;  
 } 
 
 private Position__c positiondetail(String posid){//Position__c pos_title
    
      String query = 'SELECT ';  
      for(Schema.FieldSetMember f : this.getFields()) {  
      query += f.getFieldPath() + ', ';  
       }
      query += 'Id FROM Position__c where Id = \''+posId+'\'';  //where Name := \''+posId+'\''
         return Database.query(query);  
       

  }
}