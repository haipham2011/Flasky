*** Settings ***
Documentation     User page test suite.
Library    SeleniumLibrary
Resource    ../resources/setup.robot
Resource    ../resources/common_variables.robot
Resource    ../resources/common_keywords.robot
Suite Setup    UI Test Setup
Suite Teardown    UI Test Teardown


*** Keywords ***
Go To Login Link
    Go To    ${TEST_ADDRESS}/login

Login With Valid Account
    Input Into Login Fields    ${CORRECTED_USER_LOGIN}

Open New Tab And Go To User Page
    Execute Javascript    window.open('')
    Get Window Titles
    Switch Window    title=undefined
    Go To User Link

*** Test Cases ***
Browser Display User Information Table In User Page When User Already Login
    [Setup]    Navigate To Register Page
    Given Create New User    ${VALID_USER_INFO}
    And Go To Login Link
    And Login With Valid Account
    When Open New Tab And Go To User Page
    Then User Page Show User Information Table In UI
    [Teardown]    Logout