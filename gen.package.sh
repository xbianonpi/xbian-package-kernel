#!/bin/sh

package=$(sed -ne 's/\(Package: \)\(.*\)/\2/p' ./content/DEBIAN/control)
version=$(sed -ne 's/\(Version: \)\(.*\)/\2/p' ./content/DEBIAN/control)

# calculate size dynamically. remove first any entry, then add the actual
sed -i '/Installed-Size:/d' ./content/DEBIAN/control
printf "Installed-Size: %d\n" $(du -s ./content | awk '{print $1}') >> ./content/DEBIAN/control

cd content
find ./ -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P\0' | sort -z| xargs --null md5sum > DEBIAN/md5sums
cd ..
fakeroot dpkg-deb -b ./content "${package}""${version}".deb

# remove the size again, because on different filesystems du will return different size
sed -i '/Installed-Size:/d' ./content/DEBIAN/control
