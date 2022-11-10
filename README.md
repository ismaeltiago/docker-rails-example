# docker-rails-example

## Get started

### Step 1

In your bash:

```
$ docker-compose build && docker-compose up -d && docker ps -a && docker-compose down && sudo chown $(whoami):$(whoami) -R . && docker-compose up -d && docker exec -it foo_app /bin/bash
```

### Step 2

Inside docker bash:

```
# rails new . --api --skip-git --database=postgresql -f && bundle install
```

### Step 3

Out of docker:

```bash
$ docker-compose down && sudo chown $(whoami):$(whoami) -R .
```

#### Update database.yml

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: <%= ENV.fetch("DATABASE_USERNAME") { "postgres" } %>
  password: <%= ENV.fetch("DATABASE_PASSWORD") { "password" } %>
  host: <%= ENV.fetch("DATABASE_HOST") { "localhost" } %>
  port: <%= ENV.fetch("DATABASE_PORT") { 5432 } %>

development:
  <<: *default
  database: <%= ENV.fetch("DATABASE_NAME") { "development" } %>

test:
  <<: *default
  database: foo_app_test

production:
  <<: *default
  database: foo_app_production
  username: foo_app
  password: <%= ENV["FOO_APP_DATABASE_PASSWORD"] %>

```


#### Start docker services and enter docker bash

```
$ docker-compose up -d && docker exec -it foo_app /bin/bash
```

### Step 4

Inside docker bash:

```
# bundle install && rails db:create
```

## Useful commands

### For Rails

#### Generating a scaffold

Inside docker bash:

```
# rails g scaffold Post title:string && rails db:migrate
```
#### Start the server

Out of docker:

```bash
$ docker exec -it foo_app bin/rails s -b 0.0.0.0
```

#### Start the rails console

Out of docker:

```bash
$ docker exec -it foo_app bin/rails c
```

### For Docker

#### Stop all docker-compose services

Out of docker:

```bash
$ docker-compose down
```

#### Stop and remove all docker services

Out of docker:

```bash
$ docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
```

#### Remove all docker volumes

Out of docker:

```bash
$ docker volume rm $(docker volume ls -q)
```

#### List all docker services


Out of docker:

```bash
$ docker ps - a
```
