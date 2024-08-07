#!/bin/sh -e
# POSIX
# Usage: certNew [domain] [e-mail]

ED="$(cd "$(/usr/bin/dirname "$0")" && pwd)" # Execution Dir
cd $ED
cd ..           # Go to the project dir
PROJ_DIR=$(pwd) # Save it

# --------------------------------------------------
# Show help
show_help() {
	cat <<EOF
Usage: ${0##*/} [OPTIONS] [DOMAIN] [E-MAIL]...
Generates a new Certbot cert.

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
	-h | -\? | --help)
		show_help
		exit
		;;

	--) # End of all options
		shift
		break
		;;
	-?*)
		echo 'Option "%s" is unknown. Ignoring.' "$1"
		;;
	*) # Default: No more options, ends the loop.
		break ;;
	esac

	shift
done

# --------------------------------------------------

if [ $# -lt 1 ]; then
	echo "No domain was informed. Exiting..."
	return 1
elif [ $# -lt 2 ]; then
	echo "No e-mail address was informed. Exiting..."
	return 1
fi

cd $PROJ_DIR
docker compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot/ -n -m $2 --agree-tos -d $1
