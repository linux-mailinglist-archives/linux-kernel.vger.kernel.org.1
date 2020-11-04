Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17362A5E44
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgKDGrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgKDGrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:47:46 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0596C061A4D;
        Tue,  3 Nov 2020 22:47:44 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id e7so16463914pfn.12;
        Tue, 03 Nov 2020 22:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JQfRVw+JvA74WyL79cIHLhMk0a8vhCik+EDNpAkK11o=;
        b=JOAa2k//H2LnYBr6zCUXT3mo7GQRsBnXapbrGhnCmYWZ2QAeLaOWDCe7zYe2/WDPVe
         s0zpM8nolDsOeY593GLTZgIDjgPBYh/xA9wXOftzJ2oeMZyMC0acLVWSu59g8HEqwwDj
         VuU8mUyLGQFTwVwwec+hDOx88Aio5/PvW2DsQIf5w7vdtFxzQU032wIioNqtdX1DxwFq
         kPqvgq9ni0ZoAOo0VoNRFPrAkPNzI+QzqNSOVQEhD4u6oyliVuxoZuBImAgtW4nhM0vv
         nYREEePI1FuK20PZWJ8H3kyABTzTAjEu1FCliQZY2sRXeC3DsufEMsMEpbLvXmq9/FK3
         c3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JQfRVw+JvA74WyL79cIHLhMk0a8vhCik+EDNpAkK11o=;
        b=g3vvtWJnir0f5u9WB7ONZqVU+vUZy88OYLK+6irpnCO+hGzo+Aqi0mlT0jpr5sPpjW
         2z0CaVGqNLloIUaDWTyIf2Y0pcC7+Sc24vHG7pjwWGJVocgy3VsW/566SkHvocwcA2Fa
         yZl7N59nxnChj1erJhtGx+BMecdf2cLUEwC3NGS7dOCq+jCKu2xOvBLVZl32UOulI3iU
         KaLp+vwwmlb4Crc3mN0zarNac0OUjbhzwOUaS2/Ae2ymxSN7HCt6Uz2IHDVoidviHYg/
         b3HVqIQLT2nIM8Vkxbip1gI0bsIby0HNZB5lUBoUyeO5nneyTJZNxI0u+02SJFiCzqIv
         Sf1w==
X-Gm-Message-State: AOAM530dWJf2pX5OEdPb0K9ij8VDCKkr87kfTNlWN2PO+zECZD0c7n2p
        8QuLnT0G+Y7ONQleA1NZKoc=
X-Google-Smtp-Source: ABdhPJyufrA29PcX5wXFdrhYrNw4mqJ16vQXCCFgpbRsiOI8kfTHHT7jyHUtfZ7BZz3bkgL4+deiFQ==
X-Received: by 2002:a63:ec57:: with SMTP id r23mr20660997pgj.257.1604472464508;
        Tue, 03 Nov 2020 22:47:44 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:47:43 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 04/15] usb: serial: cp210x: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:16:52 +0530
Message-Id: <20201104064703.15123-5-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104064703.15123-1-himadrispandya@gmail.com>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
usb_control_msg() with proper error check. Hence use the wrappers
instead of calling usb_control_msg() directly.

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
 drivers/usb/serial/cp210x.c | 148 ++++++++++--------------------------
 1 file changed, 42 insertions(+), 106 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index d0c05aa8a0d6..29436ab392e8 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -555,31 +555,15 @@ static int cp210x_read_reg_block(struct usb_serial_port *port, u8 req,
 {
 	struct usb_serial *serial = port->serial;
 	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
-	void *dmabuf;
 	int result;
 
-	dmabuf = kmalloc(bufsize, GFP_KERNEL);
-	if (!dmabuf) {
-		/*
-		 * FIXME Some callers don't bother to check for error,
-		 * at least give them consistent junk until they are fixed
-		 */
-		memset(buf, 0, bufsize);
-		return -ENOMEM;
-	}
-
-	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
-			req, REQTYPE_INTERFACE_TO_HOST, 0,
-			port_priv->bInterfaceNumber, dmabuf, bufsize,
-			USB_CTRL_SET_TIMEOUT);
-	if (result == bufsize) {
-		memcpy(buf, dmabuf, bufsize);
-		result = 0;
-	} else {
+	result = usb_control_msg_recv(serial->dev, 0, req,
+				      REQTYPE_INTERFACE_TO_HOST, 0,
+				      port_priv->bInterfaceNumber, buf, bufsize,
+				      USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+	if (result) {
 		dev_err(&port->dev, "failed get req 0x%x size %d status: %d\n",
-				req, bufsize, result);
-		if (result >= 0)
-			result = -EIO;
+			req, bufsize, result);
 
 		/*
 		 * FIXME Some callers don't bother to check for error,
@@ -588,8 +572,6 @@ static int cp210x_read_reg_block(struct usb_serial_port *port, u8 req,
 		memset(buf, 0, bufsize);
 	}
 
-	kfree(dmabuf);
-
 	return result;
 }
 
@@ -648,29 +630,16 @@ static int cp210x_read_u8_reg(struct usb_serial_port *port, u8 req, u8 *val)
 static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
 				    void *buf, int bufsize)
 {
-	void *dmabuf;
 	int result;
 
-	dmabuf = kmalloc(bufsize, GFP_KERNEL);
-	if (!dmabuf)
-		return -ENOMEM;
-
-	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
-				 CP210X_VENDOR_SPECIFIC, type, val,
-				 cp210x_interface_num(serial), dmabuf, bufsize,
-				 USB_CTRL_GET_TIMEOUT);
-	if (result == bufsize) {
-		memcpy(buf, dmabuf, bufsize);
-		result = 0;
-	} else {
+	result = usb_control_msg_recv(serial->dev, 0, CP210X_VENDOR_SPECIFIC,
+				      type, val, cp210x_interface_num(serial),
+				      buf, bufsize, USB_CTRL_GET_TIMEOUT,
+				      GFP_KERNEL);
+	if (result)
 		dev_err(&serial->interface->dev,
 			"failed to get vendor val 0x%04x size %d: %d\n", val,
 			bufsize, result);
-		if (result >= 0)
-			result = -EIO;
-	}
-
-	kfree(dmabuf);
 
 	return result;
 }
@@ -685,14 +654,13 @@ static int cp210x_write_u16_reg(struct usb_serial_port *port, u8 req, u16 val)
 	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
 	int result;
 
-	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-			req, REQTYPE_HOST_TO_INTERFACE, val,
-			port_priv->bInterfaceNumber, NULL, 0,
-			USB_CTRL_SET_TIMEOUT);
-	if (result < 0) {
+	result = usb_control_msg_send(serial->dev, 0, req,
+				      REQTYPE_HOST_TO_INTERFACE, val,
+				      port_priv->bInterfaceNumber, NULL, 0,
+				      USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+	if (result)
 		dev_err(&port->dev, "failed set request 0x%x status: %d\n",
 				req, result);
-	}
 
 	return result;
 }
@@ -706,28 +674,17 @@ static int cp210x_write_reg_block(struct usb_serial_port *port, u8 req,
 {
 	struct usb_serial *serial = port->serial;
 	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
-	void *dmabuf;
 	int result;
 
-	dmabuf = kmemdup(buf, bufsize, GFP_KERNEL);
-	if (!dmabuf)
-		return -ENOMEM;
+	result = usb_control_msg_send(serial->dev, 0, req,
+				      REQTYPE_HOST_TO_INTERFACE, 0,
+				      port_priv->bInterfaceNumber, buf, bufsize,
+				      USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
 
-	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-			req, REQTYPE_HOST_TO_INTERFACE, 0,
-			port_priv->bInterfaceNumber, dmabuf, bufsize,
-			USB_CTRL_SET_TIMEOUT);
 
-	kfree(dmabuf);
-
-	if (result == bufsize) {
-		result = 0;
-	} else {
+	if (result)
 		dev_err(&port->dev, "failed set req 0x%x size %d status: %d\n",
 				req, bufsize, result);
-		if (result >= 0)
-			result = -EIO;
-	}
 
 	return result;
 }
@@ -752,29 +709,17 @@ static int cp210x_write_u32_reg(struct usb_serial_port *port, u8 req, u32 val)
 static int cp210x_write_vendor_block(struct usb_serial *serial, u8 type,
 				     u16 val, void *buf, int bufsize)
 {
-	void *dmabuf;
 	int result;
 
-	dmabuf = kmemdup(buf, bufsize, GFP_KERNEL);
-	if (!dmabuf)
-		return -ENOMEM;
-
-	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-				 CP210X_VENDOR_SPECIFIC, type, val,
-				 cp210x_interface_num(serial), dmabuf, bufsize,
-				 USB_CTRL_SET_TIMEOUT);
-
-	kfree(dmabuf);
+	result = usb_control_msg_send(serial->dev, 0, CP210X_VENDOR_SPECIFIC,
+				      type, val, cp210x_interface_num(serial),
+				      buf, bufsize, USB_CTRL_SET_TIMEOUT,
+				      GFP_KERNEL);
 
-	if (result == bufsize) {
-		result = 0;
-	} else {
+	if (result)
 		dev_err(&serial->interface->dev,
 			"failed to set vendor val 0x%04x size %d: %d\n", val,
 			bufsize, result);
-		if (result >= 0)
-			result = -EIO;
-	}
 
 	return result;
 }
@@ -995,27 +940,19 @@ static int cp210x_get_tx_queue_byte_count(struct usb_serial_port *port,
 {
 	struct usb_serial *serial = port->serial;
 	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
-	struct cp210x_comm_status *sts;
+	struct cp210x_comm_status sts;
 	int result;
 
-	sts = kmalloc(sizeof(*sts), GFP_KERNEL);
-	if (!sts)
-		return -ENOMEM;
-
-	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
-			CP210X_GET_COMM_STATUS, REQTYPE_INTERFACE_TO_HOST,
-			0, port_priv->bInterfaceNumber, sts, sizeof(*sts),
-			USB_CTRL_GET_TIMEOUT);
-	if (result == sizeof(*sts)) {
-		*count = le32_to_cpu(sts->ulAmountInOutQueue);
-		result = 0;
-	} else {
+	result = usb_control_msg_recv(serial->dev, 0,
+				      CP210X_GET_COMM_STATUS,
+				      REQTYPE_INTERFACE_TO_HOST, 0,
+				      port_priv->bInterfaceNumber, &sts,
+				      sizeof(sts), USB_CTRL_GET_TIMEOUT,
+				      GFP_KERNEL);
+	if (result == 0)
+		*count = le32_to_cpu(sts.ulAmountInOutQueue);
+	else
 		dev_err(&port->dev, "failed to get comm status: %d\n", result);
-		if (result >= 0)
-			result = -EIO;
-	}
-
-	kfree(sts);
 
 	return result;
 }
@@ -1624,13 +1561,12 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 	} else {
 		u16 wIndex = buf.state << 8 | buf.mask;
 
-		result = usb_control_msg(serial->dev,
-					 usb_sndctrlpipe(serial->dev, 0),
-					 CP210X_VENDOR_SPECIFIC,
-					 REQTYPE_HOST_TO_DEVICE,
-					 CP210X_WRITE_LATCH,
-					 wIndex,
-					 NULL, 0, USB_CTRL_SET_TIMEOUT);
+		result = usb_control_msg_send(serial->dev, 0,
+					      CP210X_VENDOR_SPECIFIC,
+					      REQTYPE_HOST_TO_DEVICE,
+					      CP210X_WRITE_LATCH,
+					      wIndex, NULL, 0,
+					      USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
 	}
 
 	usb_autopm_put_interface(serial->interface);
-- 
2.17.1

