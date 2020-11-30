Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3162C7C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgK3B3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgK3B3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:29:13 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77831C0613CF;
        Sun, 29 Nov 2020 17:28:27 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id b12so317985pjl.0;
        Sun, 29 Nov 2020 17:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adCoA0FX32LVJH0CmgSfN0z9RiJT+SmZNYMtTn4BLVs=;
        b=hI0q5TyfQpDDb7ywq5cTMebgEanaCmzQpCHbbntM40pxvr0ZObjqBZ7x8cIOi8EsSD
         JsLvW0zLjlxBFdiOZ4VAakfTJ+dcsHczZLxXv2pUGjifVnIoyA4Dyj7eUGOMTzl+atY9
         ndj3tfwh4EyZ3mlySE5nnPYHcw72PAnLmxM1kSooypYLa/2myh0DhlstBwzHdDVV1ha/
         /PpH7StVUAEcWLDG8ppV/jmedk9SbjjxPzR04RrGnnPCH6E39vyJ6R7e7JAi53DcxWRe
         jUXRk3/GqhzHlD2jCF+R3EkBFDTEKt3bzZ8bc1ov/LYSJbuL9MLPxHrXM1kvrupbVxAR
         djsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adCoA0FX32LVJH0CmgSfN0z9RiJT+SmZNYMtTn4BLVs=;
        b=ta+Gbn0aQn7LZZXwHGuOKqT4BVosgKgDQ3ThqYntmKCUlpC42fcrI83RNjrq+DS0sU
         8ExK4wrEnsI3S7pvNsEZ/DLmcAFRZLxAwnraEzL9U2QJ5ywEIL+arbr5Og6dCSGFSxk7
         FebZgkajWODaGzWU+aomSXEXNN4WbONagep4E6EwTA5ZkFhABmgDrl/TyI5+pjEhJu2I
         PAELZVeVCwJZBej9ZJ1TVl+sE1SQii/1dkxtgBceEdmEQoQ4Dw6G28lYRkZ4x0a9W73h
         y2JsvZwA+2kUKAlQQVwABibIOx9SlqocURAzXZ8f6WMIXkt8iVGe33aaLSktAEcOOAtu
         32Qw==
X-Gm-Message-State: AOAM5323ReUsOQ30xOaM3vB9gpYEn3MrHmYzBwzolPuYw0CVDvYVIRWl
        LmbHpmfu+zeuLCEbrtzL8+w=
X-Google-Smtp-Source: ABdhPJyIvXXYzDDaT6Me1FDNqZuoQ2wuvK5w8bjSKQkkrHFXKoFsbgzgMqj48mBN1vHci9xnuwEaGA==
X-Received: by 2002:a17:902:7d8e:b029:da:274:c75b with SMTP id a14-20020a1709027d8eb02900da0274c75bmr16149204plm.61.1606699706939;
        Sun, 29 Nov 2020 17:28:26 -0800 (PST)
Received: from localhost.localdomain ([49.207.197.72])
        by smtp.gmail.com with ESMTPSA id m9sm20825079pjf.20.2020.11.29.17.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:28:26 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bin Liu <b-liu@ti.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 04/15] usb: misc: ehset: update to use the usb_control_msg_{send|recv}() API
Date:   Mon, 30 Nov 2020 06:58:16 +0530
Message-Id: <20201130012816.2579140-1-anant.thazhemadam@gmail.com>
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
usb_control_msg_{recv|send}() appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
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

