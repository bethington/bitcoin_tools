mkdir /var/db/bitcoin/
fetch -o ~/ https://bitcoincore.org/bin/bitcoin-core-0.17.1/bitcoin-0.17.1-x86_64-linux-gnu.tar.gz
tar xzvf bitcoin-0.17.1-x86_64-linux-gnu.tar.gz
cp /root/bitcoin-0.17.1/bin/bitcoind /usr/local/bin/
fetch -o /usr/local/etc/rc.d/bitcoin https://raw.githubusercontent.com/bethington/bitcoin_tools/master/bitcoin.rc.d
fetch -o /usr/local/etc/bitcoin.conf https://raw.githubusercontent.com/bethington/bitcoin_tools/master/bitcoin.conf
edit /usr/local/etc/bitcoin.conf
chmod 555 /usr/local/etc/rc.d/bitcoin
echo "bitcoin_enable="YES"" >> /etc/rc.conf
service bitcoin start
