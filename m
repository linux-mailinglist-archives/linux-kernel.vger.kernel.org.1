Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB01294004
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436972AbgJTPzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436965AbgJTPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:55:00 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB968C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 08:54:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id v19so2367891edx.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bertold.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJX61abtH3reP4ei/mACiToh+yCmtE2RaQdA6JQtZKc=;
        b=Zt4q41xa4gt1p7f5fFeqHLrO1ScM6uaIgdHyNaJW6gJEBQGcm9hfxuOrmtDaCPEqQy
         6/LVFIasv74XklbkfbJga/UPNumU3pZ+EcyHWDsAlCcb2wolbBThPn7kDWzq0S2J04Zc
         L/ok9cCSQ0zaj60cpHBbXLD950vcm3wFd9gmWG3VGmeVejzZf035DCPMG0/Vf4rlsPtW
         2+G5hRZ9yYHb5/Fid/F9NNj7ua48IhYAFdF46wULkPKi4NYqQiKc5bXCiBPadtO7Wp5S
         t0C40YY6gJBj2Dy4ywaIkPfMe4y/QZctp3CN/XhBl9qWa0iHyLOYBvvxcLiFYU1Fqfrc
         1F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJX61abtH3reP4ei/mACiToh+yCmtE2RaQdA6JQtZKc=;
        b=iRFnIEoKllKvUKPLMZ6gHDIf89QbMbSh40rSPsRYDLpaKCXd3mtlyKhtwwwqbyXsBc
         VsTjrWgSdf0XR0c0pqwCmP/TkDbz5b84OgadYWnWvHxwVCALRHTcl+NSQKW4ahXKsx4f
         LfuGIAvfz07Xw+Kk3ngkte847PQcYP2p+/cMa3FA+OABT4oajZAHIopIfRgM+lj3yDt5
         aCmrKdl841YUNdwCKHQlKgs6r60z40q8e1eQMV/R/MGp2/4fDjpHCfQowjYvSviUPLuU
         IIijNyCBOC5b8Awq70xJPsK7/MEnabu7vfbQngU/hSOWsW9DiNylVfjYxpFZLJXDK0pe
         6+qQ==
X-Gm-Message-State: AOAM531hNKeyjq5XaMvgD6kLDEbsNNoTRwEIJT+opyK8cjDkLef66AQe
        ZHnk0zAtnwgUi22n1TZHk2zq4Q==
X-Google-Smtp-Source: ABdhPJx/ObIT599IO/6ivnYNbaquCbyJzhbuJmRGOAl3OQUpDAto3CSKZCdLEP5TqyrmwXGVxe+z6g==
X-Received: by 2002:aa7:d7c1:: with SMTP id e1mr3476061eds.4.1603209297453;
        Tue, 20 Oct 2020 08:54:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:578:8555:c01:348:81f8:f19:66ca])
        by smtp.googlemail.com with ESMTPSA id y12sm2939394ede.82.2020.10.20.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 08:54:56 -0700 (PDT)
From:   Bertold Van den Bergh <vandenbergh@bertold.org>
Cc:     Bertold Van den Bergh <vandenbergh@bertold.org>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb-serial: support NAL Research Corporation Iridium modems
Date:   Tue, 20 Oct 2020 17:54:26 +0200
Message-Id: <20201020155426.9919-1-vandenbergh@bertold.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is for NAL Reserach Corporation Iridium modems with USB.
There are different variants of the bus protocol, but the driver should
detect this automatically.

Signed-off-by: Bertold Van den Bergh <vandenbergh@bertold.org>
---
 Documentation/usb/usb-serial.rst |  15 ++
 drivers/usb/serial/Kconfig       |   9 +
 drivers/usb/serial/Makefile      |   1 +
 drivers/usb/serial/nal.c         | 357 +++++++++++++++++++++++++++++++
 4 files changed, 382 insertions(+)
 create mode 100644 drivers/usb/serial/nal.c

diff --git a/Documentation/usb/usb-serial.rst b/Documentation/usb/usb-serial.rst
index 8fa7dbd3d..fdc8c0c76 100644
--- a/Documentation/usb/usb-serial.rst
+++ b/Documentation/usb/usb-serial.rst
@@ -494,6 +494,21 @@ Moschip MCS7720, MCS7715 driver
       with this driver with a simple addition to the usb_device_id table.  I
       don't have one of these devices, so I can't say for sure.
 
+NAL Research Corporation driver
+-------------------------------
+
+  This driver is for NAL Reserach Corporation Iridium modems with USB.
+  There are different variants of the bus protocol, but the driver should
+  detect this automatically.
+
+  The manufacturer provided Windows driver attaches to all PIDs in the given
+  VID, so you may want to try this driver even if the PID doesn't match.
+
+  The manufacturer's website: https://www.nalresearch.com/
+
+  For any questions or problems with this driver, please contact:
+  Bertold Van den Bergh <vandenbergh@bertold.org>
+
 Generic Serial driver
 ---------------------
 
diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index 4007fa25a..f97c44068 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -436,6 +436,15 @@ config USB_SERIAL_MXUPORT
 	  To compile this driver as a module, choose M here: the
 	  module will be called mxuport.
 
+config USB_SERIAL_NAL
+	tristate "USB NAL Research Corporation Serial Bridge"
+	help
+	  Say Y here if you want to use NAL Research Corporation
+	  USB devices.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called nal.
+
 config USB_SERIAL_NAVMAN
 	tristate "USB Navman GPS device"
 	help
diff --git a/drivers/usb/serial/Makefile b/drivers/usb/serial/Makefile
index 2d491e434..f3cbe972f 100644
--- a/drivers/usb/serial/Makefile
+++ b/drivers/usb/serial/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_USB_SERIAL_METRO)			+= metro-usb.o
 obj-$(CONFIG_USB_SERIAL_MOS7720)		+= mos7720.o
 obj-$(CONFIG_USB_SERIAL_MOS7840)		+= mos7840.o
 obj-$(CONFIG_USB_SERIAL_MXUPORT)		+= mxuport.o
+obj-$(CONFIG_USB_SERIAL_NAL)			+= nal.o
 obj-$(CONFIG_USB_SERIAL_NAVMAN)			+= navman.o
 obj-$(CONFIG_USB_SERIAL_OMNINET)		+= omninet.o
 obj-$(CONFIG_USB_SERIAL_OPTICON)		+= opticon.o
diff --git a/drivers/usb/serial/nal.c b/drivers/usb/serial/nal.c
new file mode 100644
index 000000000..e3272cd5e
--- /dev/null
+++ b/drivers/usb/serial/nal.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for NAL Research Corporation USB serial converter.
+ * Tested using A3LA-XG.
+ *
+ * Copyright (C) 2020 Bertold Van den Bergh (vandenbergh@bertold.org)
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/usb/serial.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+static const struct usb_device_id id_table[] = {
+	{ USB_DEVICE(0x2017, 0x0001) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(usb, id_table);
+
+struct nal_serial_private {
+	struct usb_device       *dev;
+	struct mutex             cmd_mutex; //Mutex for sharing cmd_buf
+	unsigned char            cmd_buf[64];
+
+	spinlock_t               lock;      //Lock for sharing next three entries
+	unsigned char            control_get;
+	unsigned char            control_put;
+	unsigned char            header_type;
+
+	wait_queue_head_t        control_event;
+
+	struct workqueue_struct *work_queue;
+	struct work_struct       control_work;
+	struct work_struct       data_work;
+};
+
+static int nal_prepare_write_buffer(struct usb_serial_port *port,
+				    void *buf, size_t count);
+static void nal_process_read_urb(struct urb *urb);
+static int nal_request(struct nal_serial_private *priv, int type);
+static void nal_data_work(struct work_struct *work);
+static int nal_tiocmget(struct tty_struct *tty);
+static int nal_send_control(struct nal_serial_private *priv,
+			    unsigned int set, unsigned int clear);
+static int nal_tiocmset(struct tty_struct *tty,
+			unsigned int set, unsigned int clear);
+static void nal_dtr_rts(struct usb_serial_port *port, int on);
+static void nal_control_work(struct work_struct *work);
+static int nal_port_probe(struct usb_serial_port *serial);
+static int nal_port_remove(struct usb_serial_port *serial);
+
+static struct usb_serial_driver nal_device = {
+	.driver = {
+		.owner =	THIS_MODULE,
+		.name =		"nal",
+	},
+	.id_table		= id_table,
+	.num_ports		= 1,
+	.tiocmget		= nal_tiocmget,
+	.tiocmset		= nal_tiocmset,
+	.port_probe		= nal_port_probe,
+	.port_remove		= nal_port_remove,
+	.dtr_rts		= nal_dtr_rts,
+	.process_read_urb       = nal_process_read_urb,
+	.prepare_write_buffer   = nal_prepare_write_buffer
+};
+
+static struct usb_serial_driver * const serial_drivers[] = {
+	&nal_device, NULL
+};
+
+#define CONTROL_DSR (1)
+#define CONTROL_CD  (2)
+#define CONTROL_RI  (4)
+#define CONTROL_CTS (8)
+#define CONTROL_DTR (16)
+#define CONTROL_RTS (32)
+
+static int nal_prepare_write_buffer(struct usb_serial_port *port,
+				    void *buf, size_t count)
+{
+	struct nal_serial_private *priv = usb_get_serial_port_data(port);
+	unsigned char *header = (unsigned char *)buf;
+	unsigned char header_type, cout;
+
+	spin_lock(&priv->lock);
+	header_type = priv->header_type;
+	spin_unlock(&priv->lock);
+
+	count = min_t(size_t, count, 64 - header_type);
+
+	cout = kfifo_out_locked(&port->write_fifo, buf + header_type,
+				count, &port->lock) + header_type;
+
+	header[0] = 5;
+
+	if (!header_type) {
+		return 0;
+	} else if (header_type == 2) {
+		header[1] = count;
+		return 64;
+	}
+
+	return cout;
+}
+
+static void nal_process_read_urb(struct urb *urb)
+{
+	struct usb_serial_port *port = urb->context;
+	struct nal_serial_private *priv = usb_get_serial_port_data(port);
+	const unsigned char *buf = (const unsigned char *)urb->transfer_buffer;
+	unsigned char length;
+
+	if (urb->actual_length < 1)
+		return;
+
+	if (!priv->header_type && urb->actual_length < 64) {
+		spin_lock(&priv->lock);
+		priv->header_type = 1;
+		spin_unlock(&priv->lock);
+	}
+
+	if (priv->header_type != 1)
+		schedule_work(&priv->data_work);
+
+	if (buf[0] == 5 && urb->actual_length >= 2) {
+		if (!priv->header_type) {
+			return;
+		} else if (priv->header_type == 1) {
+			tty_insert_flip_string(&port->port, buf + 1,
+					       urb->actual_length - 1);
+		} else {
+			length = buf[1];
+			if (length > urb->actual_length - 2)
+				length = urb->actual_length - 2;
+
+			tty_insert_flip_string(&port->port, buf + 2, length);
+		}
+
+		tty_flip_buffer_push(&port->port);
+	} else if (buf[0] == 0 && urb->actual_length >= 2) {
+		spin_lock(&priv->lock);
+		priv->control_get = 0x80 | buf[1];
+		if (!priv->header_type && urb->actual_length == 64)
+			priv->header_type = 2;
+		spin_unlock(&priv->lock);
+
+		wake_up(&priv->control_event);
+	} else if (buf[0] == 1) {
+		schedule_work(&priv->control_work);
+	} else {
+		dev_info(&priv->dev->dev, "Unsupported input (length=%u): %02x\n",
+			 urb->actual_length, buf[0]);
+	}
+}
+
+static int nal_request(struct nal_serial_private *priv, int type)
+{
+	int ret_val;
+
+	mutex_lock(&priv->cmd_mutex);
+
+	/* type==0: Request control lines
+	 * type==1: Request application data
+	 */
+	priv->cmd_buf[0] = type ? 0x04 : 0x01;
+	priv->cmd_buf[1] = 0xFF;
+
+	ret_val = usb_bulk_msg(priv->dev, usb_sndbulkpipe(priv->dev, 1),
+			       priv->cmd_buf, 64, NULL, HZ);
+
+	mutex_unlock(&priv->cmd_mutex);
+
+	return ret_val;
+}
+
+static void nal_data_work(struct work_struct *work)
+{
+	struct nal_serial_private *priv =
+		container_of(work, struct nal_serial_private, data_work);
+
+	nal_request(priv, 1);
+}
+
+static int nal_tiocmget(struct tty_struct *tty)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	struct nal_serial_private *priv = usb_get_serial_port_data(port);
+	int ret_val, control = 0;
+
+	spin_lock(&priv->lock);
+	priv->control_get = 0;
+	spin_unlock(&priv->lock);
+
+	ret_val = nal_request(priv, 0);
+	if (ret_val)
+		return ret_val;
+
+	while (!control) {
+		ret_val = wait_event_interruptible_timeout(priv->control_event,
+							   priv->control_get > 0, HZ);
+		if (ret_val == 0)
+			ret_val = -ETIMEDOUT;
+		if (ret_val < 0)
+			return ret_val;
+
+		spin_lock(&priv->lock);
+		control = priv->control_get;
+		spin_unlock(&priv->lock);
+	}
+
+	ret_val = ((control & CONTROL_DSR) ? TIOCM_DSR : 0) |
+		 ((control & CONTROL_CD)  ? TIOCM_CD  : 0) |
+		 ((control & CONTROL_RI)  ? TIOCM_RI  : 0) |
+		 ((control & CONTROL_CTS) ? TIOCM_CTS : 0);
+
+	spin_lock(&priv->lock);
+	control = priv->control_put;
+	spin_unlock(&priv->lock);
+
+	ret_val |= ((control & CONTROL_DTR) ? TIOCM_DTR : 0) |
+		  ((control & CONTROL_RTS) ? TIOCM_RTS : 0);
+
+	return ret_val;
+}
+
+static int nal_send_control(struct nal_serial_private *priv,
+			    unsigned int set, unsigned int clear)
+{
+	int ret_val, control;
+
+	mutex_lock(&priv->cmd_mutex);
+
+	spin_lock(&priv->lock);
+	if (set & TIOCM_RTS)
+		priv->control_put |= CONTROL_RTS;
+	if (set & TIOCM_DTR)
+		priv->control_put |= CONTROL_DTR;
+	if (clear & TIOCM_RTS)
+		priv->control_put &= ~CONTROL_RTS;
+	if (clear & TIOCM_DTR)
+		priv->control_put &= ~CONTROL_DTR;
+
+	control = priv->control_put;
+	spin_unlock(&priv->lock);
+
+	priv->cmd_buf[0] = 0x00;
+	priv->cmd_buf[1] = 0x0d | control;
+
+	ret_val = usb_bulk_msg(priv->dev, usb_sndbulkpipe(priv->dev, 1),
+			       priv->cmd_buf, 64, NULL, HZ);
+
+	mutex_unlock(&priv->cmd_mutex);
+
+	return ret_val;
+}
+
+static int nal_tiocmset(struct tty_struct *tty,
+			unsigned int set, unsigned int clear)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	struct nal_serial_private *priv = usb_get_serial_port_data(port);
+
+	return nal_send_control(priv, set, clear);
+}
+
+static void nal_dtr_rts(struct usb_serial_port *port, int enable)
+{
+	struct nal_serial_private *priv = usb_get_serial_port_data(port);
+
+	if (enable)
+		nal_send_control(priv, TIOCM_RTS | TIOCM_DTR, 0);
+	else
+		nal_send_control(priv, 0, TIOCM_RTS | TIOCM_DTR);
+}
+
+static void nal_control_work(struct work_struct *work)
+{
+	struct nal_serial_private *priv =
+		container_of(work, struct nal_serial_private, control_work);
+
+	nal_send_control(priv, 0, 0);
+}
+
+static int nal_port_probe(struct usb_serial_port *serial)
+{
+	struct nal_serial_private *priv;
+	int ret_val;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = serial->serial->dev;
+	spin_lock_init(&priv->lock);
+	init_waitqueue_head(&priv->control_event);
+	mutex_init(&priv->cmd_mutex);
+
+	priv->work_queue = alloc_workqueue("nal_wq", 0, 0);
+	if (!priv->work_queue) {
+		ret_val = -ENOMEM;
+		goto fail_queue;
+	}
+
+	usb_set_serial_port_data(serial, priv);
+
+	INIT_WORK(&priv->control_work, nal_control_work);
+	INIT_WORK(&priv->data_work, nal_data_work);
+
+	/* Used for header autodetect */
+	ret_val = nal_request(priv, 0);
+	if (ret_val < 0)
+		goto fail_probe;
+
+	ret_val = nal_send_control(priv, TIOCM_RTS | TIOCM_DTR, 0);
+	if (ret_val < 0)
+		goto fail_probe;
+
+	return 0;
+
+fail_probe:
+	cancel_work_sync(&priv->data_work);
+	cancel_work_sync(&priv->control_work);
+	destroy_workqueue(priv->work_queue);
+fail_queue:
+	kfree(priv);
+	return ret_val;
+}
+
+static int nal_port_remove(struct usb_serial_port *serial)
+{
+	struct nal_serial_private *priv = usb_get_serial_port_data(serial);
+
+	cancel_work_sync(&priv->data_work);
+	cancel_work_sync(&priv->control_work);
+	destroy_workqueue(priv->work_queue);
+	kfree(priv);
+
+	return 0;
+}
+
+module_usb_serial_driver(serial_drivers, id_table);
+
+#define AUTHOR "Bertold Van den Bergh <vandenbergh@bertold.org>"
+#define DESC   "Driver for NAL Research Corporation USB serial interface"
+MODULE_AUTHOR(AUTHOR);
+MODULE_DESCRIPTION(DESC);
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

