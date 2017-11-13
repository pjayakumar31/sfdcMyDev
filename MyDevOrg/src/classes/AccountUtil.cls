public class AccountUtil {
    public static void SendEmailTo(Account[] acclist){
        List<User> userlist=new List<User>();
        List<string> maillist=new list<String>();
        userlist=[Select id,email,name from user where isactive=true];
        system.debug('user mails : '+userlist);
        for(user u : userlist)
            maillist.add(u.email);
        maillist.add('pjayakumar31@gmail.com');
        system.debug('user mails list: '+maillist);
    messaging.SingleEmailMessage mail= new Messaging.SingleEmailMessage();
        mail.settoAddresses(maillist);         
        mail.setSubject('Mail from Salesforce');
        mail.setplaintextbody('Testing mail from your developer account buddy');
        Messaging.sendEmail(new messaging.SingleEmailMessage[]{mail} );
    }
}