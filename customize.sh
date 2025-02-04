[ ! "$MODPATH" ] && MODPATH=${0%/*}

font_dynamic() {
MISANS=$(find $MODPATH/MiSans -type f -name MiSans.ttf)
if [ -z $MISANS ]; then
    ui_print "   MiSans font not found!"
    ui_print "   Please, re-download this module!"
    ui_print "   Aborting.."
    rm -rf $MODPATH
    exit 1
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
    ui_print "   Aborting.."
    rm -rf $MODPATH
    exit 1
else
    ui_print " - patching to default font..."
    cp $MODPATH/MiSans/MiSans-Static.ttf $MODPATH/system/fonts/RobotoStatic-Regular.ttf
    sleep 2
    ui_print "   done!"
    rm -rf $MODPATH/MiSans
fi

sleep 2
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

misansvf(){
MISANSVF=$(find $MODPATH/MiSansVF -type f -name MiSansVF.ttf)
if [ -z $MISANSVF ]; then
    ui_print "   MiSansVF font not found!"
    ui_print "   Please, re-download this module!"
    ui_print "   Aborting.."
    rm -rf $MODPATH
    exit 1
else
    ui_print "   Add MiSansVF.."
    cp $MODPATH/MiSansVF/MiSansVF.ttf $MODPATH/system/fonts/MiSansVF.ttf
    sleep 1
    ui_print "   done!"
    ui_print ""
fi

sleep 2
REPLACE="
/system/fonts/MiSansVF.ttf
"
for i in $REPLACE; do
    if [ -r "$i" ]; then
        chmod 644 "${MODPATH}${i}"
        chcon u:object_r:system_file:s0 "${MODPATH}${i}"
        chown root:root "${MODPATH}${i}"
    fi
done

MISANSVFOV=$(find $MODPATH/MiSansVF -type f -name MiSansVF_Overlay.ttf)
if [ -z $MISANSVFOV ]; then
    ui_print "   MiSansVF_Overlay not found!"
    ui_print "   Please, re-download this module"
    ui_print "   Aborting.."
    rm -rf $MODPATH
    exit 1
else
    ui_print "   Add MiSansVF_Overlay.."
    cp $MODPATH/MiSansVF/MiSansVF_Overlay.ttf $MODPATH/system/fonts/MiSansVF_Overlay.ttf
    sleep 1
    rm -rf $MODPATH/MiSansVF
    ui_print "   done!"
    ui_print ""
fi

sleep 2
ui_print "  Patching to default directory.."
sleep 3
REPLACE="
/system/fonts/MiSansVF_Overlay.ttf
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
    ui_print "   continuing to patching MiSans.."
    font_dynamic
    if [ -z $(find $MODPATH/ -type d -name theme_webview) ]; then
        ui_print ""
        ui_print "   Theme_Webview is already exist!"
    else
        ui_print "   Create Theme_Webview directory.."
        sleep 1
        cp $MODPATH/system/fonts/Roboto-Regular.ttf $MODPATH/data/system/fonts/theme_webview/Roboto-Regular.ttf
        sleep 1
        ui_print "   Webview Font: $(find $MODPATH/data/system/fonts/theme_webview -type f -name Roboto-Regular.ttf)"
        ui_print "   success!"
    fi
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

ui_print ""
ui_print " • Find MiSansVF fonts:"
MISVF=$(find /system/fonts -type -f -name MiSansVF.ttf)
if [ -z $MISVF ]; then
    sleep 2
    ui_print "   MiSansVF not found, adding.."
    misansvf
else
    ui_print "   MiSansVF is already exist!"
fi
