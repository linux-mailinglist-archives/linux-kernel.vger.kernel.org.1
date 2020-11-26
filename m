Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C471F2C5328
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 12:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgKZLkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 06:40:22 -0500
Received: from mout01.posteo.de ([185.67.36.65]:43366 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgKZLkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:40:22 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id ACDF8160064
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 12:40:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1606390819; bh=mPeZ5XsgllBppPwyq/izzl8/zrGd7JvDlZWqr+4K+M0=;
        h=Date:From:To:Cc:Subject:From;
        b=QGPf2fBjJ3hGepwiBtTJZSeoxGezscXVTJnFR1tUtALNtneDjs+62Qb8m6Qlu3XJu
         OvFfYzXGZY9GeqzgyNcgQ8nAx92M0S5CB5xYZBMZWzAeWTdYZgeqNTPga0P6L3EA75
         V6mRisPAziaWkP/shlFfUeP2LUwUYhDBcYo+gEYfqRbiRNoy58cygCtDnEdKxTfn2L
         Hq5qHhIvVlRPN6jflkzJOmkkWPjB3dY8bxjTxDX61j6B6RBnjoM8jIBfBwy6A8lzx6
         5XwqPFmkmv0AxO/dDIlm6UQxg2mtWZWLWH/c3EBHjvW7HzLueK767OdkeEQtgQYrUy
         XtPHJiU8/31ig==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4ChbR62jq0z6tm5;
        Thu, 26 Nov 2020 12:40:18 +0100 (CET)
Date:   Thu, 26 Nov 2020 12:40:16 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: corsair-psu: update supported devices
Message-ID: <X7+T4aZSUuzfsf7H@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for another Corsair PSUs series: AX760i, AX860i, AX1200i,
AX1500i and AX1600i. The first 3 power supplies are supported through
the Corsair Link USB Dongle which is some kind of USB/Serial/TTL
converter especially made for the COM ports of these power supplies.
There are 3 known revisions of these adapters. The AX1500i power supply
has revision 3 built into the case and AX1600i is the only one in that
series, which has an unique usb hid id like the RM/RX series.

The patch also changes the usb hid ids to use upper case letters to be
consistent with the rest of the hex numbers in the driver and updates
the hwmon documentation.

This patch adds:
- hwmon/corsair-psu documentation update
- corsair-psu driver update

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 Documentation/hwmon/corsair-psu.rst | 10 +++++++++
 drivers/hwmon/Kconfig               |  7 +++---
 drivers/hwmon/corsair-psu.c         | 33 +++++++++++++++++++----------
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
index 396b95c9a76a..6227e9046d73 100644
--- a/Documentation/hwmon/corsair-psu.rst
+++ b/Documentation/hwmon/corsair-psu.rst
@@ -7,6 +7,16 @@ Supported devices:
 
 * Corsair Power Supplies
 
+  Corsair AX760i (by Corsair Link USB Dongle)
+
+  Corsair AX860i (by Corsair Link USB Dongle)
+
+  Corsair AX1200i (by Corsair Link USB Dongle)
+
+  Corsair AX1500i (by builtin Corsair Link USB Dongle)
+
+  Corsair AX1600i
+
   Corsair HX550i
 
   Corsair HX650i
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 716df51edc87..3c059fc23cd6 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -453,11 +453,12 @@ config SENSORS_CORSAIR_PSU
 	tristate "Corsair PSU HID controller"
 	depends on HID
 	help
-	  If you say yes here you get support for Corsair PSUs with a HID
+	  If you say yes here you get support for Corsair PSUs with an USB HID
 	  interface.
 	  Currently this driver supports the (RM/HX)550i, (RM/HX)650i,
-	  (RM/HX)750i, (RM/HX)850i, (RM/HX)1000i and HX1200i power supplies
-	  by Corsair.
+	  (RM/HX)750i, (RM/HX)850i, (RM/HX)1000i, HX1200i and AX1600i power
+	  supplies by Corsair. The AX760i, AX860i, AX1200i and AX1500i
+	  power supplies are supported through the Corsair Link USB Dongle.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called corsair-psu.
diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index 99494056f4bd..0146dda3e2c3 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -571,17 +571,28 @@ static int corsairpsu_raw_event(struct hid_device *hdev, struct hid_report *repo
 }
 
 static const struct hid_device_id corsairpsu_idtable[] = {
-	{ HID_USB_DEVICE(0x1b1c, 0x1c03) }, /* Corsair HX550i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c05) }, /* Corsair HX750i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c06) }, /* Corsair HX850i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c09) }, /* Corsair RM550i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c0a) }, /* Corsair RM650i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
+	/*
+	 * The Corsair USB/COM Dongles appear in at least 3 different revisions, where rev 1 and 2
+	 * are commonly used with the AX760i, AX860i and AX1200i, while rev3 is rarely seen with
+	 * these PSUs. Rev3 is also build into the AX1500i, while the AX1600i is the first PSU of
+	 * this series which has an unique usb hid id. Though, the actual device name is part of
+	 * the HID message protocol, so it doesn't matter which dongle is connected.
+	 */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C00) }, /* Corsair Link USB/COM Dongle rev1 */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C01) }, /* Corsair Link USB/COM Dongle rev2 */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C02) }, /* Corsair Link USB/COM Dongle rev3 (AX1500i) */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C03) }, /* Corsair HX550i */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C04) }, /* Corsair HX650i */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C05) }, /* Corsair HX750i */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C06) }, /* Corsair HX850i */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C07) }, /* Corsair HX1000i */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C08) }, /* Corsair HX1200i */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C09) }, /* Corsair RM550i */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C0A) }, /* Corsair RM650i */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C0B) }, /* Corsair RM750i */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C0C) }, /* Corsair RM850i */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C0D) }, /* Corsair RM1000i */
+	{ HID_USB_DEVICE(0x1B1C, 0x1C11) }, /* Corsair AX1600i */
 	{ },
 };
 MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
-- 
2.29.2

