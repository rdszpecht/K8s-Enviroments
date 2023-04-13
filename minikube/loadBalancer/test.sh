#!/bin/bash
for _ in {1..20}
do
  curl ${LB_IP}:5678
done