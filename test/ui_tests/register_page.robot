*** Settings ***
Library    SeleniumLibrary
Resource    ./resources/setup.robot
Suite Setup    Open Test Browser
Suite Teardown    Run Keywords    Teardown Setup    Drop database

*** Variables ***
# Labels
${userNameLabel}    Username
${passwordLabel}    Password
${firstNameLabel}    First name
${familyNameLabel}    Family Name
${phoneNumberLabel}    Phone number    

# Input ids
${userNameId}    username
${passwordId}    password
${firstNameId}    firstname
${familyNameId}    lastname
${phoneNumberId}    phone  

# Input elements
${userNameInput}    xpath=//input[@id='${userNameId}']
${passwordInput}    xpath=//input[@id='${passwordId}']
${firstNameInput}    xpath=//input[@id='${firstNameId}']
${familyNameInput}    xpath=//input[@id='${familyNameId}']
${phoneNumberInput}    xpath=//input[@id='${phoneNumberId}']

# Button elements
${loginButton}    xpath=//input[@value='${loginText}']


*** Keywords ***    
Verify Page Contains Required Labels
    Wait Until Page Contains    ${userNameLabel}
    Wait Until Page Contains    ${passwordLabel}
    Wait Until Page Contains    ${firstNameLabel}
    Wait Until Page Contains    ${familyNameLabel}
    Wait Until Page Contains    ${phoneNumberLabel}
    Wait Until Element Is Visible    ${userNameInput}
    Wait Until Element Is Visible    ${passwordInput}
    Wait Until Element Is Visible    ${firstNameInput}
    Wait Until Element Is Visible    ${familyNameInput}
    Wait Until Element Is Visible    ${phoneNumberInput}

Input Required Register Information
    Input Text    ${userNameInput}    TestUserName
    Input Text    ${passwordInput}    TestPassword123@
    Input Text    ${firstNameInput}    TestFirstName
    Input Text    ${familyNameInput}    TestLastName
    Input Text    ${phoneNumberInput}    012345678


*** Test Cases ***
Verify Register Page
    Wait Until Page Contains    ${registerText}
    Click Element    xpath=//a[text()='${registerText}']
    Verify Page Contains Required Labels 
    Input Required Register Information
    Click Element    xpath=//input[@value='${registerText}']
    
Verify Login Page
    Wait Until Page Contains    ${loginText}
    Wait Until Page Contains    ${userNameLabel}
    Wait Until Page Contains    ${passwordLabel}
    Wait Until Element Is Visible    ${userNameInput}
    Wait Until Element Is Visible    ${passwordInput}
    Wait Until Element Is Visible    ${loginButton}
