Heroku app name: sheltered-headland-1477

Install Imagick

$ cp config/application.example.yml config/application.yml

For postgres run rails in staging environment
$ rails s -e staging

If using bundler, wihout postgres installation run:
$ bundle install --without postgres

$ add config to heroku
$ heroku config:add AWS_ACCESS_KEY_ID=xxx AWS_SECRET_ACCESS_KEY=xxx GMAIL_USER_NAME=xxx GMAIL_PASSWORD=xxx