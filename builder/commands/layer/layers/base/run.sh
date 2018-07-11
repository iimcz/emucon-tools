#!/bin/sh

__cmd_name="${__cmd_name} base"


# ========== Helper Functions ==========

__print_usage()
{
	cat <<- EOT
	USAGE:
	    ${__cmd_name} -o <path>

	DESCRIPTION:
	    Builds container's base layer.

	OPTIONS:
	    -o, --output-dir <path>
	        Output directory for built files

	EOT
}


# ========== Script's Begin ==========

. $(emucon-paths helpers.sh)

if [ $# -eq 0 ] ; then
	__print_usage
	emucon_exit
fi

# Parse script's command line arguments
shortopts='o:h'
longopts='output-dir:,help'
cmdargs=$(emucon_parse_cmdargs -s "${shortopts}" -l "${longopts}" -- "$@")
if emucon_cmd_failed ; then
	emucon_abort
fi

# Lookup parsed parameters and their arguments
eval set -- ${cmdargs}
while true ; do
	case "$1" in
		-o|--output-dir)
			outdir="$2"
			shift 2 ;;
		-h|--help)
			__print_usage
			emucon_exit ;;
		--)
			shift 1
			break ;;
		*)
			emucon_print_invalid_cmdargs_error "${cmdargs}"
			emucon_abort -v ;;
	esac
done

# Check arguments
emucon_check_required_arg "-o/--output-dir" "${outdir}"
emucon_ensure_dir_exists "${outdir}"

# Docker names
tag='eaas/emucon-base-layer:latest'
name='eaas-emucon-base'

emucon_print_info "Building new image for '${tag}'..."
sudo docker build --no-cache --force-rm=true -t "${tag}" . || emucon_abort -v

emucon_print_info "Creating container from image '${tag}'..."
container=$(sudo docker create --name "${name}" "${tag}")
if emucon_cmd_failed ; then
	emucon_abort -v
fi

emucon_print_info "Exporting image to ${outdir}"
excludes='--exclude=dev/* --exclude=proc/* --exclude=usr/share/doc/* --exclude=usr/share/man/* --exclude=*/__pycache__/*'
tarargs="--ignore-failed-read --totals -C ${outdir}"
sudo docker export "${container}" | tar ${excludes} ${tarargs} -xvf -

emucon_print_info "Removing container ${name}"
sudo docker rm "${name}"

