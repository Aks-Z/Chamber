/**
 * Created by admin on 17/04/2020.
 */

public  class AccountHandler {
    public static void upsertAccount(List<Account> accList) {
        updateRussianContacts(accList);
    }

    private static void updateRussianContacts(List<Account> accList) {
        Set<Id> accountIds = new Set<Id>();
        for (Account acc :accList) {
            String website = String.valueOf(acc.Website);
            if (website.contains('@yandex.ru')){
               accountIds.add(acc.Id);
            }
        }

        List<Contact> contsToUpdList = new List<Contact>(
          //soql for loop here!!!
                [SELECT id, Languages__c from Contact WHERE AccountId in: accountIds
                ]);
        for (Contact c :contsToUpdList){
            c.Languages__c = 'Russian';
        }
                update contsToUpdList;
    }

}
