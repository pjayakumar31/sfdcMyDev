trigger PreEnrollmentTrigger on Pre_Enrollment__c (before insert,before update) {
	PreEnrollmentUtil.updateProviderName(Trigger.New);
}