# FROM centos:centos7
FROM golang:latest

LABEL maintainer="ponce.ballesteros@gmail.com"

ENV TRAVEL_HOME=/opt/travel_control \
    PATH=$TRAVEL_HOME:$PATH
    
WORKDIR $TRAVEL_HOME

RUN go get github.com/newrelic/go-agent

# instead of:
# COPY travel_control $TRAVEL_HOME/

# do these:
COPY go.mod $TRAVEL_HOME/
COPY go.sum $TRAVEL_HOME/
COPY travel_control.go $TRAVEL_HOME/
COPY types.go $TRAVEL_HOME/

COPY html $TRAVEL_HOME/html

# and this
RUN go build

ENTRYPOINT ["/opt/travel_control/travel_control"]
