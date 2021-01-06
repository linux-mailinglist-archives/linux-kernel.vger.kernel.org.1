Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B65A2EBA11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 07:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbhAFGhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 01:37:40 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48350 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbhAFGhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 01:37:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UKtHOJ6_1609914978;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UKtHOJ6_1609914978)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Jan 2021 14:36:53 +0800
From:   YANG LI <abaci-bugfix@linux.alibaba.com>
To:     hdegoede@redhat.com
Cc:     mgross@linux.intel.com, ibm-acpi@hmh.eng.br,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        YANG LI <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] thinkpad_acpi: fix: use scnprintf instead of snprintf.
Date:   Wed,  6 Jan 2021 14:36:16 +0800
Message-Id: <1609914976-28113-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The snprintf() function returns the number of characters which would
have been printed if there were enough space, but the scnprintf()
returns the number of characters which were actually printed. If the
buffer is not large enough, then using snprintf() would result in a
read overflow and an information leak. This error was found with the
help of coccicheck.

Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci <abaci@linux.alibaba.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 62 ++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index e03df28..c29a639 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1340,7 +1340,7 @@ static ssize_t tpacpi_rfk_sysfs_enable_show(const enum tpacpi_rfk_id id,
 			return status;
 	}
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
 			(status == TPACPI_RFK_RADIO_ON) ? 1 : 0);
 }
 
@@ -1433,14 +1433,14 @@ static int tpacpi_rfk_procfs_write(const enum tpacpi_rfk_id id, char *buf)
 /* interface_version --------------------------------------------------- */
 static ssize_t interface_version_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", TPACPI_SYSFS_VERSION);
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n", TPACPI_SYSFS_VERSION);
 }
 static DRIVER_ATTR_RO(interface_version);
 
 /* debug_level --------------------------------------------------------- */
 static ssize_t debug_level_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%04x\n", dbg_level);
+	return scnprintf(buf, PAGE_SIZE, "0x%04x\n", dbg_level);
 }
 
 static ssize_t debug_level_store(struct device_driver *drv, const char *buf,
@@ -1460,7 +1460,7 @@ static ssize_t debug_level_store(struct device_driver *drv, const char *buf,
 /* version ------------------------------------------------------------- */
 static ssize_t version_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s v%s\n",
+	return scnprintf(buf, PAGE_SIZE, "%s v%s\n",
 			TPACPI_DESC, TPACPI_VERSION);
 }
 static DRIVER_ATTR_RO(version);
@@ -1472,7 +1472,7 @@ static ssize_t version_show(struct device_driver *drv, char *buf)
 /* wlsw_emulstate ------------------------------------------------------ */
 static ssize_t wlsw_emulstate_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_wlsw_emulstate);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_wlsw_emulstate);
 }
 
 static ssize_t wlsw_emulstate_store(struct device_driver *drv, const char *buf,
@@ -1495,7 +1495,7 @@ static ssize_t wlsw_emulstate_store(struct device_driver *drv, const char *buf,
 /* bluetooth_emulstate ------------------------------------------------- */
 static ssize_t bluetooth_emulstate_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_bluetooth_emulstate);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_bluetooth_emulstate);
 }
 
 static ssize_t bluetooth_emulstate_store(struct device_driver *drv,
@@ -1515,7 +1515,7 @@ static ssize_t bluetooth_emulstate_store(struct device_driver *drv,
 /* wwan_emulstate ------------------------------------------------- */
 static ssize_t wwan_emulstate_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_wwan_emulstate);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_wwan_emulstate);
 }
 
 static ssize_t wwan_emulstate_store(struct device_driver *drv, const char *buf,
@@ -1535,7 +1535,7 @@ static ssize_t wwan_emulstate_store(struct device_driver *drv, const char *buf,
 /* uwb_emulstate ------------------------------------------------- */
 static ssize_t uwb_emulstate_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_uwb_emulstate);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_uwb_emulstate);
 }
 
 static ssize_t uwb_emulstate_store(struct device_driver *drv, const char *buf,
@@ -2745,7 +2745,7 @@ static ssize_t hotkey_enable_show(struct device *dev,
 	if (res)
 		return res;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", status);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", status);
 }
 
 static ssize_t hotkey_enable_store(struct device *dev,
@@ -2773,7 +2773,7 @@ static ssize_t hotkey_mask_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_user_mask);
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_user_mask);
 }
 
 static ssize_t hotkey_mask_store(struct device *dev,
@@ -2821,7 +2821,7 @@ static ssize_t hotkey_bios_mask_show(struct device *dev,
 {
 	printk_deprecated_attribute("hotkey_bios_mask",
 			"This attribute is useless.");
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_orig_mask);
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_orig_mask);
 }
 
 static DEVICE_ATTR_RO(hotkey_bios_mask);
@@ -2831,7 +2831,7 @@ static ssize_t hotkey_all_mask_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n",
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n",
 				hotkey_all_mask | hotkey_source_mask);
 }
 
@@ -2842,7 +2842,7 @@ static ssize_t hotkey_adaptive_all_mask_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n",
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n",
 			hotkey_adaptive_all_mask | hotkey_source_mask);
 }
 
@@ -2853,7 +2853,7 @@ static ssize_t hotkey_recommended_mask_show(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n",
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n",
 			(hotkey_all_mask | hotkey_source_mask)
 			& ~hotkey_reserved_mask);
 }
@@ -2867,7 +2867,7 @@ static ssize_t hotkey_source_mask_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_source_mask);
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_source_mask);
 }
 
 static ssize_t hotkey_source_mask_store(struct device *dev,
@@ -2918,7 +2918,7 @@ static ssize_t hotkey_poll_freq_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", hotkey_poll_freq);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", hotkey_poll_freq);
 }
 
 static ssize_t hotkey_poll_freq_store(struct device *dev,
@@ -2960,7 +2960,7 @@ static ssize_t hotkey_radio_sw_show(struct device *dev,
 	/* Opportunistic update */
 	tpacpi_rfk_update_hwblock_state((res == TPACPI_RFK_RADIO_OFF));
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
 			(res == TPACPI_RFK_RADIO_OFF) ? 0 : 1);
 }
 
@@ -2983,7 +2983,7 @@ static ssize_t hotkey_tablet_mode_show(struct device *dev,
 	if (res < 0)
 		return res;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", !!s);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", !!s);
 }
 
 static DEVICE_ATTR_RO(hotkey_tablet_mode);
@@ -3000,7 +3000,7 @@ static ssize_t hotkey_wakeup_reason_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", hotkey_wakeup_reason);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", hotkey_wakeup_reason);
 }
 
 static DEVICE_ATTR(wakeup_reason, S_IRUGO, hotkey_wakeup_reason_show, NULL);
@@ -3016,7 +3016,7 @@ static ssize_t hotkey_wakeup_hotunplug_complete_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", hotkey_autosleep_ack);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", hotkey_autosleep_ack);
 }
 
 static DEVICE_ATTR(wakeup_hotunplug_complete, S_IRUGO,
@@ -3051,7 +3051,7 @@ static ssize_t adaptive_kbd_mode_show(struct device *dev,
 	if (current_mode < 0)
 		return current_mode;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", current_mode);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", current_mode);
 }
 
 static ssize_t adaptive_kbd_mode_store(struct device *dev,
@@ -6295,7 +6295,7 @@ static int thermal_get_sensor(int idx, s32 *value)
 
 	case TPACPI_THERMAL_ACPI_UPDT:
 		if (idx <= 7) {
-			snprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
+			scnprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
 			if (!acpi_evalf(ec_handle, NULL, "UPDT", "v"))
 				return -EIO;
 			if (!acpi_evalf(ec_handle, &t, tmpi, "d"))
@@ -6307,7 +6307,7 @@ static int thermal_get_sensor(int idx, s32 *value)
 
 	case TPACPI_THERMAL_ACPI_TMP07:
 		if (idx <= 7) {
-			snprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
+			scnprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
 			if (!acpi_evalf(ec_handle, &t, tmpi, "d"))
 				return -EIO;
 			if (t > 127 || t < -127)
@@ -6387,7 +6387,7 @@ static ssize_t thermal_temp_input_show(struct device *dev,
 	if (value == TPACPI_THERMAL_SENSOR_NA)
 		return -ENXIO;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", value);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", value);
 }
 
 #define THERMAL_SENSOR_ATTR_TEMP(_idxA, _idxB) \
@@ -7618,10 +7618,10 @@ static int __init volume_create_alsa_mixer(void)
 		sizeof(card->driver));
 	strlcpy(card->shortname, TPACPI_ALSA_SHRTNAME,
 		sizeof(card->shortname));
-	snprintf(card->mixername, sizeof(card->mixername), "ThinkPad EC %s",
+	scnprintf(card->mixername, sizeof(card->mixername), "ThinkPad EC %s",
 		 (thinkpad_id.ec_version_str) ?
 			thinkpad_id.ec_version_str : "(unknown)");
-	snprintf(card->longname, sizeof(card->longname),
+	scnprintf(card->longname, sizeof(card->longname),
 		 "%s at EC reg 0x%02x, fw %s", card->shortname, TP_EC_AUDIO,
 		 (thinkpad_id.ec_version_str) ?
 			thinkpad_id.ec_version_str : "unknown");
@@ -8588,7 +8588,7 @@ static ssize_t fan_pwm1_enable_show(struct device *dev,
 	} else
 		mode = 1;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", mode);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", mode);
 }
 
 static ssize_t fan_pwm1_enable_store(struct device *dev,
@@ -8654,7 +8654,7 @@ static ssize_t fan_pwm1_show(struct device *dev,
 	if (status > 7)
 		status = 7;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", (status * 255) / 7);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", (status * 255) / 7);
 }
 
 static ssize_t fan_pwm1_store(struct device *dev,
@@ -8707,7 +8707,7 @@ static ssize_t fan_fan1_input_show(struct device *dev,
 	if (res < 0)
 		return res;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", speed);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", speed);
 }
 
 static DEVICE_ATTR(fan1_input, S_IRUGO, fan_fan1_input_show, NULL);
@@ -8724,7 +8724,7 @@ static ssize_t fan_fan2_input_show(struct device *dev,
 	if (res < 0)
 		return res;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", speed);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", speed);
 }
 
 static DEVICE_ATTR(fan2_input, S_IRUGO, fan_fan2_input_show, NULL);
@@ -8732,7 +8732,7 @@ static ssize_t fan_fan2_input_show(struct device *dev,
 /* sysfs fan fan_watchdog (hwmon driver) ------------------------------- */
 static ssize_t fan_watchdog_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", fan_watchdog_maxinterval);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", fan_watchdog_maxinterval);
 }
 
 static ssize_t fan_watchdog_store(struct device_driver *drv, const char *buf,
-- 
1.8.3.1

