*** Settings ***
Library    SeleniumLibrary
Resource    ./resources/setup.robot


*** Variables ***
${title}    Demo app
${header}    index page
${loginText}    Log In


*** Test Cases ***
Verify main page
    [Setup]    Open Test Browser
    Wait Until Page Contains    ${title}
    Wait Until Page Contains    ${header}
    ${urlRegister}=  Get Element Attribute   xpath=//a[text()='${registerText}']    href
    Should Be Equal    ${urlRegister}    ${webAddress}/register
    ${urlLogin}=  Get Element Attribute   xpath=//a[text()='${loginText}']    href
    Should Be Equal    ${urlLogin}    ${webAddress}/login
    [Teardown]    Teardown Setup