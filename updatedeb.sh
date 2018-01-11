#!/bin/sh
ver=$1

git=$(cat common/.gitversion)

if [ "$2" = "git" ]; then
    ver="$ver+git$(date +%Y%m%d)+$git"
fi

for d in common cluster ipmi vnfs provision; do
    cd $d
    dch -v $ver-1 Upstream commit $git.
    perl -p -i -e s/UNRELEASED/xenial/ debian/changelog
    cd ..
done
