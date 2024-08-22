#!/bin/bash
# chmod +x
set -eo pipefail
curl localhost:5000/api/v1/training-session/sync/1
