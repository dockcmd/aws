---
AWS-CLI
---

# Build

```bash
docker build --build-arg AWS_VERSION_=1.16.145 -t dcmd/aws:v1.16.145 .
docker build --build-arg AWS_VERSION_=1.16.306 -t dcmd/aws:v1.16.306 .
```

# Usage

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
  dcmd/aws:v1.16.306 --version
```
