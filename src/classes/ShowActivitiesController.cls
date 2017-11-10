public class ShowActivitiesController {
    Public Account acc = new Account();
    public Integer noRec = 5;
    public Integer offset = 5;
    
    public ShowActivitiesController(ApexPages.StandardController controller) {
        acc = (Account)controller.getRecord();
    }
    
    public list<Task> actList{
    get{
        list<task> tl = new list<task>([select id,whatid  from task where whatid = :acc.id and status <> 'Completed' limit :noRec]);
        return tl;
        }
    }
    
    public list<Task> actHistList{
    get{
        list<Task> ahl = new list<Task>([select id,whatid  from task where whatid = :acc.id and status = 'Completed' limit :noRec]);
        return ahl;
        }
    }
    
}