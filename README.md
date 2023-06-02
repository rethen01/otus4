1) Определить алгоритм с наилучшим сжатием
Наилучший алгоритм gzip-9

[root@zfs ~]# zfs get all | grep compression
otus1  compression           lzjb                   local
otus2  compression           lz4                    local
otus3  compression           gzip-9                 local
otus4  compression           zle                    local


[root@zfs ~]# ls -l /otus*
/otus1:
total 22050
-rw-r--r--. 1 root root 40941287 Jun  2 08:18 pg2600.converter.log

/otus2:
total 17986
-rw-r--r--. 1 root root 40941287 Jun  2 08:18 pg2600.converter.log

/otus3:
total 10956
-rw-r--r--. 1 root root 40941287 Jun  2 08:18 pg2600.converter.log

/otus4:
total 40010
-rw-r--r--. 1 root root 40941287 Jun  2 08:18 pg2600.converter.log

2) Определить настройки пула
Команда для скачивания архива:
wget -O archive.tar.gz --no-check-certificate 'https://drive.google.com/u/0/uc?id=1KRBNW33QWqbvbVHa3hLJivOAt60yukkg&export=download&confirm=t&uuid=4968aa4f-b2bd-43f9-b0e6-0166c23a2df9&at=AKKF8vzb26OXgzK8BGBWapI4AjqV:1685720683678'

[root@zfs tmp]# zpool import -d zpoolexport/
   pool: otus
     id: 6554193320433390805
  state: ONLINE
 action: The pool can be imported using its name or numeric identifier.
 config:

	otus                            ONLINE
	  mirror-0                      ONLINE
	    /var/tmp/zpoolexport/filea  ONLINE
	    /var/tmp/zpoolexport/fileb  ONLINE


[root@zfs tmp]# zfs get available otus
NAME  PROPERTY   VALUE  SOURCE
otus  available  350M   -
[root@zfs tmp]# zfs get readonly otus
NAME  PROPERTY  VALUE   SOURCE
otus  readonly  off     default
[root@zfs tmp]# zfs get recordsize otus
NAME  PROPERTY    VALUE    SOURCE
otus  recordsize  128K     local
[root@zfs tmp]# zfs get compression otus
NAME  PROPERTY     VALUE     SOURCE
otus  compression  zle       local




3) Работа со снапшотами
secret_messages: https://github.com/sindresorhus/awesome
