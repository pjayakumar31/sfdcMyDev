trigger CaseTrigger on Case (before insert,before update) {
	if(Trigger.isUpdate)
    CaseUtil.validateCaseClose(Trigger.NewMap,Trigger.OldMap);
}