#!/bin/bash
if docker ps | grep -w os
then 
  status=$(sudo curl -o /dev/null -s -w "%{http_code}" 192.168.99.102:85)
  if [[ $status == 200 ]]
  then 
    echo "ok"
  else  
   echo "There is some error"
   python3 /root/mail/Alert_mail.py
  fi
  else       
    docker run -dit -p 85:80 --name os rupali04/helloworld:latest
    sleep 10
    status=$(sudo curl -o /dev/null -s -w "%{http_code}" 192.168.99.102:85)
    if [[ $status == 200 ]]
    then 
      echo "ok"
    else  
      echo "There is some error"
    fi
 fi
                 
