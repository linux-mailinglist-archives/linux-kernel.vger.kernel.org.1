Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67BA304F00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405162AbhA0BdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387995AbhAZSh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:37:56 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2E8C061794;
        Tue, 26 Jan 2021 10:35:36 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t29so10925449pfg.11;
        Tue, 26 Jan 2021 10:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04c9BxYa1Ymi07bLwZCgG59VbrDPFBxGmQMOZz4mzls=;
        b=FvOQgNCqddAYm4AUTCia19wuZvPbuQkbX+N8R33QYgKyNuRjVwzcgRFgwB6glK1RLE
         p4jJIbcuu7KymzF9CEGJVoWMCBBc3eDqX0QAoOt+5zhUf8Rrw4o3tvyh71GwD9uM5Rkz
         LBAuhRPF29reaIxf14OycL3nsyQqVQsJlFIgmARemkK1gyXAiL8Xw8aZSf5s0lZQoFBZ
         S/KbP5WhAuLS+HrPCMzTLZr3F2XTJLGDdyqLEKABwLyH6y91h4eAXHqtQsfimnStABv9
         llQsmlh08D0LJcBeQiHFbunf2IvWPATo4xo4GPqkQJxNPyTV/R8yQUAEePtTw/bUookE
         NPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04c9BxYa1Ymi07bLwZCgG59VbrDPFBxGmQMOZz4mzls=;
        b=eywgZMqWDOMI3CQqTkgbe1WV/+mIfJbjaTxHHjWMriVrKHqfZA9E8OmmiNgKMDuNpl
         Un7UUnLPy1N4hJX7GCqOai2RyFWXGZBLaNH7x2/MlN8HcYlJI7Hm9LeA2QsRjLncOLR2
         qPl4xv77ofgt1hHDN9Hh+53klR/h4p3cBWTyywVK5ZMxKysxydtKB/5BJhoh7ohydRY6
         ZB7A+aY1mZyYPL0hSeJR9faCaqTmEp27np4vnfqpZGaaauPN6FCHgYj253k3ypHm5Yrw
         oz/qUb2gZCAvrSQyF/ziZxRJldFUc6myTfnnlqd2jNO+8pEbOyzHj1HVuHtwWSA2LO+b
         Gq4A==
X-Gm-Message-State: AOAM530gzj3AfQ0h2NRaGt58rQNOwA8vcuc/i/nGLtoyfSl/PoIaM95f
        SLprCQAQJEosV7jOhhRybng=
X-Google-Smtp-Source: ABdhPJwqDl+lPSKoUI67DOGZaaoeyidOGlselnVweQd3TklIxxtu004ow4RPRps5q4r94389+bcgqw==
X-Received: by 2002:a63:560b:: with SMTP id k11mr6954956pgb.89.1611686135847;
        Tue, 26 Jan 2021 10:35:35 -0800 (PST)
Received: from localhost.localdomain ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id y75sm472711pfg.119.2021.01.26.10.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:35:35 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/12] usb: misc: isight_firmware: update to use usb_control_msg_send()
Date:   Wed, 27 Jan 2021 00:03:58 +0530
Message-Id: <20210126183403.911653-8-anant.thazhemadam@gmail.com>
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
For this reason, the instances of usb_control_msg() have been replaced with
usb_control_msg_send(), and return value checking has also been
appropriately enforced.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/isight_firmware.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/misc/isight_firmware.c b/drivers/usb/misc/isight_firmware.c
index 4d30095d6ad2..1bd14a431f6c 100644
--- a/drivers/usb/misc/isight_firmware.c
+++ b/drivers/usb/misc/isight_firmware.c
@@ -37,13 +37,10 @@ static int isight_firmware_load(struct usb_interface *intf,
 	struct usb_device *dev = interface_to_usbdev(intf);
 	int llen, len, req, ret = 0;
 	const struct firmware *firmware;
-	unsigned char *buf = kmalloc(50, GFP_KERNEL);
+	unsigned char buf[50];
 	unsigned char data[4];
 	const u8 *ptr;
 
-	if (!buf)
-		return -ENOMEM;
-
 	if (request_firmware(&firmware, "isight.fw", &dev->dev) != 0) {
 		printk(KERN_ERR "Unable to load isight firmware\n");
 		ret = -ENODEV;
@@ -53,11 +50,11 @@ static int isight_firmware_load(struct usb_interface *intf,
 	ptr = firmware->data;
 
 	buf[0] = 0x01;
-	if (usb_control_msg
-	    (dev, usb_sndctrlpipe(dev, 0), 0xa0, 0x40, 0xe600, 0, buf, 1,
-	     300) != 1) {
+	ret = usb_control_msg_send(dev, 0, 0xa0, 0x40, 0xe600,
+				   0, &buf, 1, 300, GFP_KERNEL);
+	if (ret != 0) {
 		printk(KERN_ERR
-		       "Failed to initialise isight firmware loader\n");
+			"Failed to initialise isight firmware loader\n");
 		ret = -ENODEV;
 		goto out;
 	}
@@ -82,15 +79,15 @@ static int isight_firmware_load(struct usb_interface *intf,
 				ret = -ENODEV;
 				goto out;
 			}
-			memcpy(buf, ptr, llen);
+			memcpy(&buf, ptr, llen);
 
 			ptr += llen;
 
-			if (usb_control_msg
-			    (dev, usb_sndctrlpipe(dev, 0), 0xa0, 0x40, req, 0,
-			     buf, llen, 300) != llen) {
+			ret = usb_control_msg_send(dev, 0, 0xa0, 0x40, req, 0,
+						   &buf, llen, 300, GFP_KERNEL);
+			if (ret != 0) {
 				printk(KERN_ERR
-				       "Failed to load isight firmware\n");
+					"Failed to load isight firmware\n");
 				ret = -ENODEV;
 				goto out;
 			}
@@ -99,15 +96,14 @@ static int isight_firmware_load(struct usb_interface *intf,
 	}
 
 	buf[0] = 0x00;
-	if (usb_control_msg
-	    (dev, usb_sndctrlpipe(dev, 0), 0xa0, 0x40, 0xe600, 0, buf, 1,
-	     300) != 1) {
+	ret = usb_control_msg_send(dev, 0, 0xa0, 0x40, 0xe600,
+				   0, &buf, 1, 300, GFP_KERNEL);
+	if (ret != 0) {
 		printk(KERN_ERR "isight firmware loading completion failed\n");
 		ret = -ENODEV;
 	}
 
 out:
-	kfree(buf);
 	release_firmware(firmware);
 	return ret;
 }
-- 
2.25.1

