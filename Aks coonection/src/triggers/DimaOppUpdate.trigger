/**
 * Created by admin on 05/04/2020.
 */
trigger OpportunityUpdate on Opportunity (after insert) {

    Set<Id> accountIdSet = new Set<Id>();

    for (Opportunity opp: Trigger.New) {
        accountIdSet.add(opp.AccountId);
    }

    Map<Id, Account> accountsMap = new Map<Id, Account> (
    [
            SELECT Id,
            (SELECT Id FROM Contacts)
            FROM Account
            WHERE Id IN :accountIdSet
    ]
    );

    List<Id> oppSourceIdList = new List<Id>();

    for (Opportunity opp: Trigger.New) {
        oppSourceIdList.add(opp.Id);
    }

    Map<Id, Set<Id>> oppContactRolesExistMap = new Map<Id, Set<Id>>();
    Set<Id> oppContactRoleSet = new Set<Id>();

    for (OpportunityContactRole oppConRole:
    [
            SELECT ContactId, OpportunityId
            FROM OpportunityContactRole
            WHERE OpportunityId IN :oppSourceIdList
            //ORDER BY OpportunityId
    ]) {
        oppContactRoleSet = oppContactRolesExistMap.get(oppConRole.OpportunityId);
        oppContactRoleSet.add(oppConRole.ContactId);
        oppContactRolesExistMap.put(oppConRole.OpportunityId, oppContactRoleSet);
    }

    List<OpportunityContactRole> oppContactRoleList = new List<OpportunityContactRole>();
    for (Opportunity opp: Trigger.New) {
        for (Contact cont: accountsMap.get(opp.AccountId).Contacts) {
            OpportunityContactRole oppContactRole = new OpportunityContactRole();
            oppContactRole.ContactId = cont.Id;
            oppContactRole.OpportunityId = opp.Id;
            oppContactRole.Role = 'Business User';
            if (oppContactRolesExistMap.containsKey(opp.Id)) {
                Set<Id> contactIdSet = oppContactRolesExistMap.get(opp.Id);
                if (!contactIdSet.contains(cont.Id)) {
                    oppContactRoleList.add(oppContactRole);
                }
            }
        }
    }

    if (oppContactRoleList.size() > 0) {
        List<Database.SaveResult> srList = Database.insert(oppContactRoleList, false);
        for(Database.SaveResult sr: srList) {
            if (!sr.isSuccess()) {
                System.debug('Insert error is: ' + sr.getErrors() + ' ' + sr.getId());
            }
        }
    }
}