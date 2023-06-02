#!/bin/bash
sudo -i
lsblk
echo "TASK 1"
zpool list
zpool create otus1 mirror /dev/sdb /dev/sdc
zpool create otus2 mirror /dev/sdd /dev/sde
zpool create otus3 mirror /dev/sdh /dev/sdi
zpool create otus4 mirror /dev/sdh /dev/sdi
zpool list
zfs set compression=lzjb otus1
zfs set compression=lz4 otus2
zfs set compression=gzip-9 otus3
zfs set compression=zle otus4
for i in {1..4}; do wget -P /otus$i https://gutenberg.org/cache/epub/2600/pg2600.converter.log; done
zfs get all | grep compression


echo "TASK 2"
wget -O archive.tar.gz --no-check-certificate 'https://drive.google.com/u/0/uc?id=1KRBNW33QWqbvbVHa3hLJivOAt60yukkg&export=download&confirm=t&uuid=4968aa4f-b2bd-43f9-b0e6-0166c23a2df9&at=AKKF8vzb26OXgzK8BGBWapI4AjqV:1685720683678'
tar -xzvf archive.tar.gz 
zpool import -d zpoolexport/
zpool import -d zpoolexport/ otus
zfs get all otus
zfs get available otus
zfs get readonly otus
zfs get recordsize otus
zfs get compression otus
zfs get checksum otus


echo "TASK 3"
wget -O otus_task2.file --no-check-certificate "https://drive.google.com/u/0/uc?id=1gH8gCL9y7Nd5Ti3IRmplZPF1XjzxeRAG&export=download"
zfs receive otus/test@today < otus_task2.file 
VAR1=$(find /otus/test -name "secret_message")
cat $VAR1
