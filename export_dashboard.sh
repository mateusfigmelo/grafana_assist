#!/bin/bash  

# Variables  
GRAFANA_URL="http://localhost:3000"  # Change this to your Grafana URL  
GRAFANA_API_KEY="YOUR_GRAFANA_API_KEY"  # Set your Grafana API key here  
DASHBOARD_DIR="./exported_dashboards"  

# Create directory for dashboards if it doesn't exist  
mkdir -p $DASHBOARD_DIR  

# Fetch all dashboards  
DASHBOARDS=$(curl -s -H "Authorization: Bearer $GRAFANA_API_KEY" "${GRAFANA_URL}/api/search?query=" | jq -r '.[].uid')  

for DASHBOARD_UID in $DASHBOARDS; do  
    # Fetch the dashboard JSON  
    DASHBOARD_JSON=$(curl -s -H "Authorization: Bearer $GRAFANA_API_KEY" "${GRAFANA_URL}/api/dashboards/uid/$DASHBOARD_UID")  

    # Get the dashboard title  
    DASHBOARD_TITLE=$(echo $DASHBOARD_JSON | jq -r '.dashboard.title' | sed 's/[^a-zA-Z0-9_-]/_/g')  

    # Save the dashboard JSON to a file  
    echo $DASHBOARD_JSON > "${DASHBOARD_DIR}/${DASHBOARD_TITLE}.json"  
done
