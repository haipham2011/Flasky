*** Settings ***
Documentation     Main page test suite.
Library    SeleniumLibrary
Resource    ../resources/setup.robot
Resource    ../resources/common_variables.robot
Resource    ../resources/common_keywords.robot
Suite Setup    UI Test Setup
Suite Teardown    UI Test Teardown


*** Variables ***
${TITLE}    Demo app
${HEADER}    index page
${LOGIN_TEXT}    Log In
@{REQUIRED_TEXTS}=    ${TITLE}    ${HEADER}
@{URL_LIST}=    ${TEST_ADDRESS}/register    ${TEST_ADDRESS}/login


*** Keywords ***
Main Page Show Required Texts
    FOR    ${text}    IN    @{REQUIRED_TEXTS}
        Wait Until Page Contains    ${text}
    END
    

*** Test Cases ***
Browser Display Required Texts and Links
    When Main Page Show Required Texts
    ${registerUrl}=  Get Element Attribute   xpath=//a[text()='${REGISTER_TEXT}']    href
    ${loginUrl}=  Get Element Attribute   xpath=//a[text()='${LOGIN_TEXT}']    href
    Then Should Be Equal    ${registerUrl}    ${TEST_ADDRESS}/register
    And Should Be Equal    ${loginUrl}    ${TEST_ADDRESS}/login