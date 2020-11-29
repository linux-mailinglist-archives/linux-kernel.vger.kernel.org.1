Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971402C79E5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbgK2QIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbgK2QIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:08:09 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17834C0613D4;
        Sun, 29 Nov 2020 08:07:32 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id s63so8401581pgc.8;
        Sun, 29 Nov 2020 08:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXDwYZccsmVjSKXYJgsER+W1djN2DPbdJ+Caqbf/CLM=;
        b=LiqGJ3Basd+o8GXxdzaegEJjaPUcn2K6UUcgPqMO6Vl2xvPjftQokmLKEW/uAjgBiq
         A0VDTbVQM3f/adOhjCptRfD4djJdUlbpDUKY2gLdIBZqHwzrszCfoH56cn6BsJZUYuHI
         42Lxw81t2ivttnfThvE/zU5aZVVnzBMPfTT0S6arpi7/BbxgfpK5Ewjnxgb4FnS7MQ5/
         AAUmiTcwb0u3OI6UYsCf1aasPWOvuibWaVCyCBNvfCGNzQ9uziAOpLDGDL3E6hRb+Kr3
         2lVI3dLDytfUpwDWsCRrmV8IL7Xlal6xBcRCT8xgaa55PAcdnHZ5TfujlsJjFy0iJ/UT
         lZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXDwYZccsmVjSKXYJgsER+W1djN2DPbdJ+Caqbf/CLM=;
        b=Nt0Q0lQv1Yk4FjD2px8jIl5aYlJVYU01q0vNCT1ky2EhOHR1mXOCIU8BaI5BHhW7W0
         ps9afSplOf5bZyRI5EvhsQvYagAZP6m+1x9Gyl6PYSjvMEPfAn9q3rk7eYKrUEL9rGgA
         UNdhyGwVlN/ArNdym9+hppMn/yivzV41uQ6bRHI10INBVi4UB+hGof0ljq8Ivezq1W6U
         VRlFhTAC9ojkrD5ODmoeCdQ8iTNnBt2HyLms1YMHCv+AeSWNdJvQBAvdXtn71uTvjJYl
         39uc1sG0gLv9bS1RzB0Jb7e4Jdj8mTfxuAZDSO+tfVOMIdruVVLERA1/NoUIxCkJaeFC
         PpqA==
X-Gm-Message-State: AOAM531Rs8XH6XNjbtirkH7lHy0vkd+8xU3QrYW3XKP+MesbFyUvKecs
        ZH/TDl3I5TdEqHDRLPQ/Q7w=
X-Google-Smtp-Source: ABdhPJw8IiGB+Ahaz7KAq8VBFiFRibfdRL/fPLzsFugA+tGfqMm1FaGF+vZpzqwJDKizPlqC5owhkQ==
X-Received: by 2002:a17:90b:3698:: with SMTP id mj24mr1472626pjb.149.1606666051529;
        Sun, 29 Nov 2020 08:07:31 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:07:30 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zqiang <qiang.zhang@windriver.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] usb: misc: usbtest: update to use the usb_control_msg_{send|recv}() API
Date:   Sun, 29 Nov 2020 21:36:12 +0530
Message-Id: <20201129160612.1908074-16-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201129160612.1908074-1-anant.thazhemadam@gmail.com>
References: <20201129160612.1908074-1-anant.thazhemadam@gmail.com>
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
 drivers/usb/misc/usbtest.c | 63 +++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 150090ee4ec1..e44ec5261d82 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -672,10 +672,11 @@ static int get_altsetting(struct usbtest_dev *dev)
 	struct usb_device	*udev = interface_to_usbdev(iface);
 	int			retval;
 
-	retval = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-			USB_REQ_GET_INTERFACE, USB_DIR_IN|USB_RECIP_INTERFACE,
-			0, iface->altsetting[0].desc.bInterfaceNumber,
-			dev->buf, 1, USB_CTRL_GET_TIMEOUT);
+	retval = usb_control_msg_recv(udev, 0, USB_REQ_GET_INTERFACE,
+				      USB_DIR_IN|USB_RECIP_INTERFACE,
+				      0, iface->altsetting[0].desc.bInterfaceNumber,
+				      dev->buf, 1, USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+
 	switch (retval) {
 	case 1:
 		return dev->buf[0];
@@ -685,6 +686,11 @@ static int get_altsetting(struct usbtest_dev *dev)
 	default:
 		return retval;
 	}
+
+	if (retval < 0)
+		return retval;
+
+	return dev->buf[0];
 }
 
 static int set_altsetting(struct usbtest_dev *dev, int alternate)
@@ -872,14 +878,15 @@ static int ch9_postconfig(struct usbtest_dev *dev)
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
 
@@ -1683,10 +1690,10 @@ static int test_halt(struct usbtest_dev *tdev, int ep, struct urb *urb)
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
@@ -1845,30 +1852,22 @@ static int ctrl_out(struct usbtest_dev *dev,
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

