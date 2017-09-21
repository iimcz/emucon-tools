#
# Builds runc binary
#

__print_message 'Downloading OCI runc...'
go get -d github.com/opencontainers/runc
cd "${GOPATH}/src/github.com/opencontainers/runc"

__print_message 'Building OCI runc...'
make BUILDTAGS=''

__print_message 'Installing OCI runc...'
make install PREFIX="${HOME}/.local" BINDIR="${GOBIN}"

