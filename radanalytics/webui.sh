#!/bin/bash

oc create -f https://radanalytics.io/resources.yaml

oc new-app oshinko-webui
