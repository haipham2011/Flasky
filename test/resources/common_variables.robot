*** Settings ***
Documentation     Setup variables.


*** Variables ***
${TEST_ADDRESS}    http://localhost:8080
${REGISTER_TEXT}    Register
${LOGIN_TEXT}    Log In

# Ids
${USER_NAME_ID}    username
${PASSWORD_ID}    password
${FIRST_NAME_ID}    firstname
${FAMILY_NAME_ID}    lastname
${PHONE_NUMBER_ID}    phone 

# Labels
${USER_NAME_LABEL}    Username
${PASSWORD_LABEL}    Password
${FIRST_NAME_LABEL}    First name
${FAMILY_NAME_LABEL}    Family Name
${PHONE_NUMBER_LABEL}    Phone number

# Header
${USER_INFO_TEXT}    User Information
${LOGIN_FAILED_HEADER}    Login Failure

# Message
${LOGIN_FAILED_MESSAGE}    You provided incorrect login details

# Input elements
${USER_NAME_INPUT}    xpath=//input[@id='${USER_NAME_ID}']
${PASSWORD_INPUT}    xpath=//input[@id='${PASSWORD_ID}']
${FIRST_NAME_INPUT}    xpath=//input[@id='${FIRST_NAME_ID}']
${FAMILY_NAME_INPUT}    xpath=//input[@id='${FAMILY_NAME_ID}']
${PHONE_NUMBER_INPUT}    xpath=//input[@id='${PHONE_NUMBER_ID}']

# Button
${LOGIN_BUTTON}    xpath=//input[@value='${LOGIN_TEXT}']

# Links
${LOGOUT_LINK}    xpath=//a[@href='/logout']

# User Page elements
${USER_NAME_SPAN}    xpath=//span[text()='TestUserName']
${USER_INFO_HEADER}    xpath=//h1[text()='${USER_INFO_TEXT}']

@{USER_TABLE_HEADER_LIST}=    key    value
@{USER_INFO_KEYS}=    Username    First name    Last name    Phone number
@{USER_TABLE_DATA_VALUES}=    TestUserName    TestFirstName    TestFamilyName    012345678
&{VALID_USER_INFO}=    username=TestUserName    password=TestPassword123@    firstname=TestFirstName    lastname=TestFamilyName    phone=012345678
&{EMPTY_USER_INFO}=    username=    password=TestPassword123@    firstname=    lastname=TestFamilyName    phone=
&{SHORT_PASSWORD_USER}=    username=UserShortPassword    password=T    firstname=TestFirstName    lastname=TestFamilyName    phone=012345678
&{INVALID_PHONE_NUM_USER}=    username=UserInvalidphone    password=TestPassword123@    firstname=TestFirstName    lastname=TestFamilyName    phone=abcdef
&{SPACE_INCLUDE_USER}=    username=Test User     password=TestPassword123@    firstname=TestFirstName    lastname=TestFamilyName    phone=012345678

@{LOGIN_LABEL_LIST}=    ${LOGIN_TEXT}    ${USER_NAME_LABEL}    ${PASSWORD_LABEL}
@{LOGIN_ELEMENTS_LIST}=    ${USER_NAME_INPUT}    ${PASSWORD_INPUT}    ${LOGIN_BUTTON}
&{CORRECTED_USER_LOGIN}=    username=${VALID_USER_INFO}[username]    password=${VALID_USER_INFO}[password]
&{WRONG_USER_LOGIN}=    username=TestUserName    password=TestPassword123

@{ERROR_PAGE_REQUIRED_ELEMENTS}=    ${LOGIN_FAILED_HEADER}    ${LOGIN_FAILED_MESSAGE}

# API tests
&{STATUS}=    success=SUCCESS    failure=FAILURE
${INVALID_USER_MESSAGE}    Invalid User
${INVALID_PASSWORD_MESSAGE}    Invalid Authentication