Recetas de Marta
================

Local Installation
------------------

### Dependencies

* Rails
* Imagick

### Config

Create config file by copying the example file and completing
the Gmail and AWS keys:

    $ cp config/application.example.yml config/application.yml

### Database

#### PostgreSQL

Postgres is used for full text search. The application will 
default to using a simple like search if postgres is not i.e. 
in the development and test environments, where sqlite is used 
as the DBMS instead.

If using bundler on a machine which does not have PostgreSQL 
installed, to avoid attempting to install the pg gem run:

    $ bundle install --without postgres

To use PostgreSQL while not in production, use the staging 
environment. Launch Rails with:

    $ rails s -e staging

... or

    $ RAILS_ENV=staging rails s

Launch the database with:

    $ RAILS_ENV=staging rails db

### Create initial local user

    $ rails runner script/new_user email@address.com true

Production Details
------------------

### Heroku App Name

Heroku app name: vast-escarpment-5894

### Heroku Config

    $ add config to heroku
    $ heroku config:add AWS_ACCESS_KEY_ID=xxx AWS_SECRET_ACCESS_KEY=xxx GMAIL_USER_NAME=xxx GMAIL_PASSWORD=xxx

### Create initial remote user

    $ heroku run rails runner script/new_user email@address.com true 