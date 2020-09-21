/**
 * Created by JJ93 on 19.09.2020.
 */

public with sharing class RESTClient {
    // System.debug(RESTClient.getAccountById('0012w00000L6r9uAAB'));
    public static final String REST_SERVICE_ENDPOINT = 'https://wise-bear-t0v9lv-dev-ed.my.salesforce.com/services/apexrest/Accounts/';
    private static final String BEARER_TOKEN_TYPE = 'Bearer ';
    private static final String AUTHORIZATION_HEADER_KEY = 'Authorization';
    private static final String CONTENT_TYPE_HEADER_KEY = 'Content-Type';
    private static final String GET_METHOD = 'GET';
    private static final String POST_METHOD = 'POST';
    private static final String ACCESS_TOKEN_KEY = 'access_token';
    public static final String ACCESS_TOKEN_ENDPOINT = 'https://login.salesforce.com/services/oauth2/token?grant_type=password&client_id=3MVG9n_HvETGhr3Ca0T9vrY0B1ZV3PSVCfwmBWgTl3A.PaZba7CRE2g8ChhId3FaiH12kenxa4O6JFx1WCwFB&client_secret=241CE586D835C63AAF3FDD15F9F141DFAF7EC907D5B7BE5A95E74DAD0A740BDA&username=mikitka334@wise-bear-t0v9lv.com&password=nik2486976PdMZehZg1x2jOgvvI893J7F9W';
    private static final String JSON_CONTENT_TYPE = 'application/json';
    private static final String DELETE_METHOD = 'DELETE';
    private static final String PATCH_METHOD = 'PATCH';
    private static final String PUT_METHOD = 'PUT';
    public static Account getAccountById(String id) {
        Http httpConnection = new Http();
        HttpRequest request = new HttpRequest();
        String accessToken = getAccessToken();
        request.setHeader(AUTHORIZATION_HEADER_KEY, accessToken);
        request.setEndpoint(REST_SERVICE_ENDPOINT + id);
        request.setMethod(GET_METHOD);
        HttpResponse response = httpConnection.send(request);
        Account account = (Account) JSON.deserialize(response.getBody(), Account.class);
        return account;
    }
    public static Id createAccount(Account account) {
        Http httpConnection = new Http();
        HttpRequest request = new HttpRequest();
        String accessToken = getAccessToken();
        request.setHeader(AUTHORIZATION_HEADER_KEY, accessToken);
        request.setHeader(CONTENT_TYPE_HEADER_KEY, JSON_CONTENT_TYPE);
        request.setEndpoint(REST_SERVICE_ENDPOINT);
        request.setMethod(POST_METHOD);
        request.setBody(JSON.serialize(account));
        HttpResponse response = httpConnection.send(request);
        Id accountId = (Id) JSON.deserialize(response.getBody(), Id.class);
        return accountId;
    }
    public static Boolean deleteAccount(String id) {
        Http httpConnection = new Http();
        HttpRequest request = new HttpRequest();
        String accessToken = getAccessToken();
        request.setHeader(AUTHORIZATION_HEADER_KEY, accessToken);
        request.setHeader(CONTENT_TYPE_HEADER_KEY, JSON_CONTENT_TYPE);
        request.setEndpoint(REST_SERVICE_ENDPOINT + id);
        request.setMethod(DELETE_METHOD);
        Boolean result = (Boolean) JSON.deserializeUntyped(httpConnection.send(request).getBody());
        return result;
    }
    public static Id updateAccount(Account account) {
        Http httpConnection = new Http();
        HttpRequest request = new HttpRequest();
        String accessToken = getAccessToken();
        request.setHeader(AUTHORIZATION_HEADER_KEY, accessToken);
        request.setEndpoint(REST_SERVICE_ENDPOINT + account.Id);
        request.setMethod(PATCH_METHOD);
        request.setBody(JSON.serialize(account));
        HttpResponse response = httpConnection.send(request);
        Id accountId = (Id) JSON.deserialize(response.getBody(), Id.class);
        return accountId;
    }
    public static Id upsertAccount(Account account) {
        Http httpConnection = new Http();
        HttpRequest request = new HttpRequest();
        String accessToken = getAccessToken();
        request.setHeader(AUTHORIZATION_HEADER_KEY, accessToken);
        request.setEndpoint(REST_SERVICE_ENDPOINT);
        request.setMethod(PUT_METHOD);
        request.setBody(JSON.serialize(account));
        HttpResponse response = httpConnection.send(request);
        Id accountId = (Id) JSON.deserialize(response.getBody(), Id.class);
        return accountId;
    }
    private static String getAccessToken() {
        Http httpConnection = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(ACCESS_TOKEN_ENDPOINT);
        request.setMethod(POST_METHOD);
        HttpResponse response = httpConnection.send(request);
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        String token = (String) result.get(ACCESS_TOKEN_KEY);
        return BEARER_TOKEN_TYPE + token;
    } 
}