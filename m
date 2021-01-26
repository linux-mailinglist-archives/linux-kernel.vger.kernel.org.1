Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28709304EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404992AbhA0Bap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394786AbhAZSf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:35:56 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414FEC0613ED;
        Tue, 26 Jan 2021 10:35:15 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r38so6094039pgk.13;
        Tue, 26 Jan 2021 10:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bx/cdqgCma3iJlb8vZQT1JZ3qzb90ip49lgcVaqCQT4=;
        b=EJMrC+txD3IibE4RjJTLeJTuzedtcFYTmUJkcn1eVGc80DtwSuR/EcGdGNwRSTecPV
         FtLjuT1AAW/qNN037/aYSj4FeojMzsdii6pt9izxTvfVR5N8KGz/GDFBoV8NMK+9RU+S
         di1OssSp00gaJ/wyNv9viH8t56ymmxdSX2l6t0o1KlXajkSQiq5bWsnjsOhL73On1ebu
         oum8vbRWtI7k4qQU1PrJLwtPD2JuiMxx4zBVIw6MDEpaotlhNkoq4SZEd9d8DZfrojUw
         ibSoB/Ww8ZZcQ2y6cu2vzS6bNfKzgMAPJ0mn91m/YEyNJfMJTlcWH49jqnIt9mDSE4QQ
         hbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bx/cdqgCma3iJlb8vZQT1JZ3qzb90ip49lgcVaqCQT4=;
        b=PtO6r+xVyMxgKR1Pw1wGGB4JWOFPxN+LZqZHttSd5Y4zrBBRsV+wLApilhHl12nxul
         Rj6me46g4En97bwf4Alvn6iOojqsG8NsqIgiY/2U9GNld/n80Ddraw/CSny+Uh2j57tu
         s9vmi9p4yKLx7HFADZADMcSPMSkP3WnopX06L1sg8Dm5y9ueN/8GG6VlRtZTku5fePtp
         2Z2d61rW024H9zwFFfIw/vFVTlSNSLcmJArrAZ1jQojLq5NoexojQlADowYiiQdo+10q
         VZgBWOTCzexNdGi10+aSBS51UKwyXemrxVpSkv7rSkpqfD1VkwijIghupTcxJzEq4KIE
         cl9A==
X-Gm-Message-State: AOAM532u9UlikzGmN3faLkheT2Q87oZa/UniHCT9bzeG9DhIFsGWKYQW
        UQNuDbUV5Ifohfk39VmhC3/lvHSgrmycR+kyNsE=
X-Google-Smtp-Source: ABdhPJxsmzYM41sw3Zm/u83d4UqAR9pPCvyLi9JYwpsBEL3ZWQjorpTAKyBIOVb0F6ZLsN10DPNvqw==
X-Received: by 2002:a62:1b95:0:b029:19b:178f:84d7 with SMTP id b143-20020a621b950000b029019b178f84d7mr6633080pfb.70.1611686114735;
        Tue, 26 Jan 2021 10:35:14 -0800 (PST)
Received: from localhost.localdomain ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id y75sm472711pfg.119.2021.01.26.10.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:35:13 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/12] usb: misc: ehset: update to use the usb_control_msg_{send|recv}() API
Date:   Wed, 27 Jan 2021 00:03:55 +0530
Message-Id: <20210126183403.911653-5-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
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
usb_control_msg_{recv|send}() appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/usb/misc/ehset.c | 76 +++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

diff --git a/drivers/usb/misc/ehset.c b/drivers/usb/misc/ehset.c
index 2752e1f4f4d0..f87890f9cd26 100644
--- a/drivers/usb/misc/ehset.c
+++ b/drivers/usb/misc/ehset.c
@@ -24,68 +24,57 @@ static int ehset_probe(struct usb_interface *intf,
 	int ret = -EINVAL;
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct usb_device *hub_udev = dev->parent;
-	struct usb_device_descriptor *buf;
+	struct usb_device_descriptor buf;
 	u8 portnum = dev->portnum;
 	u16 test_pid = le16_to_cpu(dev->descriptor.idProduct);
 
 	switch (test_pid) {
 	case TEST_SE0_NAK_PID:
-		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
-					USB_REQ_SET_FEATURE, USB_RT_PORT,
-					USB_PORT_FEAT_TEST,
-					(USB_TEST_SE0_NAK << 8) | portnum,
-					NULL, 0, 1000);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_TEST,
+					   (USB_TEST_SE0_NAK << 8) | portnum,
+					   NULL, 0, 1000, GFP_KERNEL);
 		break;
 	case TEST_J_PID:
-		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
-					USB_REQ_SET_FEATURE, USB_RT_PORT,
-					USB_PORT_FEAT_TEST,
-					(USB_TEST_J << 8) | portnum,
-					NULL, 0, 1000);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_TEST,
+					   (USB_TEST_J << 8) | portnum, NULL, 0,
+					   1000, GFP_KERNEL);
 		break;
 	case TEST_K_PID:
-		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
-					USB_REQ_SET_FEATURE, USB_RT_PORT,
-					USB_PORT_FEAT_TEST,
-					(USB_TEST_K << 8) | portnum,
-					NULL, 0, 1000);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_TEST,
+					   (USB_TEST_K << 8) | portnum, NULL, 0,
+					   1000, GFP_KERNEL);
 		break;
 	case TEST_PACKET_PID:
-		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
-					USB_REQ_SET_FEATURE, USB_RT_PORT,
-					USB_PORT_FEAT_TEST,
-					(USB_TEST_PACKET << 8) | portnum,
-					NULL, 0, 1000);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_TEST,
+					   (USB_TEST_PACKET << 8) | portnum,
+					   NULL, 0, 1000, GFP_KERNEL);
 		break;
 	case TEST_HS_HOST_PORT_SUSPEND_RESUME:
 		/* Test: wait for 15secs -> suspend -> 15secs delay -> resume */
 		msleep(15 * 1000);
-		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
-					USB_REQ_SET_FEATURE, USB_RT_PORT,
-					USB_PORT_FEAT_SUSPEND, portnum,
-					NULL, 0, 1000);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_SUSPEND,
+					   portnum, NULL, 0, 1000, GFP_KERNEL);
 		if (ret < 0)
 			break;
 
 		msleep(15 * 1000);
-		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
-					USB_REQ_CLEAR_FEATURE, USB_RT_PORT,
-					USB_PORT_FEAT_SUSPEND, portnum,
-					NULL, 0, 1000);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_CLEAR_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_SUSPEND,
+					   portnum, NULL, 0, 1000, GFP_KERNEL);
 		break;
 	case TEST_SINGLE_STEP_GET_DEV_DESC:
 		/* Test: wait for 15secs -> GetDescriptor request */
 		msleep(15 * 1000);
-		buf = kmalloc(USB_DT_DEVICE_SIZE, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
 
-		ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
-					USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
-					USB_DT_DEVICE << 8, 0,
-					buf, USB_DT_DEVICE_SIZE,
-					USB_CTRL_GET_TIMEOUT);
-		kfree(buf);
+		ret = usb_control_msg_recv(dev, 0, USB_REQ_GET_DESCRIPTOR,
+					   USB_DIR_IN, USB_DT_DEVICE << 8, 0,
+					   &buf, USB_DT_DEVICE_SIZE,
+					   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
 		break;
 	case TEST_SINGLE_STEP_SET_FEATURE:
 		/*
@@ -100,11 +89,10 @@ static int ehset_probe(struct usb_interface *intf,
 			break;
 		}
 
-		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
-					USB_REQ_SET_FEATURE, USB_RT_PORT,
-					USB_PORT_FEAT_TEST,
-					(6 << 8) | portnum,
-					NULL, 0, 60 * 1000);
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_TEST,
+					   (6 << 8) | portnum, NULL, 0,
+					   60 * 1000, GFP_KERNEL);
 
 		break;
 	default:
@@ -112,7 +100,7 @@ static int ehset_probe(struct usb_interface *intf,
 			__func__, test_pid);
 	}
 
-	return (ret < 0) ? ret : 0;
+	return ret;
 }
 
 static void ehset_disconnect(struct usb_interface *intf)
-- 
2.25.1

