##razor-gitlab-pe-vagrant

1. vagrant up /master/ (Master of Masters - MoM)
2. add rule in PE Master group to match /compile/, add class profile::pupppetmaster to group
3. vagrant up /gitlab/
 - 3a. log into gitlab with root/5iveL!fe, create r10k_api_user, create user for you, create 'puppet' group and 'control-repo' project
 - 3b. make users above 'Master' members of the puppet/control-repo project
 - 3c. import control repo content by 'import repo by URL':  https://github.com/jpadams/control-repo.git
 - 3d. add you ssh key to your user from dev machine (if haven't done #6  git clone this repo, set remote to be gitlab, push)
 - 3e. log in as r10k_api_user, find the api token, classify master with profile::puppetmaster in console and set api token param
4. run puppet on master to create webhooks
5. vagrant up /compile/
6. vagrant up puppet.puppetlabs.demo (haproxy load balancer)
7. vagrant up /centos7a/ (agent)

To-do: open ports like 4433, 8123, 8081 on MoM only for API access.
