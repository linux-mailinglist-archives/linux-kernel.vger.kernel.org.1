Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B819B2C7C75
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgK3BfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgK3BfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:35:12 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ABBC0613D2;
        Sun, 29 Nov 2020 17:34:32 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id n137so9398883pfd.3;
        Sun, 29 Nov 2020 17:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MRf4ZKc/l/eC7hFvdoC+Q4DO+7qNVyq14MdwpxFRyF4=;
        b=G1ZxR9TkgoW8diPH06BgSmIXKYidGd9LgBebSIwX0TWLjOX0xJmKKv67iCR5getn7r
         F7TKZVzfPzxw08bbKFbMm9Imcx1CvSk5EsFakblE6/MTcZBjM1tq0x3mImWeb5JhPsLr
         ezr0XTJ7gKr5J/xbzjsNRDXFWKmYABaKmtJissHCKRnvydqPvDwTT5gDWkCuy7O6dkxx
         1f1BM1i5tu3rK5UCdxKOQLaJg2rBSYRzs2Fr004b0BrABdWZVXSuVc6cAHJlqbMYdczv
         g3xQwwvfROsl2MjrJZ7WoduuL0d0a/OswWVLv34SbCYzp5WQUk5AzznGv3cvz9AUoW1s
         UXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MRf4ZKc/l/eC7hFvdoC+Q4DO+7qNVyq14MdwpxFRyF4=;
        b=CIe3ehLSetllqNOIznPj+d0+sDjMFNYM52by6Hp3WylMlmNj5w4it25oVBiNV0Sesu
         TIA2KyYxMOF3nUtqbFZJLnfkuGq7jKYLOD3ypkfrNaecV6OaaMk0SwShAW0ekG5rny/6
         E2my0K7JCu+OjGP9R8/BqhciihYR2CrqWPXo7swIYnuRvXNZzJdsYv8RfGcqxByfAqjA
         4qvPzmxd3sCKdxycIavqWeECIIfcceSUXdafpzTdvegrhiR12yFhdtT1plllllJCcSJM
         xw9Iy2n4THO3O2Fpnpac1XZqyT9s8q1VrCb6R2woQvlgKOAsoilt2JUSeYDeU7hnjyiG
         Joww==
X-Gm-Message-State: AOAM530240RVveszRGqExeOAKGJxvKlWyw9pgiGlmYlfRROpnQ7J4sE+
        BW5bB242F+KFOOOFeZ1lnSs=
X-Google-Smtp-Source: ABdhPJyHO7I4zPVmvwQF5AEJDODFMWaZarJmtHMBk2qu5luFRYuyFq+VBvj/Vf+wFjH0DgDAvSPmIw==
X-Received: by 2002:a63:e54b:: with SMTP id z11mr3477173pgj.158.1606700072181;
        Sun, 29 Nov 2020 17:34:32 -0800 (PST)
Received: from localhost.localdomain ([49.207.197.72])
        by smtp.gmail.com with ESMTPSA id k1sm13933508pgm.21.2020.11.29.17.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:34:31 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Zqiang <qiang.zhang@windriver.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/15] usb: misc: usbtest: update to use the usb_control_msg_{send|recv}() API
Date:   Mon, 30 Nov 2020 07:04:23 +0530
Message-Id: <20201130013423.2582099-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
References: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

