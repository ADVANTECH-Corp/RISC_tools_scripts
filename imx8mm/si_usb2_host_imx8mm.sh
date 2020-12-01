#!/bin/sh
function usage() {
  E=$(($1+0))
  (( E != 0 )) && echo -e "\n!!! Invalid parameter(s) !!!\n"

  cat <<-EOT

Usage:
  ${0##*/} [*]

    -h|--help	this help
    -p		Packet
    -j		J_STATE
    -k		K_STATE
    -n		output SE0 (host) / NAK (device)

EOT
  exit $E
}

HEXV=""
case "$@" in
  ""|-h|--help) usage ;;
  -p) HEXV=0x10040000 ;;
  -j) HEXV=0x10010000 ;;
  -k) HEXV=0x10020000 ;;
  -n) HEXV=0x10030000 ;;
  *) usage 1 ;;
esac

/unit_tests/memtool 0x32E50184=$HEXV
