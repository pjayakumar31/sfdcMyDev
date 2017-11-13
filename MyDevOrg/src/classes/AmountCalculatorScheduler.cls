global with sharing class AmountCalculatorScheduler implements Schedulable {
global void execute(SchedulableContext sc){
	AmountCalculator cta=new AmountCalculator();
	
	cta.query='select AccountId ,Amount from Opportunity where AccountId!=null and Amount>0';
	Database.executeBatch(cta);
	}
}