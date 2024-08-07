#!/bin/sh -e
# POSIX
# Usage: certRenew

ED="$( cd "$( /usr/bin/dirname "$0" )" && pwd )" # Execution Dir
cd $ED
cd .. # Go to the project dir
PROJ_DIR=$(pwd) # Save it

# --------------------------------------------------
# Show help
show_help() {
cat << EOF
Usage: ${0##*/} [OPTIONS]...
Try to renew all expiring certs.

DESCRIPTION
    -h, -?, --help			Show this help and end the execution
EOF
}

# --------------------------------------------------

################
# Get options
################
while :; do
	case $1 in
	-h|-\?|--help)
		show_help; exit;
		;;

	--) # End of all options
		shift
		break
		;;
	-?*)
		echo 'Option "%s" is unknown. Ignoring.' "$1"
		;;
	*) # Default: No more options, ends the loop.
		break
	esac

	shift
done

# --------------------------------------------------

cd $PROJ_DIR
docker compose run --rm certbot renew
