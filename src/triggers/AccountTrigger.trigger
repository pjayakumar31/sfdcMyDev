trigger AccountTrigger on Account (before insert,after insert,before update) {
//AccountUtil.Sendemailto(Trigger.new);
list<Account> acclist=new list<Account>();
list<Account> triggerlist = new List<Account>();
for(Account acc : Trigger.New){
triggerList.add(acc);
}
User usr=[select id,name from User where id='00590000001DjJs'];
if(Trigger.isbefore)
{
for (Account a : triggerList)
{
a.ownerId=usr.Id;
acclist.add(a);
}
}
if(Trigger.isafter){
    try{
        if(acclist.size()>0)
        insert acclist;
    }catch(Exception e){
        
    }
}
}