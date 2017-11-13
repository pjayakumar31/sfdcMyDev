public class SurveyController {
    public Survey__c survey;
    Public boolean FinalMsg{get;set;} 
    
    public SurveyController(ApexPages.StandardController controller) {
    survey = new Survey__c();
    survey = (Survey__c)controller.getRecord();
    }
    
    public List<SelectOption> getUsers()
{
  List<SelectOption> options = new List<SelectOption>();
  List<User> Users= new List<User>();
  Users= [Select Id, Name FROM User];
  options.add(new SelectOption('--None--','--None--'));
  for (Integer j=0;j<Users.size();j++)
  {
      options.add(new SelectOption(Users[j].name,Users[j].name));
  }
  return options;
}

Public pagereference save(){
try{
insert survey;
}
Catch(Exception e){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error has occured in Submitting Survey. Please try to Submit again'));
}
FinalMsg = true;
return null; 
}

}