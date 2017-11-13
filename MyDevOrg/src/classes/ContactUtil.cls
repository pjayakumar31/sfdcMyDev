Public class ContactUtil {
public static void ValidateInactiveField(list<Contact> cons){
set<id> InactiveConIds = new set<id>();
map<id, contact> overduecontact = new map<id, contact>();
for(contact c:cons){
 if(c.inactive__c)
 InactiveConIds.add(c.id);
 overduecontact.put(c.id, c);
 }
list<id> UnUpdatedcontacts = new list<id>();
list<task> overduetasks = new list<task>([select id,ActivityDate,whoid from task where whoid in :InactiveConIds and ActivityDate > today ]);
list<event> overdueevents = new list<event>([select id,ActivityDate,whoid from Event where whoid in :InactiveConIds and ActivityDate > today ]);

for(task t :overduetasks){
 if(overduecontact.containskey(t.whoid))
 overduecontact.get(t.whoid).adderror('Inactive cannot be true if any related activity is overdue');
 }

for(Event e :overdueevents){
 if(overduecontact.containskey(e.whoid))
 overduecontact.get(e.whoid).adderror('Inactive cannot be true if any related activity is overdue');
 }

} 
}