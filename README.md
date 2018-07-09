# article_persistance

Proof of concept rails application that persists data from an external json list by saving what is needed in the database

## Dependecies
* Ruby v2.3.0 or grater
* Rails v5.2.0 or grater
* MySQL v5.7.x

## Setup
* Clone the repository locally with `git clone git@github.com:lorandsandor/article_persistance.git`
* Run `bundle install`
* Run `bundle exec rake db:create db:migrate`

## Running the app

Run `bundle exec rails s` and navigate to `localhost:3000` in a browser.

## Running Specs

Run 'bundle exec rspec spec/'

### TO DO:
* Beef up coverage
* Sanitize has before displaying
* Prettify the article display format
* If more fields need persisted, switch update method from the controller to do `update_attributes`
* Hook up continuous integration (CircleCI preferred)
