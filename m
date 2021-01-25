Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643E8303686
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbhAZG2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:28:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbhAYNvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:51:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 089F222C9E;
        Mon, 25 Jan 2021 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611582505;
        bh=8xzLVqBc4Jci34US4grEu+cGJ0o9R2i13nNACkFy6Uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dh8ErcIB19k7yiaBeige7PIdnVy8VVUvNQxYDjOyJzpN4pdb0F4CWI0s6Op2DTorV
         +Yo/siyb/mg3+EGN7gli+8GQcpPS1FPIPS0MGgkZeP7e3fQx8rFV+HsZWDQD3vQlAt
         7bpTfksWKytTqSK1lGrO8R2cBCv3FPIwoVWRYINoFWqCHDm6fZzfkFM9Ay0DMgmmhq
         oJJenFniHGbOymYupI7Qn3frFY1BQc1SKu5eq2kinr4F7+2rf7Ydq+c3/UxLz1PuF3
         yvRLS22Auf6i7ivEfE66f5tUIniio5UnCb4MYbqr6CKdSvPCM5WcB2jLxfvClVwcm8
         rNSG6O6Lg4tgQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l42EM-00034c-1a; Mon, 25 Jan 2021 14:48:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Pho Tran <Pho.Tran@silabs.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 6/7] USB: serial: cp210x: fix RTS handling
Date:   Mon, 25 Jan 2021 14:48:16 +0100
Message-Id: <20210125134817.11749-7-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210125134817.11749-1-johan@kernel.org>
References: <20210125134817.11749-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clearing TIOCM_RTS should always deassert RTS and setting the same bit
should enable auto-RTS if hardware flow control is enabled.

This allows user space to throttle input directly at the source also
when hardware-assisted flow control is enabled and makes dtr_rts()
always deassert both lines during close (when HUPCL is set).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 47 +++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 4ba3fb096bf1..f00b736f3cd3 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1166,7 +1166,10 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 	if (C_CRTSCTS(tty)) {
 		ctl_hs |= CP210X_SERIAL_CTS_HANDSHAKE;
 		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
-		flow_repl |= CP210X_SERIAL_RTS_FLOW_CTL;
+		if (port_priv->rts)
+			flow_repl |= CP210X_SERIAL_RTS_FLOW_CTL;
+		else
+			flow_repl |= CP210X_SERIAL_RTS_INACTIVE;
 		port_priv->crtscts = true;
 	} else {
 		ctl_hs &= ~CP210X_SERIAL_CTS_HANDSHAKE;
@@ -1286,6 +1289,8 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
 		unsigned int set, unsigned int clear)
 {
 	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
+	struct cp210x_flow_ctl flow_ctl;
+	u32 ctl_hs, flow_repl;
 	u16 control = 0;
 	int ret;
 
@@ -1313,16 +1318,44 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
 	}
 
 	/*
-	 * SET_MHS cannot be used to control RTS when auto-RTS is enabled.
-	 * Note that RTS is still deasserted when disabling the UART on close.
+	 * Use SET_FLOW to set DTR and enable/disable auto-RTS when hardware
+	 * flow control is enabled.
 	 */
-	if (port_priv->crtscts)
-		control &= ~CONTROL_WRITE_RTS;
+	if (port_priv->crtscts && control & CONTROL_WRITE_RTS) {
+		ret = cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
+				sizeof(flow_ctl));
+		if (ret)
+			goto out_unlock;
 
-	dev_dbg(&port->dev, "%s - control = 0x%04x\n", __func__, control);
+		ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
+		flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
 
-	ret = cp210x_write_u16_reg(port, CP210X_SET_MHS, control);
+		ctl_hs &= ~CP210X_SERIAL_DTR_MASK;
+		if (port_priv->dtr)
+			ctl_hs |= CP210X_SERIAL_DTR_ACTIVE;
+		else
+			ctl_hs |= CP210X_SERIAL_DTR_INACTIVE;
 
+		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
+		if (port_priv->rts)
+			flow_repl |= CP210X_SERIAL_RTS_FLOW_CTL;
+		else
+			flow_repl |= CP210X_SERIAL_RTS_INACTIVE;
+
+		flow_ctl.ulControlHandshake = cpu_to_le32(ctl_hs);
+		flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
+
+		dev_dbg(&port->dev, "%s - ctrl = 0x%02x, flow = 0x%02x\n",
+				__func__, ctl_hs, flow_repl);
+
+		ret = cp210x_write_reg_block(port, CP210X_SET_FLOW, &flow_ctl,
+				sizeof(flow_ctl));
+	} else {
+		dev_dbg(&port->dev, "%s - control = 0x%04x\n", __func__, control);
+
+		ret = cp210x_write_u16_reg(port, CP210X_SET_MHS, control);
+	}
+out_unlock:
 	mutex_unlock(&port_priv->mutex);
 
 	return ret;
-- 
2.26.2

