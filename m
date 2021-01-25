Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A4F30367C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbhAZG0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:26:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbhAYNtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:49:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D050F22240;
        Mon, 25 Jan 2021 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611582505;
        bh=+S7YYu4UwJ/+d67bdn3tDZJmcJ+L2q4qiPherOrHwI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BS6Nk75EKakwUxbwZHRj2tjH7BrY8cwmGZA15o60M4Pz6our4NOjF05ytcHnkjA5N
         isQ0iSlStROkYrYefAwKpFsPb2+z73zmMzEVHAXRy7pckJWrEF+HUZD3WGcXt6iIPj
         U6wBfQgMKIEG9NsfB5SzA7HcOWLCW1GB3mbG0wKOC7a68AG2NTdVsmytTKLIM5ZBCb
         avzVbBU+hAFc6En8Vqm3f2yjTrrJWPEjud+zruWEqOVJGvjlrmxnKCIQzNUKfDcHdV
         lYEdDczvKMiRBikwHYxW3CMrVs05UDBSoBPlYCflaV6uB4EnLssjt/QmeFTF0C+n+a
         hMUpwTwvLaUJg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l42EL-00034Q-LT; Mon, 25 Jan 2021 14:48:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Pho Tran <Pho.Tran@silabs.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/7] USB: serial: cp210x: fix modem-control handling
Date:   Mon, 25 Jan 2021 14:48:12 +0100
Message-Id: <20210125134817.11749-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210125134817.11749-1-johan@kernel.org>
References: <20210125134817.11749-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor request used to set the flow-control settings also sets the
state of the modem-control lines.

Add state variables to keep track of the modem-control lines to avoid
always asserting the lines whenever the flow-control settings are
updated.

This specifically also avoids asserting DTR/RTS when opening a port with
the line speed set to B0.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 7e4a09b42c99..9378b4bba34b 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -269,6 +269,8 @@ struct cp210x_port_private {
 
 	struct mutex		mutex;
 	bool			crtscts;
+	bool			dtr;
+	bool			rts;
 };
 
 static struct usb_serial_driver cp210x_device = {
@@ -1162,7 +1164,10 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 	ctl_hs &= ~CP210X_SERIAL_DCD_HANDSHAKE;
 	ctl_hs &= ~CP210X_SERIAL_DSR_SENSITIVITY;
 	ctl_hs &= ~CP210X_SERIAL_DTR_MASK;
-	ctl_hs |= CP210X_SERIAL_DTR_SHIFT(CP210X_SERIAL_DTR_ACTIVE);
+	if (port_priv->dtr)
+		ctl_hs |= CP210X_SERIAL_DTR_SHIFT(CP210X_SERIAL_DTR_ACTIVE);
+	else
+		ctl_hs |= CP210X_SERIAL_DTR_SHIFT(CP210X_SERIAL_DTR_INACTIVE);
 
 	if (C_CRTSCTS(tty)) {
 		ctl_hs |= CP210X_SERIAL_CTS_HANDSHAKE;
@@ -1172,7 +1177,10 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 	} else {
 		ctl_hs &= ~CP210X_SERIAL_CTS_HANDSHAKE;
 		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
-		flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_ACTIVE);
+		if (port_priv->rts)
+			flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_ACTIVE);
+		else
+			flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_INACTIVE);
 		port_priv->crtscts = false;
 	}
 
@@ -1287,25 +1295,29 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
 	u16 control = 0;
 	int ret;
 
+	mutex_lock(&port_priv->mutex);
+
 	if (set & TIOCM_RTS) {
+		port_priv->rts = true;
 		control |= CONTROL_RTS;
 		control |= CONTROL_WRITE_RTS;
 	}
 	if (set & TIOCM_DTR) {
+		port_priv->dtr = true;
 		control |= CONTROL_DTR;
 		control |= CONTROL_WRITE_DTR;
 	}
 	if (clear & TIOCM_RTS) {
+		port_priv->rts = false;
 		control &= ~CONTROL_RTS;
 		control |= CONTROL_WRITE_RTS;
 	}
 	if (clear & TIOCM_DTR) {
+		port_priv->dtr = false;
 		control &= ~CONTROL_DTR;
 		control |= CONTROL_WRITE_DTR;
 	}
 
-	mutex_lock(&port_priv->mutex);
-
 	/*
 	 * SET_MHS cannot be used to control RTS when auto-RTS is enabled.
 	 * Note that RTS is still deasserted when disabling the UART on close.
-- 
2.26.2

