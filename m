Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB362CACD8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgLAT4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgLAT4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:56:49 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9E3C0617A6;
        Tue,  1 Dec 2020 11:56:09 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 64so4626749wra.11;
        Tue, 01 Dec 2020 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZPmocJICJR3oELxasb3551i3Wyrk+d2+OY5hSssNeg=;
        b=Ot4IvDNVFAKwFIXaxeGR1/l64g7ZqoVacAdwZ08j6rh3MSt4HwnFcf0ndrp0NAnL61
         nldOeRMNl3NS8EbS9TAWFEL7+lgjXKEzuIS9hYd9xLYFqQzqsOVklFbsq1R5arwyp47Y
         WeJhHa3E01QmiwUPgy61ZBUomoaGUlNKeoJeyj3u5gUzt6IWFXBNloLq4Jeq5ydFBZV4
         Jpd54bLPgGJcCiHyDkOear2R7hlVCqDFqk5Zo2YPUX+fDuO1kV5ej3PjMsC/vx+yO6Lx
         Ys4No0w5spwnqUFbaTVlBvoVqy1DQIXaKCSfe/2/EAZkziZwXnhQa24w75blEnzPqhw0
         QPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZPmocJICJR3oELxasb3551i3Wyrk+d2+OY5hSssNeg=;
        b=IczQgrvrZmYeiRJtOeeYfcfTb61ax+wNJJfQZWBWw5tSd8qFLhTjnjAfeqAkUKo3QW
         F+cgcWsQxdV1Ub+S/JNPAr9FtdI34+cpTS0UePg015IrXcsIauuLruRI6ZvOp0XvexlS
         n4yX2VlpZuOUaavDyWzWfFhGkxxq6jmitpGqusQYd74ls9cYXfAII1YVGPSob1ZK2N/N
         fdmSl01CY334skOZ+R1+OxaoZMz8mR2UqGFOBVThAH9vn395q0EDlkbMEBFVRDhcWWCE
         8JzvQGFWy0PmBwV1rOL+1ZMf2abR0BbWFrz+S+3CqHxz/g0Ypdberu9ewKkbTVG7J7A+
         BKwA==
X-Gm-Message-State: AOAM5332A7anbIFRR6MXoETsY3RRrmRjU0xfvm9be4fpNfN4EeRgiPa1
        J8yt3/hZjuB86S1N1mLUmSg=
X-Google-Smtp-Source: ABdhPJygRVmcYQRorSqoK7Rk+6lPYcG4g+OIm+nZv+lYWMtEdFyDAwINjGt8zqtS0sH15wA4Znfjkg==
X-Received: by 2002:a05:6000:11c2:: with SMTP id i2mr5986981wrx.21.1606852568060;
        Tue, 01 Dec 2020 11:56:08 -0800 (PST)
Received: from localhost.localdomain (host-79-13-10-171.retail.telecomitalia.it. [79.13.10.171])
        by smtp.gmail.com with ESMTPSA id z22sm1253681wml.1.2020.12.01.11.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:56:07 -0800 (PST)
From:   Elia Devito <eliadevito@gmail.com>
Cc:     mario.limonciello@dell.com, Elia Devito <eliadevito@gmail.com>,
        Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] intel-hid: add support for SW_TABLET_MODE
Date:   Tue,  1 Dec 2020 20:55:05 +0100
Message-Id: <20201201195504.22296-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SW_TABLET_MODE for convertibles notebook.

Exactly as intel-vbtn driver, the event code 0xcc is emitted by
convertibles when entering tablet mode and 0xcd when return to
laptop mode.

Signed-off-by: Elia Devito <eliadevito@gmail.com>
---
more info: https://bugzilla.kernel.org/show_bug.cgi?id=207433
 
 drivers/platform/x86/intel-hid.c | 84 ++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index 86261970bd8f..5093c57102cf 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -15,6 +15,9 @@
 #include <linux/platform_device.h>
 #include <linux/suspend.h>
 
+/* When NOT in tablet mode, VGBS returns with the flag 0x40 */
+#define TABLET_MODE_FLAG 0x40
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alex Hung");
 
@@ -61,7 +64,11 @@ static const struct key_entry intel_array_keymap[] = {
 	{ KE_IGNORE, 0xC9, { KEY_ROTATE_LOCK_TOGGLE } },      /* Release */
 	{ KE_KEY,    0xCE, { KEY_POWER } },                   /* Press */
 	{ KE_IGNORE, 0xCF, { KEY_POWER } },                   /* Release */
-	{ KE_END },
+};
+
+static const struct key_entry intel_array_switches[] = {
+	{ KE_SW, 0xCC, { .sw = { SW_TABLET_MODE, 1 } } },  /* Tablet */
+	{ KE_SW, 0xCD, { .sw = { SW_TABLET_MODE, 0 } } },  /* Laptop */
 };
 
 static const struct dmi_system_id button_array_table[] = {
@@ -89,9 +96,23 @@ static const struct dmi_system_id button_array_table[] = {
 	{ }
 };
 
+static const struct dmi_system_id button_array_switches_table[] = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_CHASSIS_TYPE, "31" /* Convertible */),
+		},
+	},
+	{ }
+};
+
+#define KEYMAP_LEN \
+	(ARRAY_SIZE(intel_array_keymap) + ARRAY_SIZE(intel_array_switches) + 1)
+
 struct intel_hid_priv {
+	struct key_entry keymap[KEYMAP_LEN];
 	struct input_dev *input_dev;
 	struct input_dev *array;
+	bool has_switches;
 	bool wakeup_mode;
 };
 
@@ -327,23 +348,54 @@ static int intel_hid_input_setup(struct platform_device *device)
 	return input_register_device(priv->input_dev);
 }
 
+static void detect_tablet_mode(struct platform_device *device)
+{
+	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
+	acpi_handle handle = ACPI_HANDLE(&device->dev);
+	unsigned long long vgbs;
+	int m;
+
+	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_VGBS_FN, &vgbs))
+		return;
+
+	m = !(vgbs & TABLET_MODE_FLAG);
+	input_report_switch(priv->array, SW_TABLET_MODE, m);
+}
+
 static int intel_button_array_input_setup(struct platform_device *device)
 {
 	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
-	int ret;
+	int ret, keymap_len = 0;
 
 	/* Setup input device for 5 button array */
 	priv->array = devm_input_allocate_device(&device->dev);
 	if (!priv->array)
 		return -ENOMEM;
 
-	ret = sparse_keymap_setup(priv->array, intel_array_keymap, NULL);
+	memcpy(&priv->keymap[keymap_len], intel_array_keymap,
+		       ARRAY_SIZE(intel_array_keymap) *
+		       sizeof(struct key_entry));
+	keymap_len += ARRAY_SIZE(intel_array_keymap);
+
+	if (priv->has_switches) {
+		memcpy(&priv->keymap[keymap_len], intel_array_switches,
+		       ARRAY_SIZE(intel_array_switches) *
+		       sizeof(struct key_entry));
+		keymap_len += ARRAY_SIZE(intel_array_switches);
+	}
+
+	priv->keymap[keymap_len].type = KE_END;
+
+	ret = sparse_keymap_setup(priv->array, priv->keymap, NULL);
 	if (ret)
 		return ret;
 
 	priv->array->name = "Intel HID 5 button array";
 	priv->array->id.bustype = BUS_HOST;
 
+	if (priv->has_switches)
+		detect_tablet_mode(device);
+
 	return input_register_device(priv->array);
 }
 
@@ -352,7 +404,10 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	struct platform_device *device = context;
 	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
 	unsigned long long ev_index;
+	unsigned int val = !(event & 1); /* Even=press, Odd=release */
+	const struct key_entry *ke;
 
+	dev_info(&device->dev, "event 0x%x\n", event);
 	if (priv->wakeup_mode) {
 		/*
 		 * Needed for wakeup from suspend-to-idle to work on some
@@ -367,13 +422,19 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 		if (event == 0xc0 || !priv->array)
 			return;
 
-		if (!sparse_keymap_entry_from_scancode(priv->array, event)) {
+		ke = sparse_keymap_entry_from_scancode(priv->array, event);
+		if (!ke) {
 			dev_info(&device->dev, "unknown event 0x%x\n", event);
 			return;
 		}
 
 wakeup:
 		pm_wakeup_hard_event(&device->dev);
+
+		/* report the new switch position to the input subsystem. */
+		if (ke && ke->type == KE_SW)
+			sparse_keymap_report_event(priv->array, event, val, 0);
+
 		return;
 	}
 
@@ -441,6 +502,20 @@ static bool button_array_present(struct platform_device *device)
 	return false;
 }
 
+static bool intel_button_array_has_switches(struct platform_device *device)
+{
+	acpi_handle handle = ACPI_HANDLE(&device->dev);
+	unsigned long long vgbs;
+
+	if (!dmi_check_system(button_array_switches_table))
+		return false;
+
+	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_VGBS_FN, &vgbs))
+		return false;
+
+	return true;
+}
+
 static int intel_hid_probe(struct platform_device *device)
 {
 	acpi_handle handle = ACPI_HANDLE(&device->dev);
@@ -479,6 +554,7 @@ static int intel_hid_probe(struct platform_device *device)
 
 	/* Setup 5 button array */
 	if (button_array_present(device)) {
+		priv->has_switches = intel_button_array_has_switches(device);
 		dev_info(&device->dev, "platform supports 5 button array\n");
 		err = intel_button_array_input_setup(device);
 		if (err)
-- 
2.28.0

