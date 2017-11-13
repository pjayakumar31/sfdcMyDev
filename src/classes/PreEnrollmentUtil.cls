public class PreEnrollmentUtil {
    Public static void updateProviderName(list<Pre_Enrollment__c> newPreEnrList){
       	Map<id,Pre_Enrollment__c> preEnrMap = new Map<id, Pre_Enrollment__c>();
        set<id> pnmSiteSet = new set<id>();
        Map<id,PNMSite__c> pnmSiteMap;
        for(Pre_Enrollment__c pe: newPreEnrList){
            if( pe.PNMSite__c<>null ){
                pnmSiteSet.add(pe.PNMSite__c);
            }
        }
        pnmSiteMap = new Map<id, PNMSite__c>([select id, (select id,contact__r.name from Site_Locations__r where contact__r.name<>null) from PNMSite__c where id in :pnmSiteset]);
        for(Pre_Enrollment__c pe: newPreEnrList){
            if(pnmsitemap.containsKey(pe.PNMSite__c) && pnmSiteMap.get(pe.PNMSite__c).Site_Locations__r.size() == 1){
                pe.ProviderName__c = pnmSiteMap.get(pe.PNMSite__c).Site_Locations__r.get(0).Contact__r.name;
            }
            else{
                pe.ProviderName__c = '';
            }
        }
    }
}