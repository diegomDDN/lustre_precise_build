#!/bin/bash
cd /vagrant/lustre/source/lustre-$LUSTRE_VERSION/debian
echo Y | ./prepare.sh /vagrant/lustre/debs/linux-image-*
cd /vagrant/lustre/source/lustre-$LUSTRE_VERSION
dpkg-buildpackage -rfakeroot -uc -us
mv /vagrant/lustre/source/*.deb /vagrant/lustre/debs/
exit
rm -rf  /var/lib/dkms/lustre-exascaler-2-1-client-modules
dh_clean
make clean
echo building dkms packages
rsync -a /vagrant/lustre/source/lustre-2.5.27.ddnpf2/*  /usr/src/lustre-client-modules-2.5.27.ddnpf2-1.0.0
dkms add -m lustre-client-modules-2.5.27.ddnpf2  -v 1.0.0 --all
dkms -m lustre-client-modules-2.5.27.ddnpf2  -v 1.0.0 --all
dkms mkdeb  -m lustre-client-modules-2.5.27.ddnpf2  -v 1.0.0 --all

mv  /var/lib/dkms/lustre-exascaler-2-1-client-modules/1.0.0/deb/*.deb /vagrant/lustre/debs
rm  /var/lib/dkms/lustre-exascaler-2-1-client-modules/1.0.0/tarball/*
dkms mkdsc -m lustre-exascaler-2-1-client-modules -v 1.0.0 --all
mv  /var/lib/dkms/lustre-exascaler-2-1-client-modules/1.0.0/dsc/*.dsc /vagrant/lustre/debs



