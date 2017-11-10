trigger OpportunityProductCodeUdateTrigger on OpportunityLineItem(after insert) {
OpptyProductCodeUpdate.OpportunityProductCodeUpdate(Trigger.New);

}