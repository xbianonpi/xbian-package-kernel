#!/bin/sh

package=$(cat ./xbian-package-kernel/DEBIAN/control | grep Package | awk '{print $2}')
version=$(cat ./xbian-package-kernel/DEBIAN/control | grep Version | awk '{print $2}')

fakeroot find ./xbian-package-kernel  | grep -v DEBIAN/ | xargs md5sum > ./xbian-package-kernel/DEBIAN/md5sums 
fakeroot dpkg-deb -b ./xbian-package-kernel "${package}"-"${version}".deb