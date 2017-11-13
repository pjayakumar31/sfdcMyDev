public with sharing class OpportunityUtil {
    
    public static void nameAppender(list<Opportunity> opp)
    {
        try{
            
        for(Opportunity op:opp)
        op.Name=op.Name+'-'+op.closeDate.format();
        system.debug('before updating the opportunity name');
        }
        catch(System.Exception e)
        {
            system.debug(e);
        }
    }
    
    
    public static void appendAccountNameToOpportunityName(list<Opportunity> opp)
    {
        for(Opportunity op:opp)
        {
            if(op.AccountId!=null)
            {           
                list<Account> acc=[select Name from Account where Id = :op.AccountId];
                op.Name=op.Name+'-'+acc[0].Name;
                system.debug(op.Name);
            }   
            
        }
    }
    
    
    

}