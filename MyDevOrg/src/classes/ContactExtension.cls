public with sharing class ContactExtension {
public Contact newContact{get;set;}
private Id contactId;
    public ContactExtension(ApexPages.StandardController controller) {
    contactId=controller.getId();
    if(contactId!=null){
    newContact=[select Salutation,FirstName,Phone,HomePhone,LastName,MobilePhone,AccountId,OtherPhone,Title,Fax,Department,Email,BirthDate,AssistantName,ReportstoId,AssistantPhone,LeadSource,MailingStreet,OtherStreet,MailingCity,OtherCity,MailingState,OtherState,MailingPostalCode,OtherPostalCode,MailingCountry,OtherCountry,Languages__c,Level__c,Description from Contact where Id=:contactId];
    }else{
    newContact=new Contact();
    }
    }
  public pagereference saveandnew(){
    try{
    upsert newContact;
    newContact=new Contact();

    }catch(Exception ex){
    system.debug(ex);
    ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR,ex.getMessage()));
       }
    return null;
    }
public pagereference newcontacts()
{
	insert newContact;
	return null;
}

public PageReference save()
{
	list<Contact> li=new list<Contact>();
	li=[select id from contact where lastname= :newcontact.lastname];
	if(li.isempty())
	{
		try{
		insert newcontact;
		
		}
		
		catch(Exception ex)
		{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR,ex.getMessage()));
		}
		return new PageReference('/'+newcontact.id);
	}
	if((li[0].Id)==(newContact.Id))
	{
		try{
			update newcontact;
		}
		catch(Exception ex)
		{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR,ex.getMessage()));
		}
		return new PageReference('/'+newcontact.id);
	}
	else
	{
		ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR,'Contact with the same last name already exist'));
		return null;
	}
	
	
}
}