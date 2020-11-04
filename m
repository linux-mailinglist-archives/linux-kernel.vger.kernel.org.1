Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0872A5E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgKDGsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgKDGs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:48:27 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDA3C061A4D;
        Tue,  3 Nov 2020 22:48:27 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id x13so15731241pgp.7;
        Tue, 03 Nov 2020 22:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ysHUcVNbp38AUgn7NKxkH5Q5DIwpvOeEqm2kZUXUKmU=;
        b=YzNxGd//p6RpHxyQKY/zhdc1gm8gz0LIfXvR7h5InWiRax8cOhO7XTjfgvIru0w46l
         X4w55YlLlkCPHdQ7hCo/wgNXiRwUQwoMCmLOrB7YdM0Y48n/40OymgK1fgJjk6oKvAfv
         7uVVyrGgzpO3DjwzTf0pMKZR7HXCHLU9ELAqbDeQjWMGAk/QECCKqV4RXooBd9RDzTz6
         rt2B2eYb6efu4pg9hoDN0oc5SJwuch2gDNxkXMhM7SuNI9JPZJKNLZ6YnkBP4dLq7yky
         lgLbjZy9wNJl65sC7/5OOztv1vKFyROkxORu4j8Oz0KhdlhkPT1JUIlf8ZkgP5xaQWoD
         8v0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ysHUcVNbp38AUgn7NKxkH5Q5DIwpvOeEqm2kZUXUKmU=;
        b=DU06/bxEHeOGD9o+Aj8KbJ68ECb0CsBJQDuZZ56V8DdtOoncVK93pqiKgO7rqiVGXY
         vnii9PYYQ495N8/xEwJfJRWouIl63Jv6DzwhIt41PV86NPunXKdmuG6+ehepBEO83hgG
         5QxAXrXmEhTjhWV2E4DCmts28Cec6TOJhtpcLZENUy1Hh7PemAVJcjBaZYaahY08h+tn
         /hTFpApHgV5aHzgQ/6dw5Zguv8eudqbbKqwKjzmoLaFDYCIuz8LLnBJIlK5//mFSz474
         rRbxsv+w150Y3Eg04nv1hl3avNoGGzpK2qoAWze446UCaAsrOmeBl1Gbt2zY6Syrzqer
         1PSw==
X-Gm-Message-State: AOAM532GfLQyPtjYnv5lgC3f+RcMQGUQEhpPdTeqISoS6TBQGyeZbd7c
        sC0L8zpVA3pJIJ3COuog2a4=
X-Google-Smtp-Source: ABdhPJzuiIEqTk+1+1eFZRvLotka0QLSy6Ky8iB1wyY+65k+2+Lj+I04P2RisE3gcfbxPM73VqZifA==
X-Received: by 2002:a17:90b:34f:: with SMTP id fh15mr3075738pjb.66.1604472507072;
        Tue, 03 Nov 2020 22:48:27 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:48:26 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 15/15] usb: serial: kl5kusb105: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:17:03 +0530
Message-Id: <20201104064703.15123-16-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104064703.15123-1-himadrispandya@gmail.com>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
usb_control_msg() with proper error check. Hence use the wrappers
instead of calling usb_control_msg() directly

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
 drivers/usb/serial/kl5kusb105.c | 94 +++++++++++++++------------------
 1 file changed, 44 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
index 5ee48b0650c4..75cfd1c907f3 100644
--- a/drivers/usb/serial/kl5kusb105.c
+++ b/drivers/usb/serial/kl5kusb105.c
@@ -124,16 +124,17 @@ static int klsi_105_chg_port_settings(struct usb_serial_port *port,
 {
 	int rc;
 
-	rc = usb_control_msg(port->serial->dev,
-			usb_sndctrlpipe(port->serial->dev, 0),
-			KL5KUSB105A_SIO_SET_DATA,
-			USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_INTERFACE,
-			0, /* value */
-			0, /* index */
-			settings,
-			sizeof(struct klsi_105_port_settings),
-			KLSI_TIMEOUT);
-	if (rc < 0)
+	rc = usb_control_msg_send(port->serial->dev, 0,
+				  KL5KUSB105A_SIO_SET_DATA,
+				  USB_TYPE_VENDOR | USB_DIR_OUT |
+				  USB_RECIP_INTERFACE,
+				  0, /* value */
+				  0, /* index */
+				  settings,
+				  sizeof(struct klsi_105_port_settings),
+				  KLSI_TIMEOUT,
+				  GFP_KERNEL);
+	if (rc)
 		dev_err(&port->dev,
 			"Change port settings failed (error = %d)\n", rc);
 
@@ -167,28 +168,21 @@ static int klsi_105_get_line_state(struct usb_serial_port *port,
 				   unsigned long *line_state_p)
 {
 	int rc;
-	u8 *status_buf;
+	u8 status_buf[2];
 	__u16 status;
 
-	status_buf = kmalloc(KLSI_STATUSBUF_LEN, GFP_KERNEL);
-	if (!status_buf)
-		return -ENOMEM;
-
 	status_buf[0] = 0xff;
 	status_buf[1] = 0xff;
-	rc = usb_control_msg(port->serial->dev,
-			     usb_rcvctrlpipe(port->serial->dev, 0),
-			     KL5KUSB105A_SIO_POLL,
-			     USB_TYPE_VENDOR | USB_DIR_IN,
-			     0, /* value */
-			     0, /* index */
-			     status_buf, KLSI_STATUSBUF_LEN,
-			     10000
-			     );
-	if (rc != KLSI_STATUSBUF_LEN) {
+	rc = usb_control_msg_recv(port->serial->dev, 0,
+				  KL5KUSB105A_SIO_POLL,
+				  USB_TYPE_VENDOR | USB_DIR_IN,
+				  0, /* value */
+				  0, /* index */
+				  &status_buf, KLSI_STATUSBUF_LEN,
+				  10000,
+				  GFP_KERNEL);
+	if (rc) {
 		dev_err(&port->dev, "reading line status failed: %d\n", rc);
-		if (rc >= 0)
-			rc = -EIO;
 	} else {
 		status = get_unaligned_le16(status_buf);
 
@@ -198,7 +192,6 @@ static int klsi_105_get_line_state(struct usb_serial_port *port,
 		*line_state_p = klsi_105_status2linestate(status);
 	}
 
-	kfree(status_buf);
 	return rc;
 }
 
@@ -283,16 +276,17 @@ static int  klsi_105_open(struct tty_struct *tty, struct usb_serial_port *port)
 		goto err_free_cfg;
 	}
 
-	rc = usb_control_msg(port->serial->dev,
-			     usb_sndctrlpipe(port->serial->dev, 0),
-			     KL5KUSB105A_SIO_CONFIGURE,
-			     USB_TYPE_VENDOR|USB_DIR_OUT|USB_RECIP_INTERFACE,
-			     KL5KUSB105A_SIO_CONFIGURE_READ_ON,
-			     0, /* index */
-			     NULL,
-			     0,
-			     KLSI_TIMEOUT);
-	if (rc < 0) {
+	rc  = usb_control_msg_send(port->serial->dev, 0,
+				   KL5KUSB105A_SIO_CONFIGURE,
+				   USB_TYPE_VENDOR | USB_DIR_OUT |
+				   USB_RECIP_INTERFACE,
+				   KL5KUSB105A_SIO_CONFIGURE_READ_ON,
+				   0, /* index */
+				   NULL,
+				   0,
+				   KLSI_TIMEOUT,
+				   GFP_KERNEL);
+	if (rc) {
 		dev_err(&port->dev, "Enabling read failed (error = %d)\n", rc);
 		retval = rc;
 		goto err_generic_close;
@@ -314,14 +308,14 @@ static int  klsi_105_open(struct tty_struct *tty, struct usb_serial_port *port)
 	return 0;
 
 err_disable_read:
-	usb_control_msg(port->serial->dev,
-			     usb_sndctrlpipe(port->serial->dev, 0),
+	usb_control_msg_send(port->serial->dev, 0,
 			     KL5KUSB105A_SIO_CONFIGURE,
 			     USB_TYPE_VENDOR | USB_DIR_OUT,
 			     KL5KUSB105A_SIO_CONFIGURE_READ_OFF,
 			     0, /* index */
 			     NULL, 0,
-			     KLSI_TIMEOUT);
+			     KLSI_TIMEOUT,
+			     GFP_KERNEL);
 err_generic_close:
 	usb_serial_generic_close(port);
 err_free_cfg:
@@ -335,15 +329,15 @@ static void klsi_105_close(struct usb_serial_port *port)
 	int rc;
 
 	/* send READ_OFF */
-	rc = usb_control_msg(port->serial->dev,
-			     usb_sndctrlpipe(port->serial->dev, 0),
-			     KL5KUSB105A_SIO_CONFIGURE,
-			     USB_TYPE_VENDOR | USB_DIR_OUT,
-			     KL5KUSB105A_SIO_CONFIGURE_READ_OFF,
-			     0, /* index */
-			     NULL, 0,
-			     KLSI_TIMEOUT);
-	if (rc < 0)
+	rc = usb_control_msg_send(port->serial->dev, 0,
+				  KL5KUSB105A_SIO_CONFIGURE,
+				  USB_TYPE_VENDOR | USB_DIR_OUT,
+				  KL5KUSB105A_SIO_CONFIGURE_READ_OFF,
+				  0, /* index */
+				  NULL, 0,
+				  KLSI_TIMEOUT,
+				  GFP_KERNEL);
+	if (rc)
 		dev_err(&port->dev, "failed to disable read: %d\n", rc);
 
 	/* shutdown our bulk reads and writes */
-- 
2.17.1

