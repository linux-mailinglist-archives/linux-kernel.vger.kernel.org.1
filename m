Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE0303683
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbhAZG1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:27:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729101AbhAYNvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:51:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA2E622B3B;
        Mon, 25 Jan 2021 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611582505;
        bh=rzy6JQ7F/EugWU8tK/NmPdX8jnCIpy4RnsHcMdpnLIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZuwUtmCe5KLJq5zCG5W2uoP06HZd3dSkSAU2WWCU2R19zcsR3JDZos4Rr42ELlxfY
         y/0M9RVkVyOftQLxiJhCs0l5WLd3aHqDXQ5/Xt2wr22rPJ1m8RAlXroiNoTl33Vx2o
         /XFr26yC4sLG9wSxlDdG8i/g8kNUa09jnqCEn1IjFCT9949uw4plNLsFGdu2T1vHDm
         UI3XDEuka0nOn6T+Yx7OdxM/cSlapf7T7pOpBMgY1dFgTL3/GhBHfZzLcvkh3upzCK
         BqJu5fgm/2sumL+SGUZonH2gL7J5o0/k/9eFYuZlVDO/OYJBrZcGIGSEzA2/BeMIHJ
         HLb0CVr1tAxLQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l42EL-00034O-IT; Mon, 25 Jan 2021 14:48:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Pho Tran <Pho.Tran@silabs.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Pho Tran <pho.tran@silabs.com>
Subject: [PATCH 1/7] USB: serial: cp210x: suppress modem-control errors
Date:   Mon, 25 Jan 2021 14:48:11 +0100
Message-Id: <20210125134817.11749-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210125134817.11749-1-johan@kernel.org>
References: <20210125134817.11749-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CP210X_SET_MHS request cannot be used to control RTS when hardware
flow control (auto-RTS) is enabled and instead returns an error which is
currently logged as:

	cp210x ttyUSB0: failed set request 0x7 status: -32

when opening and closing a port (and on TIOCMSET requests).

Add a crtscts flag to keep track of the hardware flow-control setting
and use it to suppress any request to change RTS when auto-RTS is
enabled.

Note that RTS is still deasserted when disabling the UART as part of
close.

Reported-by: Pho Tran <pho.tran@silabs.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index d813a052738f..7e4a09b42c99 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -21,6 +21,7 @@
 #include <linux/usb/serial.h>
 #include <linux/gpio/driver.h>
 #include <linux/bitops.h>
+#include <linux/mutex.h>
 
 #define DRIVER_DESC "Silicon Labs CP210x RS232 serial adaptor driver"
 
@@ -264,7 +265,10 @@ struct cp210x_port_private {
 	u8			bInterfaceNumber;
 	bool			event_mode;
 	enum cp210x_event_state event_state;
-	u8 lsr;
+	u8			lsr;
+
+	struct mutex		mutex;
+	bool			crtscts;
 };
 
 static struct usb_serial_driver cp210x_device = {
@@ -1117,6 +1121,7 @@ static bool cp210x_termios_change(const struct ktermios *a, const struct ktermio
 static void cp210x_set_flow_control(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
+	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
 	struct cp210x_special_chars chars;
 	struct cp210x_flow_ctl flow_ctl;
 	u32 flow_repl;
@@ -1143,10 +1148,12 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 			return;
 	}
 
+	mutex_lock(&port_priv->mutex);
+
 	ret = cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
 			sizeof(flow_ctl));
 	if (ret)
-		return;
+		goto out_unlock;
 
 	ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
 	flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
@@ -1161,10 +1168,12 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 		ctl_hs |= CP210X_SERIAL_CTS_HANDSHAKE;
 		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
 		flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL);
+		port_priv->crtscts = true;
 	} else {
 		ctl_hs &= ~CP210X_SERIAL_CTS_HANDSHAKE;
 		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
 		flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_ACTIVE);
+		port_priv->crtscts = false;
 	}
 
 	if (I_IXOFF(tty))
@@ -1188,6 +1197,8 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 
 	cp210x_write_reg_block(port, CP210X_SET_FLOW, &flow_ctl,
 			sizeof(flow_ctl));
+out_unlock:
+	mutex_unlock(&port_priv->mutex);
 }
 
 static void cp210x_set_termios(struct tty_struct *tty,
@@ -1272,7 +1283,9 @@ static int cp210x_tiocmset(struct tty_struct *tty,
 static int cp210x_tiocmset_port(struct usb_serial_port *port,
 		unsigned int set, unsigned int clear)
 {
+	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
 	u16 control = 0;
+	int ret;
 
 	if (set & TIOCM_RTS) {
 		control |= CONTROL_RTS;
@@ -1291,9 +1304,22 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
 		control |= CONTROL_WRITE_DTR;
 	}
 
+	mutex_lock(&port_priv->mutex);
+
+	/*
+	 * SET_MHS cannot be used to control RTS when auto-RTS is enabled.
+	 * Note that RTS is still deasserted when disabling the UART on close.
+	 */
+	if (port_priv->crtscts)
+		control &= ~CONTROL_WRITE_RTS;
+
 	dev_dbg(&port->dev, "%s - control = 0x%.4x\n", __func__, control);
 
-	return cp210x_write_u16_reg(port, CP210X_SET_MHS, control);
+	ret = cp210x_write_u16_reg(port, CP210X_SET_MHS, control);
+
+	mutex_unlock(&port_priv->mutex);
+
+	return ret;
 }
 
 static void cp210x_dtr_rts(struct usb_serial_port *port, int on)
@@ -1770,6 +1796,7 @@ static int cp210x_port_probe(struct usb_serial_port *port)
 		return -ENOMEM;
 
 	port_priv->bInterfaceNumber = cp210x_interface_num(serial);
+	mutex_init(&port_priv->mutex);
 
 	usb_set_serial_port_data(port, port_priv);
 
-- 
2.26.2

