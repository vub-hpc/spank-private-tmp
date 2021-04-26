#!/bin/bash

VERSION=$(grep "Version:.*[0-9]" slurm-spank-private-tmpdir.spec | tr -s " " |  awk '{print $2;}')
RELEASE=$(grep "%global rel.*[-1-9]" slurm-spank-private-tmpdir.spec | tr -s " " | awk '{print $3}')

#if [ "${RELEASE}" -gt 1 ]; then
    #SUFFIX=${VERSION}-${RELEASE}
#else
    SUFFIX=${VERSION}
#fi

GITTAG=$(git log --format=%ct.%h -1)

mkdir -p BUILD SOURCES SPECS RPMS BUILDROOT
git archive --format=tar.gz -o "SOURCES/slurm-spank-private-tmpdir-${SUFFIX}.tar.gz" --prefix="slurm-spank-private-tmpdir-${SUFFIX}/" HEAD
cp slurm-spank-private-tmpdir.spec "SPECS"
rpmbuild --define "gittag ${GITTAG}" --define "_topdir $PWD" -ba SPECS/slurm-spank-private-tmpdir.spec
