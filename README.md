# Docker Transporter

Docker Image for [compose/transporter](https://github.com/compose/transporter).

This image is available for pulling from [Docker Hub](https://index.docker.io/u/dortort/transporter).

Launch this container with the following environment variables to suit your situation:

* PIPELINE (the inline application.js)

### Running this container

Running this container is as simple as running the following command:

    docker run -d \
        -e PIPELINE="Source({type: \"mongo\", uri:\"mongodb://user:pass@10.10.16.10:9999\", namespace: \"db.collection\", tail: true}).save({type: \"elasticsearch\", uri: \"http://10.10.16.20:80/\", namespace: \"search.doc\"})" \
        dortort/transporter:latest

