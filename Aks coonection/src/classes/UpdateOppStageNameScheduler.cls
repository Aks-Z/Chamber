/**
 * Created by admin on 09/04/2020.
 */

global class UpdateOppStageNameScheduler implements Schedulable {
    global void execute (SchedulableContext sc) {
UpdateOppStageName batch = new UpdateOppStageName();
database.executeBatch(batch);
}
}