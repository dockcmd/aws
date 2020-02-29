#!/bin/bash

token_code=$1

# get profile from AWS_STS_PROFILE or default to sts
profile_sts=${AWS_PROFILE_STS-sts}

serial_number=$(aws configure get profile.$profile_sts.mfa_serial)

credentials=$(aws --profile $profile_sts sts get-session-token \
  --duration 129600 \
  --serial-number $serial_number \
  --token-code $token_code \
  --output text)

if [ ! $? -eq 0 ]; then
  echo $credentials
  exit 1
fi

read _ aws_access_key_id _ aws_secret_access_key aws_session_token _ <<< $credentials

aws configure set default.aws_access_key_id $aws_access_key_id
aws configure set default.aws_secret_access_key $aws_secret_access_key
aws configure set default.aws_session_token $aws_session_token