#!/bin/sh

# PROVIDE: bitcoin
# REQUIRE: LOGIN
# KEYWORD: shutdown

#
# Add the following lines to /etc/rc.conf.local or /etc/rc.conf
# to enable this service:
#
# bitcoin_enable (bool):	Set to NO by default.
#				Set it to YES to enable bitcoin.
# bitcoin_config (path):	Set to /usr/local/etc/bitcoin.conf
#				by default.
# bitcoin_user:	The user account bitcoin daemon runs as
#				It uses 'root' user by default.
# bitcoin_group:	The group account bitcoin daemon runs as
#				It uses 'wheel' group by default.
# bitcoin_datadir (str):	Default to "/var/db/bitcoin"
#				Base data directory.

. /etc/rc.subr

name=bitcoin
rcvar=bitcoin_enable

: ${bitcoin_enable:=NO}
: ${bitcoin_config=/usr/local/etc/bitcoin.conf}
: ${bitcoin_datadir=/var/db/bitcoin}
: ${bitcoin_user="root"}
: ${bitcoin_group="wheel"}

required_files=${bitcoin_config}
command=/usr/local/bin/bitcoind
bitcoin_chdir=${bitcoin_datadir}
pidfile="${bitcoin_datadir}/bitcoind.pid"
stop_cmd=bitcoin_stop
command_args="-conf=${bitcoin_config} -datadir=${bitcoin_datadir} -noupnp -daemon -pid=${pidfile}"
start_precmd="${name}_prestart"

bitcoin_create_datadir()
{
	echo "Creating data directory"
	eval mkdir -p ${bitcoin_datadir}
	[ $? -eq 0 ] && chown -R ${bitcoin_user}:${bitcoin_group} ${bitcoin_datadir}
}

bitcoin_prestart()
{
	if [ ! -d "${bitcoin_datadir}/." ]; then
		bitcoin_create_datadir || return 1
	fi
}

bitcoin_requirepidfile()
{
	if [ ! "0`check_pidfile ${pidfile} ${command}`" -gt 1 ]; then
		echo "${name} not running? (check $pidfile)."
		exit 1
	fi
}

bitcoin_stop()
{
    bitcoin_requirepidfile

	echo "Stopping ${name}."
	eval ${command} -conf=${bitcoin_config} -datadir=${bitcoin_datadir} stop
	wait_for_pids ${rc_pid}
}

load_rc_config $name
run_rc_command "$1"
