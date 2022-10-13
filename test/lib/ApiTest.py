import requests


APPLICATION_JSON = "application/json"

class ApiTest(object):
    '''API Class contains methods to execute testing requests'''

    def __init__(self, address, api_route):
        self.__api_full_address = address + "/" + api_route

    def get_request(self, endpoint, content_type=APPLICATION_JSON, authentication=None, token=None):
        '''
        Implement GET request
        Argument(s):
            - endpoint: parameter (For example: user)
            - content_type: header content type (For example: application/json)
            - authentication: basic authentication with username and password
            - token: token string taken from /auth/token
        Return:
            json repsonse
        '''
        request_url = self.__api_full_address + "/" + endpoint

        if authentication:
            session = requests.Session()
            session.auth = (
                authentication["username"], authentication["password"])

            response = session.get(request_url, headers={
                'Content-Type': content_type,
            })

        else:
            response = requests.get(url=request_url, headers={
                'Content-Type': content_type,
                'Token': token
            })

        return response.json()

    def post_request(self, endpoint, content_type=APPLICATION_JSON, body=None):
        '''
        Implement POST request to add new object
        Argument(s):
            - endpoint: parameter (For example: user)
            - content_type: header content type (For example: application/json)
            - body: request body with user info (For example: username, password, first_name, family_name, phone_number)
        Return:
            json repsonse
        '''
        request_url = self.__api_full_address + "/" + endpoint
        response = requests.post(url=request_url, json=body, headers={
            'Content-Type': content_type
        })

        return response.json()

    def put_request(self, endpoint, content_type=APPLICATION_JSON, body=None, token=None):
        '''
        Implement PUT request to modify object
        Argument(s):
            - endpoint: parameter (For example: user)
            - content_type: header content type (For example: application/json)
            - body: request body with object info (For example: username, password, first_name, family_name, phone_number)
            - token: token string taken from /auth/token
        Return:
            json repsonse
        '''
        request_url = self.__api_full_address + "/" + endpoint
        response = requests.put(url=request_url, json=body, headers={
            'Content-Type': content_type,
            'Token': token
        })

        return response.json()
