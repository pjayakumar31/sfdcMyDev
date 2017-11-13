trigger OpportunityTrigger on Opportunity (after insert) {
    try{
        List<Account> newAccounts = new List<Account>();
        newAccounts.add(new Account(Name = 'ExceptionLogTesting'));
        Database.SaveResult[] saveResults = Database.insert(newAccounts, false);
        ExceptionLogUtil.createExceptionLogs(saveResults, newAccounts, 'OpportunityTrigger');
    }Catch(Exception e){
        ExceptionLogUtil.createExceptionLog(e);
    }
}