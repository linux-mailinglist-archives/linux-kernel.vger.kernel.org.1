Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506462982E9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 18:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417848AbgJYRrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 13:47:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40288 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417725AbgJYRql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 13:46:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id 23so7281525ljv.7;
        Sun, 25 Oct 2020 10:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sp4NdDzvf7ets2jCUs0u83t/aBTY5svl7aNfj78wdxY=;
        b=h7jNzDOmVwgFf2D3YwOAOjz3CNfuy1HX8SfkjA1P2x46kFJLkcIOVYFmkxlO2bse6F
         SuaGHJQERta5t5YAdza0O5Ok+26IwJGzVSCraHUW6+kTQFVh7qhB9zGVfMMSD2vqZlXV
         4acav2/ispsXnR0ddYXtq3I7WagSI4aBHDkeTdgo/XhOgoECjKwQbHWj93X2m8Zfe0p4
         5PlN3li5mLfeyAM43TaNubMPklybV53TO1sY7DKnHsUriuDfTMACAJXoRU4UjNEuLUmz
         wA+Ubu0+IMpuntZG6OwYspL7BFUO1+5hW8tLcrnl+7lMZIejBB5VWL0rhSqusOTUaI1u
         1RHQ==
X-Gm-Message-State: AOAM5326LsypoMhWbKv+Noh+B5cgA8k78B7c4q2Cbbt2D8pZIzH1uJFV
        4jTFNdoaTZT8xEAT00EwW4U3ZdrG8lzGKg==
X-Google-Smtp-Source: ABdhPJynCx+XhHjVnmOHl6Fu5cj+2GpR6klM2BYqazOdZ/vWLANJctsuC9wd3+Pkihwx3V8OM4LTuA==
X-Received: by 2002:a2e:a375:: with SMTP id i21mr4278088ljn.135.1603647998662;
        Sun, 25 Oct 2020 10:46:38 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id 28sm794158lfp.295.2020.10.25.10.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 10:46:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kWk6J-0007He-18; Sun, 25 Oct 2020 18:46:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 07/14] USB: serial: keyspan_pda: refactor write-room handling
Date:   Sun, 25 Oct 2020 18:45:53 +0100
Message-Id: <20201025174600.27896-8-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201025174600.27896-1-johan@kernel.org>
References: <20201025174600.27896-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper to retrieve the available device transfer-buffer space.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/keyspan_pda.c | 113 ++++++++++++++-----------------
 1 file changed, 50 insertions(+), 63 deletions(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 39ed3ad32365..54a21a99c001 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -98,6 +98,42 @@ static const struct usb_device_id id_table_fake_xircom[] = {
 };
 #endif
 
+static int keyspan_pda_get_write_room(struct keyspan_pda_private *priv)
+{
+	struct usb_serial_port *port = priv->port;
+	struct usb_serial *serial = priv->serial;
+	u8 *room;
+	int rc;
+
+	room = kmalloc(1, GFP_KERNEL);
+	if (!room)
+		return -ENOMEM;
+
+	rc = usb_control_msg(serial->dev,
+			     usb_rcvctrlpipe(serial->dev, 0),
+			     6, /* write_room */
+			     USB_TYPE_VENDOR | USB_RECIP_INTERFACE
+			     | USB_DIR_IN,
+			     0, /* value: 0 means "remaining room" */
+			     0, /* index */
+			     room,
+			     1,
+			     2000);
+	if (rc != 1) {
+		if (rc >= 0)
+			rc = -EIO;
+		dev_dbg(&port->dev, "roomquery failed: %d\n", rc);
+		goto out_free;
+	}
+
+	dev_dbg(&port->dev, "roomquery says %d\n", *room);
+	rc = *room;
+out_free:
+	kfree(room);
+
+	return rc;
+}
+
 static void keyspan_pda_request_unthrottle(struct work_struct *work)
 {
 	struct keyspan_pda_private *priv =
@@ -436,7 +472,6 @@ static int keyspan_pda_tiocmset(struct tty_struct *tty,
 static int keyspan_pda_write(struct tty_struct *tty,
 	struct usb_serial_port *port, const unsigned char *buf, int count)
 {
-	struct usb_serial *serial = port->serial;
 	int request_unthrottle = 0;
 	int rc = 0;
 	struct keyspan_pda_private *priv;
@@ -479,38 +514,11 @@ static int keyspan_pda_write(struct tty_struct *tty,
 	   device how much room it really has.  This is done only on
 	   scheduler time, since usb_control_msg() sleeps. */
 	if (count > priv->tx_room && !in_interrupt()) {
-		u8 *room;
-
-		room = kmalloc(1, GFP_KERNEL);
-		if (!room) {
-			rc = -ENOMEM;
+		rc = keyspan_pda_get_write_room(priv);
+		if (rc < 0)
 			goto exit;
-		}
 
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
-			goto exit;
-		}
+		priv->tx_room = rc;
 	}
 
 	if (count >= priv->tx_room) {
@@ -614,48 +622,27 @@ static void keyspan_pda_dtr_rts(struct usb_serial_port *port, int on)
 static int keyspan_pda_open(struct tty_struct *tty,
 					struct usb_serial_port *port)
 {
-	struct usb_serial *serial = port->serial;
-	u8 *room;
-	int rc = 0;
-	struct keyspan_pda_private *priv;
+	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
+	int rc;
 
 	/* find out how much room is in the Tx ring */
-	room = kmalloc(1, GFP_KERNEL);
-	if (!room)
-		return -ENOMEM;
+	rc = keyspan_pda_get_write_room(priv);
+	if (rc < 0)
+		return rc;
 
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
-		goto error;
-	}
-	priv = usb_get_serial_port_data(port);
-	priv->tx_room = *room;
-	priv->tx_throttled = *room ? 0 : 1;
+	priv->tx_room = rc;
+	priv->tx_throttled = rc ? 0 : 1;
 
 	/*Start reading from the device*/
 	rc = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
 	if (rc) {
 		dev_dbg(&port->dev, "%s - usb_submit_urb(read int) failed\n", __func__);
-		goto error;
+		return rc;
 	}
-error:
-	kfree(room);
-	return rc;
+
+	return 0;
 }
+
 static void keyspan_pda_close(struct usb_serial_port *port)
 {
 	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
-- 
2.26.2

