trigger ContactTriggerUtilities on Contact (before insert,before update) {

    if(trigger.isupdate)
    {
    ContactUtil.ValidateInactiveField(Trigger.new);
    }    
    SetContactToPrimary.primaryContactSetter(trigger.new);



}