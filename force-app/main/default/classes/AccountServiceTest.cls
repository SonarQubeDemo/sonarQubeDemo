@isTest
public class AccountServiceTest {
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            accounts.add(new Account(Name = 'OldName' + i));
        }
        insert accounts;
    }

    @isTest
    static void testUpdateAccountNames() {
        // Verify that the setup method created 5 accounts
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE 'OldName%'];
        System.assertEquals(5, accounts.size());

        // Run the method under test
        AccountService.updateAccountNames('OldName0', 'NewName');

        // Verify that the account name was updated
        Account updatedAccount = [SELECT Id, Name FROM Account WHERE Name = 'NewName' LIMIT 1];
        System.assertEquals('NewName', updatedAccount.Name);
    }

    @isTest
    static void testUpdateAccountNames_NoMatch() {
        // Run the method with a name that doesn't match any account
        AccountService.updateAccountNames('NonExistentName', 'NewName');

        // Verify that no account names were updated
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE 'NewName'];
        System.assertEquals(0, accounts.size());
    }
}
