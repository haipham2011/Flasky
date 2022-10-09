*** Settings ***
Documentation     Setup keywords.
Resource    ../resources/common_variables.robot
Library    SeleniumLibrary
Library    OperatingSystem
Library    ../lib/Utils.py
Library    ../lib/ApiTest.py    ${TEST_ADDRESS}    api


*** Keywords ***
Login Page Show Correct Elements In UI
    FOR    ${label}    IN    @{LOGIN_LABEL_LIST}
        Wait Until Page Contains    ${label} 
    END

    FOR    ${element}    IN    @{LOGIN_ELEMENTS_LIST}
        Wait Until Element Is Visible    ${element}
    END

Input Required Register Information
    [Arguments]    ${userInfo}
    Input Text    ${USER_NAME_INPUT}    ${userInfo}[username]
    Input Text    ${PASSWORD_INPUT}    ${userInfo}[password]
    Input Text    ${FIRST_NAME_INPUT}    ${userInfo}[firstname]
    Input Text    ${FAMILY_NAME_INPUT}    ${userInfo}[lastname]
    Input Text    ${PHONE_NUMBER_INPUT}    ${userInfo}[phone]

Navigate To Register Page
    Go To    ${TEST_ADDRESS}/register

Create New User
    [Arguments]    ${userInfo}
    Input Required Register Information    ${userInfo}
    Click Element    xpath=//input[@value='${REGISTER_TEXT}']

User Page Show User Information Table In UI
    Wait Until Element Is Visible    ${USER_NAME_SPAN}
    Wait Until Element Is Visible    ${USER_INFO_HEADER}

    ${rows}    Get Element Count    xpath=//table[@id="content"]/tbody/tr
    ${columns}    Get Element Count    xpath=//table[@id="content"]/tbody/tr[1]/th

    FOR    ${col}    IN RANGE    1    ${columns + 1}
        ${headerText}    Get Text    xpath=//*[@id="content"]/tbody/tr[1]/th[${col}]
        Should Be Equal    ${headerText}    ${USER_TABLE_HEADER_LIST}[${col - 1}]
    END
    
    FOR    ${i}    IN RANGE    2    ${rows + 1}
        ${dataKeys}    Get Text    xpath=//*[@id="content"]/tbody/tr[${i}]/td[1]
        ${userData}    Get Text    xpath=//*[@id="content"]/tbody/tr[${i}]/td[2]

        Should Be Equal    ${dataKeys}    ${USER_INFO_KEYS}[${i - 2}]
        Should Be Equal    ${userData}    ${USER_TABLE_DATA_VALUES}[${i - 2}]
    END

Error Page Show Message In UI
    FOR    ${element}    IN    @{ERROR_PAGE_REQUIRED_ELEMENTS}
        Wait Until Page Contains    ${element}
    END

Input Into Login Fields
    [Arguments]    ${user}
    Input Text    ${USER_NAME_INPUT}    ${user}[username]
    Input Text    ${PASSWORD_INPUT}    ${user}[password]
    Click Element    ${LOGIN_BUTTON}

Logout
    Click Element    ${LOGOUT_LINK}

Go To Link
    [Arguments]    ${link}
    Go To    ${TEST_ADDRESS}/${link}

Go To User Link
    Go To Link    user

Go To Login Link
    Go To Link    login

Create New User By API Method
    Post Request    users    body=${VALID_USER_INFO}

Get Token By API Method
    [Arguments]    ${userAuthentication}
    ${response}=    Get Request    auth/token    authentication=${userAuthentication}
    [return]  ${response}[token]

Assert Message And Status To Expected Result
    [Arguments]    ${response}    ${expectedStatus}    ${expectedMessage}
    Should Be Equal    ${response}[message]    ${expectedMessage}
    Should Be Equal    ${response}[status]    ${expectedStatus}