# Intial Setup

    docker-compose build
    docker-compose up mariadb
    # Once mariadb says it's ready for connections, you can use ctrl + c to stop it
    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml build

# To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

# To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

# Run the web server

    docker-compose up

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc

# URL encode Algorithm

During a research to find the way to get the smallest url, I could find a approach implemented by zumbojo using the bijective function. 
It consists on converting from an ID to base 62 given an array of valid characters, using it we just need to save the result on our DB.
When the app points the show method (by shorted code) our controller can find the long URL by the code that we have to redirect to the original one we have saved.

## Links from where I found the information
- https://gist.github.com/zumbojo/1073996
- https://byjus.com/maths/bijective-function/
- https://www.educative.io/courses/grokking-the-system-design-interview/m2ygV4E81AR
