#
# Builds runtime-tools binaries
#

__print_message 'Downloading OCI runtime-tools...'
dstdir="${GOPATH}/src/github.com/opencontainers/runtime-tools"
url='https://github.com/opencontainers/runtime-tools.git'
tag='v0.4.0'
mkdir -v -p "${dstdir}"
cd "${dstdir}"
git clone --depth 1 --branch "${tag}" "${url}" .

__print_message 'Building OCI runtime-tools...'
make

__print_message 'Installing OCI runtime-tools...'
make install PREFIX="${HOME}/.local" BINDIR="${GOBIN}"

