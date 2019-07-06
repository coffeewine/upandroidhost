#!"$PREFIX"/bin/sh

 # Copyright (c) 2019 coffeewine
 #
 # Permission to use, copy, modify, and distribute this software for any
 # purpose with or without fee is hereby granted, provided that the above
 # copyright notice and this permission notice appear in all copies.
 #
 # THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 # WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 # MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 # ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 # WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 # ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 # OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 #

#!"$PREFIX"/bin/sh

#this script needs gnu/wget (busybox wget doesn't handle ssl) and tsu packages.
#pkg install wget tsu
#give permission to execute: chmod +x androhost.sh
#type: tsu
#run: sh androhost.sh

#your hosts file here!
cp myhosts.txt hosts

#put your hosts url here:
hostlists='https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt
           https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
          '

for host in $hostlists; do
    "$PREFIX"/bin/wget "$host" -O tmphost
     cat tmphost >> sumhosts
done

sed -E -i 's/127.0.0.1|::/0.0.0.0/g' sumhosts 
sed -E -i '/0.0.0.0 |#/!d' sumhosts #delets all lines unless 0.0.0.0 or comments.
awk '!a[$0]++' sumhosts >> hosts #remove duplicates

/system/bin/mount -o rw,remount /system 
mv hosts /system/etc/hosts
/system/bin/mount -o ro,remount /system

rm tmphost sumhosts
