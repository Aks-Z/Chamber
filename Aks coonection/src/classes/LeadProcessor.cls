/**
 * Created by admin on 08/04/2020.
 */

global class LeadProcessor implements Database.Batchable<sObject> {
    global Database.QueryLocator start (Database.BatchableContext bc)
    {
        return Database.getQueryLocator([SELECT LeadSource from Lead ]);
    }
    global void execute (Database.BatchableContext bc, List<Lead> scope)
    {   for (Lead Leads :scope)
        { leads.leadsource = 'Dreamforce';
        }
        update scope;
    }
    global void finish (Database.batchableContext bc) {  }
}

