#!/bin/bash
json_file="$HOME/ibm-concert/concert-hub/localstorage/volumes/infra/account-instances/0000-0000-0000-0000.json"
if [ -e $json_file ]; then
        sed -i ':a;N;$!ba;s/\n/ /g' $json_file
        contents="$(jq '.[1].instance_url = "https://concert:443"' $json_file)" && echo -E "${contents}" > $json_file
else
        echo "File $json_file not found"
fi
