#!/bin/bash

USER='xxxx'
API_TOKEN='xxxxxx'
GIT_API_URL='https://api.github.com'
ORG='xxxx'

function get_all_repos {
  for ((i=1;i<=5;i++)); do
  curl -s -u "$USER:$API_TOKEN" -H "Accept: application/vnd.github.v3+json" $GIT_API_URL/orgs/$ORG/repos\?page\=$i | grep hooks | awk '{print $2}' > list.txt 
  done
}
 

function get_hooks {
  get_all_repos 
  for x in $(cat list.txt | sed -e 's/,//g' -e 's/"//g'); do
  webhook=$(curl -s -u "$USER:$API_TOKEN" -H "Accept: application/vnd.github.v3+json" ${x} | jq '.[].config.url')
    if [[ -n ${webhook} ]]; then

    echo Repo=${x} / Webhook=${webhook}
    
    fi
  done
  
}
get_hooks
