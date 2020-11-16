Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580912B4AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbgKPQSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:18:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36025 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731856AbgKPQSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:18:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id f11so25935931lfs.3;
        Mon, 16 Nov 2020 08:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fEboWUqvEaujKYtDzKhOgGKsfAfgCyL5KGE9ncAd/lM=;
        b=QuLgcMJt66d0j/rSVjwmLHhpC4lijJcgTEcy4kcMdxEy5v2ah4rV21Zfuu7sGnRcd2
         HU/Dq336Cnt6mYbvBUQDkheoMDuzjoAM/kkLJ/Ln74kF/TZDZbPclfx9FqToOZzKSmGr
         pf8plIebUX/ZpnPRruZqiXm9DoFim5eed8irbt9eIZ9kmD5x7Kqw5CARfMpVjkX8ZZJj
         XVMznc87gC+f1O8vTtOwlFw5PB9QBDQsqnoT5RtetFj1HKqRrlgjzGm0WO4pjF3CvowK
         3dUdfB0YqGyWvRpcC/UGsL0AKlm7ZpxTqYRVOxuoiASb6eirxPslUsIhmMi69hVWdBkw
         ZRXA==
X-Gm-Message-State: AOAM532rV0cVxKLehYF5HkgEKAlZGblscZ6eJMO5RlzTfXJS/gg445XN
        6luO0zGEKfT2UM0CNrD5B8IrgvRNzp2xvQ==
X-Google-Smtp-Source: ABdhPJzb/oUpqj0eC4ddy4axsWPgIabtp/6ksL+WmP+LkakeV5YwCw3T/jEqOPjvdGEt0lCu/g1dBA==
X-Received: by 2002:a19:8003:: with SMTP id b3mr34329lfd.489.1605543524398;
        Mon, 16 Nov 2020 08:18:44 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id n26sm2781836lfi.303.2020.11.16.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:18:42 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kehDI-0007g0-3a; Mon, 16 Nov 2020 17:18:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Sheng Long Wang <shenglong.wang.ext@siemens.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/6] USB: serial: cp210x: refactor flow-control handling
Date:   Mon, 16 Nov 2020 17:18:25 +0100
Message-Id: <20201116161826.29417-6-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201116161826.29417-1-johan@kernel.org>
References: <20201116161826.29417-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function to be used to configure flow control.

The flow-control code was the last caller that relied on the
memset-on-failure behaviour of cp210x_read_reg_block(), which we can now
drop in favour of bailing out on errors when retrieving the flow-control
settings.

This should also simplify adding support for software flow control.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 97 ++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 04d2b15ceded..c77fd09b91ce 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -555,14 +555,8 @@ static int cp210x_read_reg_block(struct usb_serial_port *port, u8 req,
 	int result;
 
 	dmabuf = kmalloc(bufsize, GFP_KERNEL);
-	if (!dmabuf) {
-		/*
-		 * FIXME Some callers don't bother to check for error,
-		 * at least give them consistent junk until they are fixed
-		 */
-		memset(buf, 0, bufsize);
+	if (!dmabuf)
 		return -ENOMEM;
-	}
 
 	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
 			req, REQTYPE_INTERFACE_TO_HOST, 0,
@@ -576,12 +570,6 @@ static int cp210x_read_reg_block(struct usb_serial_port *port, u8 req,
 				req, bufsize, result);
 		if (result >= 0)
 			result = -EIO;
-
-		/*
-		 * FIXME Some callers don't bother to check for error,
-		 * at least give them consistent junk until they are fixed
-		 */
-		memset(buf, 0, bufsize);
 	}
 
 	kfree(dmabuf);
@@ -1095,11 +1083,55 @@ static bool cp210x_termios_change(const struct ktermios *a, const struct ktermio
 	return tty_termios_hw_change(a, b) || iflag_change;
 }
 
+static void cp210x_set_flow_control(struct tty_struct *tty,
+		struct usb_serial_port *port, struct ktermios *old_termios)
+{
+	struct cp210x_flow_ctl flow_ctl;
+	u32 flow_repl;
+	u32 ctl_hs;
+	int ret;
+
+	if (old_termios && C_CRTSCTS(tty) == (old_termios->c_cflag & CRTSCTS))
+		return;
+
+	ret = cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
+			sizeof(flow_ctl));
+	if (ret)
+		return;
+
+	ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
+	flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
+
+	ctl_hs &= ~CP210X_SERIAL_DSR_HANDSHAKE;
+	ctl_hs &= ~CP210X_SERIAL_DCD_HANDSHAKE;
+	ctl_hs &= ~CP210X_SERIAL_DSR_SENSITIVITY;
+	ctl_hs &= ~CP210X_SERIAL_DTR_MASK;
+	ctl_hs |= CP210X_SERIAL_DTR_SHIFT(CP210X_SERIAL_DTR_ACTIVE);
+
+	if (C_CRTSCTS(tty)) {
+		ctl_hs |= CP210X_SERIAL_CTS_HANDSHAKE;
+		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
+		flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL);
+	} else {
+		ctl_hs &= ~CP210X_SERIAL_CTS_HANDSHAKE;
+		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
+		flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_ACTIVE);
+	}
+
+	dev_dbg(&port->dev, "%s - ulControlHandshake=0x%08x, ulFlowReplace=0x%08x\n",
+			__func__, ctl_hs, flow_repl);
+
+	flow_ctl.ulControlHandshake = cpu_to_le32(ctl_hs);
+	flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
+
+	cp210x_write_reg_block(port, CP210X_SET_FLOW, &flow_ctl,
+			sizeof(flow_ctl));
+}
+
 static void cp210x_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
 	struct cp210x_serial_private *priv = usb_get_serial_data(port->serial);
-	struct device *dev = &port->dev;
 	u16 bits;
 	int ret;
 
@@ -1156,42 +1188,7 @@ static void cp210x_set_termios(struct tty_struct *tty,
 	if (ret)
 		dev_err(&port->dev, "failed to set line control: %d\n", ret);
 
-	if (!old_termios || C_CRTSCTS(tty) != (old_termios->c_cflag & CRTSCTS)) {
-		struct cp210x_flow_ctl flow_ctl;
-		u32 ctl_hs;
-		u32 flow_repl;
-
-		cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
-				sizeof(flow_ctl));
-		ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
-		flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
-
-		ctl_hs &= ~CP210X_SERIAL_DSR_HANDSHAKE;
-		ctl_hs &= ~CP210X_SERIAL_DCD_HANDSHAKE;
-		ctl_hs &= ~CP210X_SERIAL_DSR_SENSITIVITY;
-		ctl_hs &= ~CP210X_SERIAL_DTR_MASK;
-		ctl_hs |= CP210X_SERIAL_DTR_SHIFT(CP210X_SERIAL_DTR_ACTIVE);
-		if (C_CRTSCTS(tty)) {
-			ctl_hs |= CP210X_SERIAL_CTS_HANDSHAKE;
-
-			flow_repl &= ~CP210X_SERIAL_RTS_MASK;
-			flow_repl |= CP210X_SERIAL_RTS_SHIFT(
-					CP210X_SERIAL_RTS_FLOW_CTL);
-		} else {
-			ctl_hs &= ~CP210X_SERIAL_CTS_HANDSHAKE;
-
-			flow_repl &= ~CP210X_SERIAL_RTS_MASK;
-			flow_repl |= CP210X_SERIAL_RTS_SHIFT(
-					CP210X_SERIAL_RTS_ACTIVE);
-		}
-
-		dev_dbg(dev, "%s - ulControlHandshake=0x%08x, ulFlowReplace=0x%08x\n",
-				__func__, ctl_hs, flow_repl);
-		flow_ctl.ulControlHandshake = cpu_to_le32(ctl_hs);
-		flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
-		cp210x_write_reg_block(port, CP210X_SET_FLOW, &flow_ctl,
-				sizeof(flow_ctl));
-	}
+	cp210x_set_flow_control(tty, port, old_termios);
 
 	/*
 	 * Enable event-insertion mode only if input parity checking is
-- 
2.26.2

