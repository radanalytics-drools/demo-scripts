#!/bin/bash

minishift config set memory 6Gb
minishift config set cpus 3

minishift addons install --defaults
minishift addons enable admin-user
minishift addons apply admin-user
