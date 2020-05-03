/**
 * Created by admin on 08/04/2020.
 */

global class UpdateOppStageName implements Database.Batchable<sObject> {
    global Database.QueryLocator start (Database.BatchableContext bc) {
        return Database.getQueryLocator (
                'SELECT Id, StageName from Opportunity' +
                'where StageName = \'Account Set Up\' AND'+
                'Account.First_Transaction_Date == TODAY'
        );
    }
    global void execute (Database.BatchableContext bc, List<Opportunity> scope)
    {
        for (Opportunity opps: scope){
        opps.StageName = 'Implementation';
    }
        update scope;

            }
    global void finish (Database.batchableContext bc) {  }

}