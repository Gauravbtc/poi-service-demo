# POI Service

POI Service is a web application which is used to display Points of Interest (locations in a map), and then allow the creation of routes that connect all or a set of those points.

By using this application user can register them self create there point of interest. User can select their favorite point of interest create routes based on it.

The application contains various gems like geocoder for creating  Point of interest and using google map direction API for generating map routes. Used Rspec gem for testing this application.

## APPROACH
I used the Agile software development methodology for developing this web application.

#### 1. Discovery & Planning

  I understand the detailed requirements of this application. Identifies third-party API service like google direction API which is used to create routes. Geocoder gem for creating Point of Interest of users. Device gem for User Registration, Login. Rspec gem for test cases and
  differentiate application into smaller modules like

  **User Module**: Registration, Login, Logout

  **Point Of Interest Module**: Create, Update, Delete User's Point of Interest

  **Routes**: Create Routes between the point of Interest

#### 2. Design
 Database Design for this application.

**User Module**: Create User table identifies it's fields and  validations

**Point Of Interest**: Create Location table which stores users location address, location latitude and longitude information. Design code structure of this application

#### 3. Development
**User Module**: Used device gem for users Registration, and Login features. Once the user login with the application unique auth_token is generated for the user and this token is required for the subsequent request. For auth_token creation (JWT) gem.

**Location Module**:
 Used Geocoder gem for Point of Interest CRUD Operations.
 Locations address, latitude, longitude information are store in Database

**Routes Module**: Used Google direction API for routes creations.
  User can select their point of Interest locations and call Routes
  creation API in response will give details information of routes.
  Develop Route API service which is used for executing Google Direction API calls based for executing HTTP request call I used Rest Client gem

#### 4. Testing
  Using Rspec for test case generations.

**Model Test**:
      it Tests application models validation and methods current system has two models User and Location

**Controller Test**: it tests application Controllers logic with all possible actions. the current system has a Location Controller test.

## Release Note
#### Version 1
  i) Use Rails Internationalization

  ii) Code refactoring

  iii) Exception Handling


## Pre Requirements

Ruby : 2.7.2

Rails : 6.0.3

Database: Postgres

Google Map API Key


## Follow below steps to setup your development environment

Step 1 : take a clone for this repository

```bash
https://github.com/Gauravbtc/poi-service-demo.git
```
Step 2 : Go to the project directory

```bash
cd poi-service-demo
```

Step 3: Install requires RVM for ruby 2.7.2

Step 4: Rename sample_databse.yml to database.yml and put your database
        credentials

Step 5: Rename sample_secrets.yml to secrets.yml and place your secerets key and google map api key

Step 6: Do bundle install
```
bundle install
```

Step 7: Web packer install
```
rails webpacker:install
```

Step 8: Add stimulus package
```
yarn add stimulus
```

Step 9: Create a database and run migrations
```
rails db:create
rails db:migrate
```

Step 10: Run Rails Server
```
rails s
```

## API Documentation

http://localhost:3000/api-docs/index.html


## Run Test Cases

```
bundle exec rails db:migrate -e test

bundle exec rspec
```

## Class Diagram

![POI_Class_Diyagram](https://user-images.githubusercontent.com/16643699/98346003-c046ac00-2058-11eb-8026-c5a630c8b85f.png)

## Swagger Document

![swagger](https://user-images.githubusercontent.com/16643699/98345530-21ba4b00-2058-11eb-864f-cf4022b8feee.png)
