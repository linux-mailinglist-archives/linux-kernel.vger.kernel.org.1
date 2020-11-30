Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26742C7C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgK3Bcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgK3Bcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:32:35 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB48BC0613CF;
        Sun, 29 Nov 2020 17:31:54 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id y7so9364073pfq.11;
        Sun, 29 Nov 2020 17:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04c9BxYa1Ymi07bLwZCgG59VbrDPFBxGmQMOZz4mzls=;
        b=K4/211RPyH8AC68ON0DQNEbKbkXoSOGzSBPdICQr7PmW5l1mASVK+NtY/l9bx0jVct
         HsMeh8tqjINe/UZIj41aZCIeoAxXWJ+3vWE3h03Acb2JUy8ZGtvCJAiasw4oe+v8GUAz
         4bcddyq/QMmUQYduArGCAeMS6nZhaIy3JCWod9uTlStJAJYJGn6tCOzxTaIbWq8MTJaU
         ts6J9IVHJS/xqwCfOSFh9MozfYHp5xdeF/xtZ3UAYIld/Tec3PmdQVXOWBKaxchIOG10
         es0CUMVrwZbiDnZ3LVQzflO5OCjNdYESn6tRBsm7TUUgkCVynN977iysXuSQYkzzqOo/
         uUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04c9BxYa1Ymi07bLwZCgG59VbrDPFBxGmQMOZz4mzls=;
        b=KLijA0/5S+YsxomxrUzPQvKYu2JOSF9J8JxgFUxDjP+CLR3WY2mMDvUD2J9dTkRBv0
         v8kpPluEcYejbDFzqjGmzS8jo3QQaIdSmwd4kbi1T+s+tYxKtHKRjQUdMvO2OiF+cY37
         bcZNVV/bR8jran1RJcjH7vws0CLMuGazIhjmGdZKPOIb/BwQjqb9GFBIo1pDXmxCzwu8
         RtjJMVwowbdEnxO9CRAlRtRdfPk+MkjMCjoNJd/yAuPlKUOt9Zo0AlZTQKhtk6S6AccC
         8QrzwXWsal96bey8nes5456mXY00VzJCig43Z//yHbN2ADHzg/HlNFov/Go2Q0t8U3V3
         KRTw==
X-Gm-Message-State: AOAM531V844RB1NYgmPZxAgA9nTesozmi6z0YZK0m7sHErY4jAoWVmA6
        7IxPIUPmQo4yLa+2CXYtC/U=
X-Google-Smtp-Source: ABdhPJxM7H+CT4jARvaYn0bcnsLdxdmO6/Z5uIdDPaOCOchLBN7hcQTv+G4anBoZdpOzLNbq40c4iA==
X-Received: by 2002:a63:344a:: with SMTP id b71mr15476454pga.146.1606699914442;
        Sun, 29 Nov 2020 17:31:54 -0800 (PST)
Received: from localhost.localdomain ([49.207.197.72])
        by smtp.gmail.com with ESMTPSA id m73sm14641550pfd.106.2020.11.29.17.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:31:53 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/15] usb: misc: isight_firmware: update to use usb_control_msg_send()
Date:   Mon, 30 Nov 2020 07:01:44 +0530
Message-Id: <20201130013144.2580664-1-anant.thazhemadam@gmail.com>
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

