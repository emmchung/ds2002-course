#!/bin/bash
aws ec2 describe-instances | jq '.Reservations[].Instances[] | {
  ImageId: .ImageId,
  InstanceId: .InstanceId,
  InstanceType: .InstanceType,
  InstanceName: ((.Tags // []) | map(select(.Key=="Name")) | .[0].Value),
  PublicIpAddress: .PublicIpAddress,
  State: .State
}'
