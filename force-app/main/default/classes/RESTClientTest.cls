@IsTest
private class RESTClientTest {
    @IsTest
    static void getAccountByIdTest() {
        Test.setMock(HttpCalloutMock.class, new RESTClientMock());
        Account account = RESTClient.getAccountById('0012w00000L74Cq');
        System.assertEquals(new Account(Id = '0012w00000L74Cq', Name = 'Test Account'), account);
    }
    @IsTest
    static void createAccountTest() {
        Test.setMock(HttpCalloutMock.class, new RESTClientMock());
        Id newAccountId = RESTClient.createAccount(new Account(Name = 'sample-name', Description = 'sample-description'));
        System.assertEquals('0012w00000L74Cq', newAccountId);
    }
    @IsTest
    static void deleteAccountTest() {
        Test.setMock(HttpCalloutMock.class, new RESTClientMock());
        Boolean result = RESTClient.deleteAccount('0012w00000L74Cq');
        System.assertEquals(true, result);
    }
    @IsTest
    static void updateAccountTest() {
        Test.setMock(HttpCalloutMock.class, new RESTClientMock());
        Id updatedAccountId = RESTClient.updateAccount(new Account(Name = 'sample-name',
                Description = 'sample-description'));
        System.assertEquals('0012w00000L74Cq', updatedAccountId);
    }
    @IsTest
    static void upsertAccountTest() {
        Test.setMock(HttpCalloutMock.class, new RESTClientMock());
        Id upsertedAccountId = RESTClient.upsertAccount(new Account(Name = 'sample-name',
                Description = 'sample-description'));
        System.assertEquals('0012w00000L74Cq', upsertedAccountId);

    }
}