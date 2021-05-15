#!/usr/bin/env bash
set -e
DORP=${DORP:-docker}
DOCKER_VERSION=v2_nrinstrumentation
IMAGE_HUB=danstadlernr


## Travel Control

DOCKER_TRAVEL_CONTROL=${IMAGE_HUB}/demo_travels_control
DOCKER_TRAVEL_CONTROL_TAG=${DOCKER_TRAVEL_CONTROL}:${DOCKER_VERSION}

rm -Rf docker/travel_control/travel_control docker/travel_control/html
rm -Rf docker/travel_control/go.mod docker/travel_control/go.sum
rm -Rf docker/travel_control/travel_control.go docker/travel_control/types.go

cd travel_control

go get github.com/newrelic/go-agent
go get github.com/newrelic/go-agent/v3/newrelic

cp go.mod ../docker/travel_control
cp go.sum ../docker/travel_control

cp travel_control.go ../docker/travel_control
cp types.go ../docker/travel_control

cp -R html ../docker/travel_control

cd ..

${DORP} build -t ${DOCKER_TRAVEL_CONTROL_TAG} docker/travel_control



## Travel Portal

DOCKER_TRAVEL_PORTAL=${IMAGE_HUB}/demo_travels_portal
DOCKER_TRAVEL_PORTAL_TAG=${DOCKER_TRAVEL_PORTAL}:${DOCKER_VERSION}

rm -Rf docker/travel_portal/travel_portal
rm -Rf docker/travel_portal/go.mod docker/travel_portal/go.sum
rm -Rf docker/travel_portal/travel_portal.go docker/travel_portal/types.go

cd travel_portal

go get github.com/newrelic/go-agent
go get github.com/newrelic/go-agent/v3/newrelic

cp go.mod ../docker/travel_portal
cp go.sum ../docker/travel_portal

cp travel_portal.go ../docker/travel_portal
cp types.go ../docker/travel_portal

cd ..

${DORP} build -t ${DOCKER_TRAVEL_PORTAL_TAG} docker/travel_portal





## these 2 are not yet converted:

## Travel LoadTester

DOCKER_TRAVEL_LOADTESTER=${IMAGE_HUB}/demo_travels_loadtester
DOCKER_TRAVEL_LOADTESTER_TAG=${DOCKER_TRAVEL_LOADTESTER}:${DOCKER_VERSION}

${DORP} build -t ${DOCKER_TRAVEL_LOADTESTER_TAG} docker/travel_loadtester

## MySQL

DOCKER_TRAVEL_MYSQL=${IMAGE_HUB}/demo_travels_mysqldb
DOCKER_TRAVEL_MYSQL_TAG=${DOCKER_TRAVEL_MYSQL}:${DOCKER_VERSION}

${DORP} build -t ${DOCKER_TRAVEL_MYSQL_TAG} docker/travel_agency/mysql





## Cars

DOCKER_TRAVEL_CARS=${IMAGE_HUB}/demo_travels_cars
DOCKER_TRAVEL_CARS_TAG=${DOCKER_TRAVEL_CARS}:${DOCKER_VERSION}

rm -Rf docker/travel_agency/cars/cars
rm -Rf docker/travel_agency/cars/cars.go docker/travel_agency/cars/go.mod docker/travel_agency/cars/go.sum

cd travel_agency/cars

go get github.com/newrelic/go-agent
go get github.com/newrelic/go-agent/v3/newrelic

cp go.mod ../../docker/travel_agency/cars
cp go.sum ../../docker/travel_agency/cars
cp cars.go ../../docker/travel_agency/cars

cd ../..

${DORP} build -t ${DOCKER_TRAVEL_CARS_TAG} docker/travel_agency/cars


## Discounts

DOCKER_TRAVEL_DISCOUNTS=${IMAGE_HUB}/demo_travels_discounts
DOCKER_TRAVEL_DISCOUNTS_TAG=${DOCKER_TRAVEL_DISCOUNTS}:${DOCKER_VERSION}

rm -Rf docker/travel_agency/discounts/discounts
rm -Rf docker/travel_agency/discounts/discounts.go docker/travel_agency/discounts/go.mod docker/travel_agency/discounts/go.sum

cd travel_agency/discounts

go get github.com/newrelic/go-agent
go get github.com/newrelic/go-agent/v3/newrelic

cp go.mod ../../docker/travel_agency/discounts
cp go.sum ../../docker/travel_agency/discounts
cp discounts.go ../../docker/travel_agency/discounts

cd ../..


${DORP} build -t ${DOCKER_TRAVEL_DISCOUNTS_TAG} docker/travel_agency/discounts

## Flights

DOCKER_TRAVEL_FLIGHTS=${IMAGE_HUB}/demo_travels_flights
DOCKER_TRAVEL_FLIGHTS_TAG=${DOCKER_TRAVEL_FLIGHTS}:${DOCKER_VERSION}

rm -Rf docker/travel_agency/flights/flights
rm -Rf docker/travel_agency/flights/flights.go docker/travel_agency/flights/go.mod docker/travel_agency/flights/go.sum

cd travel_agency/flights

go get github.com/newrelic/go-agent
go get github.com/newrelic/go-agent/v3/newrelic

cp go.mod ../../docker/travel_agency/flights
cp go.sum ../../docker/travel_agency/flights
cp flights.go ../../docker/travel_agency/flights

cd ../..

${DORP} build -t ${DOCKER_TRAVEL_FLIGHTS_TAG} docker/travel_agency/flights

## Hotels

DOCKER_TRAVEL_HOTELS=${IMAGE_HUB}/demo_travels_hotels
DOCKER_TRAVEL_HOTELS_TAG=${DOCKER_TRAVEL_HOTELS}:${DOCKER_VERSION}

rm -Rf docker/travel_agency/hotels/hotels
rm -Rf docker/travel_agency/hotels/hotels.go docker/travel_agency/hotels/go.mod docker/travel_agency/hotels/go.sum

cd travel_agency/hotels

go get github.com/newrelic/go-agent
go get github.com/newrelic/go-agent/v3/newrelic

cp go.mod ../../docker/travel_agency/hotels
cp go.sum ../../docker/travel_agency/hotels
cp hotels.go ../../docker/travel_agency/hotels

cd ../..

${DORP} build -t ${DOCKER_TRAVEL_HOTELS_TAG} docker/travel_agency/hotels

## Insurances

DOCKER_TRAVEL_INSURANCES=${IMAGE_HUB}/demo_travels_insurances
DOCKER_TRAVEL_INSURANCES_TAG=${DOCKER_TRAVEL_INSURANCES}:${DOCKER_VERSION}

rm -Rf docker/travel_agency/insurances/insurances
rm -Rf docker/travel_agency/insurances/insurances.go docker/travel_agency/insurances/go.mod docker/travel_agency/insurances/go.sum

cd travel_agency/insurances

go get github.com/newrelic/go-agent
go get github.com/newrelic/go-agent/v3/newrelic

cp go.mod ../../docker/travel_agency/insurances
cp go.sum ../../docker/travel_agency/insurances
cp insurances.go ../../docker/travel_agency/insurances

cd ../..

${DORP} build -t ${DOCKER_TRAVEL_INSURANCES_TAG} docker/travel_agency/insurances

## Travels

DOCKER_TRAVEL_TRAVELS=${IMAGE_HUB}/demo_travels_travels
DOCKER_TRAVEL_TRAVELS_TAG=${DOCKER_TRAVEL_TRAVELS}:${DOCKER_VERSION}

rm -Rf docker/travel_agency/travels/travels
rm -Rf docker/travel_agency/travels/travels.go docker/travel_agency/travels/go.mod docker/travel_agency/travels/go.sum

cd travel_agency/travels

go get github.com/newrelic/go-agent
go get github.com/newrelic/go-agent/v3/newrelic

cp go.mod ../../docker/travel_agency/travels
cp go.sum ../../docker/travel_agency/travels
cp travels.go ../../docker/travel_agency/travels

cd ../..

${DORP} build -t ${DOCKER_TRAVEL_TRAVELS_TAG} docker/travel_agency/travels



# ${DORP} login ${IMAGE_HUB}

${DORP} push ${DOCKER_TRAVEL_CONTROL_TAG}
${DORP} push ${DOCKER_TRAVEL_PORTAL_TAG}
${DORP} push ${DOCKER_TRAVEL_LOADTESTER_TAG}
${DORP} push ${DOCKER_TRAVEL_MYSQL_TAG}
${DORP} push ${DOCKER_TRAVEL_CARS_TAG}
${DORP} push ${DOCKER_TRAVEL_DISCOUNTS_TAG}
${DORP} push ${DOCKER_TRAVEL_FLIGHTS_TAG}
${DORP} push ${DOCKER_TRAVEL_HOTELS_TAG}
${DORP} push ${DOCKER_TRAVEL_INSURANCES_TAG}
${DORP} push ${DOCKER_TRAVEL_TRAVELS_TAG}

