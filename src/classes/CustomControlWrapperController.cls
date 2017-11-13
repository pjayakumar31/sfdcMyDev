public with sharing class CustomControlWrapperController {
    public string name{get;set;}
    

//represents the check boxes in the page    
    public boolean cases{get;set;}
    public boolean leads{get;set;}
    public boolean opportunities{get;set;}
    public boolean accounts{get;set;}
    public boolean contacts{get;set;}

//boolean values whether there are any values of accounts,contacts,opps,leads,cases exist or not..
    public boolean arender{get;set;}
    public boolean crender{get;set;}
    public boolean orender{get;set;}
    public boolean lrender{get;set;}
    public boolean corender{get;set;}
    

//list of those records
    public list<case> caseList{get;set;}
    public list<Lead> leadList{get;set;}
    public list<Opportunity> oppList{get;set;}
    public list<Account> accList{get;set;}
    public list<Contact> conList{get;set;}
   
    public list<CustomControlWrapper> ccwList{get;set;}
   
       public  class CustomControlWrapper{
        public boolean selected{get;set;}
        public Opportunity opp{get;set;}
        
        public CustomControlWrapper(Opportunity o){
        this.selected=false;
        this.opp=o;
     } 
     
    }
 
    public CustomControlWrapperController(){
        //Opportunity o=new Opportunity();
      //  CustomControlWrapper ccw=new CustomControlWrapper(o);   
        
                //name=Apexpages.currentPage().getParameters().get('Account Name');this is only for query string parameter
                cases=false;
                leads=false;
                opportunities=true;
                accounts=true;
                contacts=true;
    }
   
    public PageReference search() {
    caseList=new List<Case>();
    leadList=new List<Lead>();
    oppList=new List<Opportunity>();
    accList=new List<Account>();
    conList=new List<Contact>();
    ccwList=new List<CustomControlWrapper>();
    try{
    String query='FIND '+'{'+Name+'}'+' IN ALL FIELDS RETURNING Account(id,name,createddate,createdbyid,type,rating,phone)';
    if(contacts)
    query+=',Contact(id,Account.name,Account.id,name,title,email,phone,createddate,createdbyid)';
    if(opportunities)
    query+=',OPPORTUNITY(id,name,account.id,account.name,stagename,amount,closedate,createddate,createdbyid)';
    if(cases)
    query+=',CASE(id,account.id,casenumber,account.name,status,createddate,createdbyid)';
    if(leads)
    query+=',LEAD(id,name,status,phone,email,createddate,createdbyid)';
    

  //querying the objects which contains the particular word..it returns list of objects list....we can refer each list by using the index..
  
    List<List<sObject>> relatedList=Search.query(query);
    if(relatedList[0].getSObjectType()==Account.sObjectType){
    accList=(List<Account>) relatedList[0];}
    if(accList.isEmpty())
    arender=false;
    else
    arender=true;
    integer i=0;


if(contacts)
{
i++;
 conList= relatedList[i];
 if(conList.isEmpty())
corender=false;
else 
corender=true;
}


if(opportunities)      
{
i++;
oppList=relatedList[i];
if(oppList.isEmpty())
orender=false;
else{
orender=true;
system.debug('opportunitylist'+oppList);
for(Opportunity o:oppList)
    {
        CustomControlWrapper cww=new CustomControlWrapper(o);
        ccwList.add(cww);
    }
    system.debug('wrapperOppportunity list :'+ccwList);
}
}
  
  
   
  if(cases)
{
i++;
caseList=relatedList[i];
if(caseList.isEmpty())
crender=false;
else
crender=true;
}


if(leads)
{
i++;
leadList=relatedList[i];
if(leadList.isEmpty())
lrender=false;
else
lrender=true;
}

if(!oppList.isEmpty())
{
    
}
system.debug(oppList);
system.debug(ccwList);
  return null;
  
}
    
catch(Exception e)
{
    ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR,e.getMessage()));
  return null;
}

}
    
    
    public pagereference reset()
    {
        name=null;
        return null;
    }
    public pagereference close()
    {
        pagereference url= new pagereference('/home/home.jsp');
        return url;
    }
    public pagereference deletes()
    {
        system.debug(ccwList);
        list<CustomControlWrapper> wrapList = new list<CustomControlWrapper>();
        list<Opportunity> delList=new list<Opportunity>();
        if(!ccwList.isEmpty()){
        for(CustomControlWrapper ccw:ccwList)
        {
            if(ccw.selected==true)
            {
                delList.add(ccw.opp);
            } else{
                wrapList.add(ccw);
            }
        }
        delete delList;
        ccwList.cleAR();
        ccwList.addAll(wrapList);
        }
        return null;
    }
    
}