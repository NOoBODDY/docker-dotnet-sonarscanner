#!/bin/bash

set -x

PROJECT_KEY="${PROJECT_KEY:-ConsoleApplication1}"
PROJECT_NAME="${PROJECT_NAME:-ConsoleApplication1}"
PROJECT_VERSION="${PROJECT_VERSION:-1.0}"
SONAR_HOST="${HOST:-http://localhost:9000}"
SONAR_TOKEN="${SONAR_TOKEN}"
PROJECT_USETEST="${PROJECT_USETEST}"

dotnet sonarscanner begin /k:"$PROJECT_KEY" /d:sonar.token="$SONAR_TOKEN" /d:sonar.host.url="$SONAR_HOST"
dotnet build

if [ "$PROJECT_USETEST" = "true" ]; then
    
  dotnet test
fi
dotnet sonarscanner end /d:sonar.token="$SONAR_TOKEN"
