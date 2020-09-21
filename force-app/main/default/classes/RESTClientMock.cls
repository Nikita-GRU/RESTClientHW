/**
 * Created by JJ93 on 20.09.2020.
 */

public with sharing class RESTClientMock implements HttpCalloutMock {
    public static final String GET_RESPONSE = JSON.serialize(new Account(Id='0012w00000L74Cq',Name = 'Test Account'));
    public static final String POST_RESPONSE = JSON.serialize('0012w00000L74Cq');
    public static final String DELETE_RESPONSE = JSON.serialize(true);
    public static final String PUT_RESPONSE = JSON.serialize('0012w00000L74Cq');
    public static final String PATCH_RESPONSE = JSON.serialize('0012w00000L74Cq');
    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
        if (request.getMethod().equals('GET')) {
            response.setBody(GET_RESPONSE);
        } else if (request.getMethod().equals('POST') && request.getEndpoint().equals(RESTClient.REST_SERVICE_ENDPOINT)) {
            response.setBody(POST_RESPONSE);
        } else if (request.getMethod().equals('DELETE')) {
            response.setBody(DELETE_RESPONSE);
        } else if (request.getMethod().equals('PUT')) {
            response.setBody(PUT_RESPONSE);
        } else if (request.getMethod().equals('PATCH')) {
            response.setBody(PATCH_RESPONSE);
        } else if (request.getMethod().equals('POST') && request.getEndpoint().equals(RESTClient.ACCESS_TOKEN_ENDPOINT)){
            response.setBody('{"access_token":"sample-token"}');
        }
        return response;
    }

}