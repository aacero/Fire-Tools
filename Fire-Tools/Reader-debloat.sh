#!/usr/bin/env sh
# Reader-debloat.sh - Kindle Reader-Safe Debloat script
# Safely debloats non-essential Amazon apps, telemetry, ads, and Alexa
# while strictly preserving device registration, Whispersync, and the Kindle app.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LIST_FILE="${SCRIPT_DIR}/Debloat-Reader.txt"
OPTION="${1:-Disable}"

if [ ! -f "$LIST_FILE" ]; then
    echo "Error: Could not find ${LIST_FILE}"
    exit 1
fi

echo "Gathering installed system packages from device..."
adb shell pm list packages -s > /tmp/ft_packagelist 2>/dev/null

packages=$(awk '{print $1}' < "$LIST_FILE" | grep -v '^#')

count=0
case "$OPTION" in
    Disable|disable)
        echo "Applying Kindle-Safe Debloat (Disabling bloatware)..."
        for pkg in $packages; do
            if grep -q "package:${pkg}$" /tmp/ft_packagelist; then
                if adb shell pm disable-user --user 0 "$pkg" >/dev/null 2>&1; then
                    echo "Disabled: $pkg"
                    count=$((count + 1))
                fi
            fi
        done

        echo "Applying privacy & system optimizations..."
        adb shell settings put secure limit_ad_tracking 1 >/dev/null 2>&1
        adb shell settings put secure usage_metrics_marketing_enabled 0 >/dev/null 2>&1
        adb shell settings put secure USAGE_METRICS_UPLOAD_ENABLED 0 >/dev/null 2>&1
        adb shell settings put global LOCKSCREEN_AD_ENABLED 0 >/dev/null 2>&1
        adb shell settings put secure search_on_lockscreen_settings 0 >/dev/null 2>&1
        adb shell settings put global window_animation_scale 0.50 >/dev/null 2>&1
        adb shell settings put global transition_animation_scale 0.50 >/dev/null 2>&1
        adb shell settings put global animator_duration_scale 0.50 >/dev/null 2>&1
        echo "Successfully debloated $count packages."
        ;;

    Enable|enable|undo)
        echo "Restoring debloated packages..."
        for pkg in $packages; do
            if grep -q "package:${pkg}$" /tmp/ft_packagelist; then
                if adb shell pm enable "$pkg" >/dev/null 2>&1; then
                    echo "Enabled: $pkg"
                    count=$((count + 1))
                fi
            fi
        done
        echo "Successfully restored $count packages."
        ;;

    *)
        echo "Usage: $0 [Disable|Enable]"
        exit 1
        ;;
esac

rm -f /tmp/ft_packagelist
