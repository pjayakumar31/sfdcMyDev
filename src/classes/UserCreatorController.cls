public class UserCreatorController {

public list<Employee__c> SimEmplist{get;set;}
public list<Employee__c> Peerlist{get;set;}
public list<user> peer{get;set;}
public String Empmanager{get;set;}
Public String SimManager{get;set;}
public String copyuser{get;set;}
public string finalsim{get;set;}
public Employee__c Employee{get;set;}
public String userid{get;set;}
public boolean simempren{get;set;}
public boolean peerempren{get;set;}
public boolean noempren{get;set;}
Public string Peeruser{get;set;}

public void SimilarEmp()
{
String Emp = Apexpages.currentpage().getparameters().get('emp');
//emp='%'+emp+'%';
//Query to search employees with similar names
SimEmplist = [select id,empname__c,emailid__c,title__c,department__c,manager__r.Name,manager__r.title__c,manager__r.empname__c,Name from Employee__c where empname__c LIKE :emp];
//if no match is found renders no employee found block
if(SimEmplist.size() == 0)
{
peerempren=false;
simempren=false;
noempren=true;
return;
}
//if an exact match is found renders peers list and calls method to find peers list. 
else if(simemplist.size() == 1)
{
Employee=simemplist[0];
Empmanager= simemplist[0].manager__r.empname__c;
getfindpeers();
return;
}
//if more than one emp is found with similar name renders similar employees list
else if(simemplist.size()>1)
{
peerempren=false;
simempren=true;
noempren=false;
return;
}
}

public void getfindpeers()
{
peerempren=true;
simempren=false;
noempren=false;
if(Empmanager <> null)
{

peer = [select id, title,name, lastname from User where manager.lastname= :EmpManager];    
return;
}
else
{
finalSim= Apexpages.currentpage().getparameters().get('simemp');
for(Employee__c e: simemplist){
if(e.name==finalsim)
{Employee = e;break;}
}
String mgr = Employee.manager__r.empname__c;
peer = [select id, title, name,lastname,manager.lastname from User where manager.lastname= :mgr];
return;
}
}

public pagereference getUserCreator()
{
Peeruser = Apexpages.currentpage().getparameters().get('Peerid');
User[] copyuser= new user[10];
String emps=Employee.empname__c;
copyUser = [select id,TimeZoneSidKey,profileId,EmailEncodingKey,ManagerId,LocaleSidKey,LanguageLocaleKey from user where Lastname = :peeruser  ];
User mainUser = new User();
mainuser.username=Employee.emailid__c;
mainuser.email=Employee.emailid__c;
mainuser.LastName=Employee.empname__c;
mainuser.alias=Employee.empname__c.left(4);
mainuser.CommunityNickname=Employee.empname__c.left(7);
mainuser.TimeZoneSidKey=copyuser[0].TimeZoneSidKey;
mainuser.profileId=copyuser[0].profileId;
mainuser.EmailEncodingKey=copyuser[0].EmailEncodingKey;
mainuser.LocaleSidKey=copyuser[0].LocaleSidKey;
mainuser.LanguageLocaleKey=copyuser[0].LanguageLocaleKey;
mainuser.managerid=copyuser[0].managerid;
mainuser.isactive=false;
//Copy user fields values to mainuser and insert user.
insert mainuser;
Pagereference url = new pagereference('/001');
return null;

}

}