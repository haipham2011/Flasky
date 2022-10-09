*** Settings ***
Documentation     Login page test suite.
Library    SeleniumLibrary
Resource    ../resources/setup.robot
Resource    ../resources/common_variables.robot
Resource    ../resources/common_keywords.robot
Suite Setup    UI Test Setup
Suite Teardown    UI Test Teardown


*** Variables ***
&{EMPTY_USER_LOGIN}=    username=    password=TestPassword123

*** Keywords ***
Login With Valid Account
    Input Into Login Fields    ${CORRECTED_USER_LOGIN}
    
Login With Invalid Account
    Input Into Login Fields    ${WRONG_USER_LOGIN}

Login With Empty Fields
    Input Into Login Fields    ${EMPTY_USER_LOGIN}


*** Test Cases ***
Browser Display User Information Table When User Input Correct Username
    [Setup]    Navigate To Register Page
    Given Create New User    ${VALID_USER_INFO}
    And Go To Login Link
    Then Login Page Show Correct Elements In UI
    When Login With Valid Account
    Then User Page Show User Information Table In UI
    [Teardown]    Logout

Browser Display Error Message When User Input Wrong Username
    Given Go To Login Link
    When Login With Invalid Account
    Then Error Page Show Message In UI
    
Browser Not Navigate To User Page When User Not Input Username Or Password
    Given Go To Login Link
    When Login With Empty Fields
    Then Page Should Not Contain    ${USER_INFO_HEADER}
