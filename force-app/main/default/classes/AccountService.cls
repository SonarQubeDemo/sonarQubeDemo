public class AccountService {
    public static void updateAccountNames(String oldName, String newName) {
        List<Account> accountsToUpdate = [SELECT Id, Name FROM Account WHERE Name = :oldName];
        for (Account acc : accountsToUpdate) {
            acc.Name = newName;
        }
        update accountsToUpdate;
    }
}
