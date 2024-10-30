#!/bin/bash  

# Wait for Grafana to start  
sleep 10  

# Create the API key if it does not exist  
API_KEY=$(curl -s -H "Content-Type: application/json" \
  -d '{"name":"my-api-key","role":"Admin","secondsToLive":3600}' \
  -H "Authorization: Basic $(echo 'admin:admin' | base64)" \
  http://localhost:3000/api/auth/keys | jq -r .key)  

echo "Created API Key: $API_KEY"
