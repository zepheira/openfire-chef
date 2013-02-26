#!/usr/bin/env bash

set -o errexit

cd /
git add -A
sleep 5
git commit -m "automatic commit"
