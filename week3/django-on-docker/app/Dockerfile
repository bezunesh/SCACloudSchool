FROM python:3.9

# set work directory
WORKDIR /usr/src/app

# set environment variable
ENV PYTHONUNBUFFERED 1
   
# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy project
COPY . .