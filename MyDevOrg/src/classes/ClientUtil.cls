public class ClientUtil {
    Public static Map<id, opportunity> opptoupdatemap;
    Public static set<id> oldOpptyHandoffSet;
    Public static set<id> oldOpptyNoUpdate;
    
    public static void updateOpportunityHandoffAttached(list<client__c> newClientList, 
                            map<id,client__c> oldClientMap,
                                                        map<id,client__c> newClientMap,
                                                        boolean insertop, boolean updateop,boolean deleteop){
    
    opptoupdatemap = new map<id, opportunity>();
    oldOpptyHandoffSet = new set<id>();
    oldOpptyNoUpdate = new set<id>();
    
    if(insertop ){   
    
        System.debug('Jaya in insertop1');
        for(Client__c c: [select related_opportunity__c  from client__c where id in :newClientlist and related_opportunity__c <> null and related_opportunity__r.Handoff_Attached__c = 'Yes']){
            oldOpptyHandoffSet.add(c.related_opportunity__c);
        }
                System.debug('Jaya in insertop1 oldOpptyHandoffset:'+oldopptyhandoffset);
        for(Client__c c: [select id, Type__c, Document_Attached__c,Related_Opportunity__c from client__c where related_opportunity__c in :oldOpptyHandoffSet and Type__c <> null]){
        if(!newClientMap.containskey(c.id) && c.Type__c == 'Contract Flow Down/Handoff'  && c.Document_Attached__c){
                oldOpptyNoUpdate.add(c.related_opportunity__c); 
        } 
        System.debug('Jaya in insertop1 oldOpptyNoUpdate:'+oldOpptyNoUpdate);  
    }
    }
    
    if(updateop || deleteop ){
    System.debug('Jaya in updateop1');
        for(Client__c c: [select related_opportunity__c  from client__c where id in :oldClientMap.Values() and related_opportunity__c <> null and related_opportunity__r.Handoff_Attached__c = 'Yes']){
            oldOpptyHandoffSet.add(c.related_opportunity__c);
        }
        System.debug('Jaya in updateop1 oldOpptyHandoffset:'+oldopptyhandoffset);
        for(Client__c c: [select id, Type__c, Document_Attached__c,Related_Opportunity__c from client__c where related_opportunity__c in :oldOpptyHandoffSet and Type__c <> null]){
        if(!oldClientMap.containskey(c.id) && c.Type__c == 'Contract Flow Down/Handoff'  && c.Document_Attached__c){
                oldOpptyNoUpdate.add(c.related_opportunity__c); 
        }
        System.debug('Jaya in updateop1 oldOpptyNoUpdate:'+oldOpptyNoUpdate);    
    }
    }

                                              
        if(insertop || updateop){
            System.debug('Jaya in updateop2');
            for(client__c c: newClientlist){
            System.debug('Jaya in updateop2 for loop');
                    if(  c.related_opportunity__c != null && !oldOpptyNoUpdate.contains(c.related_opportunity__c) && c.Type__c == 'Contract Flow Down/Handoff'  && c.Document_Attached__c ){
                  System.debug('Jaya in updateop2 for loop if');       
                Opportunity o = new opportunity();
                        o.id = c.related_opportunity__c;
                    o.Handoff_Attached__c = 'Yes';
                    opptoupdatemap.put(o.id, o);
                     System.debug('Jaya in updateop2 for loop if opptoupdatemap'+opptoupdatemap); 
                }else if(updateop && !oldOpptyNoUpdate.contains(c.related_opportunity__c) && !opptoupdatemap.containsKey(c.related_Opportunity__c) &&
                    ((oldclientmap.get(c.id).related_opportunity__c!= null && c.related_opportunity__c == null) ||
                    ( c.related_opportunity__c != null && 
                    ((c.Type__c != 'Contract Flow Down/Handoff' && oldClientMap.get(c.id).Type__c == 'Contract Flow Down/Handoff') ||
                    ( c.Document_Attached__c != True && oldClientMap.get(c.id).Document_Attached__c))))){
                     
                    System.debug('Jaya in updateop2 for loop else if');  
                     System.debug('jaya else if beginning opptoupdatemap '+opptoupdatemap );
                                  
                Opportunity o = new opportunity();
                        o.id = oldClientMap.get(c.id).related_opportunity__c;
                    o.Handoff_Attached__c = 'No';
                    opptoupdatemap.put(o.id, o);
                    System.debug('jaya else if end opptoupdatemap '+opptoupdatemap );
            }
        }
    }

    else if(deleteop){
        for(client__c c: oldclientmap.Values()){
            if(!oldOpptyNoUpdate.contains(c.related_opportunity__c)){
                Opportunity o = new opportunity();
                        o.id = c.related_opportunity__c;
                    o.Handoff_Attached__c = 'No';
                    opptoupdatemap.put(o.id, o);
            }
        }   
    }
    System.debug('before update opptoupdatemap '+opptoupdatemap );
    if(opptoupdatemap.size()>0){
        update opptoupdatemap.values();
    }
    }
}