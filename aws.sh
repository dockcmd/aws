#!/bin/bash
. shmod

include github.com/dockcmd/shmod util.sh

# ensure settings directories exist
mkdir -p $HOME/.aws
mkdir -p $HOME/.kube

# must be run under bash or <(env) will cause an unexpected token `('
# to link: shln ln aws bash
exec_or_dryrun \
  `docker_run` \
  --env-file <(env|grep ^AWS_) \
  --mount type=bind,source=$HOME/.aws,target=/root/.aws,consistency=delegated \
  --mount type=bind,source=$HOME/.kube,target=/root/.kube,consistency=delegated \
  `docker_workdir` \
  `docker_image dockcmd/aws` \
  "$@"
