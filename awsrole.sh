#!/bin/sh

if [ $# -ne 1 ]; then
  echo "$(aws configure get role_arn)"
  exit
fi

profile=$1

role_arn=$(aws configure get profile.$profile.role_arn)

if [ ! $role_arn ]; then
  echo No role set for profile $profile
  exit 1
fi

aws configure set default.role_arn $role_arn
echo $role_arn