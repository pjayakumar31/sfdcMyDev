public with sharing class paginationcontroller {
 id projectid=null;
 public list<defect__c> defectList { get; set; } 
 public String projectids {get;set;}       
 public boolean lrender{get;set;}    
 public boolean mreneder{get;set;}    
 public boolean hrender{get;set;}
 public list<defect__c> lowList { get; set; }
 public list<defect__c> mediumList { get; set; }
 public list<defect__c> highList { get; set; }        
 public string projectnumber{get;set;}public string stype{set;get;}
 public boolean srender{get;set;} 


public integer total_size;
private integer counter=0;  //keeps track of the offset    
private integer list_size=5;
public paginationcontroller()
{
total_size=[select count() from project__c];
 projectid=System.currentPagereference().getParameters().get('id');
defectList=new list<defect__C>();


if(projectid!=null)
{
srender=true;
defectList=[Select d.Type__c, d.Severity__c,d.Name, d.project__c,d.Description__c, d.Defect_Name__c, d.CreatedDate,d.project__r.project_name__C, d.CreatedById From Defect__c d where d.project__r.id=:projectid  ];
lowList=new list<defect__c>();
mediumList=new list<defect__c>();
highList=new list<defect__c>();
for(defect__c d:defectList)
{
if(d.severity__c=='Low')
lowList.add(d);
if(d.severity__c=='Medium')
mediumList.add(d);
if(d.severity__c=='High')
highList.add(d);
}
if(!lowList.isempty())
lrender=true;
else 
lrender=false;

if(!mediumList.isempty())
mreneder=true;
else 
mreneder=false;

if(!highList.isempty())
hrender=true;
else 
hrender=false;

}



}

public project__c[] getProjectList()
{
project__c[] prolist=[select Name,Project_Name__c,phase__c,Id from project__c limit :list_size offset :counter];
return prolist;
}

public PageReference Beginning() { //user clicked beginning      
 counter = 0;
    srender=false;
       
 return null;   
  }   
  
   public PageReference Previous() { //user clicked previous button      
    counter -= list_size; 
    srender=false;
 
    return null;    
    }  
     
 public PageReference Next() { //user clicked next button      
        counter += list_size;      
           srender=false;
         return null;   
          }    
         
 public PageReference End() { //user clicked end      
  counter = total_size - math.mod(total_size, list_size);      
     srender=false;
   return null;   
    }   
 public pagereference Tester(){
 System.debug('Entered Tester method : ');
 return null;
 }   
}