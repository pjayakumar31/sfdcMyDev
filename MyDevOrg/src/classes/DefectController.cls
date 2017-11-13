public with sharing class DefectController {
       public list<defect__c> defectList { get; set; }
    
    public boolean lrender{get;set;}
    public boolean mreneder{get;set;}
    public boolean hrender{get;set;}
public list<defect__c> lowList { get; set; }
public list<defect__c> mediumList { get; set; }
public list<defect__c> highList { get; set; }


        public string projectnumber{get;set;}
public string stype{set;get;}
public DefectController()
{
}
public list<Selectoption> getProjs(){
  list<selectoption> options=new list<selectoption>();
  options.add(new selectoption('','--None--'));
    
    for(project__c p:[select id,Name from project__c where phase__c='Testing'])    
    {
 options.add(new selectoption(p.id,p.name))       ;
    }
    return options;    
}

public pagereference deflist(){
  
defectList=new list<defect__C>();
defectList=[Select d.Type__c, d.Severity__c,d.Name, d.project__c,d.Description__c, d.Defect_Name__c, d.CreatedDate,d.project__r.project_name__C, d.CreatedById From Defect__c d where d.project__c=:projectnumber  ];

lowList=new list<defect__c>();
mediumList=new list<defect__c>();
highList=new list<defect__c>();

for(defect__c d:defectList){
if(d.severity__c=='Low')
lowList.add(d);
if(d.severity__c=='Medium')
mediumList.add(d);
if(d.severity__c=='High')
highList.add(d);
}
if(!lowList.isempty())
lrender=true;
else lrender=false;
if(!mediumList.isempty())
mreneder=true;
else mreneder=false;
if(!highList.isempty())
hrender=true;
else hrender=false;
return null;
}
}