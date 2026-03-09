#!/bin/sh
now=$(date +%s)

# macOS uses "date -r EPOCH", Linux (GNU) uses "date -d @EPOCH"
if date -d @0 >/dev/null 2>&1; then
  dflag="-d @$now"
else
  dflag="-r $now"
fi

pd=$(TZ=America/Los_Angeles date $dflag +%Y%m%d)
pd_fmt=$(TZ=America/Los_Angeles date $dflag +%m/%d)
pd_day_raw=$(TZ=America/Los_Angeles date $dflag +%a)
pt=$(TZ=America/Los_Angeles date $dflag +%H:%M)
ud=$(date -u $dflag +%Y%m%d)
ut=$(date -u $dflag +%H:%M)
ld=$(date $dflag +%Y%m%d)
lt=$(date $dflag +%H:%M)

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

local_part=""
if [ "$lt" != "$pt" ] && [ "$lt" != "$ut" ]; then
  local_part="#[fg=cyan,dim]L${lt}${l_s} "
fi

echo "#[fg=white,dim]$pd_day $pd_fmt ${local_part}#[fg=yellow]P${pt} #[fg=magenta,dim]Z${ut}${u_s}#[default]"
