# FROM centos:centos7
FROM golang:latest as builder

LABEL maintainer="ponce.ballesteros@gmail.com"

ENV TRAVEL_HOME=/opt/travel_portal \
    PATH=$TRAVEL_HOME:$PATH
    
WORKDIR $TRAVEL_HOME

COPY go.mod $TRAVEL_HOME/
COPY go.sum $TRAVEL_HOME/
RUN go mod download

COPY travel_portal.go $TRAVEL_HOME/
COPY types.go $TRAVEL_HOME/
RUN go build -o /opt/travel_portal/travel_portal


# final stage:
FROM centos:centos7
COPY --from=builder /opt/travel_portal/travel_portal /opt/travel_portal/travel_portal
ENTRYPOINT ["/opt/travel_portal/travel_portal"]