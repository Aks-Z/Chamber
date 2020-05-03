/**
 * Created by admin on 18/04/2020.
 */

trigger AccountTrigger on Account (after insert, after update) {
    if(Trigger.isAfter){
        if (Trigger.isInsert || Trigger.isUpdate){
            AccountHandler.upsertAccount(Trigger.new);
        }
    }

}