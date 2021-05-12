FROM golang:latest as builder

LABEL maintainer="ponce.ballesteros@gmail.com"

ENV TRAVEL_HOME=/opt/travel_control \
    PATH=$TRAVEL_HOME:$PATH
    
WORKDIR $TRAVEL_HOME

COPY go.mod $TRAVEL_HOME/
COPY go.sum $TRAVEL_HOME/
RUN go mod download

COPY travel_control.go $TRAVEL_HOME/
COPY types.go $TRAVEL_HOME/
COPY html $TRAVEL_HOME/html

RUN go build -o /opt/travel_control/travel_control

# final stage:
FROM centos:centos7
COPY --from=builder /opt/travel_control/travel_control /opt/travel_control/travel_control

WORKDIR $TRAVEL_HOME
COPY html $TRAVEL_HOME/html

ENTRYPOINT ["/opt/travel_control/travel_control"]
