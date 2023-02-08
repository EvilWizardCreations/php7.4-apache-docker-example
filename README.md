# PHP 7.4 & Apache Dockerfile Example

A base PHP 7.4 Apache 2 image[^docker_pull_cmd_note] for demonstrating legacy projects available at [EWC Docker Hub](https://hub.docker.com/r/ewc2020/web).

An old version of ***PHP*** that some codebase sites still require to emulate a ***production*** environment to run in.

Other Packages Included:

- Node
- Composer
- libxml2-dev
- libzip-dev
- libyaml-dev
- zip
- git
- nodejs
- default-mysql-client
- vim
- npm i npm@latest -g
- yaml

PHP Extensions:

- gettext 
- mysqli 
- pdo_mysql 
- zip
- yaml


## Build Image

Build the ***Docker Image*** without using ***cached*** versions of previous image build stages.

**N.B.**

This ***requires*** that the file be named `Dockerfile` and nothing else.

```bash
sudo docker build --target php-7-4-build --no-cache -t php-7-4-web-server .
```

### Create A Container

This creates a named container and attaches it to the ***host network*** and may cause port conflict if the host machine is already listening on any exposed ports from the ***Docker Image*** being used.

```bash
sudo docker run -d --network host --name container-name php-7-4-web-server
```

**OR**

This creates a named container and attaches it to the ***bridge network*** and allows for ***port forward mapping*** from the ***host*** to the ***Container***.  The ports are mapped **8080** on the ***Host*** machine to port **80** on the ***Container***

```bash
sudo docker run -d --network bridge --expose 8080:80 --name container-name php-7-4-web-server
```

### Start Container

```bash
sudo docker start php-7-4-web-server
```

### Stop Container

```bash
sudo docker stop php-7-4-web-server
```

## Docker Compose

A `docker-compose` configuration file is included to simplify the build & deployment of the image.

### Build - No Cache

This is only necessary when completely rebuilding the image to make sure all parts are rebuilt[^compose_name_note].

```bash
sudo docker-compose build --no-cache php-7-4-web-server
```

### Build & Up

This will try to use a local version or rebuild the image with current context.

```bash
sudo docker-compose up --build -d
```

## Connect To Container

```bash
sudo docker exec -it php-7-4-web-server /bin/bash
```

[^docker_pull_cmd_note]: Use `docker pull ewc2020/web:php-7.4-apache` to get a copy of the image.

[^compose_name_note]: The `php-7-4-web-server` container name to build the image for.
