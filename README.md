# POI Service

POI Service is a web application which is used to display Points of Interest (locations in a map), and then allow the creation of routes that connect all or a set of those points.

By using this application user can register them self create there point of interest. User can select their favorite point of interest create routes based on it.

The application contains various gems like geocoder for creating  Point of interest and using google direction API for generating map routes.


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


