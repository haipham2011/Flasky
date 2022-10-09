*** Settings ***
Documentation     Register page test suite.
Library    SeleniumLibrary
Resource    ../resources/setup.robot
Resource    ../resources/common_variables.robot
Resource    ../resources/common_keywords.robot
Suite Setup    UI Test Setup
Suite Teardown    UI Test Teardown


*** Variables ***
${LOGIN_ERROR_MESSAGE}    User ${VALID_USER_INFO}[username] is already registered.
@{LABEL_LIST}=    ${USER_NAME_LABEL}    ${PASSWORD_LABEL}    ${FIRST_NAME_LABEL}    ${FAMILY_NAME_LABEL}    ${PHONE_NUMBER_LABEL}
@{INPUT_LIST}=    ${USER_NAME_INPUT}    ${PASSWORD_INPUT}    ${FIRST_NAME_INPUT}    ${FAMILY_NAME_INPUT}    ${PHONE_NUMBER_INPUT}


*** Keywords ***    
Register Page Contains Required Elements
    FOR    ${label}    IN    @{LABEL_LIST}
        Wait Until Page Contains    ${label}  
    END
        
    FOR    ${input}    IN    @{INPUT_LIST}
        Wait Until Element Is Visible    ${input}
    END

Navigate to Register Page From Main Page
    Wait Until Page Contains    ${REGISTER_TEXT}
    Click Element    xpath=//a[text()='${REGISTER_TEXT}']

*** Test Cases ***
Browser Navigate To Login Page After Register Successfully
    Given Navigate to Register Page From Main Page
    When Register Page Contains Required Elements 
    And Create New User    ${VALID_USER_INFO}
    Then Login Page Show Correct Elements In UI

Browser Display Already Registered Message After User Register Existed Username
    Given Navigate to Register Page From Main Page
    When Create New User    ${VALID_USER_INFO}
    Then Wait Until Page Contains    ${LOGIN_ERROR_MESSAGE}

Browser Should Not Navigate To Login Page When User Leave Some Field Empty
    Given Navigate to Register Page From Main Page
    When Create New User    ${EMPTY_USER_INFO}
    Then Register Page Contains Required Elements

Browser Should Not Navigate To Login Page When User Type Short Password
    Given Navigate to Register Page From Main Page
    When Create New User    ${SHORT_PASSWORD_USER}
    Then Page Should Not Contain    ${LOGIN_TEXT}

Browser Should Not Navigate To Login Page When User Type Invalid Phone Number
    Given Navigate to Register Page From Main Page
    When Create New User    ${INVALID_PHONE_NUM_USER}
    Then Page Should Not Contain    ${LOGIN_TEXT}

Browser Should Not Navigate To Login Page When User Type Space Character in Username Field
    Given Navigate to Register Page From Main Page
    When Create New User    ${SPACE_INCLUDE_USER}
    Then Page Should Not Contain    ${LOGIN_TEXT}