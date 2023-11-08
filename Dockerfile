FROM python:3.10-buster

USER root

# These can be overridden on container run using the -e flag
ENV DB_USERNAME=postgres
ENV DB_PASSWORD=
ENV DB_NAME=postgres
ENV DB_HOST=127.0.0.1
ENV DB_PORT=5432


RUN apt update -y && apt install postgresql-contrib -y

USER root

WORKDIR /src

COPY ./analytics/requirements.txt requirements.txt

# Dependencies are installed during build time in the container itself so we don't have OS mismatch
RUN pip install -r requirements.txt

COPY ./analytics .

# Start the database and Flask application
CMD python app.py
