/**
 * Created by admin on 05/04/2020.
 */

trigger updateAccForOppNeedDiscussion on Opportunity (after update) {

    Set<Id> AccountIdSet = new Set <Id> ();
            for (Opportunity opp :Trigger.New) {
            AccountIdSet.add (opp.AccountId);
            }

    List<Account> accsToUpdateList = new List<Account>();
            for (Account acc :
    [
    SELECT Id, Opportunity_is_on_discussion__c
    FROM Account WHERE Id in :AccountIdSet
    ]
                ) {
            for (Opportunity opp :Trigger.New) {
                Opportunity oppOld = new Opportunity ();
                oppOld = Trigger.oldMap.get(opp.Id);
             if (opp.StageName == 'Need Discussion' && !(oppOld.StageName == 'Need Discussion')) {
                 acc.Opportunity_is_on_discussion__c = opp.id;
                 accsToUpdateList.add(acc);
             }
                else if (!(opp.StageName == 'Need Discussion') && oppOld.StageName == 'Need Discussion')
                {acc.Opportunity_is_on_discussion__c = null;
                accsToUpdateList.add(acc);
                }
                                               }
                  }
    system.debug(accsToUpdateList);
update accsToUpdateList;


            }

