---
AWS-CLI
---

# Build

```bash
docker build --build-arg AWS_VERSION_=1.16.145 -t dockcmd/aws:v1.16.145 .
docker build --build-arg AWS_VERSION_=1.16.306 -t dockcmd/aws:v1.16.306 .
```


# Usage of AWS

```bash

# docker bind mount fails if directory does not exist
mkdir -p $HOME/.aws
mkdir -p $HOME/.kube

docker run --rm \
  --env AWS_ACCESS_KEY_ID \
  --env AWS_SECRET_ACCESS_KEY \
  --env AWS_DEFAULT_REGION \
  --mount type=bind,source=$HOME/.aws,target=/root/.aws,consistency=delegated \
  --mount type=bind,source=$HOME/.kube,target=/root/.kube,consistency=delegated \
  --mount type=bind,source=$PWD,target=/wd,consistency=delegated \
  awscli:v1.16.306 --version
```

# Usage of awsts and awsrole

## Setup

```bash
# assumes shln installed
shln ln awsts
shln ln awsrole

# access to root account
export aws_access_key_id=<access key>
export aws_secret_access_key=<secret>
export mfa_serial=arn:aws:iam::<account>:mfa/<login>

aws configure set default.region us-east-2
aws configure set default.source_profile sts
aws configure set profile.sts.mfa_serial $mfa_serial

aws configure set profile.sts.aws_access_key_id $aws_access_key_id
aws configure set profile.sts.aws_secret_access_key $aws_secret_access_key 

aws configure set profile.dev.role_arn arn:aws:iam::<organizationaccount>:role/OrganizationAccountAccessRole
```

## Usage

```bash
# Authenticate using an MFA code using sts profile
awsts <mfa>

# List any s3 buckets in root account.
aws s3 ls

# Set the role to dev profile for another account
awsrole dev

aws s3 ls

# Subsequent awsts will stay on dev profile
```