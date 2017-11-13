@istest
public class ClientUtilTest {
    public static testmethod void updateOpptyHandoffTest(){
		Opportunity testOppty = new Opportunity();
        List<Client__c> testClients = new List<Client__c>();
        testOppty.name = 'Tester';
        testOppty.Handoff_Attached__c = 'No';
        testOppty.StageName = 'Engaged';
        testOppty.CloseDate = System.today();
        insert testOppty;
        
        Client__c c1 = new Client__c();
        c1.Document_Attached__c = True;
        c1.Type__c = 'Contract Flow Down/Handoff';
        c1.related_opportunity__c = testOppty.id;
        testClients.add(c1);
        
        Client__c c2 = new Client__c();
        c2.Document_Attached__c = True;
        c2.Type__c = 'Contract Flow Down/Handoff';
        c2.related_opportunity__c = testOppty.id;
        insert c2;
        
        Client__c c3 = new Client__c();
        c3.Document_Attached__c = True;
        c3.Type__c = 'Contract Flow Down/Handoff';
        //c3.related_opportunity__c = testOppty.id;
        testClients.add(c3);
        
        insert testClients;
        
        Test.startTest();
        
        testOppty = [select id,Handoff_Attached__c from opportunity where id = :testOppty.id];
        System.assertEquals('Yes', testOppty.Handoff_Attached__c);
        System.debug('oldOpptyNoUpdate : '+ClientUtil.oldOpptyNoUpdate);
        
        c2.Type__c = '';
        update c2;
        testOppty = [select id,Handoff_Attached__c from opportunity where id = :testOppty.id];
        System.debug('oldOpptyNoUpdate : '+ClientUtil.oldOpptyNoUpdate);
        System.assertEquals('Yes', testOppty.Handoff_Attached__c);
        
        c1.Related_Opportunity__c = null;
        update c1;
        testOppty = [select id,Handoff_Attached__c from opportunity where id = :testOppty.id];
        System.assertEquals('No', testOppty.Handoff_Attached__c);
        
        Test.stopTest();
    }

}