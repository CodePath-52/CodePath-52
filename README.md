Original App Design Project - README Template
===

# APP_NAME_HERE

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
An app that will look for the doctors or clinics nearby to help people look for the appropriate doctors and make doctor appointments with ease. User can rate their doctors and the ratings are accessible to all the users.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category**
    - Medical
- **Mobile: How uniquely mobile is the product experience?**
    - What makes your app more than a glorified website?
    - Try for 2 or more of these: maps, camera, location, audio, sensors, push, real-time, etc
    - Answer: With user's location, we can recommend them to the nearby doctors 
- **Story: How compelling is the story around this app once completed?**
    - How clear is the value of this app to your audience?
    - How well would your friends or peers respond to this product idea?
    - Answer: Finding an appropriate doctor for symptoms can be difficult with the relevant information sometimes requiring looking at many different areas. This apps serves to streamline that information into one place.
- **Market: How large or unique is the market for this app?**
    - What's the size and scale of your potential user base?
    - Does this app provide huge value to a niche group of people?
    - Do you have a well-defined audience of people for this app?
    - Answer: This app doesn't have a targeted group
- **Habit: How habit-forming or addictive is this app?**
    - How frequently would an average user open and use this app?
    - Does an average user just consume your app or do they create?
    - Answer: This app is not addictive as people only use it in need of medical service.
- **Scope: How well-formed is the scope for this app?**
    - How technically challenging will it be to complete this app by the end of the program?
    - Is a stripped-down version of this app still interesting to build?
    - How clearly defined is the product you want to build?
    - Answer: It will be fairly challenging to gather doctors' information

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [x] Users can log in and out off the app
* [x] App will remember login even after the app closes
* [ ] Users can select the type of doctor they're looking for (dermatologist, general physician, pediatrician, etc.)
* [ ] App will display contact information of local doctors of the appropriate type (in the local area)


**Optional Nice-to-have Stories**

* [ ] Infinite scroll -- the lower you scroll, the farther away the doctors get.
* [ ] Users can rate the doctor after they've visited
* [ ] App will display the rating of the doctor
* [ ] Users can leave comments for each doctor
* [ ] App will display expanded information of each doctor when the appropriate cell is tapped

### 2. Screen Archetypes

* Login
   * [x] Prompt user to enter username and password
   * [x] Link to register if new user
   * [x] Verify username and password
   * [ ] Show appropriate error message if needed (e.g. wrong password, username doesn't exist)
* Register
   * [x] Prompt user to enter username and password
   * [x] Confirm password
   * [ ] Verify username and password before creating new user
   * [x] Show appropriate error message if needed (e.g. passwords don't match, username already exists)
* Stream
    * User can view a list of doctors near them
* Rate
    * Prompt user to add their rating out of 5 stars, price range for the doctor, maybe a comment - present modally.
* User Profile
    * Prompt user to enter age, sex, illness

### 3. Navigation

**Tab Navigation** (Tab to Screen)
* Home
* User Profile

**Flow Navigation** (Screen to Screen)

* Login
    * &rarr; User Profile
* Register
    * &rarr; User Profile
* Stream
    * &rarr; Rate if tap on doctor's table view cell
* Rate
    * &rarr; Stream

## GIFs
### Login
<img src="https://user-images.githubusercontent.com/50003319/162596228-fe710681-f979-4dfc-8b7b-fbeabb7de915.gif" width=250>

### Sign Up
<img src="https://i.imgur.com/ZAu8GHn.gif" width=250>


## Wireframes
<img src="https://user-images.githubusercontent.com/50003319/161401510-436bf12a-2b2d-4072-9d4b-315f2af2806c.jpeg" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models

#### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | userId      | String   | unique id for the user (default field) |
   | symptoms        | array of strings| list of symptoms |
   | age       | Integer   | user's age|
   | sex | String   | user's sex |
   | username | String | username |
   | password | String | password |

#### Doctor

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | doctorId      | String   | unique id for the doctor (default field) |
   | location        | dictionary of doubles | {'latitude':..., 'longtitude':...} |
   | rating         | Float     | average rating of doctor |
   | sex       | String   | doctor's sex |
   | type | String   | type of doctor |
   | phoneNumber    | String   | phone number of doctor |
   | hours     | array of paired DateTimes | availability of doctor |
   | website     | String | website of doctor for more information (optional) |
   
#### Rating

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | doctor      | Pointer to Doctor   | Doctor being rated |
   | user        | Pointer to User | User being rated (object uniquely identified by doctor-user pair) |
   | rating         | Float     | rating of doctor |
   | title       | String   | title of rating |
   | description | String   | description of rating |

### Networking
#### Login Screen
* (Create/POST) Login user given username and password
#### Register Screen
* (Create/POST) Create a new user with age, sex, symptoms, username, password, etc.
#### Stream Screen
* (Read/GET) Get list of doctors near the user
* (Read/GET) Get list of doctors near the user with applied filters/preferences
#### Rate Screen
* (Create/POST) Create a new rating
#### User Profile Screen
* (Update/PUT) Update user with new information
* (Delete) Delete existing ratings

- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
