#!/bin/bash

oc create configmap kie-maven-settings --from-file=../conf/maven/settings.xml

oc new-app --template oshinko-scala-spark-build-dc \
-p APPLICATION_NAME=tutorial-drools \
-p GIT_URI=https://github.com/reynoldsm88/tutorial-radanalytics-scala-drools \
-p APP_MAIN_CLASS=io.radanalytics.tutorial.scala.drools.service.Main \
-p APP_FILE=service-assembly-0.0.1-SNAPSHOT.jar \
-p SBT_ARGS="clean assembly" \
-p APP_ARGS="kie.maven.settings.custom=/opt/conf/settings.xml" \
-p OSHINKO_CLUSTER_NAME="spark" \
-p GIT_REF="experimental"


sleep 2

oc rollout pause dc/tutorial-drools

oc set volume dc/tutorial-drools \
    --add --overwrite \
    --name=kie-maven-settings \
    -t configmap \
    --configmap-name=kie-maven-settings \
    -m /opt/conf \
    --default-mode=644

oc rollout resume dc/tutorial-drools
