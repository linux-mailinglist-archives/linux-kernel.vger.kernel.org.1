Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6242FEB31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbhAUNEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:04:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbhAUKbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:31:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3562239EB;
        Thu, 21 Jan 2021 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611224970;
        bh=v5TgOwXWj0YY94HrnCt3iZPfS8p5FlPm3RviRv/L0ME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKY1pyJ5iW32eEeBPWbGWV4NQzWsqnbFjXsBeshkGsrUCN1s35y819qTxGvcME6H1
         F20FMpcEU8JHAJjwQQXXrFj4HHLcDFTp40F+nr/aW6KNm8AhgESBChwxTKwlgtcnPx
         athTudEMfwVgz0ygLTzGDk5PDX0SvHjpmTiSSP9rTaHE6a+otvPpZRWWz3+QcV4Kfr
         frVdJD5r193stCExKb2PXyhSA5N6qwb7HtQdKmVoGUCIROHBxsBr2ARmeY2J46cGMl
         eUeeoO85RR2s8pPvQ3G22lXcMBRuozk+1mghQOybuSFMELPAzM01Uf7oT6MyFyUXUi
         AvGHeHZW6TAqw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2XDd-0004Yj-Fe; Thu, 21 Jan 2021 11:29:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 10/10] USB: serial: xr: fix B0 handling
Date:   Thu, 21 Jan 2021 11:29:22 +0100
Message-Id: <20210121102922.17439-12-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121102922.17439-1-johan@kernel.org>
References: <20210121102922.17439-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up B0 handling which should leave the baud rate unchanged and
specifically not report back a non-B0 rate when B0 is requested; must
temporarily disable hardware flow control so that RTS can be deasserted;
and should reassert DTR/RTS when moving from B0.

Fixes: a8f54b7bd132 ("USB: serial: add MaxLinear/Exar USB to Serial driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index f67e7dba9509..483d07dee19d 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -341,8 +341,11 @@ static int xr_set_baudrate(struct tty_struct *tty,
 	u16 tx_mask, rx_mask;
 	int ret;
 
-	baud = clamp(tty->termios.c_ospeed, XR21V141X_MIN_SPEED,
-		     XR21V141X_MAX_SPEED);
+	baud = tty->termios.c_ospeed;
+	if (!baud)
+		return 0;
+
+	baud = clamp(baud, XR21V141X_MIN_SPEED, XR21V141X_MAX_SPEED);
 	divisor = XR_INT_OSC_HZ / baud;
 	idx = ((32 * XR_INT_OSC_HZ) / baud) & 0x1f;
 	tx_mask = xr21v141x_txrx_clk_masks[idx].tx;
@@ -399,7 +402,8 @@ static int xr_set_baudrate(struct tty_struct *tty,
 }
 
 static void xr_set_flow_mode(struct tty_struct *tty,
-			     struct usb_serial_port *port)
+			     struct usb_serial_port *port,
+			     struct ktermios *old_termios)
 {
 	u8 flow, gpio_mode;
 	int ret;
@@ -411,7 +415,7 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 	/* Set GPIO mode for controlling the pins manually by default. */
 	gpio_mode &= ~XR21V141X_UART_MODE_GPIO_MASK;
 
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
 		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
 		gpio_mode |= XR21V141X_UART_MODE_RTS_CTS;
 		flow = XR21V141X_UART_FLOW_MODE_HW;
@@ -438,6 +442,11 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 	xr_uart_enable(port);
 
 	xr_set_reg_uart(port, XR21V141X_REG_GPIO_MODE, gpio_mode);
+
+	if (C_BAUD(tty) == B0)
+		xr_dtr_rts(port, 0);
+	else if (old_termios && (old_termios->c_cflag & CBAUD) == B0)
+		xr_dtr_rts(port, 1);
 }
 
 static void xr_set_termios(struct tty_struct *tty,
@@ -493,11 +502,7 @@ static void xr_set_termios(struct tty_struct *tty,
 	if (ret)
 		return;
 
-	/* If baud rate is B0, clear DTR and RTS */
-	if (C_BAUD(tty) == B0)
-		xr_dtr_rts(port, 0);
-
-	xr_set_flow_mode(tty, port);
+	xr_set_flow_mode(tty, port, old_termios);
 }
 
 static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
-- 
2.26.2

