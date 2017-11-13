Public class OpptyProductCodeUpdate
{
public static void OpportunityProductCodeUpdate(list<OpportunityLineItem> OppPros)
{
Set<ID> oppset= new Set<id>();
list<Opportunity> opptytoupdate= new list<Opportunity>();
list<Products__c> prolist=new list<Products__c>();
list<String> codelist= new list<String>();
list<Opportunity> finalopptylist=new list<Opportunity>();
map<Id, Opportunity> oppmap= new map<Id, Opportunity>();

prolist=Products__c.getall().Values();
for(Products__c p : prolist)
codelist.add(p.Product_Code__c);

for(OpportunityLineItem op : opppros)
oppset.add(op.opportunityid);

opptytoupdate=[select Id,ProductCode__c from opportunity where Id in :oppset];

for(Opportunity oppty : opptytoupdate)
oppmap.put(oppty.Id, oppty);

for(OpportunityLineItem op: OppPros)
{
Opportunity tempopp=new Opportunity();
  for(String c : codelist ) 
  {
  if(c==op.ProductCode){
   tempopp=oppmap.get(op.opportunityid);
   if(tempopp.Productcode__c<>'' && tempopp.productcode__c <> null ) 
     {
     tempopp.ProductCode__c+=','+op.Productcode;
     }
   else 
     {
     tempopp.ProductCode__c=op.Productcode ;
     } 
//(tempopp.Productcode__c<>'' && tempopp.productcode__c <> null ) ? tempopp.ProductCode__c+=','+op.Productcode : tempopp.ProductCode__c = op.Productcode ;
   }
  finalopptylist.add(tempopp);
  }
 }

update finalopptylist;
}
}