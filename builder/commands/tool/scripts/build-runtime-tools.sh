#
# Builds runtime-tools binaries
#

__print_message 'Downloading OCI runtime-tools...'
go get -d github.com/opencontainers/runtime-tools/cmd/oci-runtime-tool
cd "${GOPATH}/src/github.com/opencontainers/runtime-tools"

__print_message 'Building OCI runtime-tools...'
make

__print_message 'Installing OCI runtime-tools...'
make install PREFIX="${HOME}/.local" BINDIR="${GOBIN}"

