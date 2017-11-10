Public Class ClaimUtil{
    Public void setPrimaryCliam(List<Claim__c> NewList){
        
        Map<string, Claim__c> newCNMap = new Map<String, Claim__c>(); //Map with key as Claim_Number__c + Service_Date__c and value as Record to get the most recent claim with amount less than zero in CN and Date combination
        Map<String, Claim__c> NameMap = new Map<String, Claim__c>();  //Map with Name of claim and Claim record pair. It stores the claim record with apt Primary value.
        List<Claim__c> oldCNlist = new List<Claim__c>();
        Set<String> ClaimNumberSet = new Set<string>();
        
        // To Create a map with Name and Claim record which has Primary__c true in Trigger.New
        for(Claim__c c: NewList){
            if(c.Amount__c < 1){
                ClaimNumberSet.add(c.Claim_Number__c);
                String str = c.Claim_Number__c + c.Service_Date__c;
                if(newCNMap.containskey(str) && newCNMap.get(str).CreatedDate<c.CreatedDate ){
                    
                    //Updates the existing Claim record's Primary in NameMap with value False
                    Claim__c tc = new Claim__c();
                    tc = newCNMap.get(str);
                    tc.Primary__c = False;
                    NameMap.put(c.Name,tc);
                    
                    //Enters the new record into NameMap
                    c.Primary__c = True;
                    NameMap.put(c.Name,new Claim__c());
                    NameMap.put(c.Name,c);
                    //Replaces the old record in newCNMap
                    newCNMap.put(str,c);
                }else{
                    c.Primary__c = True;
                    NameMap.put(c.Name,new Claim__c());
                    NameMap.put(c.Name,c);
                    newCNMap.put(str,new Claim__c());
                    newCNMap.put(str,c);
                }
            }
        }
        
        // To update records in Trigger.New with apt Primary values
        for(Claim__c c: NewList){
            if(c.Amount__c > 0){
                c.Primary__c = True;
            }else{ 
                c.Primary__c = NameMap.get(c.Name).Primary__c; 
            }
        }
        
        // To update existing records with False as value in Primary 
        for(Claim__c c: [select Claim_Number__c,Service_Date__c,Primary__c from Claim__c where Claim_Number__c in :ClaimNumberSet]){
            if(newCNMap.containsKey(c.Claim_Number__c+c.Service_Date__c)){
                c.Primary__c = False;
                oldCNlist.add(c);
            }
        }
        update oldCNlist;
    }
}