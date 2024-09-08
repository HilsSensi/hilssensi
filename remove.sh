$AXFUN
echo ""
status=$(pgrep -f good) >/dev/null 2>&1
if [ "$status" ]; then
  pkill -f good
fi

status=$(pgrep -f good) >/dev/null 2>&1
if [ ! "$status" ]; then
  echo ""
  echo " HighSettings stopped in background."
  echo ""
else
  echo ""
  echo " HighSettings failed to stop."
  echo ""
fi
echo ""
