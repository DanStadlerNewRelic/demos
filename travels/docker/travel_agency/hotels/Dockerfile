FROM golang:latest as builder

LABEL maintainer="ponce.ballesteros@gmail.com"

ENV TRAVEL_HOME=/opt/travel_agency \
    PATH=$TRAVEL_HOME:$PATH
    
WORKDIR $TRAVEL_HOME

COPY go.mod $TRAVEL_HOME/
COPY go.sum $TRAVEL_HOME/
RUN go mod download

COPY hotels.go $TRAVEL_HOME/

RUN go build -o /opt/travel_agency/hotels

# final stage:
FROM centos:centos7
COPY --from=builder /opt/travel_agency/hotels /opt/travel_agency/hotels

ENTRYPOINT ["/opt/travel_agency/hotels"]
