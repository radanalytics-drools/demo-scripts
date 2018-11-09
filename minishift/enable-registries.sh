#!/bin/bash

## @michael - TODO make this not hardcoded

oc create -f mireynol-registry-redhat-io-secret.yaml
oc secret add sa/builder secret/mireynol-registry-redhat-io-secret
oc secret add sa/deployer secret/mireynol-registry-redhat-io-secret
