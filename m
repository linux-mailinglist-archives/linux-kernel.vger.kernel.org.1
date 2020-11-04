Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10832A5E59
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgKDGs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgKDGsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:48:23 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8F8C061A4D;
        Tue,  3 Nov 2020 22:48:23 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w65so16511274pfd.3;
        Tue, 03 Nov 2020 22:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KB7CZf3CU86Z0He3UNjFkiBM0LUE2H0157Uy00zeVnM=;
        b=iDOmSv+7rnBajXf+cgmft9pCQRr9KEydAxoL7P7WFn9jTTjy8yotjsRt8yRcI0fP+T
         nrbtCWwMxIW04SbdFr0mlOVMSI9IasE3xah8/XxIY7efTVIz5IrZt3sphQ56WpfoV6hG
         FS3vbjAzq4y7Bd0XsUqj8rZS/FvfazwHUccVApgtsqAZPQ56kkfA4FO45aKuvjYAyfU/
         11MZFLdps7sowj0mG+/EJQR+oOOkljGyawOkNqhwyP1McQHsP9pW/3dhN5gvp7AcI0aX
         MUjuqRcIbKAOxnexRylpMPuQoTYBfWSM3Fpf2sf0rYbL096Fygr9rlkkBHpXBnJIAjdl
         8M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KB7CZf3CU86Z0He3UNjFkiBM0LUE2H0157Uy00zeVnM=;
        b=te7W1rT+xTNbafeZy7rhUR2+p7vlVKO2lKF3UA1MEu4VL1RiiUQlwvt9naPnvTiZmf
         FJA1jNSeQPgI5tcDgI0HX4Ji1iUJtVTwfgJanjPno0z2XI/fOrk7/4QZvMw0q5KbiRav
         2djjfNmuJSbSrRc6WKvvXMndDMk22DMVgn9CeVDDoXitdxslLYakbHXRVHsNfeMP84kM
         rKL/lCdKt0pXKomVKegENdynrEa6JiQp+0gMvHnxxrdzwiy0n9FzJlR8l1bjbExw8IfU
         vTAuSKGU1xP2U8/MFjsxG2lc0A/T5wGzZFmqlDJuCJyokUL0H0hA6mSLqq9wooYt5Epd
         L+qQ==
X-Gm-Message-State: AOAM533NBjMA3gb48+vJTOsn99lhFzNJiWDqJTvhlGhPXi3mxgiwiBwn
        ytMTNcNu21iOVLpcNzxqFyo=
X-Google-Smtp-Source: ABdhPJxs0MkrmUYxezpuHa4boCFPRLOvuB9Nud9oWd6sw5dUNBePOgrl+hKFsnFyKeXvFpEe4oYnbA==
X-Received: by 2002:a17:90a:df0d:: with SMTP id gp13mr3045148pjb.92.1604472503048;
        Tue, 03 Nov 2020 22:48:23 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:48:22 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 14/15] usb: serial: keyspan_pda: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:17:02 +0530
Message-Id: <20201104064703.15123-15-himadrispandya@gmail.com>
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
 drivers/usb/serial/keyspan_pda.c | 172 +++++++++++++------------------
 1 file changed, 72 insertions(+), 100 deletions(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index c1333919716b..44e1c4490fa9 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -115,17 +115,17 @@ static void keyspan_pda_request_unthrottle(struct work_struct *work)
 
 	/* ask the device to tell us when the tx buffer becomes
 	   sufficiently empty */
-	result = usb_control_msg(serial->dev,
-				 usb_sndctrlpipe(serial->dev, 0),
-				 7, /* request_unthrottle */
-				 USB_TYPE_VENDOR | USB_RECIP_INTERFACE
-				 | USB_DIR_OUT,
-				 16, /* value: threshold */
-				 0, /* index */
-				 NULL,
-				 0,
-				 2000);
-	if (result < 0)
+	result = usb_control_msg_send(serial->dev, 0,
+				      7, /* request_unthrottle */
+				      USB_TYPE_VENDOR | USB_RECIP_INTERFACE
+				      | USB_DIR_OUT,
+				      16, /* value: threshold */
+				      0, /* index */
+				      NULL,
+				      0,
+				      2000,
+				      GFP_KERNEL);
+	if (result)
 		dev_dbg(&serial->dev->dev, "%s - error %d from usb_control_msg\n",
 			__func__, result);
 }
@@ -269,17 +269,18 @@ static speed_t keyspan_pda_setbaud(struct usb_serial *serial, speed_t baud)
 
 	/* rather than figure out how to sleep while waiting for this
 	   to complete, I just use the "legacy" API. */
-	rc = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-			     0, /* set baud */
-			     USB_TYPE_VENDOR
-			     | USB_RECIP_INTERFACE
-			     | USB_DIR_OUT, /* type */
-			     bindex, /* value */
-			     0, /* index */
-			     NULL, /* &data */
-			     0, /* size */
-			     2000); /* timeout */
-	if (rc < 0)
+	rc = usb_control_msg_send(serial->dev, 0,
+				  0, /* set baud */
+				  USB_TYPE_VENDOR
+				  | USB_RECIP_INTERFACE
+				  | USB_DIR_OUT, /* type */
+				  bindex, /* value */
+				  0, /* index */
+				  NULL, /* &data */
+				  0, /* size */
+				  2000, /* timeout */
+				  GFP_KERNEL);
+	if (rc)
 		return 0;
 	return baud;
 }
@@ -296,11 +297,12 @@ static void keyspan_pda_break_ctl(struct tty_struct *tty, int break_state)
 		value = 1; /* start break */
 	else
 		value = 0; /* clear break */
-	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-			4, /* set break */
-			USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
-			value, 0, NULL, 0, 2000);
-	if (result < 0)
+	result = usb_control_msg_send(serial->dev, 0,
+				      4, /* set break */
+				      USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
+				      USB_DIR_OUT,
+				      value, 0, NULL, 0, 2000, GFP_KERNEL);
+	if (result)
 		dev_dbg(&port->dev, "%s - error %d from usb_control_msg\n",
 			__func__, result);
 	/* there is something funky about this.. the TCSBRK that 'cu' performs
@@ -359,22 +361,11 @@ static int keyspan_pda_get_modem_info(struct usb_serial *serial,
 				      unsigned char *value)
 {
 	int rc;
-	u8 *data;
-
-	data = kmalloc(1, GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	rc = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
-			     3, /* get pins */
-			     USB_TYPE_VENDOR|USB_RECIP_INTERFACE|USB_DIR_IN,
-			     0, 0, data, 1, 2000);
-	if (rc == 1)
-		*value = *data;
-	else if (rc >= 0)
-		rc = -EIO;
-
-	kfree(data);
+	rc = usb_control_msg_recv(serial->dev, 0,
+				  3, /* get pins */
+				  USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
+				  USB_DIR_IN, 0, 0, value, 1, 2000,
+				  GFP_KERNEL);
 	return rc;
 }
 
@@ -383,10 +374,11 @@ static int keyspan_pda_set_modem_info(struct usb_serial *serial,
 				      unsigned char value)
 {
 	int rc;
-	rc = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-			     3, /* set pins */
-			     USB_TYPE_VENDOR|USB_RECIP_INTERFACE|USB_DIR_OUT,
-			     value, 0, NULL, 0, 2000);
+	rc = usb_control_msg_send(serial->dev, 0,
+				  3, /* set pins */
+				  USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
+				  USB_DIR_OUT, value, 0, NULL, 0, 2000,
+				  GFP_KERNEL);
 	return rc;
 }
 
@@ -481,36 +473,25 @@ static int keyspan_pda_write(struct tty_struct *tty,
 	   device how much room it really has.  This is done only on
 	   scheduler time, since usb_control_msg() sleeps. */
 	if (count > priv->tx_room && !in_interrupt()) {
-		u8 *room;
-
-		room = kmalloc(1, GFP_KERNEL);
-		if (!room) {
-			rc = -ENOMEM;
-			goto exit;
+		u8 room;
+
+		rc = usb_control_msg_recv(serial->dev, 0,
+					  6, /* write_room */
+					  USB_TYPE_VENDOR | USB_RECIP_INTERFACE
+					  | USB_DIR_IN,
+					  0, /* value: 0 means "remaining room" */
+					  0, /* index */
+					  &room,
+					  1,
+					  2000,
+					  GFP_KERNEL);
+		if (rc == 0) {
+			dev_dbg(&port->dev, "roomquery says %d\n", room);
+			priv->tx_room = room;
 		}
 
-		rc = usb_control_msg(serial->dev,
-				     usb_rcvctrlpipe(serial->dev, 0),
-				     6, /* write_room */
-				     USB_TYPE_VENDOR | USB_RECIP_INTERFACE
-				     | USB_DIR_IN,
-				     0, /* value: 0 means "remaining room" */
-				     0, /* index */
-				     room,
-				     1,
-				     2000);
-		if (rc > 0) {
-			dev_dbg(&port->dev, "roomquery says %d\n", *room);
-			priv->tx_room = *room;
-		}
-		kfree(room);
-		if (rc < 0) {
-			dev_dbg(&port->dev, "roomquery failed\n");
-			goto exit;
-		}
-		if (rc == 0) {
-			dev_dbg(&port->dev, "roomquery returned 0 bytes\n");
-			rc = -EIO; /* device didn't return any data */
+		if (rc) {
+			dev_dbg(&port->dev, "roomquery failed %d\n", rc);
 			goto exit;
 		}
 	}
@@ -613,36 +594,28 @@ static int keyspan_pda_open(struct tty_struct *tty,
 					struct usb_serial_port *port)
 {
 	struct usb_serial *serial = port->serial;
-	u8 *room;
+	u8 room;
 	int rc = 0;
 	struct keyspan_pda_private *priv;
 
-	/* find out how much room is in the Tx ring */
-	room = kmalloc(1, GFP_KERNEL);
-	if (!room)
-		return -ENOMEM;
-
-	rc = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
-			     6, /* write_room */
-			     USB_TYPE_VENDOR | USB_RECIP_INTERFACE
-			     | USB_DIR_IN,
-			     0, /* value */
-			     0, /* index */
-			     room,
-			     1,
-			     2000);
-	if (rc < 0) {
-		dev_dbg(&port->dev, "%s - roomquery failed\n", __func__);
-		goto error;
-	}
-	if (rc == 0) {
-		dev_dbg(&port->dev, "%s - roomquery returned 0 bytes\n", __func__);
-		rc = -EIO;
+	rc = usb_control_msg_recv(serial->dev, 0,
+				  6, /* write_room */
+				  USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
+				  USB_DIR_IN,
+				  0, /* value */
+				  0, /* index */
+				  &room,
+				  1,
+				  2000,
+				  GFP_KERNEL);
+	if (rc) {
+		dev_dbg(&port->dev, "%s - roomquery failed %d\n", __func__, rc);
 		goto error;
 	}
+
 	priv = usb_get_serial_port_data(port);
-	priv->tx_room = *room;
-	priv->tx_throttled = *room ? 0 : 1;
+	priv->tx_room = room;
+	priv->tx_throttled = room ? 0 : 1;
 
 	/*Start reading from the device*/
 	rc = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
@@ -651,7 +624,6 @@ static int keyspan_pda_open(struct tty_struct *tty,
 		goto error;
 	}
 error:
-	kfree(room);
 	return rc;
 }
 static void keyspan_pda_close(struct usb_serial_port *port)
-- 
2.17.1

