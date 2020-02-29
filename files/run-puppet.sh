#!/bin/bash
# change to the directory we keep puppet
cd /etc/puppet/code/environments/production && git pull --ff-only
# apply all of our puppet manifest files
puppet apply manifests/
