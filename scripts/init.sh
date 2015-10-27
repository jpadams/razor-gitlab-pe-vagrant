#!/bin/sh

# The purpose of this script is to provide a one-fire method of creating all
# virtual machines in the pe demo stack without bringing them up simultaneously
# or exhausting the 16GB of memory on a Macbook Pro (the hardware this stack is
# targeted for).

set -e
set -x

vagrant up /master/

# All I do is bring up each system in the stack and snap it unless it's master, solaris11a or razorclient
for i in `vagrant status '/^(?!(master|solaris|razor))/' | awk '/puppetlabs.demo/{ print $1 }'`;do
  vagrant up $i
  sleep 120
  vagrant snap take --name provisioned $i
  vagrant halt $i
done

vagrant snap take --name provisioned /master/
