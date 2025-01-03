[ ! "$MODPATH" ] && MODPATH=${0%/*}

font_dynamic() {
MISANS=$(find $MODPATH/MiSans -type f -name MiSans.ttf)
if [ -z $MISANS ]; then
    ui_print "   MiSans font not found!"
    ui_print "   Please, re-download this module!"
else
    ui_print " - patching to default font..."
    cp $MODPATH/MiSans/MiSans.ttf $MODPATH/system/fonts/Roboto-Regular.ttf
    ui_print "   done!"
fi

REPLACE="
/system/fonts/Roboto-Regular.ttf
"
for i in $REPLACE; do
    if [ -r "$i" ]; then
        chmod 644 "${MODPATH}${i}"
        chcon u:object_r:system_file:s0 "${MODPATH}${i}"
        chown root:root "${MODPATH}${i}"
    fi
done
}

font_static(){
MISANS=$(find $MODPATH/MiSans -type f -name MiSans-Static.ttf)
if [ -z $MISANS ]; then
    ui_print "   MiSans-Static font not found!"
    ui_print "   Please, re-download this module!"
else
    ui_print " - patching to default font..."
    cp $MODPATH/MiSans/MiSans-Static.ttf $MODPATH/system/fonts/RobotoStatic-Regular.ttf
    sleep 2
    rm -r $MODPATH/MiSans
    ui_print "   done!"
    ui_print ""
fi

sleep 2
ui_print "  Patching to default directory.."
sleep 3
REPLACE="
/system/fonts/RobotoStatic-Regular.ttf
"
for i in $REPLACE; do
    if [ -r "$i" ]; then
        chmod 644 "${MODPATH}${i}"
        chcon u:object_r:system_file:s0 "${MODPATH}${i}"
        chown root:root "${MODPATH}${i}"
    fi
done
}

ui_print ""
ui_print " • Find default dynamic font:"
FONTD=$(find /system/fonts -type f -name Roboto-Regular.ttf)
if [ -z $FONTD ]; then
    ui_print "   System Font not found!"
    ui_print "   Failed to patching MiSans!"
else
    ui_print "   System Font found!"
    font_dynamic
fi

ui_print ""
ui_print " • Find default static font:"
FONTS=$(find /system/fonts -type f -name RobotoStatic-Regular.ttf)
if [ -z $FONTS ]; then
    ui_print "   Static found not found!"
    ui_print "   Failed to patching MiSans static!"
else
    ui_print "   Static font found!"
    font_static
fi