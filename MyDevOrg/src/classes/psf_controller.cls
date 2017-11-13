public with sharing class psf_controller {
public position__c obj{get;set;}
public Id positionId{set;get;}
public list<position__c> poslist{get;set;}
public boolean listrender{get;set;}
public boolean searchrender{get;set;}


public list<Selectoption> getPos(){
  list<selectoption> options=new list<selectoption>();
  options.add(new selectoption('','--None--'));
    
    for(position__c p:[select id,Name from position__c ])   
    {
 options.add(new selectoption(p.id,p.name))       ;
    }
    return options;    
}


    public PageReference showdetail() {
    searchrender=true;
    listrender=false;
    obj=new position__c();
    obj=this.positiondetails(positionId);
        return null;
    }
    public psf_controller()
    {
    listrender=false;
    searchrender=false;
        }
    
    public pagereference list_positions()
    {
    listrender=true;
    searchrender=false;
    poslist=new list<position__c>();
    string query=pre_query();
    poslist=database.query(query);
    return null;
    }
    
    private string pre_query(){
    
    String query = 'SELECT ';  
      for(Schema.FieldSetMember f : SObjectType.Position__c.FieldSets.information.getFields()) {  
      query += f.getFieldPath() + ', ';  
       }

for(Schema.FieldSetMember f : SObjectType.Position__c.FieldSets.compensation.getFields()) {  
      query += f.getFieldPath() + ', ';  
       }

for(Schema.FieldSetMember f : SObjectType.Position__c.FieldSets.description.getFields()) {  
      query += f.getFieldPath() + ', ';  
       }

for(Schema.FieldSetMember f : SObjectType.Position__c.FieldSets.required_languages.getFields()) {  
      query += f.getFieldPath() + ', ';  
       }

      query += 'Id FROM Position__c ';  //where Name := \''+posId+'\''
 return query;
    
    }
    
     public List<Schema.FieldSetMember> getFields() {  
    return SObjectType.Position__c.FieldSets.sample.getFields();  
     }
    
 private position__c positiondetails(Id posid){
  String query = 'SELECT ';  
      for(Schema.FieldSetMember f : SObjectType.Position__c.FieldSets.information.getFields()) {  
      query += f.getFieldPath() + ', ';  
       }

for(Schema.FieldSetMember f : SObjectType.Position__c.FieldSets.compensation.getFields()) {  
      query += f.getFieldPath() + ', ';  
       }

for(Schema.FieldSetMember f : SObjectType.Position__c.FieldSets.description.getFields()) {  
      query += f.getFieldPath() + ', ';  
       }

for(Schema.FieldSetMember f : SObjectType.Position__c.FieldSets.required_languages.getFields()) {  
      query += f.getFieldPath() + ', ';  
       }

      query += 'Id FROM Position__c where Id = \''+posId+'\'';  //where Name := \''+posId+'\''
         return Database.query(query);  
   }

}