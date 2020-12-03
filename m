Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA7B2CE08D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgLCVWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgLCVWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:22:13 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F5EC061A51;
        Thu,  3 Dec 2020 13:21:32 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id g185so5285060wmf.3;
        Thu, 03 Dec 2020 13:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKeMXOH+eJz7j+HhXLNdNRBb9s9T/2sajZT9nLh+WJ4=;
        b=VKWs5J1DwItm0Gz458sdJheb1IOXNbPp+TSvfpRljk3gBdmeeoz7MjXgkAG5RHXLtI
         8g4kFhieLcva3WewYfBDNjmjyIJ2zOIzhdSnZBMe2xVN1O5PZXKfUEF4DI8+JrMd7veU
         /tDZPdaVon3HkCUhB82jWtimVkh+tjpRwF7z6C/I/YeHz+s7BQ8XH7Sganmj5Kyi4T9r
         pl8XMmRmOE/q0Cpyk+yAWX0zw9Hf0fEsiognhqmqU1Tm7aw1h+LQPgSZ8EOUr8icn0xX
         xxLoyiuASEMgVWrdL0rfwgj5E14Djd1vrGYt0DVFMm7evHSVwRL8GYjiDzfXjSoq4ipj
         NE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKeMXOH+eJz7j+HhXLNdNRBb9s9T/2sajZT9nLh+WJ4=;
        b=TvwbNlOW94HAliEfYSscRcLhCQAhFLA2qg73VZ1lKC9gjHJ1GRA/htFaoujB07xPVq
         64Rc9MwPqEjcgsS9HYSXQolwiez22Tv2lMPW/TcDyThblY3zlmUeveztdKijcIzbzAc2
         jQHUKOpIq+9d9/fHK5bcjM1Iph6IdAcFNUCDDr6npjBfB4auZ7ugHmsy3GxQsT6A4Adg
         pUdvKypJ5eTZwr4xFxy1UZEnyDnA7F0CV6g2f81yehv3f8MyKT7uTXrnOxYuhLKpyh5L
         Gs+EjKYzVOPkESjNj4FqkegnDjyfIbDjaEsvlpHL5G0eHH0irvXCCSTVhXSDEdAv/w50
         EYSw==
X-Gm-Message-State: AOAM533HkiSrAAWVN7K/BKX/Ye0WprZRVPnfZ3Amcpni5KYpKOEUg/w2
        IPitN2D6rplCwPvj8ZI3RWI=
X-Google-Smtp-Source: ABdhPJwfgUeIXfND4K1NcXP0WxqZVqBuJ18v6DD/Bif3lF6m5+XnOi8h+0pKXV0O/npg1JfYbBtOnQ==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr751718wmc.176.1607030491372;
        Thu, 03 Dec 2020 13:21:31 -0800 (PST)
Received: from localhost.localdomain (host-79-13-10-171.retail.telecomitalia.it. [79.13.10.171])
        by smtp.gmail.com with ESMTPSA id q16sm853280wrn.13.2020.12.03.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:21:30 -0800 (PST)
From:   Elia Devito <eliadevito@gmail.com>
Cc:     Elia Devito <eliadevito@gmail.com>,
        Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] intel-hid: add support for SW_TABLET_MODE
Date:   Thu,  3 Dec 2020 22:20:01 +0100
Message-Id: <20201203212000.35898-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <69f340f6-4301-6546-f14a-47d90208d44b@redhat.com>
References: <69f340f6-4301-6546-f14a-47d90208d44b@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some convertible use the intel-hid ACPI interface to report SW_TABLET_MODE,
implement this with DMI based allow-list to be sure to activate support
only on models that effectively have it.

Signed-off-by: Elia Devito <eliadevito@gmail.com>
---
v2:
  patch reworked according to received feedbacks

 drivers/platform/x86/intel-hid.c | 98 ++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index 86261970bd8f..fed24d4f28b8 100644
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
 
@@ -89,9 +92,26 @@ static const struct dmi_system_id button_array_table[] = {
 	{ }
 };
 
+/*
+ * Some convertible use the intel-hid ACPI interface to report SW_TABLET_MODE,
+ * these need to be compared via a DMI based authorization list because some
+ * models have unreliable VGBS return which could cause incorrect
+ * SW_TABLET_MODE report.
+ */
+static const struct dmi_system_id dmi_vgbs_allow_list[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Spectre x360 Convertible 15-df0xxx"),
+		},
+	},
+	{ }
+};
+
 struct intel_hid_priv {
 	struct input_dev *input_dev;
 	struct input_dev *array;
+	struct input_dev *switches;
 	bool wakeup_mode;
 };
 
@@ -347,6 +367,38 @@ static int intel_button_array_input_setup(struct platform_device *device)
 	return input_register_device(priv->array);
 }
 
+static int intel_hid_switches_setup(struct platform_device *device)
+{
+	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
+
+	/* Setup input device for switches */
+	priv->switches = devm_input_allocate_device(&device->dev);
+	if (!priv->switches)
+		return -ENOMEM;
+
+	__set_bit(EV_SW, priv->switches->evbit);
+	__set_bit(SW_TABLET_MODE, priv->switches->swbit);
+
+	priv->switches->name = "Intel HID switches";
+	priv->switches->id.bustype = BUS_HOST;
+	return input_register_device(priv->switches);
+}
+
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
+	input_report_switch(priv->switches, SW_TABLET_MODE, m);
+	input_sync(priv->switches);
+}
+
 static void notify_handler(acpi_handle handle, u32 event, void *context)
 {
 	struct platform_device *device = context;
@@ -363,6 +415,13 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 		if (event == 0xce)
 			goto wakeup;
 
+		/*
+		 * Switch events will wake the device and report the new switch
+		 * position to the input subsystem.
+		 */
+		if (priv->switches && (event == 0xcc || event == 0xcd))
+			goto wakeup;
+
 		/* Wake up on 5-button array events only. */
 		if (event == 0xc0 || !priv->array)
 			return;
@@ -374,6 +433,21 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 
 wakeup:
 		pm_wakeup_hard_event(&device->dev);
+
+		if (priv->switches) {
+			if (event == 0xcc) {
+				input_report_switch(priv->switches, SW_TABLET_MODE, 1);
+				input_sync(priv->switches);
+				return;
+			}
+
+			if (event == 0xcd) {
+				input_report_switch(priv->switches, SW_TABLET_MODE, 0);
+				input_sync(priv->switches);
+				return;
+			}
+		}
+
 		return;
 	}
 
@@ -398,6 +472,20 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 		}
 	}
 
+	if (priv->switches) {
+		if (event == 0xcc) {
+			input_report_switch(priv->switches, SW_TABLET_MODE, 1);
+			input_sync(priv->switches);
+			return;
+		}
+
+		if (event == 0xcd) {
+			input_report_switch(priv->switches, SW_TABLET_MODE, 0);
+			input_sync(priv->switches);
+			return;
+		}
+	}
+
 	/* 0xC0 is for HID events, other values are for 5 button array */
 	if (event != 0xc0) {
 		if (!priv->array ||
@@ -485,6 +573,16 @@ static int intel_hid_probe(struct platform_device *device)
 			pr_err("Failed to setup Intel 5 button array hotkeys\n");
 	}
 
+	/* Setup switches for devices that we know VGBS return correctly */
+	if (dmi_check_system(dmi_vgbs_allow_list)) {
+		dev_info(&device->dev, "platform supports switches\n");
+		err = intel_hid_switches_setup(device);
+		if (err)
+			pr_err("Failed to setup Intel HID switches\n");
+		else
+			detect_tablet_mode(device);
+	}
+
 	status = acpi_install_notify_handler(handle,
 					     ACPI_DEVICE_NOTIFY,
 					     notify_handler,
-- 
2.28.0

