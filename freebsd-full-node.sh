mkdir /var/db/bitcoin/
cd /usr/local/etc/rc.d
fetch -o /usr/local/etc/rc.d/bitcoin https://raw.githubusercontent.com/bethington/bitcoin_tools/master/bitcoin.rc.d
fetch -o /usr/local/etc/bitcoin.conf https://raw.githubusercontent.com/bethington/bitcoin_tools/master/bitcoin.conf
edit /usr/local/etc/bitcoin.conf
chmod 555 /usr/local/etc/rc.d/bitcoin
echo "bitcoin_enable="YES"" >> /etc/rc.conf
service bitcoin start
