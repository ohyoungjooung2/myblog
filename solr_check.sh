#!/usr/bin/env bash
ipaddr=$(ifconfig | grep inet | head -3 | tail -1 | awk -F':' '{print $2}' | awk  '{print $1}')
check(){
   RV=$?
   if  [[ $RV != "0" ]]
   then
       echo -e "\e[1;31m $JOB failed please check\e[0m"
       exit $RV
   else
       echo -e "\e[1;34m $JOB is(was) successful\e[0m"
   fi
}


kill_solr(){
  set -x
  SOLR_PID=$(ps -ef | grep solr | grep java | awk  '{print $2}' | head -1)
  if [[  $SOLR_PID  ]]
  then
  kill -9 $SOLR_PID
  sleep 9
  kill_solr
  JOB="killing solr"
  check
  else
   echo "Solr is not running"
  fi
  set +x
} 
start_solr(){
  bundle exec rake sunspot:solr:start RAILS_ENV="development"
  JOB="Staring solr gem search engine"
  check
}

start_rails_server(){
    JOB="STARTING RAILS DEVELOPMENT"
    kill_solr
    start_solr
    rails s -b $ipaddr -p 3333
    #check
}


echo -e "\e[1;33m Starting solr and rails development\e[0m"
start_rails_server
