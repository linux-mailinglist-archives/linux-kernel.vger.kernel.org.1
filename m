Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4271E2982DE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 18:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417782AbgJYRq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 13:46:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33253 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417705AbgJYRqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 13:46:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id c21so7310897ljj.0;
        Sun, 25 Oct 2020 10:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGDmsU51VlNmwvmrx+C4NjJ6P2Sb+1uW9es0aJLQvH8=;
        b=DLa9SNh2haVZnKJDCVh37vkltNkF6cAqXIWtgcb2hesJiYHDqEgTZj8yA4BSQ2+pa8
         hWEvUXOsAGYxwjCnHT70sgHKKsZy+I1iObCLU0cVqtFgUhpIvCCKVqplQ27GTEuitw/n
         n7q6LGZuKXfIMVZHwT912MxVwXmPAWlN67Uca3YADGr7Dm9PhNajEuNj/Wpjl6+C3ABN
         i4wdiMz6rZc0uUhB8NmsZ0CziHkm3QMc07iQdAEZFnwq3CH7S4At+OfE74xVxn0Ko+mk
         POa7KrwGAtlh6g6IMLtz/HpEcGLJh7zBHil3gxTnSi84rIafnGW2Z2GijqUtETDOqBeu
         B48w==
X-Gm-Message-State: AOAM532BeZe57fcT7PeQPoP1Q5hZMIxL4D60N39rWGvbllPGZzXOySRS
        F4POE6BOW9K5JeACCOYrGyi/Ji9lHnJWrA==
X-Google-Smtp-Source: ABdhPJzB8QhtqcaIcFbIYe8gTJ0mYx6BYHnmh3pvknqCvi0ryg6HlLDaVdvtvbmLYksW8hrqfVMJ3Q==
X-Received: by 2002:a2e:8612:: with SMTP id a18mr3950173lji.255.1603648000508;
        Sun, 25 Oct 2020 10:46:40 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id o4sm796693lfg.247.2020.10.25.10.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 10:46:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kWk6J-0007Hy-Bj; Sun, 25 Oct 2020 18:46:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 11/14] USB: serial: keyspan_pda: clean up xircom/entrega support
Date:   Sun, 25 Oct 2020 18:45:57 +0100
Message-Id: <20201025174600.27896-12-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201025174600.27896-1-johan@kernel.org>
References: <20201025174600.27896-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the separate Kconfig symbol for Xircom / Entrega and always include
support in the keyspan_pda driver.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/Kconfig       | 19 ++-------
 drivers/usb/serial/Makefile      |  1 -
 drivers/usb/serial/keyspan_pda.c | 68 +++++---------------------------
 3 files changed, 13 insertions(+), 75 deletions(-)

diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index 4007fa25a8ff..a21ff5ab6df9 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -298,12 +298,12 @@ config USB_SERIAL_IUU
 	  module will be called iuu_phoenix.o
 
 config USB_SERIAL_KEYSPAN_PDA
-	tristate "USB Keyspan PDA Single Port Serial Driver"
+	tristate "USB Keyspan PDA / Xircom Single Port Serial Driver"
 	select USB_EZUSB_FX2
 	help
-	  Say Y here if you want to use a Keyspan PDA single port USB to
-	  serial converter device.  This driver makes use of firmware
-	  developed from scratch by Brian Warner.
+	  Say Y here if you want to use a Keyspan PDA, Xircom or Entrega single
+	  port USB to serial converter device. This driver makes use of
+	  firmware developed from scratch by Brian Warner.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called keyspan_pda.
@@ -538,17 +538,6 @@ config USB_SERIAL_CYBERJACK
 
 	  If unsure, say N.
 
-config USB_SERIAL_XIRCOM
-	tristate "USB Xircom / Entrega Single Port Serial Driver"
-	select USB_EZUSB_FX2
-	help
-	  Say Y here if you want to use a Xircom or Entrega single port USB to
-	  serial converter device.  This driver makes use of firmware
-	  developed from scratch by Brian Warner.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called keyspan_pda.
-
 config USB_SERIAL_WWAN
 	tristate
 
diff --git a/drivers/usb/serial/Makefile b/drivers/usb/serial/Makefile
index 2d491e434f11..50c53aed787a 100644
--- a/drivers/usb/serial/Makefile
+++ b/drivers/usb/serial/Makefile
@@ -61,5 +61,4 @@ obj-$(CONFIG_USB_SERIAL_UPD78F0730)		+= upd78f0730.o
 obj-$(CONFIG_USB_SERIAL_VISOR)			+= visor.o
 obj-$(CONFIG_USB_SERIAL_WISHBONE)		+= wishbone-serial.o
 obj-$(CONFIG_USB_SERIAL_WHITEHEAT)		+= whiteheat.o
-obj-$(CONFIG_USB_SERIAL_XIRCOM)			+= keyspan_pda.o
 obj-$(CONFIG_USB_SERIAL_XSENS_MT)		+= xsens_mt.o
diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index aa19dd181e42..f102dbf83492 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -26,18 +26,6 @@
 #include <linux/usb/serial.h>
 #include <linux/usb/ezusb.h>
 
-/* make a simple define to handle if we are compiling keyspan_pda or xircom support */
-#if IS_ENABLED(CONFIG_USB_SERIAL_KEYSPAN_PDA)
-	#define KEYSPAN
-#else
-	#undef KEYSPAN
-#endif
-#if IS_ENABLED(CONFIG_USB_SERIAL_XIRCOM)
-	#define XIRCOM
-#else
-	#undef XIRCOM
-#endif
-
 #define DRIVER_AUTHOR "Brian Warner <warner@lothar.com>, Johan Hovold <johan@kernel.org>"
 #define DRIVER_DESC "USB Keyspan PDA Converter driver"
 
@@ -64,18 +52,13 @@ static int keyspan_pda_write_start(struct usb_serial_port *port);
 #define ENTREGA_FAKE_ID			0x8093
 
 static const struct usb_device_id id_table_combined[] = {
-#ifdef KEYSPAN
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, KEYSPAN_PDA_FAKE_ID) },
-#endif
-#ifdef XIRCOM
 	{ USB_DEVICE(XIRCOM_VENDOR_ID, XIRCOM_FAKE_ID) },
 	{ USB_DEVICE(XIRCOM_VENDOR_ID, XIRCOM_FAKE_ID_2) },
 	{ USB_DEVICE(ENTREGA_VENDOR_ID, ENTREGA_FAKE_ID) },
-#endif
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, KEYSPAN_PDA_ID) },
 	{ }						/* Terminating entry */
 };
-
 MODULE_DEVICE_TABLE(usb, id_table_combined);
 
 static const struct usb_device_id id_table_std[] = {
@@ -83,21 +66,13 @@ static const struct usb_device_id id_table_std[] = {
 	{ }						/* Terminating entry */
 };
 
-#ifdef KEYSPAN
 static const struct usb_device_id id_table_fake[] = {
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, KEYSPAN_PDA_FAKE_ID) },
-	{ }						/* Terminating entry */
-};
-#endif
-
-#ifdef XIRCOM
-static const struct usb_device_id id_table_fake_xircom[] = {
 	{ USB_DEVICE(XIRCOM_VENDOR_ID, XIRCOM_FAKE_ID) },
 	{ USB_DEVICE(XIRCOM_VENDOR_ID, XIRCOM_FAKE_ID_2) },
 	{ USB_DEVICE(ENTREGA_VENDOR_ID, ENTREGA_FAKE_ID) },
-	{ }
+	{ }						/* Terminating entry */
 };
-#endif
 
 static int keyspan_pda_get_write_room(struct keyspan_pda_private *priv)
 {
@@ -647,22 +622,21 @@ static void keyspan_pda_close(struct usb_serial_port *port)
 /* download the firmware to a "fake" device (pre-renumeration) */
 static int keyspan_pda_fake_startup(struct usb_serial *serial)
 {
+	unsigned int vid = le16_to_cpu(serial->dev->descriptor.idVendor);
 	const char *fw_name;
 
 	/* download the firmware here ... */
 	ezusb_fx1_set_reset(serial->dev, 1);
 
-	if (0) { ; }
-#ifdef KEYSPAN
-	else if (le16_to_cpu(serial->dev->descriptor.idVendor) == KEYSPAN_VENDOR_ID)
+	switch (vid) {
+	case KEYSPAN_VENDOR_ID:
 		fw_name = "keyspan_pda/keyspan_pda.fw";
-#endif
-#ifdef XIRCOM
-	else if ((le16_to_cpu(serial->dev->descriptor.idVendor) == XIRCOM_VENDOR_ID) ||
-		 (le16_to_cpu(serial->dev->descriptor.idVendor) == ENTREGA_VENDOR_ID))
+		break;
+	case XIRCOM_VENDOR_ID:
+	case ENTREGA_VENDOR_ID:
 		fw_name = "keyspan_pda/xircom_pgs.fw";
-#endif
-	else {
+		break;
+	default:
 		dev_err(&serial->dev->dev, "%s: unknown vendor, aborting.\n",
 			__func__);
 		return -ENODEV;
@@ -681,12 +655,8 @@ static int keyspan_pda_fake_startup(struct usb_serial *serial)
 	return 1;
 }
 
-#ifdef KEYSPAN
 MODULE_FIRMWARE("keyspan_pda/keyspan_pda.fw");
-#endif
-#ifdef XIRCOM
 MODULE_FIRMWARE("keyspan_pda/xircom_pgs.fw");
-#endif
 
 static int keyspan_pda_port_probe(struct usb_serial_port *port)
 {
@@ -716,7 +686,6 @@ static int keyspan_pda_port_remove(struct usb_serial_port *port)
 	return 0;
 }
 
-#ifdef KEYSPAN
 static struct usb_serial_driver keyspan_pda_fake_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
@@ -727,20 +696,6 @@ static struct usb_serial_driver keyspan_pda_fake_device = {
 	.num_ports =		1,
 	.attach =		keyspan_pda_fake_startup,
 };
-#endif
-
-#ifdef XIRCOM
-static struct usb_serial_driver xircom_pgs_fake_device = {
-	.driver = {
-		.owner =	THIS_MODULE,
-		.name =		"xircom_no_firm",
-	},
-	.description =		"Xircom / Entrega PGS - (prerenumeration)",
-	.id_table =		id_table_fake_xircom,
-	.num_ports =		1,
-	.attach =		keyspan_pda_fake_startup,
-};
-#endif
 
 static struct usb_serial_driver keyspan_pda_device = {
 	.driver = {
@@ -770,12 +725,7 @@ static struct usb_serial_driver keyspan_pda_device = {
 
 static struct usb_serial_driver * const serial_drivers[] = {
 	&keyspan_pda_device,
-#ifdef KEYSPAN
 	&keyspan_pda_fake_device,
-#endif
-#ifdef XIRCOM
-	&xircom_pgs_fake_device,
-#endif
 	NULL
 };
 
-- 
2.26.2

