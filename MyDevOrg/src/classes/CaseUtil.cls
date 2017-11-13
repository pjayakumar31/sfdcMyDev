public class CaseUtil {
    public Static void validateCaseClose(Map<id,case> newCaseMap, Map<id,Case> oldCaseMap){
        list<case> casesToValidate = new list<case>();
        for(Case c: newCaseMap.Values()){
            if( (c.status <> oldCaseMap.get(c.id).status) && c.status == 'Closed Admin'){
                casesToValidate.add(c);
            }
        }
        for(case c: [select id,(select id from Tasks where status = 'In Progress'), (select id from Events where StartDateTime > Today) from case where id in :casesToValidate ]){
        	if(!c.Tasks.isempty() || !c.Events.isempty()){
            	newCaseMap.get(c.id).addError('You cannot close case which has open activities');
            }
        }	    
    }
}