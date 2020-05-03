/**
 * Created by admin on 26/04/2020.
 */

public class UpdateOppStageInitialization implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator (
                'SELECT Id, StageName from Opportunity' +
                        'where Account.First_Transaction_Date = TODAY'

        );
    }

        public void execute (Database.BatchableContext bc, List<Opportunity> scope) {
        for (Opportunity opps: scope) {
        opps.StageName = 'Initialization';
         }
         update scope;
        }

     public void finish (Database.batchableContext bc) {  }
    }
