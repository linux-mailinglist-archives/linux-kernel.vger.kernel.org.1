Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92E62A5E41
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgKDGrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbgKDGrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:47:37 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EDCC061A4D;
        Tue,  3 Nov 2020 22:47:37 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b3so16522427pfo.2;
        Tue, 03 Nov 2020 22:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vnMYTYPWpL/m30915j5zLtve0vatdenqyPp6S7vmLgE=;
        b=It3dft3OWinLT6cIhmfl1Xv4H4P0etg2tdyYAgpuFPVb5m0GvsMP7aDS00s3nNcknq
         gPPq0cHV/5+JvxAyR5IoozAo8INdiK+/U1PS0GcwX37ZNTZzD9kWbc2/bLlEGj+A0pBf
         YKDvw7/YoUAq/iisroJq59zIUmq+Gk3FwnTAbRngVlxh+VR0H3UFiR6TG8JlnbAehl4Q
         8QGM81Uvs5cdtzaVAuR+3jBxCtCMwIAjVQSSw+DcLwsw5F0UmX20kYTRM3nRkHDsy4Fv
         D9qXpd5SkiCWtFlcckNq1Yt+Ned9A8E4QMvOjgQ34Y1zl63ROHxvtiNoU7mDH1XjCkCy
         HJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vnMYTYPWpL/m30915j5zLtve0vatdenqyPp6S7vmLgE=;
        b=U1p5omxbypeYqFaekdaM65gj/Jrzui1TMmWtFsXekOzPLinSU+IQeWIQ5ysh5omGFu
         mHczfMMQxHbOFFUAUOz2W5KBDHQhqqmGO3000VGGpblX25lyQwuad1LyU9wy9oVT7bon
         avkEi5lS76eSjJkknuFJqMfEa0jo7PdgiQEDnXmfvjyFZm8Md5kvwrBLLJI84H8yaBLA
         Swt/M9X/st3/+NFehq49CKHKHnh61yHABS4wOl6ZYmqCP+52lESxpDWPGcohhCmzQ6VM
         ySwaWJVgeltDzy9R9+ddiHBnK5YmgNSqlDxZFukv+kRDLpzP9j++yqd+vkNzmf1pLxUB
         I1aw==
X-Gm-Message-State: AOAM530XB+EXOqEXZbPgCDQ+UFzyqgO+Ao/HuF+Q0kcWQGqlXVXtHBiJ
        FEn3oPkwxzWihy5SBD57mHM=
X-Google-Smtp-Source: ABdhPJwnNQfXO7AjHXWMn/tpTXzV0nUf1dFk+DWr2khbTMJSk39gkNgezJp4Wv7vki3qJV0KgjGvpg==
X-Received: by 2002:a62:2e47:0:b029:155:853a:80d5 with SMTP id u68-20020a622e470000b0290155853a80d5mr28804533pfu.29.1604472457118;
        Tue, 03 Nov 2020 22:47:37 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:47:36 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 02/15] usb: serial: belkin_sa: use usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:16:50 +0530
Message-Id: <20201104064703.15123-3-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104064703.15123-1-himadrispandya@gmail.com>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new usb_control_msg_send() nicely wraps usb_control_msg() with
proper error check. Hence use the wrapper instead of calling
usb_control_msg() directly.

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
 drivers/usb/serial/belkin_sa.c | 35 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
index 9bb123ab9bc9..a5ff55f48303 100644
--- a/drivers/usb/serial/belkin_sa.c
+++ b/drivers/usb/serial/belkin_sa.c
@@ -105,9 +105,10 @@ struct belkin_sa_private {
 #define WDR_TIMEOUT 5000 /* default urb timeout */
 
 /* assumes that struct usb_serial *serial is available */
-#define BSA_USB_CMD(c, v) usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0), \
-					    (c), BELKIN_SA_SET_REQUEST_TYPE, \
-					    (v), 0, NULL, 0, WDR_TIMEOUT)
+#define BSA_USB_CMD(c, v) usb_control_msg_send(serial->dev, 0, (c), \
+					       BELKIN_SA_SET_REQUEST_TYPE, \
+					       (v), 0, NULL, 0, WDR_TIMEOUT, \
+					       GFP_KERNEL)
 
 static int belkin_sa_port_probe(struct usb_serial_port *port)
 {
@@ -309,12 +310,11 @@ static void belkin_sa_set_termios(struct tty_struct *tty,
 		/* reassert DTR and (maybe) RTS on transition from B0 */
 		if ((old_cflag & CBAUD) == B0) {
 			control_state |= (TIOCM_DTR|TIOCM_RTS);
-			if (BSA_USB_CMD(BELKIN_SA_SET_DTR_REQUEST, 1) < 0)
+			if (BSA_USB_CMD(BELKIN_SA_SET_DTR_REQUEST, 1))
 				dev_err(&port->dev, "Set DTR error\n");
 			/* don't set RTS if using hardware flow control */
 			if (!(old_cflag & CRTSCTS))
-				if (BSA_USB_CMD(BELKIN_SA_SET_RTS_REQUEST
-								, 1) < 0)
+				if (BSA_USB_CMD(BELKIN_SA_SET_RTS_REQUEST, 1))
 					dev_err(&port->dev, "Set RTS error\n");
 		}
 	}
@@ -330,18 +330,18 @@ static void belkin_sa_set_termios(struct tty_struct *tty,
 
 		/* Report the actual baud rate back to the caller */
 		tty_encode_baud_rate(tty, baud, baud);
-		if (BSA_USB_CMD(BELKIN_SA_SET_BAUDRATE_REQUEST, urb_value) < 0)
+		if (BSA_USB_CMD(BELKIN_SA_SET_BAUDRATE_REQUEST, urb_value))
 			dev_err(&port->dev, "Set baudrate error\n");
 	} else {
 		/* Disable flow control */
 		if (BSA_USB_CMD(BELKIN_SA_SET_FLOW_CTRL_REQUEST,
-						BELKIN_SA_FLOW_NONE) < 0)
+				BELKIN_SA_FLOW_NONE))
 			dev_err(&port->dev, "Disable flowcontrol error\n");
 		/* Drop RTS and DTR */
 		control_state &= ~(TIOCM_DTR | TIOCM_RTS);
-		if (BSA_USB_CMD(BELKIN_SA_SET_DTR_REQUEST, 0) < 0)
+		if (BSA_USB_CMD(BELKIN_SA_SET_DTR_REQUEST, 0))
 			dev_err(&port->dev, "DTR LOW error\n");
-		if (BSA_USB_CMD(BELKIN_SA_SET_RTS_REQUEST, 0) < 0)
+		if (BSA_USB_CMD(BELKIN_SA_SET_RTS_REQUEST, 0))
 			dev_err(&port->dev, "RTS LOW error\n");
 	}
 
@@ -352,7 +352,7 @@ static void belkin_sa_set_termios(struct tty_struct *tty,
 						: BELKIN_SA_PARITY_EVEN;
 		else
 			urb_value = BELKIN_SA_PARITY_NONE;
-		if (BSA_USB_CMD(BELKIN_SA_SET_PARITY_REQUEST, urb_value) < 0)
+		if (BSA_USB_CMD(BELKIN_SA_SET_PARITY_REQUEST, urb_value))
 			dev_err(&port->dev, "Set parity error\n");
 	}
 
@@ -377,7 +377,7 @@ static void belkin_sa_set_termios(struct tty_struct *tty,
 			urb_value = BELKIN_SA_DATA_BITS(8);
 			break;
 		}
-		if (BSA_USB_CMD(BELKIN_SA_SET_DATA_BITS_REQUEST, urb_value) < 0)
+		if (BSA_USB_CMD(BELKIN_SA_SET_DATA_BITS_REQUEST, urb_value))
 			dev_err(&port->dev, "Set data bits error\n");
 	}
 
@@ -385,8 +385,7 @@ static void belkin_sa_set_termios(struct tty_struct *tty,
 	if ((cflag & CSTOPB) != (old_cflag & CSTOPB)) {
 		urb_value = (cflag & CSTOPB) ? BELKIN_SA_STOP_BITS(2)
 						: BELKIN_SA_STOP_BITS(1);
-		if (BSA_USB_CMD(BELKIN_SA_SET_STOP_BITS_REQUEST,
-							urb_value) < 0)
+		if (BSA_USB_CMD(BELKIN_SA_SET_STOP_BITS_REQUEST, urb_value))
 			dev_err(&port->dev, "Set stop bits error\n");
 	}
 
@@ -407,7 +406,7 @@ static void belkin_sa_set_termios(struct tty_struct *tty,
 		if (bad_flow_control)
 			urb_value &= ~(BELKIN_SA_FLOW_IRTS);
 
-		if (BSA_USB_CMD(BELKIN_SA_SET_FLOW_CTRL_REQUEST, urb_value) < 0)
+		if (BSA_USB_CMD(BELKIN_SA_SET_FLOW_CTRL_REQUEST, urb_value))
 			dev_err(&port->dev, "Set flow control error\n");
 	}
 
@@ -422,7 +421,7 @@ static void belkin_sa_break_ctl(struct tty_struct *tty, int break_state)
 	struct usb_serial_port *port = tty->driver_data;
 	struct usb_serial *serial = port->serial;
 
-	if (BSA_USB_CMD(BELKIN_SA_SET_BREAK_REQUEST, break_state ? 1 : 0) < 0)
+	if (BSA_USB_CMD(BELKIN_SA_SET_BREAK_REQUEST, break_state ? 1 : 0))
 		dev_err(&port->dev, "Set break_ctl %d\n", break_state);
 }
 
@@ -476,13 +475,13 @@ static int belkin_sa_tiocmset(struct tty_struct *tty,
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	retval = BSA_USB_CMD(BELKIN_SA_SET_RTS_REQUEST, rts);
-	if (retval < 0) {
+	if (retval) {
 		dev_err(&port->dev, "Set RTS error %d\n", retval);
 		goto exit;
 	}
 
 	retval = BSA_USB_CMD(BELKIN_SA_SET_DTR_REQUEST, dtr);
-	if (retval < 0) {
+	if (retval) {
 		dev_err(&port->dev, "Set DTR error %d\n", retval);
 		goto exit;
 	}
-- 
2.17.1

