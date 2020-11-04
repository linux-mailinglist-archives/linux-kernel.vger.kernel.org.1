Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BABB2A5E4C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgKDGsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbgKDGr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:47:57 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364DAC061A4D;
        Tue,  3 Nov 2020 22:47:56 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 10so16499474pfp.5;
        Tue, 03 Nov 2020 22:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gj3vhr1jCB9Dg5NnjmQRggTwPs6mgGI9aVvWxKxd4YM=;
        b=LGMsvBSA5gQwLgkvnOtNA/ctaxR/E125DO1k+uIzy8+IItaLrI13+92z9tUKubJ9VX
         GTUh+oetORPbEjpLw6kRJPhQlanj/eFr7ZmgmkZ3if/3vzTeI0D0evPTE2iO7fDnhqTh
         zmp2sU8c8zTFcnT/qGhh/G5K7qr8DElmk6J7LHoJPbp27iyk+hyC/OflbKdaCpLiDJd5
         yhcd2VBlQY1RNmjWfzb6SC0cb4vjh++6YTekI/TODPfwmKF3bm3pp1Ex1Sh7Cbjcbzlu
         Tls94X0O8/vQhL2pJr5uytezbDhLEWq+CPJfErobLvgKSNWICIu/n9HbhXQB/XFTMrna
         VjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gj3vhr1jCB9Dg5NnjmQRggTwPs6mgGI9aVvWxKxd4YM=;
        b=beEhgYMoMHE/jbuqBl03WeAJwKZa4u0Xf3i+61XRrHW59HlWG6fK62nfb0RMkd4u7H
         7KetS2CV+SS/2YsFJnNyLp5pOrFpyGzeCTiIacqwkzLwHCwCApSa351KVbGNi6hnJuQY
         /EUaoQl3imPFEVULWe3mlFkWUZ+bcy0UhFkFAP3fmRJ+Q9oWwmFZVa0mN1BlG8vlCQ6E
         oDdal4MSKGrZq9nNHKgnsekbY6PlhKSR6FvimbH0302z70FjfLCi9RGTHcsMqdvyYkWZ
         QRp8fLune7HUUQO/CBC+qlndSPTYByPijXcsvE322LATJJ8UuUu588giVFVZ3EZwtIsG
         3m/w==
X-Gm-Message-State: AOAM532DomMs0Y2g2L7RzFC3mJTlLQukk3Vc/paI9OWR55TKqj/ojuuC
        IaTENuiV5+mvlXrXKmRqwng=
X-Google-Smtp-Source: ABdhPJwpRtZ7gPzaBfsGb4ipy/z5/ycwX0Yqva3is6V9+uWWx9rwD7uszHRbk8NvkHmAbfSr70TXBQ==
X-Received: by 2002:a63:381:: with SMTP id 123mr6416620pgd.112.1604472475787;
        Tue, 03 Nov 2020 22:47:55 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:47:55 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 07/15] usb: serial: f81534: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:16:55 +0530
Message-Id: <20201104064703.15123-8-himadrispandya@gmail.com>
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
 drivers/usb/serial/f81534.c | 63 +++++++++++--------------------------
 1 file changed, 18 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
index 5661fd03e545..23eb17a2c052 100644
--- a/drivers/usb/serial/f81534.c
+++ b/drivers/usb/serial/f81534.c
@@ -217,38 +217,26 @@ static int f81534_set_register(struct usb_serial *serial, u16 reg, u8 data)
 	struct usb_device *dev = serial->dev;
 	size_t count = F81534_USB_MAX_RETRY;
 	int status;
-	u8 *tmp;
-
-	tmp = kmalloc(sizeof(u8), GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
-
-	*tmp = data;
 
 	/*
 	 * Our device maybe not reply when heavily loading, We'll retry for
 	 * F81534_USB_MAX_RETRY times.
 	 */
 	while (count--) {
-		status = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
-					 F81534_SET_GET_REGISTER,
-					 USB_TYPE_VENDOR | USB_DIR_OUT,
-					 reg, 0, tmp, sizeof(u8),
-					 F81534_USB_TIMEOUT);
-		if (status > 0) {
-			status = 0;
-			break;
-		} else if (status == 0) {
-			status = -EIO;
+		status = usb_control_msg_send(dev, 0, F81534_SET_GET_REGISTER,
+					      USB_TYPE_VENDOR | USB_DIR_OUT,
+					      reg, 0, &data, sizeof(u8),
+					      F81534_USB_TIMEOUT, GFP_KERNEL);
+		if (status) {
+			/* Try again */
+			continue;
 		}
 	}
 
-	if (status < 0) {
+	if (status)
 		dev_err(&interface->dev, "%s: reg: %x data: %x failed: %d\n",
-				__func__, reg, data, status);
-	}
+			__func__, reg, data, status);
 
-	kfree(tmp);
 	return status;
 }
 
@@ -258,40 +246,25 @@ static int f81534_get_register(struct usb_serial *serial, u16 reg, u8 *data)
 	struct usb_device *dev = serial->dev;
 	size_t count = F81534_USB_MAX_RETRY;
 	int status;
-	u8 *tmp;
-
-	tmp = kmalloc(sizeof(u8), GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
 
 	/*
 	 * Our device maybe not reply when heavily loading, We'll retry for
 	 * F81534_USB_MAX_RETRY times.
 	 */
 	while (count--) {
-		status = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
-					 F81534_SET_GET_REGISTER,
-					 USB_TYPE_VENDOR | USB_DIR_IN,
-					 reg, 0, tmp, sizeof(u8),
-					 F81534_USB_TIMEOUT);
-		if (status > 0) {
-			status = 0;
-			break;
-		} else if (status == 0) {
-			status = -EIO;
+		status = usb_control_msg_recv(dev, 0, F81534_SET_GET_REGISTER,
+					      USB_TYPE_VENDOR | USB_DIR_IN, reg,
+					      0, data, sizeof(u8),
+					      F81534_USB_TIMEOUT, GFP_KERNEL);
+		if (status) {
+			/* Try again */
+			continue;
 		}
 	}
 
-	if (status < 0) {
+	if (status)
 		dev_err(&interface->dev, "%s: reg: %x failed: %d\n", __func__,
-				reg, status);
-		goto end;
-	}
-
-	*data = *tmp;
-
-end:
-	kfree(tmp);
+			reg, status);
 	return status;
 }
 
-- 
2.17.1

