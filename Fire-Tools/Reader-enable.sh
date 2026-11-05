#!/usr/bin/env sh
# Reader-enable.sh - Re-enables all Kindle, Amazon Auth, Whispersync, and Keyboard packages
# Safe to run without wiping user accounts or login tokens

echo "Re-enabling core Amazon Identity, Authentication & Registration..."
adb shell pm enable com.amazon.dcp >/dev/null 2>&1
adb shell pm enable com.amazon.dcp.contracts.framework.library >/dev/null 2>&1
adb shell pm enable com.amazon.dcp.contracts.library >/dev/null 2>&1
adb shell pm enable com.amazon.dcpms.client >/dev/null 2>&1
adb shell pm enable com.amazon.dcpms.fos.service >/dev/null 2>&1
adb shell pm enable com.amazon.identity.auth.device.authorization >/dev/null 2>&1
adb shell pm enable com.amazon.imp >/dev/null 2>&1
adb shell pm enable com.amazon.h2settingsfortablet >/dev/null 2>&1
adb shell pm enable amazon.jackson19 >/dev/null 2>&1
adb shell pm enable com.amazon.tcomm >/dev/null 2>&1
adb shell pm enable com.amazon.tcomm.client >/dev/null 2>&1
adb shell pm enable com.amazon.tcomm.jackson >/dev/null 2>&1
adb shell pm enable com.amazon.communication.discovery >/dev/null 2>&1

echo "Re-enabling Kindle App, Whispersync, and Content Services..."
adb shell pm enable com.amazon.kindle >/dev/null 2>&1
adb shell pm enable com.amazon.kindle.unifiedSearch >/dev/null 2>&1
adb shell pm enable com.amazon.sync.provider.ipc >/dev/null 2>&1
adb shell pm enable com.amazon.sync.service >/dev/null 2>&1
adb shell pm enable com.amazon.device.sync >/dev/null 2>&1
adb shell pm enable com.amazon.device.sync.sdk.internal >/dev/null 2>&1
adb shell pm enable com.amazon.device.messaging >/dev/null 2>&1
adb shell pm enable com.amazon.cloud9.contentservice >/dev/null 2>&1
adb shell pm enable com.amazon.providers.contentsupport >/dev/null 2>&1
adb shell pm enable com.amazon.securitysyncclient >/dev/null 2>&1
adb shell pm enable com.amazon.webapp >/dev/null 2>&1
adb shell pm enable com.amazon.zico >/dev/null 2>&1

echo "Re-enabling System Keyboards..."
adb shell pm enable jp.co.omronsoft.iwnnime.mlaz >/dev/null 2>&1
adb shell pm enable org.dslul.openboard.inputmethod.latin >/dev/null 2>&1

echo "Done! Core Kindle and Authentication services are enabled."
