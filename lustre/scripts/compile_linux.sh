#!/bin/bash
cd /mnt/vagrant/lustre/source/$KERNEL
make oldconfig
make kpkg-clean
DATE="`date -u +%F%H%M |sed -e 's/-//g'`"
if [ -z "${BUILDER}" ] ; then
 export BUILDER="jb23"
fi
if [ -z "${LUSTRE_VERSION}" ] ; then
 export LUSTRE_VERSION="exascaler-2-1"
fi
if [ -z "${KERNEL_VERSION}" ] ; then
KERNEL_VERSION="`pwd | sed -e 's#^/mnt/vagrant/lustre/source/linux-2.6.32-##' -e 's/.x86_64$//'`"
fi
CONCURRENCY_LEVEL=5  make-kpkg kernel-image kernel-headers kernel-source --append-to-version="-$BUILDER-$KERNEL_VERSION-$LUSTRE_VERSION" --revision=$DATE --rootcmd fakeroot --initrd
mv /mnt/vagrant/lustre/source/*.deb /vagrant/lustre/debs/

