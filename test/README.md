# Description
This project directory contains automated tests for demo_app

# List of features

## UI tests

1. Main page
- When user access main page, the "Demo app" title  should show
- When user access main page, the Register link should show
- When user access main page, the Login link should show
- When user access main page, the "index page" text should show

2. Register page
- When user click register, the browser should navigate to register page
- When user input /register address, the browser should navigate to register page
- When user open register page, the username text and input should show
- When user open register page, the password text and input should show
- When user open register page, the first name text and input should show
- When user open register page, the family name text and input should show
- When user open register page, the phone number text and input should show
- When user open register page, register button should show
- When user input username, password, firstname, familyname, phone number and click register, browser should navigate to Login page
- When user input empty fields, it is not allow to register
- When user register with the existed username, it should show message in the top

* What should improve:
- password too short and should have more rules to check password
- when user input text instead of number in phonenumber field, the website still allow to register
- user name still allow special characters

3. Login page
- When user click login, the browser should navigate to login page
- When user input /login address, the browser should navigate to login page
- When user open login page, Login header text field should show
- When user open login page, username text field should show
- When user open login page, password text field should show
- When user open login page, login button should show
- When user input valid test username and password, it should navigate to user page
- When user input invalid test username and password, it should navigate to error page
- When user input empty username and password, it should stay the same page

4. User app
* Preset: login with valid username and password
- When user input /user address, the browser should navigate to user page
- When user open user page, it show user name on top
- When user open user page, it show log out button on top
- When user open user page, it show User Information text
- When user open user page, it show table of username, firstname, lastname, phone number
- When user open user page, it show user information according to table fields
- When user click logout, it redirect to main page
- When user not login but access /user link, it does not show user table