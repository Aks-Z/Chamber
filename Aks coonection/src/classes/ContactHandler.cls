/**
 * Created by admin on 21/04/2020.
 */

public class ContactHandler {
public static void RoundRobinAssignment (List<Contact> contactList) {

    List<Contact> targetContactsSet = new List<Contact>();
    /*contat owner changed - get contact list

    Map<Id, List> ownersToContactsMap



/*List<GroupMember> relevantGroupMembersList = new List<GroupMember>([
        SELECT UserOrGroupId, GroupId
        FROM GroupMember
        WHERE UserOrGroupId in :contactList]);
        System.debug(relevantGroupMembersList);
*/
    Map<List<Id>, List<Id>> managerVsSalesMap = new Map<List<Id>, List<Id>>();
    List<Id> managersIdList = new List<Id>();
    List<Id> salesIdList = new List <Id>();

    for(ManagersToSales1__c	cset: [SELECT id, Manager_Team_Id__c,  SalesTeam__c from ManagersToSales1__c]){
        Id ManagerGroupId = cset.Manager_Team_Id__c;
        Id SalesGroupId = cset.SalesTeam__c;

        List<Id> managerUsersIdList = new List<Id>();
        List<GroupMember> GPManagerList = [SELECT UserOrGroupId FROM GroupMember WHERE GroupId =: ManagerGroupId];
        for(GroupMember gm1: GPManagerList){
            managerUsersIdList.add(gm1.UserOrGroupId)};

        List<Id> salesUsersIdList = new List<Id>();
        List<GroupMember> GPSalesList = [SELECT UserOrGroupId FROM GroupMember WHERE GroupId =: SalesGroupId];
        for (GroupMember gm2: GPSalesList){
            salesUsersIdList.add(gm2.UserOrGroupId);}

        managerVsSalesMap.put(salesUsersIdList, managerUsersIdList);

        }

    Set<String> salesKeySet = new Set<String>;
            salesKeySet = managerVsSalesMap.keySet();

    for (Contact con1: contactList){
        Id targetManager;
        Id salesKeyId;

        for (Id keyId : salesKeySet){
        if(con1.OwnerId == keyId){
            salesKeyId = keyId;
            Set <id> targetManagersSet = new Set<id>();
            if (managerVsSalesMap.containsKey(salesKeyId)){
                Set targetManagersSet = managerVsSalesMap.get(salesKeyId);
            }



    }
            if()

    }
/*
    }

   // List<id> SalesUsersIdList = new List<id>


    for(Contact con: contactList){
        if con.OwnerId in:[SELECT ]
    }


    Map <Id, List<Id>> groupIdByUserIdMap = new Map <Id, List<Id>>();


    }
}
}