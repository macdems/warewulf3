#!/bin/sh
ver=$1

git=$(git show -s --pretty=format:%h)

if [ "$2" = "git" ]; then
    ver="$ver+git$(date +%Y%m%d)+$git"
fi

for d in common cluster ipmi vnfs provision; do
    autoreconf -i $d
    rm -rf $d/autom4te.cache
    echo -n $git > $d/.gitversion
    tar cJf warewulf-${d}_${ver}.orig.tar.xz --exclude=.git --exclude=.pc --exclude=$d/debian $d
done
