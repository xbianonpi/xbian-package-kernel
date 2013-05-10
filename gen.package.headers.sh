#!/bin/sh

package=$(cat ./xbian-package-headers/DEBIAN/control | grep Package | awk '{print $2}')
version=$(cat ./xbian-package-headers/DEBIAN/control | grep Version | awk '{print $2}')

fakeroot find ./xbian-package-headers  | grep -v DEBIAN/ | xargs md5sum > ./xbian-package-headers/DEBIAN/md5sums > /dev/null 2>&1
fakeroot dpkg-deb -b ./xbian-package-headers "${package}"-"${version}".deb