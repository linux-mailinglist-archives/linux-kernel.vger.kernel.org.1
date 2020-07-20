Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29FE226F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 22:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgGTUK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 16:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbgGTUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:10:27 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D005EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:10:27 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mn17so410998pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qt6jGzvm3GC6CjwiV6wln+Xb/8pwnGX0O0vF6jd8ZYE=;
        b=f7HmX8uJEiLg6GPaHOjJQaUIRNQ2abmjKS9jJE1HkNfeKfm37XujIMuScSCInwA7Ro
         CJUNZBjCoez4wYxKk2xuIYefO41y3yF/OYbBo59YkAI4DXiZQlmqMYPCuYvIR4mWBxGo
         1MPylNVJZvcDWKNeojzbWvlhmphlBGtjkBiETy5gZPfz8olOlMUVls6mFvvofA/s8sEP
         wmcKfdT6IdUHaTi4EP440bBQb4F1/QXZdAI0G48cHwXFtW2oJUCdjZMtZhjjVfyzcF9s
         eB1U5TOpGb+RBOKjpWsM+vRclDohkdF46Nmo5EjjL4wDLQ9zCznBtQGNCXx7WjFVqkqd
         3yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qt6jGzvm3GC6CjwiV6wln+Xb/8pwnGX0O0vF6jd8ZYE=;
        b=CjPPInXphczapm9yjYexJdU8Vm+jA0cY528OT2CdsUOyxsgcyArKKrRQJsvWcM2PDJ
         FVx2Tk+motmjRSqegrssDWfI/aK2VqcoPkBa92Jsb2vGC6wrwcDb+wTKtfbXyhibnOSF
         wzk41ng21+Qq4yXvA9DjJfyMthMy9T52umx8D8OYdCBjZ9DOlzzuzXRFevW4v+SaTFjF
         NMl8Pi55WDe41kAkOSZaNY6/te5M/ObeEMJXbjHvaBMFNiZvNCB6yQwtQ2YKVYvFw/BQ
         /aPKiBHfni1OlSkoXFZGYrWBwSGxxo37GVaJsPSnx1rMqpRQIgpiO8MuWA74AoLmtmbQ
         4asQ==
X-Gm-Message-State: AOAM531b+3b8Z3qJrZah8xox82VB2jvCMPBq/xbXdg/jPdCkecFO6iS+
        3LBZwYSifMASO6TXwTZemtW07GF52rghR5AG
X-Google-Smtp-Source: ABdhPJyw0TRbyVLKTq1Ia1pocvwrGkYe1MTP5ts2b3uJlaceVIXKGr0KiTl+ODtRo3QxFnOUsLl2Kg==
X-Received: by 2002:a17:90a:c207:: with SMTP id e7mr1079695pjt.49.1595275827051;
        Mon, 20 Jul 2020 13:10:27 -0700 (PDT)
Received: from frank-MS-7C02.skbroadband ([211.110.90.114])
        by smtp.gmail.com with ESMTPSA id j26sm17208028pfe.200.2020.07.20.13.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 13:10:26 -0700 (PDT)
From:   Frank Yang <puilp0502@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Frank Yang <puilp0502@gmail.com>
Subject: [PATCH] HID: Support Varmilo Keyboards' media hotkeys
Date:   Tue, 21 Jul 2020 05:09:16 +0900
Message-Id: <20200720200916.31082-1-puilp0502@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Varmilo VA104M Keyboard (04b4:07b1, reported as Varmilo Z104M)
exposes media control hotkeys as a USB HID consumer control device,
but these keys do not work in the current (5.8-rc1) kernel due to
the incorrect HID report descriptor. Fix the problem by modifying
the internal HID report descriptor.

More specifically, the keyboard report descriptor specifies the
logical boundary as 572~10754 (0x023c ~ 0x2a02) while the usage
boundary is specified as 0~10754 (0x00 ~ 0x2a02). This results in an
incorrect interpretation of input reports, causing inputs to be ignored.
By setting the Logical Minimum to zero, we align the logical boundary
with the Usage ID boundary.

Some notes:

* There seem to be multiple variants of the VA104M keyboard. This
  patch specifically targets 04b4:07b1 variant.

* The device works out-of-the-box on Windows platform with the generic
  consumer control device driver (hidserv.inf). This suggests that
  Windows either ignores the Logical Minimum/Logical Maximum or
  interprets the Usage ID assignment differently from the linux
  implementation; Maybe there are other devices out there that only
  works on Windows due to this problem?

Signed-off-by: Frank Yang <puilp0502@gmail.com>
---
 drivers/hid/Kconfig       |  6 ++++
 drivers/hid/Makefile      |  1 +
 drivers/hid/hid-ids.h     |  2 ++
 drivers/hid/hid-varmilo.c | 58 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+)
 create mode 100644 drivers/hid/hid-varmilo.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 443c5cbbde04..c9f0c9b79158 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -441,6 +441,12 @@ config HID_WALTOP
 	---help---
 	Support for Waltop tablets.
 
+config HID_VARMILO
+	tristate "Varmilo Keyboards"
+	depends on HID
+	help
+	  Support for Varmilo keyboards.
+
 config HID_VIEWSONIC
 	tristate "ViewSonic/Signotec"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index d8ea4b8c95af..e90a98090452 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -124,6 +124,7 @@ obj-$(CONFIG_HID_LED)		+= hid-led.o
 obj-$(CONFIG_HID_XINMO)		+= hid-xinmo.o
 obj-$(CONFIG_HID_ZEROPLUS)	+= hid-zpff.o
 obj-$(CONFIG_HID_ZYDACRON)	+= hid-zydacron.o
+obj-$(CONFIG_HID_VARMILO)	+= hid-varmilo.o
 obj-$(CONFIG_HID_VIEWSONIC)	+= hid-viewsonic.o
 
 wacom-objs			:= wacom_wac.o wacom_sys.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 874fc3791f3b..955be22fc69d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1189,6 +1189,8 @@
 #define USB_DEVICE_ID_UNITEC_USB_TOUCH_0709	0x0709
 #define USB_DEVICE_ID_UNITEC_USB_TOUCH_0A19	0x0a19
 
+#define USB_DEVICE_ID_VARMILO_VA104M_07B1   0X07b1
+
 #define USB_VENDOR_ID_VELLEMAN		0x10cf
 #define USB_DEVICE_ID_VELLEMAN_K8055_FIRST	0x5500
 #define USB_DEVICE_ID_VELLEMAN_K8055_LAST	0x5503
diff --git a/drivers/hid/hid-varmilo.c b/drivers/hid/hid-varmilo.c
new file mode 100644
index 000000000000..10e50f2dca61
--- /dev/null
+++ b/drivers/hid/hid-varmilo.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  HID report fixup for varmilo keyboards
+ *
+ *  Copyright (c) 2020 Frank Yang <puilp0502@gmail.com>
+ *
+ */
+
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+/*
+ * Varmilo VA104M with device ID of 07B1 incorrectly reports Logical Minimum as
+ * 572 (0x02 0x3c). We fix this by setting Logical Minimum to zero.
+ */
+static __u8 *varmilo_07b1_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+				       unsigned int *rsize)
+{
+	if (*rsize == 25 &&
+	    rdesc[0] == 0x05 && rdesc[1] == 0x0c &&
+	    rdesc[2] == 0x09 && rdesc[3] == 0x01 &&
+	    rdesc[6] == 0x19 && rdesc[7] == 0x00 &&
+	    rdesc[11] == 0x16 && rdesc[12] == 0x3c && rdesc[13] == 0x02) {
+		hid_info(hdev,
+			 "fixing up varmilo VA104M consumer control report descriptor\n");
+		rdesc[12] = 0x00;
+		rdesc[13] = 0x00;
+	}
+	return rdesc;
+}
+
+static __u8 *varmilo_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+				  unsigned int *rsize)
+{
+	if (hdev->product == USB_DEVICE_ID_VARMILO_VA104M_07B1 &&
+	    hdev->vendor == USB_VENDOR_ID_CYPRESS)
+		rdesc = varmilo_07b1_report_fixup(hdev, rdesc, rsize);
+	return rdesc;
+}
+
+static const struct hid_device_id varmilo_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_VARMILO_VA104M_07B1) },
+	{}
+};
+
+MODULE_DEVICE_TABLE(hid, varmilo_devices);
+
+static struct hid_driver varmilo_driver = {
+	.name = "varmilo",
+	.id_table = varmilo_devices,
+	.report_fixup = varmilo_report_fixup,
+};
+
+module_hid_driver(varmilo_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.17.1

