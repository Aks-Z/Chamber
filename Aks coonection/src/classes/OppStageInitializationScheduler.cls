/**
 * Created by admin on 26/04/2020.
 */

public class OppStageInitializationScheduler implements Schedulable {
    public void execute (SchedulableContext sc) {
    UpdateOppStageInitialization batch = new UpdateOppStageInitialization();
    database.executeBatch(batch);
}
}
