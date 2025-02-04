# uninstall 
backup(){
mkdir -p /metadata/early-mount.d/system/fonts

METADATA=/metadata/early-mount.d/system/fonts
BACKUP=$MODPATH/files/backups
for METADATA in $BACKUP; do
    cp $BACKUP/Roboto-Regular.ttf $METADATA/Roboto-Regular.ttf
    cp $BACKUP/RobotoStatic-Regular.ttf $METADATA/RobotoStatic-Regular.ttf
done
}

backup

if [ -f $INFO ]; then
  while read LINE; do
    if [ "$(echo -n $LINE | tail -c 1)" == "~" ]; then
      continue
    elif [ -f "$LINE~" ]; then
      mv -f $LINE~ $LINE
    else
      rm -f $LINE
      while true; do
        LINE=$(dirname $LINE)
        [ "$(ls -A $LINE 2>/dev/null)" ] && break 1 || rm -rf $LINE
      done
    fi
  done < $INFO
  rm -f $INFO
fi
