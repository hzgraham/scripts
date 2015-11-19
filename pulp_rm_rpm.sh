#!/bin/bash
# this script will remove an rpm from the platops pulp system by connecting to
# its mongo db and purging it manually

function usage {
    printf -- "usage: $0 -p PHASE -r REPO -f FILENAME\n" 1>&2
}

function parse {
    while getopts "h?vp:r:f:s:" opt; do
        case "$opt" in
            p)
                PHASE=$OPTARG
                ;;
            r)
                REPO=$OPTARG
                ;;
            f)
                FNAME=$OPTARG
                ;;
	    s)
		HOST=$OPTARG
		;;
            v)
                VERBOSE="true"
                ;;
            h|\?|\*)
                usage
                exit 0
                ;;
        esac
    done
    printf "Host: ${HOST} REPO: $REPO FNAME: $FNAME PHASE: $PHASE \n"
    if [ -z "$PHASE" -o -z "$REPO" -o -z "$FNAME" -o -z "$HOST" ]; then
        printf -- "-p -r -f and -h are all mandatory\n\n" 1>&2
        usage
        exit 0
    fi
}

# returns the pulp unit_id of an rpm by directly querying the mongo db
# 
# parameters (in order):
#
# full filename of the rpm
function rpm_id {
    RPMNAME=$1

    if [ ! -z "$VERBOSE" ]; then
        printf "mongo pulp_database --quiet --eval 'db.units_rpm.find({'filename': '${RPMNAME}'}, {'unit_id':1}).forEach(printjson);' | awk -F\" '{print $4}'\n" 1>&2
    fi
    mongo pulp_database --quiet --eval "db.units_rpm.find({'filename': '${RPMNAME}'}, {'unit_id':1}).forEach(printjson);" | awk -F\" '{print $4}'
}

# removes the association of a unit_id and a repository. this will remove an
# rpm from the repo without removing it from the filesystem
# 
# parameters (in order):
#
# unit_id of the rpm in pulp
# yum repository short name
# phase of the yum repo (eg: dev, stage, etc)
function mongo_rm {
    ID=$1
    REPO=$2
    PHASE=$3
    printf "These are the IDs for ${FNAME}: ${ID} \n"
    if [ ! -z "$VERBOSE" ]; then
        printf "mongo pulp_database --quiet --eval 'db.repo_content_units.remove({'unit_id': '${ID}', 'repo_id':'${REPO}-${PHASE}'}, 1);'\n" 1>&2
    fi
    mongo pulp_database --quiet --eval "db.repo_content_units.remove({'unit_id': '${ID}', 'repo_id':'${REPO}-${PHASE}'}, 1);"
}

# connect to the pulp server via ssh and run an arbitrary command
#
# parameters (in order):
#
# command to run
function ssh_cmd {
    CMD=$1
    printf "CMD ${CMD}"
    if [ ! -z "$VERBOSE" ]; then
        printf "ssh ${HOST} ${CMD}\n\n\n" 1>&2
    fi
    printf "ssh ${HOST} ${CMD}\n\n\n" 
    ssh ${HOST} ${CMD}
}

# don't forget to pass in all the arguments!
function main {
    parse $@

    if [ ! -z "$VERBOSE" ]; then
        printf "Phase:\t\t${PHASE}\n" 1>&2
        printf "Repo:\t\t${REPO}\n" 1>&2
        printf "Filename:\t${FNAME}\n" 1>&2
    fi

    # remove the rpm from the pulp db
    RPMID=$(rpm_id "$FNAME")
    if [ ! -z "$VERBOSE" ]; then
        printf "\t-> ${RPMID}\n"
    fi
    mongo_rm "$RPMID" "$REPO" "$PHASE"

    # the rpm is now gone from pulp! hooray!
    # now it's time to remove it from the pulp filesystem
    ssh_cmd "rm -f /mnt/gca/pulp/published/http/repos/${PHASE}/${REPO}/${FNAME}";
    
    printf "\nrm -f /mnt/gca/pulp/published/http/repos/${PHASE}/${REPO}/${FNAME}"
    # the repo metadata now needs to be rebuilt. tell the user to do that thing!
    printf "\n"
    printf "rebuild the metadata for ${REPO} in ${PHASE} now\n"
}

main $@

