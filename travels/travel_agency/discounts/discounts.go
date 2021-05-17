package main

import (
	"encoding/json"
	"flag"
	"github.com/golang/glog"
	"github.com/gorilla/mux"
	"net/http"
	"os"
	"strconv"
	"time"
	"github.com/newrelic/go-agent/v3/newrelic"
)

type Discount struct {
	User string `json:"user"`
	Discount float32 `json:"discount"`
}

var (
	currentService = "discounts"
	currentVersion = "no-version"
	listenAddress = ":8092"
	instance = currentService + "/" + currentVersion

	chaosMonkey = false
	chaosMonkeySleep = 500 * time.Millisecond // Milliseconds to wait if chaosMonkey is enabled
	chaosMonkeyPortal = ""
	chaosMonkeyDevice = ""
	chaosMonkeyUser = ""

	nrAppName = ""
	nrLicenseKey = ""

)

func setup() {
	flag.Set("logtostderr", "true")
	flag.Parse()
	ss := os.Getenv("CURRENT_SERVICE")
	if ss != "" {
		currentService = ss
	}
	sv := os.Getenv("CURRENT_VERSION")
	if sv != "" {
		currentVersion = sv
	}
	instance = currentService + "/" + currentVersion

	la := os.Getenv("LISTEN_ADDRESS")
	if la != "" {
		listenAddress = la
		glog.Infof("LISTEN_ADDRESS=%s", listenAddress)
	} else {
		glog.Warningf("LISTEN_ADDRESS variable empty. Using default [%s]", listenAddress)
	}

	if os.Getenv("CHAOS_MONKEY") == "true" {
		chaosMonkey = true
		sleep := os.Getenv("CHAOS_MONKEY_SLEEP")
		if value, err := strconv.Atoi(sleep); err == nil {
			chaosMonkeySleep = time.Duration(value) * time.Millisecond
		}
		chaosMonkeyPortal = os.Getenv("CHAOS_MONKEY_PORTAL")
		chaosMonkeyDevice = os.Getenv("CHAOS_MONKEY_DEVICE")
		chaosMonkeyUser = os.Getenv("CHAOS_MONKEY_USER")
	}

	nran := os.Getenv("NR_APP_NAME")
	if nran != "" {
		nrAppName = nran
		glog.Infof("New Relic App Name was provided: [%s]", nrAppName)
	} else {
		glog.Errorf("NR_APP_NAME is empty !! Travel Control won't start")
		os.Exit(1)
	}

	nrlk := os.Getenv("NR_LICENSE_KEY")
	if nrlk != "" {
		nrLicenseKey = nrlk
		glog.Infof("New Relic License Key was provided: [%s]", nrLicenseKey)
	} else {
		glog.Errorf("NR_LICENSE_KEY is empty !! Travel Control won't start")
		os.Exit(1)
	}

}

func GetDiscounts(w http.ResponseWriter, r *http.Request) {

	txn := newrelic.FromContext(r.Context())
	s := txn.StartSegment("getDiscounts")
	defer s.End()

	portal := r.Header.Get("portal")
	device := r.Header.Get("device")
	params := mux.Vars(r)
	user := params["user"]
	discount := Discount{
		User: user,
		Discount: 0,
	}
	discountFrom := r.Header.Get("discountFrom")
	if user != "" {
		switch user {
		case "registered":
			discount.Discount = 0.10
		case "new":
			discount.Discount = 0.25
		default:
			discount.Discount = 0.05
		}
	}

	glog.Infof("[%s] GetDiscounts for user %s from %s \n", instance, user, discountFrom)

	releaseTheMonkey(portal, device, user)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(discount)
}

func releaseTheMonkey(portal, device, user string) {
	if chaosMonkey {
		glog.Infof("[%s] ChaosMonkey introduced %s \n", instance, chaosMonkeySleep.String())
		if (portal != "" && portal == chaosMonkeyPortal) ||
			(device != "" && device == chaosMonkeyDevice) ||
			(user != "" && user == chaosMonkeyUser) ||
			(portal == "" && device == "" && user == "") {
			time.Sleep(chaosMonkeySleep)
		}
	}
}

func main() {
	setup()
	app, err := newrelic.NewApplication(
		newrelic.ConfigAppName(nrAppName),
		newrelic.ConfigLicense(nrLicenseKey),
		newrelic.ConfigDistributedTracerEnabled(true),
	)
	_ = err

	glog.Infof("Starting %s \n", instance)
	router := mux.NewRouter()
	router.HandleFunc(newrelic.WrapHandleFunc(app, "/discounts/{user}", GetDiscounts)).Methods("GET")
	glog.Fatal(http.ListenAndServe(listenAddress, router))
}