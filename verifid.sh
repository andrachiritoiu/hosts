#!/bin/bash

cat /etc/hosts | while read ip nume
do
  if [ -n "$ip" ] && [ -n "$nume" ]; then
    ip_nslookup=$(nslookup "$nume" | grep -m 1 "Address" | awk '{print $2}')#tipareste a doua coloana
    if [ "$ip" != "$ip_nslookup" ]; then
      echo "Bogus IP for <nume> in /etc/hosts"
    fi
  fi
done
