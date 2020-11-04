Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327DC2A5E42
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgKDGrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgKDGrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:47:41 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F528C061A4D;
        Tue,  3 Nov 2020 22:47:41 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id e7so16463812pfn.12;
        Tue, 03 Nov 2020 22:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jIXN4oV96UfWYf6NfkH9p6xOm8rqz64TQybeTquYEoU=;
        b=bdgDAL36GFSxZ5FJZO8E/+xQp0pgIRfJKgW1vhllCfE0cWJXALFLZGTVA13Io9oEax
         kLBpBdoxoqrgjlfuKpWU9xamztTgEHWQ/4zyec1bzBTOi42ddb3NxHH3veNbcCCbkv+C
         lj7FjBxipHKImRwsp9ihQpsbBvb+SR5XVAtFS8g3+Sy5NZfVSWtcPONRHV/XDazRGabG
         LwoyNMh3bfJMpBDoeuCJSFWlYlPlYt/qbsqR+YoC+4QkiMUXyE1m3jyWCJ1edBEUQV96
         vQRdQb8hs4hPxg2NrxnrQURJjQE/8/4HjyfeMPmci58vskAZ2q/OxQMHkKUmJaH8Gko/
         5dSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jIXN4oV96UfWYf6NfkH9p6xOm8rqz64TQybeTquYEoU=;
        b=t0V0zviXfsAJnII631r9s2Q011wMY9A5J9leJ8A1uVTWIqScKgUtjqvi58LzU9aB+m
         RDFHez5YWXCzVnG9IsvGfaTD4hGUm+VCzYJu8+fXm7GfC1ABDw60FYXWXszUCnJBG0l4
         wruoAEY0bbynOi1OQKBS2tZe2QBASKAx0srrMf+bLoG5kf05Vf+K8WURPf+UMu8WBLOb
         LRL5glrMtnaKl6J7qFrlTZ6920IsKgm3ODRL2eTj94NGqtgxChXYpZHXJbGnz/2nVuUZ
         y664TPqUZyeGHobyHtnSKc4C1U0kuy6wxullJYYbDho9p+iMXlx2h+h0elqcQSrYZ2Y3
         E7KA==
X-Gm-Message-State: AOAM533Ng6JAlvqVBjadRT716iaFxqhuKQSILfOR8r6oFR0PJhXWXfRy
        PIy5lZP/SLsKI8mUftomA6TprAKVpW8=
X-Google-Smtp-Source: ABdhPJwbeR7/672K26Vnqd7j+koUadp3SD8IiepZdPZZlrlpgw5sN/lrTix2osWHCk8nYK4A+rfHtg==
X-Received: by 2002:a63:1d12:: with SMTP id d18mr20727693pgd.314.1604472460880;
        Tue, 03 Nov 2020 22:47:40 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:47:40 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 03/15] usb: serial: ch314: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:16:51 +0530
Message-Id: <20201104064703.15123-4-himadrispandya@gmail.com>
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
 drivers/usb/serial/ch341.c | 45 ++++++++++++--------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index a2e2f56c88cd..58c5d3ce4f75 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -111,10 +111,10 @@ static int ch341_control_out(struct usb_device *dev, u8 request,
 	dev_dbg(&dev->dev, "%s - (%02x,%04x,%04x)\n", __func__,
 		request, value, index);
 
-	r = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), request,
-			    USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			    value, index, NULL, 0, DEFAULT_TIMEOUT);
-	if (r < 0)
+	r = usb_control_msg_send(dev, 0, request, USB_TYPE_VENDOR |
+				 USB_RECIP_DEVICE | USB_DIR_OUT, value, index,
+				 NULL, 0, DEFAULT_TIMEOUT, GFP_KERNEL);
+	if (r)
 		dev_err(&dev->dev, "failed to send control message: %d\n", r);
 
 	return r;
@@ -129,23 +129,14 @@ static int ch341_control_in(struct usb_device *dev,
 	dev_dbg(&dev->dev, "%s - (%02x,%04x,%04x,%u)\n", __func__,
 		request, value, index, bufsize);
 
-	r = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), request,
-			    USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			    value, index, buf, bufsize, DEFAULT_TIMEOUT);
-	if (r < (int)bufsize) {
-		if (r >= 0) {
-			dev_err(&dev->dev,
-				"short control message received (%d < %u)\n",
-				r, bufsize);
-			r = -EIO;
-		}
-
+	r = usb_control_msg_recv(dev, 0, request, USB_TYPE_VENDOR |
+				 USB_RECIP_DEVICE | USB_DIR_IN, value, index,
+				 buf, bufsize, DEFAULT_TIMEOUT, GFP_KERNEL);
+	if (r)
 		dev_err(&dev->dev, "failed to receive control message: %d\n",
 			r);
-		return r;
-	}
 
-	return 0;
+	return r;
 }
 
 #define CH341_CLKRATE		48000000
@@ -343,22 +334,18 @@ static int ch341_detect_quirks(struct usb_serial_port *port)
 	struct usb_device *udev = port->serial->dev;
 	const unsigned int size = 2;
 	unsigned long quirks = 0;
-	char *buffer;
+	u8 buffer[2];
 	int r;
 
-	buffer = kmalloc(size, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
 	/*
 	 * A subset of CH34x devices does not support all features. The
 	 * prescaler is limited and there is no support for sending a RS232
 	 * break condition. A read failure when trying to set up the latter is
 	 * used to detect these devices.
 	 */
-	r = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0), CH341_REQ_READ_REG,
-			    USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			    CH341_REG_BREAK, 0, buffer, size, DEFAULT_TIMEOUT);
+	r = usb_control_msg_recv(udev, 0, CH341_REQ_READ_REG, USB_TYPE_VENDOR |
+				 USB_RECIP_DEVICE | USB_DIR_IN, CH341_REG_BREAK,
+				 0, &buffer, size, DEFAULT_TIMEOUT, GFP_KERNEL);
 	if (r == -EPIPE) {
 		dev_info(&port->dev, "break control not supported, using simulated break\n");
 		quirks = CH341_QUIRK_LIMITED_PRESCALER | CH341_QUIRK_SIMULATE_BREAK;
@@ -366,17 +353,13 @@ static int ch341_detect_quirks(struct usb_serial_port *port)
 		goto out;
 	}
 
-	if (r != size) {
-		if (r >= 0)
-			r = -EIO;
+	if (r) {
 		dev_err(&port->dev, "failed to read break control: %d\n", r);
 		goto out;
 	}
 
 	r = 0;
 out:
-	kfree(buffer);
-
 	if (quirks) {
 		dev_dbg(&port->dev, "enabling quirk flags: 0x%02lx\n", quirks);
 		priv->quirks |= quirks;
-- 
2.17.1

