#
# Bootstrapping for emucon-tools
#

curdir="$(dirname $(readlink -f $0))"
bindir="${curdir}/runtime/bin"

if [ ! -f "${bindir}/emucon-init.sh" ] ; then
	echo 'Unexpected directory layout!'
	echo 'Aborting...'
else
	echo 'Modifying PATH for current terminal session...'
	echo "Adding ${bindir}"

	export PATH="${bindir}:${PATH}"
fi

unset bindir
unset curdir

