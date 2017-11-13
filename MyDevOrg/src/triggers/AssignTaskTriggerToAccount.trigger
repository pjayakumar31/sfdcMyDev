trigger AssignTaskTriggerToAccount on Account (after insert, after update) {
	OpportunityObjectTriggerClass2.assignTask(trigger.new);
}