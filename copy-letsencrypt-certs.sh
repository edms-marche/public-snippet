marche@251-reverse-proxy:~$ sudo ls -l /etc/letsencrypt
total 40
drwxr-xr-x  3 root root 4096 Jan 19 18:43 accounts
drwx------ 13 root root 4096 May 11 18:02 archive
-rw-r--r--  1 root root  121 Feb 11  2019 cli.ini
drwxr-xr-x  2 root root 4096 May 11 18:02 csr
drwx------  2 root root 4096 May 11 18:02 keys
drwx------ 13 root root 4096 May 11 18:02 live
-rw-r--r--  1 root root  742 Jan 19 18:43 options-ssl-nginx.conf
drwxr-xr-x  2 root root 4096 May 11 18:02 renewal
drwxr-xr-x  5 root root 4096 Jan 19 18:43 renewal-hooks
-rw-r--r--  1 root root  424 Jan 19 18:43 ssl-dhparams.pem
marche@251-reverse-proxy:~$ 
marche@251-reverse-proxy:~$ sudo ls -l /etc/letsencrypt/archive
total 44
drwxr-xr-x 2 root root 4096 May  4 06:06 api.marchehk.com
drwxr-xr-x 2 root root 4096 May 10 03:03 edms.marche.com.hk
drwxr-xr-x 2 root root 4096 Mar 26 19:46 fa.marche.com.hk
drwxr-xr-x 2 root root 4096 May 11 07:10 hq.marche.com.hk
drwxr-xr-x 2 root root 4096 Mar 20 21:47 jb22.marche.com.hk
drwxr-xr-x 2 root root 4096 May  4 06:06 jb5.marche.com.hk
drwxr-xr-x 2 root root 4096 May 11 16:19 mail.marche.com.hk
drwxr-xr-x 2 root root 4096 May  4 06:06 m.marche.com.hk
drwxr-xr-x 2 root root 4096 May  5 20:56 rdp.marche.com.hk
drwxr-xr-x 2 root root 4096 May  4 06:06 rest.marche.com.hk
drwxr-xr-x 2 root root 4096 May 11 18:02 webmail.marche.com.hk
marche@251-reverse-proxy:~$ 
marche@251-reverse-proxy:~$ sudo ls -l /etc/letsencrypt/archive/mail.marche.com.hk
total 20
-rw-r--r-- 1 root root 1850 May 11 16:19 cert1.pem
-rw-r--r-- 1 root root 3750 May 11 16:19 chain1.pem
-rw-r--r-- 1 root root 5600 May 11 16:19 fullchain1.pem
-rw------- 1 root root 1704 May 11 16:19 privkey1.pem
marche@251-reverse-proxy:~$ 
marche@251-reverse-proxy:~$ sudo ls -l /etc/letsencrypt/live/mail.marche.com.hk
total 4
lrwxrwxrwx 1 root root  42 May 11 16:19 cert.pem -> ../../archive/mail.marche.com.hk/cert1.pem
lrwxrwxrwx 1 root root  43 May 11 16:19 chain.pem -> ../../archive/mail.marche.com.hk/chain1.pem
lrwxrwxrwx 1 root root  47 May 11 16:19 fullchain.pem -> ../../archive/mail.marche.com.hk/fullchain1.pem
lrwxrwxrwx 1 root root  45 May 11 16:19 privkey.pem -> ../../archive/mail.marche.com.hk/privkey1.pem
-rw-r--r-- 1 root root 692 May 11 16:19 README
marche@251-reverse-proxy:~$ 


Here on the server where letsencrypt cert is generated, you need public read permission

sudo mkdir /etc/letsencrypt/remote
sudo chmod 0777 /etc/letsencrypt/remote


# use scp command with -r to copy a directory
sudo scp -r /etc/letsencrypt/archive/mail.marche.com.hk marche@192.168.1.250:/etc/letsencrypt/remote/.


marche@250-docker-iredmail:~$ ls -l mail.marche.com.hk
total 20
-rw-r--r-- 1 marche marche 1850 May 13 15:39 cert1.pem
-rw-r--r-- 1 marche marche 3750 May 13 15:39 chain1.pem
-rw-r--r-- 1 marche marche 5600 May 13 15:39 fullchain1.pem
-rw------- 1 marche marche 1704 May 13 15:39 privkey1.pem
marche@250-docker-iredmail:~$ 

# use rsync (preferred)
sudo rsync -r /etc/letsencrypt/archive/mail.marche.com.hk marche@192.168.1.250:~/

# create crontab to update the renewed cert
sudo crontab -e

# rename cert files（用咗 docker volumn 所以唔使 rename）
cd mail.marche.com.hk
sudo cp fullchain2.pem fullchain.pem
sudo cp privkey2.pem privkey.pem

