public class actionFunctionPage {
  String uname;
    public Boolean testBox{get;set;}
    public String getUsername() {
        return uname;
    }
            
    public PageReference sayHello() {
        uname = UserInfo.getName();
        return null;
    }
            
    public void setState(String n) {
        state = n;
    }
            
    public String getState() {
        return state;
    }
            
    public PageReference methodOne() {
        return null;
    }
            
    private String state = 'no';
    
    public PageReference checkedBox(){
        List<String> addresses = new List<String>{'jayakumar.pillala@jpmchase.com'};
        Messaging.SingleEmailMessage mesg = new Messaging.SingleEmailMessage();
        //mesg.setToAddresses({'jayakumar.pillala@jpmchase.com'});
        mesg.setToAddresses(addresses);
        mesg.setSubject('Testing Email');
        mesg.setHtmlBody('Testing Email sent for demo purpose');
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {mesg});
        return null;
    }
}