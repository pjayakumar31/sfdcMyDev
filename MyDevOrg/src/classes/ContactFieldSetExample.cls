Public Class ContactFieldSetExample{
    //List<Schema.FieldSetMember> contactfields = new List<Schema.FieldSetMember>();
    Public Contact con{get;set;}
    Public ContactFieldSetExample(){
        this.con = ContactRetreiver();
    }
    Public Contact ContactRetreiver(){
      String query = 'Select ';
      for(Schema.FieldSetMember f: SObjectType.Contact.FieldSets.FirstFieldSet.getFields())
          query+= f.getFieldPath()+', ';
      query+='lastname from Contact limit 1';    
      return Database.query(query);      
    }
    //System.Debug('Jaya ');    
}