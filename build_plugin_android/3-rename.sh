#!/bin/bash

cd src/Plugin~/tools

find . -type f -name "*.txt" -exec sed -i 's/Java_org_webrtc/Java_org_unityrtc/g' {} +
