Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99D22FE7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbhAUKf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:35:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:59612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729446AbhAUKaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:30:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EC06204EF;
        Thu, 21 Jan 2021 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611224969;
        bh=hDcCV63sIsqexDfHHTIRFTcbjagA3dzVFYGYL6Q444A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HzN1xzDbp9s8hPuvQ3l6FBlFuw36AW377Gq9RsrrO7vELsew92gQUSAmBlCDqpEkE
         EKQ4bcF9bj2jkgWpq/boJRqw9Ar1ySZnXvFlm540SVTulmca53XFl6OGrsUx1P9/eK
         fLP6mGntfsglXmzqtfGqmuIG0Ijj5Z5oMYrsmqMV1URj9RuPSfEBJnbBgguS0MD10s
         c8DFFEJFoYgpM/InNtDAKWTv6ANqaGklluB8cDEtBu23JB5G4YJlSWEjg4SrGgTzFD
         6k+PeZgWXU9b3/8qh9qaREGraoel+Y/fUpKehXJksfl6PJI3UhbSSY8bgxL/3Pp5g2
         1socv+cJ9vx8A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2XDc-0004YF-EI; Thu, 21 Jan 2021 11:29:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Pho Tran <pho.tran@silabs.com>
Subject: [PATCH] USB: serial: cp210x: suppress modem-control error on open and close
Date:   Thu, 21 Jan 2021 11:29:12 +0100
Message-Id: <20210121102922.17439-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121102922.17439-1-johan@kernel.org>
References: <20210121102922.17439-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CP210X_SET_MHS request cannot be used to control DTR/RTS when
hardware flow control is enabled and instead returns an error which is
currently logged as:

	cp210x ttyUSB0: failed set request 0x7 status: -32

Add a crtscts flag to keep track of the hardware flow-control setting
and use it to suppress the request in dtr_rts().

Note that both lines are still deasserted when disabling the UART as
part of close().

Also note that TIOCMSET is left unchanged and will continue to return an
error to user-space when flow control is enabled (i.e. instead of
disabling and re-enabling auto-RTS when RTS is deasserted and
re-asserted).

Reported-by: Pho Tran <pho.tran@silabs.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index d813a052738f..ac1e5cbe61dd 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -264,7 +264,8 @@ struct cp210x_port_private {
 	u8			bInterfaceNumber;
 	bool			event_mode;
 	enum cp210x_event_state event_state;
-	u8 lsr;
+	u8			lsr;
+	bool			crtscts;
 };
 
 static struct usb_serial_driver cp210x_device = {
@@ -1117,6 +1118,7 @@ static bool cp210x_termios_change(const struct ktermios *a, const struct ktermio
 static void cp210x_set_flow_control(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
+	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
 	struct cp210x_special_chars chars;
 	struct cp210x_flow_ctl flow_ctl;
 	u32 flow_repl;
@@ -1161,10 +1163,12 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
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
@@ -1298,6 +1302,16 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
 
 static void cp210x_dtr_rts(struct usb_serial_port *port, int on)
 {
+	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
+
+	/*
+	 * CP210X_SET_MHS cannot be used to control DTR/RTS when hardware flow
+	 * control is enabled. Note that both lines are still deasserted when
+	 * disabling the UART.
+	 */
+	if (port_priv->crtscts)
+		return;
+
 	if (on)
 		cp210x_tiocmset_port(port, TIOCM_DTR | TIOCM_RTS, 0);
 	else
-- 
2.26.2

