#!/bin/bash

cat << EOF >> ai-workflows-values.yaml
rna:
  instance:
    ai:
      watsonx_auth_type: "iam"
      watsonx_api_key: "$WATSONX_API_KEY"
      watsonx_project_id: "$WATSONX_API_PROJECT_ID"
      watsonx_cluster_url: "$WATSONX_API_URL"
EOF
