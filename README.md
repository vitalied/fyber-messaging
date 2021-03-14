# Fyber Messaging

## Setup

### Build app image
```
docker-compose build
```

### Database
#### Run postgresql and redis
```
docker-compose up -d postgres redis
```

#### Prepare DB
##### Create database, run migrations and add seed entries.
```
docker-compose run fyber_messaging bundle exec rails db:setup
```

## Run app
```
docker-compose up
```

## Run tests
```
docker-compose run fyber_messaging bundle exec rspec
```

## Access app

#### URL
http://localhost:3000

#### Headers
```
Authorization token_hash
Accept application/json
Content-Type application/json
```

## Access API docs

#### URL
http://localhost:8080
