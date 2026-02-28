#!/bin/sh
pd=$(TZ=America/Los_Angeles date +%Y%m%d)
pd_fmt=$(TZ=America/Los_Angeles date +%m/%d)
pd_day_raw=$(TZ=America/Los_Angeles date +%a)
pt=$(TZ=America/Los_Angeles date +%H:%M)
ud=$(date -u +%Y%m%d)
ut=$(date -u +%H:%M)
ld=$(date +%Y%m%d)
lt=$(date +%H:%M)

case "$pd_day_raw" in
  Mon) pd_day="Mo" ;;
  Tue) pd_day="Tu" ;;
  Wed) pd_day="We" ;;
  Thu) pd_day="Th" ;;
  Fri) pd_day="Fr" ;;
  Sat) pd_day="Sa" ;;
  Sun) pd_day="Su" ;;
  *) pd_day="$pd_day_raw" ;;
esac

# Day offsets relative to PST date
if [ "$ud" -eq "$pd" ]; then u_s=""; elif [ "$ud" -gt "$pd" ]; then u_s="+1"; else u_s="-1"; fi
if [ "$ld" -eq "$pd" ]; then l_s=""; elif [ "$ld" -gt "$pd" ]; then l_s="+1"; else l_s="-1"; fi

echo "#[fg=white,dim]$pd_day $pd_fmt #[fg=cyan,dim]L${lt}${l_s} #[fg=yellow]P${pt} #[fg=magenta,dim]Z${ut}${u_s}#[default]"
