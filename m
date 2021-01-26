Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63822304F10
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392286AbhA0BlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391738AbhAZSlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:41:32 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029D8C061786
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:40:52 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u15so1060740plf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gHW9fONbamfIOSD/jiG5utLruM4EG0wf2DaVHQnD+Sw=;
        b=vPBZzbKAIhTx7/MjPOk7W0gbW3dGTIKqQfJkwRslV5l7IoCqQmKvFm3qF6WOL4H/hV
         ajbDTIMEyrtVpeK20G7F/UzCxHqzuM42nDVQD5PpOxpLrzNMCYajsO99z//OA5knWcYS
         zqLfjpzpga2CdH1n9eqBTljQqYfKbJ6aabnacSetN+obG5chZjCMQkm4M2TWwoCJ2bhB
         GJcf7mbgrMkzidmFqKtXJ3/9GIIPu2P2SuGEH6JZ0pnlbJyowQjGM4dd8piieFuOzRUz
         KTaSfs+dBanhJzKnHHwucQAQbyDvHpA6f9J5AFF/Sg9/3AjpF97mgNKAhthuspue2ILY
         QUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHW9fONbamfIOSD/jiG5utLruM4EG0wf2DaVHQnD+Sw=;
        b=ZqIfvuy+U977pOmeGFa1IVj9ZF9TFRsllu1nJkzn4d4k6qGkREIpweYNx5p4Fyc+HY
         LTaWfrarlUSNihrxS6YE5qxzt09i9IJaHKd6oPvXnFl1h5YHGJAf8/skgJdMPVs5u4vU
         LH6QHPIrifPBQC42eEQsWeAjNgIajZKeqc8TKQEKZVRQ7Uej5yw3D7OqDvN1y9puSqOB
         x+1UO7CZ1VZAiTfCPv6fQSmnEeKz3D1n+k/TuLrdjzB4JzzSuwKuwnEoAqeucxGRlohB
         3ZfINS/a9x4KB5Xo25hQbUYAeOWEJe2P5VQey2JxxNWWhS87I65+67HPcwqWP57y02CV
         U+3w==
X-Gm-Message-State: AOAM530Myx1QpqGqBngL9GGfYlwHRk3LkvVt6/7I7VCsMLN7OPsrpoO9
        RTHGWexQvyOfcsVLNPIVXKY=
X-Google-Smtp-Source: ABdhPJx8cgvQ3sU645kfcPvEgeMgAO1l7Ti6pMTWkdv9U6JihOEN1fgiQvTOhIdh0Ce7WhKG0cs9ZQ==
X-Received: by 2002:a17:90a:4a08:: with SMTP id e8mr1131216pjh.149.1611686451533;
        Tue, 26 Jan 2021 10:40:51 -0800 (PST)
Received: from localhost.localdomain ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id 34sm9854302pgn.56.2021.01.26.10.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:40:50 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Zqiang linux-usb @ vger . kernel . org" <qiang.zhang@windriver.com>,
        linux-kernel@vger.kernel.org
Subject: 
Date:   Wed, 27 Jan 2021 00:10:43 +0530
Message-Id: <20210126184043.915235-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH v3 12/12] usb: misc: usbtest: update to use the
 usb_control_msg_{send|recv}() API

The newer usb_control_msg_{send|recv}() API are an improvement on the
existing usb_control_msg() as it ensures that a short read/write is treated
as an error, data can be used off the stack, and raw usb pipes need not be
created in the calling functions.
For this reason, instances of usb_control_msg() have been replaced with
usb_control_msg_{recv|send}() and the return value checking conditions have
also been modified appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/usbtest.c | 69 ++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 150090ee4ec1..4337eff2a749 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -672,19 +672,15 @@ static int get_altsetting(struct usbtest_dev *dev)
 	struct usb_device	*udev = interface_to_usbdev(iface);
 	int			retval;
 
-	retval = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-			USB_REQ_GET_INTERFACE, USB_DIR_IN|USB_RECIP_INTERFACE,
-			0, iface->altsetting[0].desc.bInterfaceNumber,
-			dev->buf, 1, USB_CTRL_GET_TIMEOUT);
-	switch (retval) {
-	case 1:
-		return dev->buf[0];
-	case 0:
-		retval = -ERANGE;
-		fallthrough;
-	default:
+	retval = usb_control_msg_recv(udev, 0, USB_REQ_GET_INTERFACE,
+				      USB_DIR_IN|USB_RECIP_INTERFACE,
+				      0, iface->altsetting[0].desc.bInterfaceNumber,
+				      dev->buf, 1, USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+
+	if (retval < 0)
 		return retval;
-	}
+
+	return dev->buf[0];
 }
 
 static int set_altsetting(struct usbtest_dev *dev, int alternate)
@@ -872,14 +868,15 @@ static int ch9_postconfig(struct usbtest_dev *dev)
 		 * ... although some cheap devices (like one TI Hub I've got)
 		 * won't return config descriptors except before set_config.
 		 */
-		retval = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-				USB_REQ_GET_CONFIGURATION,
-				USB_DIR_IN | USB_RECIP_DEVICE,
-				0, 0, dev->buf, 1, USB_CTRL_GET_TIMEOUT);
-		if (retval != 1 || dev->buf[0] != expected) {
+		retval = usb_control_msg_recv(udev, 0, USB_REQ_GET_CONFIGURATION,
+					      USB_DIR_IN | USB_RECIP_DEVICE,  0,
+					      0, dev->buf, 1, USB_CTRL_GET_TIMEOUT,
+					      GFP_KERNEL);
+
+		if (retval != 0 || dev->buf[0] != expected) {
 			dev_err(&iface->dev, "get config --> %d %d (1 %d)\n",
 				retval, dev->buf[0], expected);
-			return (retval < 0) ? retval : -EDOM;
+			return retval;
 		}
 	}
 
@@ -1683,10 +1680,10 @@ static int test_halt(struct usbtest_dev *tdev, int ep, struct urb *urb)
 		return retval;
 
 	/* set halt (protocol test only), verify it worked */
-	retval = usb_control_msg(urb->dev, usb_sndctrlpipe(urb->dev, 0),
-			USB_REQ_SET_FEATURE, USB_RECIP_ENDPOINT,
-			USB_ENDPOINT_HALT, ep,
-			NULL, 0, USB_CTRL_SET_TIMEOUT);
+	retval = usb_control_msg_send(urb->dev, 0, USB_REQ_SET_FEATURE,
+				      USB_RECIP_ENDPOINT, USB_ENDPOINT_HALT,
+				      ep, NULL, 0, USB_CTRL_SET_TIMEOUT,
+				      GFP_KERNEL);
 	if (retval < 0) {
 		ERROR(tdev, "ep %02x couldn't set halt, %d\n", ep, retval);
 		return retval;
@@ -1845,30 +1842,22 @@ static int ctrl_out(struct usbtest_dev *dev,
 		/* write patterned data */
 		for (j = 0; j < len; j++)
 			buf[j] = (u8)(i + j);
-		retval = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-				0x5b, USB_DIR_OUT|USB_TYPE_VENDOR,
-				0, 0, buf, len, USB_CTRL_SET_TIMEOUT);
-		if (retval != len) {
+		retval = usb_control_msg_send(udev, 0, 0x5b,
+					      USB_DIR_OUT | USB_TYPE_VENDOR, 0,
+					      0, buf, len, USB_CTRL_SET_TIMEOUT,
+					      GFP_KERNEL);
+		if (retval < 0) {
 			what = "write";
-			if (retval >= 0) {
-				ERROR(dev, "ctrl_out, wlen %d (expected %d)\n",
-						retval, len);
-				retval = -EBADMSG;
-			}
 			break;
 		}
 
 		/* read it back -- assuming nothing intervened!!  */
-		retval = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-				0x5c, USB_DIR_IN|USB_TYPE_VENDOR,
-				0, 0, buf, len, USB_CTRL_GET_TIMEOUT);
-		if (retval != len) {
+		retval = usb_control_msg_recv(udev, 0,
+					      0x5c, USB_DIR_IN|USB_TYPE_VENDOR,
+					      0, 0, buf, len, USB_CTRL_GET_TIMEOUT,
+					      GFP_KERNEL);
+		if (retval < 0) {
 			what = "read";
-			if (retval >= 0) {
-				ERROR(dev, "ctrl_out, rlen %d (expected %d)\n",
-						retval, len);
-				retval = -EBADMSG;
-			}
 			break;
 		}
 
-- 
2.25.1

