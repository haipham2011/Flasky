*** Settings ***
Documentation     Setup before and after each test suites.
Resource    ../resources/common_variables.robot
Library    SeleniumLibrary
Library    OperatingSystem
Library    ../lib/Utils.py
Library    ../lib/ApiTest.py    ${TEST_ADDRESS}    api


*** Keywords ***
Initialize Database For Test
    Init Database
    
UI Test Setup
    Open Browser    ${TEST_ADDRESS}
    Initialize Database For Test

Drop database By Python
    Remove Database

UI Test Teardown
    Close Browser
    Drop database By Python