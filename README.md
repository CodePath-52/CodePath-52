Original App Design Project - README Template
===

# FindDocs 🩺

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
FindDocs will look for the doctors or clinics nearby to help people browse throguh available doctors and make doctor appointments with ease. User can rate their doctors and the ratings are accessible to other users.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category**
    - Medical
- **Mobile: How uniquely mobile is the product experience?**
    - With user's mobile phone location, we can recommend them to the nearby doctors 
- **Story: How compelling is the story around this app once completed?**
    - Finding an appropriate doctor for symptoms can be difficult with the relevant information sometimes requiring looking at many different areas. This apps serves to streamline that information into one place.
- **Market: How large or unique is the market for this app?**
    - The app's target group is adult.
- **Habit: How habit-forming or addictive is this app?**
    - This app is not addictive as people only use it in need of medical service.
- **Scope: How well-formed is the scope for this app?**
    - We believe the app provide practical values even in its stripped down version.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [x] User can log in and out off the app
* [x] App will remember login even after the app closes
* [ ] User can select the type of doctor they're looking for (dermatologist, general physician, pediatrician, etc.)
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
* Home
	* [ ] User can view a list of doctors near them
* Rate
    * [ ] Prompt user to add their rating out of 5 stars, price range for the doctor, maybe a comment - present modally.
* User Profile
	* [x] Display user age, sex, and symptoms
	* [x] Display logout button
	* [x] Allow user to edit symptoms

### 3. Navigation

**Tab Navigation** (Tab to Screen)
	* [x] Home screen
	* [x] User profile screen

**Flow Navigation** (Screen to Screen)

* Login
    * &rarr; Home
    * &rarr; Register
* Register
    * &rarr; Home
* Home
    * &rarr; Rate if tap on doctor's table view cell
* Rate
    * &rarr; Home

## Wireframes
<img src="https://user-images.githubusercontent.com/50003319/163289773-f760ee21-9acd-46fc-9913-561d27348019.jpg" width=500>

## Prototypes
### Login
<img src="https://user-images.githubusercontent.com/50003319/162596228-fe710681-f979-4dfc-8b7b-fbeabb7de915.gif" width=250>

### Signup
<img src="https://i.imgur.com/ZAu8GHn.gif" width=250>

### User Profile
<img src="https://user-images.githubusercontent.com/50003319/163290089-f586d8f3-463f-4985-a24b-1a164a42578e.gif" width=250>


## Schema 
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
#### Home Screen
* (Read/GET) Get list of doctors near the user with symptoms
#### Rate Screen
* (Create/POST) Create a new rating
#### User Profile Screen
* (Update/PUT) Update user with new information
* (Delete) Delete existing ratings

### Additional APIs
* Google Maps
	* add endpoints
* Symptom Checker

- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
