#!/usr/bin/env sh

until curl --connect-timeout 5 --silent --output /dev/null --fail $SERVICE_URL; do
  echo "Waiting for DHIS2 service to be ready... $SERVICE_URL"
  sleep 5
done

curl --fail --silent --show-error --location --user "$USERNAME:$PASSWORD" --request POST $SERVICE_URL/api/resourceTables/analytics
CURL_EXIT_CODE=$?

if [ $CURL_EXIT_CODE -ne 0 ]; then
  echo "Analytics job failed with exit code: $CURL_EXIT_CODE"
  exit $CURL_EXIT_CODE
fi

echo "Analytics job completed successfully"
