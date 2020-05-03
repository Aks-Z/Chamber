/**
 * Created by admin on 25/04/2020.
 */

trigger ContactTrigger on Contact (before update) {

    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            ContactHandler2.RoundRobinAssignment(Trigger.new);
        }
    }

}]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]ыввввввввввввввввввввв