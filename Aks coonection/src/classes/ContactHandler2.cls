/**
 * Created by admin on 23/04/2020.
 */

public class ContactHandler2 {

    public static void RoundRobinAssignment (List<Contact> contactList) {
        updateContactManager (contactList);
    }
        public static void updateContactManager(List<Contact> contactList){

            List<Contact> contactFilteredList = new List<Contact>();

            for (Contact con : contactList) {
                Contact conOld = new Contact();
                conOld = (Contact) Trigger.oldMap.get(con.Id);
                if (con.OwnerId != conOld.OwnerId) {
                    contactFilteredList.add(con);
                }
            }
                System.debug(contactFilteredList);

            // List of custom settings ManagersToSales1__c:

                List<ManagersToSales1__c> customSetlist = [SELECT id, SalesTeam__c, Manager_Team_Id__c
                from ManagersToSales1__c];

                List<Id> GroupSalesIdList = new List<Id>();

                for(ManagersToSales1__c	customSet: customSetlist) {

                    GroupSalesIdList.add(customSet.SalesTeam__c);
                }

               System.debug(GroupSalesIdList);


                Id salesGroupId;
                Id managerGroupId;

                for (Contact con: contactFilteredList){

                    for (GroupMember gm : [SELECT Id, UserOrGroupId, GroupId
                    FROM GroupMember
                    WHERE GroupId IN :GroupSalesIdList]) {
                        if (con.OwnerId == gm.UserOrGroupId) {
                            salesGroupId = gm.GroupId;
                            break;
                        }
                    }

                    for(ManagersToSales1__c	customSet: customSetlist){

                        if(customSet.SalesTeam__c == salesGroupId) {
                            managerGroupId = customSet.Manager_Team_Id__c;
                        }

                        List<GroupMember> ManagerGroupMemberList=[Select Id, UserOrGroupId From GroupMember
                        where GroupId = managerGroupId];

                        Set<id> targetManagersSet = new Set<Id>();
                            for (GroupMember gm3 : ManagerGroupMemberList){
                                if(string.valueOf(gm3.UserOrGroupId).startsWith('005')){
                                targetManagersSet.add(gm3.UserOrGroupId);

                            }
                        }



                        }
                    }

                }

            }
















