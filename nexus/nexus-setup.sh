#!/bin/bash

# default username/password for nexus3 is admin:admin123

# Install Nexus 3 and configure proxies and mirrors
oc new-project nexus --display-name "Nexus 3"
oc new-app sonatype/nexus3:latest
oc rollout pause dc nexus3
oc patch dc nexus3 --patch='{ "spec": { "strategy": { "type": "Recreate" }}}'
oc set resources dc nexus3 --limits=memory=2Gi,cpu=2 --requests=memory=1Gi,cpu=500m
oc set probe dc/nexus3 --liveness --failure-threshold 3 --initial-delay-seconds 60 -- echo ok
oc set probe dc/nexus3 --readiness --failure-threshold 3 --initial-delay-seconds 60 --get-url=http://:8081/repository/maven-public/
oc rollout resume dc nexus3
