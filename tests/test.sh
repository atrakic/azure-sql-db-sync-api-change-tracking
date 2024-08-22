#!/bin/bash
# chmod +x
set -eo pipefail
curl -H "fromVersion: 0" localhost:5000/api/v1/training-session/sync
