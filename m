Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC9A2CF16A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgLDQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLDQDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:03:06 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83169C0613D1;
        Fri,  4 Dec 2020 08:02:26 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so5806545wrw.10;
        Fri, 04 Dec 2020 08:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pp1a+ATF8qiN53BuxdEhpfs3MjoKxfuQK/6++DNLsoo=;
        b=s78IOj/k4aMRKel+zVIMQoHqdbO8BZaMQaaXMRnnLT+DifP8nO4swGagH7jeX6Z0o4
         5VN+DJsbZurHiIMLZQgdQy5Eu/VwJEmbKhMTDIWHlE1nQ67Vd1qS5iOc0UEspDGho6X8
         8Yhpc1D+dNhzLGGcog+os02u0/SwGg9B458uIFUX64TGBCfITQ1ACF6FjlDdHpEPmxu/
         hgpwdQikPXUq5ymo7vieMI+NENa9YPJR7egdUr7rzcUDgaEOGmi0o1xatFtxOzD4GgeD
         1ULqS10WYbZik6Rqi5/gR5ktDuuCZxHrlwxv9OZoqwCBqajcTjh7MUtiXnPn1k6bwRUT
         X/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pp1a+ATF8qiN53BuxdEhpfs3MjoKxfuQK/6++DNLsoo=;
        b=njq+LNkDJM+9C1a/SfxO5dzr/diI1XdTG12o8tN3nEwL6nyAC4hJ4a1gP+zCUsP72J
         PKAH43FD3YoMyn63vM5aYrljZ2xkcXz7aOrAg4CxUE3G48aosvhOUxuCfukuMZQXwh9i
         phcGShhq23yzU2NPT2Rkd1UskK5FNUAtAa9ii/Ja4sjeI22XkTftUzlLev1ToKpPMHSr
         jwiWRP0KQvpJutnvlllhJgllBuNP8Qu9nSJjqsOsrrAVGqY2G7B7GY6++CNUmzyt9t9t
         MexwYL+Y4zu8/IlPYB9kMFYKjGsXToAK76royzL6Oe1+uFMPZPmBYF3jFs2k3+NuHHLq
         DS0g==
X-Gm-Message-State: AOAM533/Ss1X0Js0VaA0Bq3GOMsBbgZLDR3MZSxjjN6O7ZRJH+5HF5+K
        1ypEbrna54faPnNZiAyZylk=
X-Google-Smtp-Source: ABdhPJxY6hYNv1daWsxdQShqXONB2ryneXzwQGO5LUgJY0eDjkuF2SkMqpTx7avUdQGhQPIXZ6hiQA==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr5894290wru.352.1607097745217;
        Fri, 04 Dec 2020 08:02:25 -0800 (PST)
Received: from localhost.localdomain (host-79-13-10-171.retail.telecomitalia.it. [79.13.10.171])
        by smtp.gmail.com with ESMTPSA id v4sm4115565wru.12.2020.12.04.08.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 08:02:24 -0800 (PST)
From:   Elia Devito <eliadevito@gmail.com>
X-Google-Original-From: Elia Devito <elia@xvalue.it>
Cc:     Elia Devito <eliadevito@gmail.com>,
        Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] intel-hid: add support for SW_TABLET_MODE
Date:   Fri,  4 Dec 2020 17:01:22 +0100
Message-Id: <20201204160121.36703-1-elia@xvalue.it>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201203212000.35898-1-eliadevito@gmail.com>
References: <20201203212000.35898-1-eliadevito@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elia Devito <eliadevito@gmail.com>

Some convertible use the intel-hid ACPI interface to report SW_TABLET_MODE,
implement this with DMI based allow-list to be sure to activate support
only on models that effectively have it.

Signed-off-by: Elia Devito <eliadevito@gmail.com>
---
v2:
 patch reworked according to received feedbacks
  
v3:
 improved code according to received feedbacks

 drivers/platform/x86/intel-hid.c | 95 ++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index 86261970bd8f..d2f892665ec6 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -15,6 +15,9 @@
 #include <linux/platform_device.h>
 #include <linux/suspend.h>
 
+/* When NOT in tablet mode, VGBS returns with the flag 0x40 */
+#define TABLET_MODE_FLAG BIT(6)
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
 
@@ -347,6 +367,57 @@ static int intel_button_array_input_setup(struct platform_device *device)
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
+static void report_tablet_mode_state(struct platform_device *device)
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
+static bool report_tablet_mode_event(struct input_dev *input_dev, u32 event)
+{
+	if (!input_dev)
+		return false;
+
+	switch (event) {
+	case 0xcc:
+		input_report_switch(input_dev, SW_TABLET_MODE, 1);
+		input_sync(input_dev);
+		return true;
+	case 0xcd:
+		input_report_switch(input_dev, SW_TABLET_MODE, 0);
+		input_sync(input_dev);
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void notify_handler(acpi_handle handle, u32 event, void *context)
 {
 	struct platform_device *device = context;
@@ -363,6 +434,13 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
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
@@ -374,6 +452,10 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 
 wakeup:
 		pm_wakeup_hard_event(&device->dev);
+
+		if (report_tablet_mode_event(priv->switches, event))
+			return;
+
 		return;
 	}
 
@@ -398,6 +480,9 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 		}
 	}
 
+	if (report_tablet_mode_event(priv->switches, event))
+		return;
+
 	/* 0xC0 is for HID events, other values are for 5 button array */
 	if (event != 0xc0) {
 		if (!priv->array ||
@@ -485,6 +570,16 @@ static int intel_hid_probe(struct platform_device *device)
 			pr_err("Failed to setup Intel 5 button array hotkeys\n");
 	}
 
+	/* Setup switches for devices that we know VGBS return correctly */
+	if (dmi_check_system(dmi_vgbs_allow_list)) {
+		dev_info(&device->dev, "platform supports switches\n");
+		err = intel_hid_switches_setup(device);
+		if (err)
+			pr_err("Failed to setup Intel HID switches\n");
+		else
+			report_tablet_mode_state(device);
+	}
+
 	status = acpi_install_notify_handler(handle,
 					     ACPI_DEVICE_NOTIFY,
 					     notify_handler,
-- 
2.28.0

