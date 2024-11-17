#!/bin/bash

verif_ip() {
  local host_name="$1"
  local expected_ip="$2"
  local dns_server="$3"
  ip_nslookup=$(nslookup "$host_name" "$dns_server" | grep -m 1 "Address" | awk '{print $2}')
  if [ "$ip_nslookup" != "$expected_ip" ]; then
    echo "Bogus IP for $host_name in /etc/hosts"
  fi
}

cat /etc/hosts | while read ip nume
do
  if [ -n "$ip" ] && [ -n "$nume" ]; then
    dns_server="8.8.8.8"
    verif_ip"$nume" "$ip" "$dns_server"
  fi
done
