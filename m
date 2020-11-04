Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626EF2A5E4E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgKDGsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgKDGsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:48:00 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618AFC061A4D;
        Tue,  3 Nov 2020 22:48:00 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 72so9797243pfv.7;
        Tue, 03 Nov 2020 22:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dpWiQNpplpqqXHZdrnmhkGJL1ecVpKlvWB6beWz5Buc=;
        b=MYE0aP2sTJ28zHydRlEZpqrjSq0Ni8YgJJcdXzKs6AtEoJiQPXeJYtidrVhHQFJGgq
         Et08mk2FJgezufH4+f2VACRRq3eKJD1J1e3RluUuUGYJr+5jGegsig0SXTZpis6CWzX0
         YzAkaPdmL21C96QDOFFCJXClajtC36ifWWpSet9CJIFA951Bv7CYpE1zBkXvLk1fhK5b
         uh5nQHsGzlWW6ToVv/bErPFFDUGRaaJEktup8ID8TVHgQe5L3qdYBjGbeoV57/ckjtu5
         2A8658/P3R8kVOgqtPHE9DgJBQATqr1TIHGl4g+EbB3B5+205Aurj17ADH0n31Pz69SU
         w5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dpWiQNpplpqqXHZdrnmhkGJL1ecVpKlvWB6beWz5Buc=;
        b=gpYV3ZSN1ccTi5ahUxoFa/mkOfNYEx1442o266YxZz7dlgI/2wX6p+jrAyBnKavPgZ
         Rull5Z54LXoyTxGOi5seoRmBrWhbnPb7xOiLMxa+QHo9mSae/8H53cmMZ93yh6h2zYfv
         h3W8et9ZYunKdSu4rTrlNFyRmBhCOxx7KuvHXIGeuWh9zsRbgIfgiBGMqUiMsNtw8gnm
         CvtYCoRVEKAE2yC5j7BTn2Zi6BVawkyEYzVN4BCH368EwW4t6Opcgs0JiAFMrYyFAwn/
         yNVISCl+rWTtKuC/tpdOYHbahbi+4M8Fdns9k/7IyEZKRwAey2sAbyDSMPIF8j9IklcY
         kyoQ==
X-Gm-Message-State: AOAM532IzE+ljtOT7OJeikahKfvlzh+8hv6bZtRhw/bJoaypHkiUInTe
        e7BROdksYtDcGmCG2fXh09c=
X-Google-Smtp-Source: ABdhPJw0JU8dTd5DFfKgoSD0DK+rO+h/ugVmblHCRx0FgcpjSvB7Yg3dLqGfeFFqMKtKs8IGjzrz3w==
X-Received: by 2002:a63:b10:: with SMTP id 16mr1119840pgl.309.1604472479959;
        Tue, 03 Nov 2020 22:47:59 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:47:59 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 08/15] usb: serial: ftdi_sio: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:16:56 +0530
Message-Id: <20201104064703.15123-9-himadrispandya@gmail.com>
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
 drivers/usb/serial/ftdi_sio.c | 182 +++++++++++++++-------------------
 1 file changed, 78 insertions(+), 104 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index e0f4c3d9649c..37e9e75b90d0 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1245,13 +1245,12 @@ static int update_mctrl(struct usb_serial_port *port, unsigned int set,
 		value |= FTDI_SIO_SET_DTR_HIGH;
 	if (set & TIOCM_RTS)
 		value |= FTDI_SIO_SET_RTS_HIGH;
-	rv = usb_control_msg(port->serial->dev,
-			       usb_sndctrlpipe(port->serial->dev, 0),
-			       FTDI_SIO_SET_MODEM_CTRL_REQUEST,
-			       FTDI_SIO_SET_MODEM_CTRL_REQUEST_TYPE,
-			       value, priv->interface,
-			       NULL, 0, WDR_TIMEOUT);
-	if (rv < 0) {
+	rv = usb_control_msg_send(port->serial->dev, 0,
+				  FTDI_SIO_SET_MODEM_CTRL_REQUEST,
+				  FTDI_SIO_SET_MODEM_CTRL_REQUEST_TYPE,
+				  value, priv->interface,
+				  NULL, 0, WDR_TIMEOUT, GFP_KERNEL);
+	if (rv) {
 		dev_dbg(dev, "%s Error from MODEM_CTRL urb: DTR %s, RTS %s\n",
 			__func__,
 			(set & TIOCM_DTR) ? "HIGH" : (clear & TIOCM_DTR) ? "LOW" : "unchanged",
@@ -1393,12 +1392,11 @@ static int change_speed(struct tty_struct *tty, struct usb_serial_port *port)
 		index = (u16)((index << 8) | priv->interface);
 	}
 
-	rv = usb_control_msg(port->serial->dev,
-			    usb_sndctrlpipe(port->serial->dev, 0),
-			    FTDI_SIO_SET_BAUDRATE_REQUEST,
-			    FTDI_SIO_SET_BAUDRATE_REQUEST_TYPE,
-			    value, index,
-			    NULL, 0, WDR_SHORT_TIMEOUT);
+	rv = usb_control_msg_send(port->serial->dev, 0,
+				  FTDI_SIO_SET_BAUDRATE_REQUEST,
+				  FTDI_SIO_SET_BAUDRATE_REQUEST_TYPE,
+				  value, index,
+				  NULL, 0, WDR_SHORT_TIMEOUT, GFP_KERNEL);
 	return rv;
 }
 
@@ -1417,13 +1415,12 @@ static int write_latency_timer(struct usb_serial_port *port)
 
 	dev_dbg(&port->dev, "%s: setting latency timer = %i\n", __func__, l);
 
-	rv = usb_control_msg(udev,
-			     usb_sndctrlpipe(udev, 0),
-			     FTDI_SIO_SET_LATENCY_TIMER_REQUEST,
-			     FTDI_SIO_SET_LATENCY_TIMER_REQUEST_TYPE,
-			     l, priv->interface,
-			     NULL, 0, WDR_TIMEOUT);
-	if (rv < 0)
+	rv = usb_control_msg_send(udev, 0,
+				  FTDI_SIO_SET_LATENCY_TIMER_REQUEST,
+				  FTDI_SIO_SET_LATENCY_TIMER_REQUEST_TYPE,
+				  l, priv->interface,
+				  NULL, 0, WDR_TIMEOUT, GFP_KERNEL);
+	if (rv)
 		dev_err(&port->dev, "Unable to write latency timer: %i\n", rv);
 	return rv;
 }
@@ -1432,27 +1429,16 @@ static int _read_latency_timer(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	struct usb_device *udev = port->serial->dev;
-	unsigned char *buf;
+	u8 buf;
 	int rv;
 
-	buf = kmalloc(1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	rv = usb_control_msg(udev,
-			     usb_rcvctrlpipe(udev, 0),
-			     FTDI_SIO_GET_LATENCY_TIMER_REQUEST,
-			     FTDI_SIO_GET_LATENCY_TIMER_REQUEST_TYPE,
-			     0, priv->interface,
-			     buf, 1, WDR_TIMEOUT);
-	if (rv < 1) {
-		if (rv >= 0)
-			rv = -EIO;
-	} else {
-		rv = buf[0];
-	}
-
-	kfree(buf);
+	rv = usb_control_msg_recv(udev, 0,
+				  FTDI_SIO_GET_LATENCY_TIMER_REQUEST,
+				  FTDI_SIO_GET_LATENCY_TIMER_REQUEST_TYPE,
+				  0, priv->interface,
+				  &buf, 1, WDR_TIMEOUT, GFP_KERNEL);
+	if (rv == 0)
+		rv = buf;
 
 	return rv;
 }
@@ -1731,13 +1717,12 @@ static ssize_t event_char_store(struct device *dev,
 
 	dev_dbg(&port->dev, "%s: setting event char = 0x%03x\n", __func__, v);
 
-	rv = usb_control_msg(udev,
-			     usb_sndctrlpipe(udev, 0),
-			     FTDI_SIO_SET_EVENT_CHAR_REQUEST,
-			     FTDI_SIO_SET_EVENT_CHAR_REQUEST_TYPE,
-			     v, priv->interface,
-			     NULL, 0, WDR_TIMEOUT);
-	if (rv < 0) {
+	rv = usb_control_msg_send(udev, 0,
+				  FTDI_SIO_SET_EVENT_CHAR_REQUEST,
+				  FTDI_SIO_SET_EVENT_CHAR_REQUEST_TYPE,
+				  v, priv->interface,
+				  NULL, 0, WDR_TIMEOUT, GFP_KERNEL);
+	if (rv) {
 		dev_dbg(&port->dev, "Unable to write event character: %i\n", rv);
 		return -EIO;
 	}
@@ -1805,12 +1790,12 @@ static int ftdi_set_bitmode(struct usb_serial_port *port, u8 mode)
 		return result;
 
 	val = (mode << 8) | (priv->gpio_output << 4) | priv->gpio_value;
-	result = usb_control_msg(serial->dev,
-				 usb_sndctrlpipe(serial->dev, 0),
-				 FTDI_SIO_SET_BITMODE_REQUEST,
-				 FTDI_SIO_SET_BITMODE_REQUEST_TYPE, val,
-				 priv->interface, NULL, 0, WDR_TIMEOUT);
-	if (result < 0) {
+	result = usb_control_msg_send(serial->dev, 0,
+				      FTDI_SIO_SET_BITMODE_REQUEST,
+				      FTDI_SIO_SET_BITMODE_REQUEST_TYPE, val,
+				      priv->interface, NULL, 0, WDR_TIMEOUT,
+				      GFP_KERNEL);
+	if (result) {
 		dev_err(&serial->interface->dev,
 			"bitmode request failed for value 0x%04x: %d\n",
 			val, result);
@@ -1866,32 +1851,21 @@ static int ftdi_read_cbus_pins(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	struct usb_serial *serial = port->serial;
-	unsigned char *buf;
+	u8 buf;
 	int result;
 
 	result = usb_autopm_get_interface(serial->interface);
 	if (result)
 		return result;
 
-	buf = kmalloc(1, GFP_KERNEL);
-	if (!buf) {
-		usb_autopm_put_interface(serial->interface);
-		return -ENOMEM;
-	}
-
-	result = usb_control_msg(serial->dev,
-				 usb_rcvctrlpipe(serial->dev, 0),
-				 FTDI_SIO_READ_PINS_REQUEST,
-				 FTDI_SIO_READ_PINS_REQUEST_TYPE, 0,
-				 priv->interface, buf, 1, WDR_TIMEOUT);
-	if (result < 1) {
-		if (result >= 0)
-			result = -EIO;
-	} else {
-		result = buf[0];
-	}
+	result = usb_control_msg_recv(serial->dev, 0,
+				      FTDI_SIO_READ_PINS_REQUEST,
+				      FTDI_SIO_READ_PINS_REQUEST_TYPE, 0,
+				      priv->interface, &buf, 1, WDR_TIMEOUT,
+				      GFP_KERNEL);
+	if (result == 0)
+		result = buf;
 
-	kfree(buf);
 	usb_autopm_put_interface(serial->interface);
 
 	return result;
@@ -2311,6 +2285,7 @@ static int ftdi_NDI_device_setup(struct usb_serial *serial)
 {
 	struct usb_device *udev = serial->dev;
 	int latency = ndi_latency_timer;
+	int ret;
 
 	if (latency == 0)
 		latency = 1;
@@ -2320,12 +2295,12 @@ static int ftdi_NDI_device_setup(struct usb_serial *serial)
 	dev_dbg(&udev->dev, "%s setting NDI device latency to %d\n", __func__, latency);
 	dev_info(&udev->dev, "NDI device with a latency value of %d\n", latency);
 
-	/* FIXME: errors are not returned */
-	usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-				FTDI_SIO_SET_LATENCY_TIMER_REQUEST,
-				FTDI_SIO_SET_LATENCY_TIMER_REQUEST_TYPE,
-				latency, 0, NULL, 0, WDR_TIMEOUT);
-	return 0;
+	ret = usb_control_msg_send(udev, 0,
+				   FTDI_SIO_SET_LATENCY_TIMER_REQUEST,
+				   FTDI_SIO_SET_LATENCY_TIMER_REQUEST_TYPE,
+				   latency, 0, NULL, 0, WDR_TIMEOUT,
+				   GFP_KERNEL);
+	return ret;
 }
 
 /*
@@ -2424,12 +2399,11 @@ static void ftdi_dtr_rts(struct usb_serial_port *port, int on)
 
 	/* Disable flow control */
 	if (!on) {
-		if (usb_control_msg(port->serial->dev,
-			    usb_sndctrlpipe(port->serial->dev, 0),
-			    FTDI_SIO_SET_FLOW_CTRL_REQUEST,
-			    FTDI_SIO_SET_FLOW_CTRL_REQUEST_TYPE,
-			    0, priv->interface, NULL, 0,
-			    WDR_TIMEOUT) < 0) {
+		if (usb_control_msg_send(port->serial->dev, 0,
+					 FTDI_SIO_SET_FLOW_CTRL_REQUEST,
+					 FTDI_SIO_SET_FLOW_CTRL_REQUEST_TYPE,
+					 0, priv->interface, NULL, 0,
+					 WDR_TIMEOUT, GFP_KERNEL)) {
 			dev_err(&port->dev, "error from flowcontrol urb\n");
 		}
 	}
@@ -2617,12 +2591,11 @@ static void ftdi_break_ctl(struct tty_struct *tty, int break_state)
 	else
 		value = priv->last_set_data_value;
 
-	if (usb_control_msg(port->serial->dev,
-			usb_sndctrlpipe(port->serial->dev, 0),
-			FTDI_SIO_SET_DATA_REQUEST,
-			FTDI_SIO_SET_DATA_REQUEST_TYPE,
-			value , priv->interface,
-			NULL, 0, WDR_TIMEOUT) < 0) {
+	if (usb_control_msg_send(port->serial->dev, 0,
+				 FTDI_SIO_SET_DATA_REQUEST,
+				 FTDI_SIO_SET_DATA_REQUEST_TYPE,
+				 value, priv->interface,
+				 NULL, 0, WDR_TIMEOUT, GFP_KERNEL)) {
 		dev_err(&port->dev, "%s FAILED to enable/disable break state (state was %d)\n",
 			__func__, break_state);
 	}
@@ -2754,11 +2727,11 @@ static void ftdi_set_termios(struct tty_struct *tty,
 	   - but is or'ed with this value  */
 	priv->last_set_data_value = value;
 
-	if (usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
-			    FTDI_SIO_SET_DATA_REQUEST,
-			    FTDI_SIO_SET_DATA_REQUEST_TYPE,
-			    value , priv->interface,
-			    NULL, 0, WDR_SHORT_TIMEOUT) < 0) {
+	if (usb_control_msg_send(dev, 0,
+				 FTDI_SIO_SET_DATA_REQUEST,
+				 FTDI_SIO_SET_DATA_REQUEST_TYPE,
+				 value, priv->interface,
+				 NULL, 0, WDR_SHORT_TIMEOUT, GFP_KERNEL)) {
 		dev_err(ddev, "%s FAILED to set databits/stopbits/parity\n",
 			__func__);
 	}
@@ -2767,11 +2740,11 @@ static void ftdi_set_termios(struct tty_struct *tty,
 no_data_parity_stop_changes:
 	if ((cflag & CBAUD) == B0) {
 		/* Disable flow control */
-		if (usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
-				    FTDI_SIO_SET_FLOW_CTRL_REQUEST,
-				    FTDI_SIO_SET_FLOW_CTRL_REQUEST_TYPE,
-				    0, priv->interface,
-				    NULL, 0, WDR_TIMEOUT) < 0) {
+		if (usb_control_msg_send(dev, 0,
+					 FTDI_SIO_SET_FLOW_CTRL_REQUEST,
+					 FTDI_SIO_SET_FLOW_CTRL_REQUEST_TYPE,
+					 0, priv->interface,
+					 NULL, 0, WDR_TIMEOUT, GFP_KERNEL)) {
 			dev_err(ddev, "%s error from disable flowcontrol urb\n",
 				__func__);
 		}
@@ -2806,11 +2779,12 @@ static void ftdi_set_termios(struct tty_struct *tty,
 
 	index |= priv->interface;
 
-	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
-			FTDI_SIO_SET_FLOW_CTRL_REQUEST,
-			FTDI_SIO_SET_FLOW_CTRL_REQUEST_TYPE,
-			value, index, NULL, 0, WDR_TIMEOUT);
-	if (ret < 0)
+	ret = usb_control_msg_send(dev, 0,
+				   FTDI_SIO_SET_FLOW_CTRL_REQUEST,
+				   FTDI_SIO_SET_FLOW_CTRL_REQUEST_TYPE,
+				   value, index, NULL, 0, WDR_TIMEOUT,
+				   GFP_KERNEL);
+	if (ret)
 		dev_err(&port->dev, "failed to set flow control: %d\n", ret);
 }
 
-- 
2.17.1

