public with sharing class CustomControlController {
    public string name{get;set;}
    public boolean cases{get;set;}
    public boolean leads{get;set;}
    public boolean opportunities{get;set;}
    public boolean accounts{get;set;}
    public boolean contacts{get;set;}
    public boolean arender{get;set;}
    public boolean crender{get;set;}
    public boolean orender{get;set;}
    public boolean lrender{get;set;}
    public boolean corender{get;set;}
    public list<case> caseList{get;set;}
    public list<Lead> leadList{get;set;}
    public list<Opportunity> oppList{get;set;}
    public list<Account> accList{get;set;}
    public list<Contact> conList{get;set;}
    public CustomControlController(){
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
else
orender=true;
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
return null;
}

catch(Exception e)
{
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
}