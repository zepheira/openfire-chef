#!/usr/bin/env bash
# check / into git so we can track all changes

yum install -y git

cd /
if [ -d .git ]; then
	exit
fi

cat << 'EOF' > ~/.gitconfig
[user]
	name = vagrant
	email = vagrant@localhost
[color]
	branch = auto
	status = auto
	diff = auto
[color "diff"]
	meta = yellow
	frag = cyan
	old = red
	new = green
[color "branch"]
	current = yellow reverse
	local = yellow
	remote = green
[color "status"]
	added = yellow
	changed = green
	untracked = cyan
[alias]
	st = status
	ci = commit
	co = checkout
	br = branch
	lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative
	vimdiff = "difftool -y -t vimdiff"
EOF

git init .

cat << 'EOF' > .git/info/exclude
.autofsck
.autorelabel
etc/blkid/blkid.tab*
dev
proc
sys
tmp
vagrant
var/cache/yum
var/chef/backup
var/chef/cache
var/lib/dhclient
var/lib/pgsql/data/base
var/lib/pgsql/data/global
var/lib/pgsql/data/pg_*
var/lib/rpm/__db.*
var/lib/yum
var/lock
var/log
var/run
EOF

git add -A
# this is a big commit, so keep it quiet with -q
git commit -q -m "initial commit"
