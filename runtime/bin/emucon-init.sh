#
# Initialization for emucon scripts
#

if ! which emucon-paths > /dev/null ; then
	echo "[${__cmd_name}] emucon-paths not found in PATH!" >&2
	echo "[${__cmd_name}] Unexpected directory layout!" >&2
	echo "[${__cmd_name}] Aborting..." >&2
	exit 1
fi

# Try to import helper functions
__helpers=$(emucon-paths helpers.sh)
__return_code=$?

# Lookup failed?
if [ ${__return_code} -ne 0 ] ; then
	exit ${__return_code}
fi

. "${__helpers}"

# Clean up
unset __return_code
unset __helpers

# Handler to be called on termination signals
__on_termination() {
	emucon_print_error 'Termination signal received!'
	emucon_abort -v
}

# Possible cleanup callbacks should
# be registered using the EXIT signal!
trap __on_termination QUIT INT TERM

