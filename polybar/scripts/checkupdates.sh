#!/usr/bin/env bash

updates=$(checkupdates)

if [ -z "$updates" ]
then
  count=0
else
  printf '%s\n' "$updates" > /tmp/i3-eos-polybar-updates
  count=$(wc -l "/tmp/i3-eos-polybar-updates" | awk '{print $1}')
fi

echo "%{T1}%{T-} %{T2}$count%{T-}"

