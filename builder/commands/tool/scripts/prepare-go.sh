#
# Prepares GO toolchain
#

__print_message 'Installing GO toolchain...'
apt-get update
apt-get install -y git golang go-md2man

__print_message 'Setting up GO toolchain...'
mkdir -p "${HOME}/.local/bin"
cat >> "${HOME}/.profile" <<- EOF
	export GOPATH=${HOME}/work
	export GOBIN=${HOME}/.local/bin
	export PATH="${GOBIN}:${PATH}"
	export MANPATH=${HOME}/.local/share/man:"${MANPATH}"
EOF

. "${HOME}/.profile"

