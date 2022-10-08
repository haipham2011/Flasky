*** Settings ***
Documentation     Setup keywords.
Library    SeleniumLibrary
Library    OperatingSystem


*** Variables ***
${webAddress}    http://localhost:8080
${registerText}    Register
${loginText}    Log In


*** Keywords ***
Open Test Browser
    Open Browser    ${webAddress}

Teardown Setup
    Close Browser

Drop database
    Remove File    ../../../instance/demo_app.sqlite