#!/usr/bin/env bash
set -Eeuo pipefail

panic() {
  echo "${*}" 2>&1
  exit 1
}

loud_exec() {
  echo "Running: ${*}"
  "${@}"
}

THIS_DIR="$(dirname "${0}")"
cd "${THIS_DIR}" || panic "unable to cd to ${THIS_DIR}"

PGM="TEST"

INPUT_FILE="$PGM.PLI"
# INCLUDE_FILE="INCLUDES/"
OBJ_FILE="LOADLIB/$PGM.OBJ"
EXE_FILE="LOADLIB/$PGM.EXE"
MAP_FILE="LOADLIB/$PGM.MAP"
CN="-cn(^)"
CO="-co(|)"
# LS="-lsiaxgmov"
LS="-lsaxgmov"

# LS="-lsiaxgmov"
# Compiler Listing options
#   s = source code
#   i = includes
#   a = Symbol Table
#   x = Cross-Reference Listing
#   g = Aggregate Listing
#   m = Assembly Listing
#   o = Procedure Map
#   v = ?

rm --force ./*.lst LOADLIB/*

# loud_exec plic -C -i"$INCLUDE_FILE" -ew -N -O -V $CN $CO $LS "$INPUT_FILE" -o "$OBJ_FILE"
loud_exec plic -C -ew -N -O -V $CN $CO $LS "$INPUT_FILE" -o "$OBJ_FILE"

# gcc -o "$EXE_FILE" "$OBJ_FILE" -Wl,-M > "$MAP_FILE"
# gcc -o "$EXE_FILE" "$OBJ_FILE" -lprf -Wl,-M -Wl,-zmuldefs -Wl,--oformat=elf32-i386 -Wl,-melf_i386 > "$MAP_FILE"
ld -z muldefs \
  -Bstatic \
  -M \
  -e _pli_Main \
  -t \
  --oformat=elf32-i386 \
  -melf_i386 \
  -o "$EXE_FILE" "$OBJ_FILE" > "$MAP_FILE"
