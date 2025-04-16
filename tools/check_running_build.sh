#!/bin/bash
set -e

echo "$TRIGGER_BUILD_CONFIG_PATH"

MATCHING_BUILDS=$(gcloud builds list --ongoing --format 'value(id)' --filter="substitutions.TRIGGER_BUILD_CONFIG_PATH=\"$TRIGGER_BUILD_CONFIG_PATH\"")
MATCHING_COUNT=$(echo "$MATCHING_BUILDS" | wc -w)

if [ "$MATCHING_COUNT" -gt 1 ]; then
    echo "Found more than 1 matching running build(s):"
    echo "$MATCHING_BUILDS"
    exit 1
fi

echo "No other matching running builds found (or only one)."
exit 0
