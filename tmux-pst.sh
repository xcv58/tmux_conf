#!/bin/sh
pd=$(TZ=America/Los_Angeles date +%Y%m%d)
pd_fmt=$(TZ=America/Los_Angeles date +%m/%d)
pt=$(TZ=America/Los_Angeles date +%H:%M)
ud=$(date -u +%Y%m%d)
ut=$(date -u +%H:%M)
ld=$(date +%Y%m%d)
lt=$(date +%H:%M)

# Day offsets relative to PST date
if [ "$ud" -eq "$pd" ]; then u_s=""; elif [ "$ud" -gt "$pd" ]; then u_s="+1"; else u_s="-1"; fi
if [ "$ld" -eq "$pd" ]; then l_s=""; elif [ "$ld" -gt "$pd" ]; then l_s="+1"; else l_s="-1"; fi

if [ "$lt" = "$pt" ] && [ "$ld" = "$pd" ]; then
  echo "$pd_fmt P $pt Z ${ut}${u_s}"
elif [ "$lt" = "$ut" ] && [ "$ld" = "$ud" ]; then
  echo "$pd_fmt P $pt Z ${ut}${u_s}"
else
  echo "$pd_fmt L ${lt}${l_s} P $pt Z ${ut}${u_s}"
fi
