Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90C02C79E8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbgK2QIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbgK2QIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:08:14 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE00C0613CF;
        Sun, 29 Nov 2020 08:07:14 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id b6so8722117pfp.7;
        Sun, 29 Nov 2020 08:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgdeRrn/rBQnDRJ3mL6h7kSEUvCqL6QpWixhCtowYGU=;
        b=qr+FI5l194+d+QM2vNdpKDJu5l5aSlTiazCzx9nRfePYryhUbJGMJdxF+STdfR+y8I
         eL8z3JQdPNh75TwgYsYKQpMHeNOMzoHWgG0/y9eF2qwd6md9QnewGv+Rez5Firj5iqaL
         ttQMv2nc3Me95DZkWeftQUM67bNtGJB2nuzB7tOVVz8BYbfrlT+sNpYHeci6rwQMlisj
         APBbZNrVNLJcxLfRILXqRihz09riJVhD+u6QKTbwwkV/a9ASrqrbOitYpiR5HyJd0NIN
         HJ84lWM2SrAr8G19o2gbNQ2xKA1y6duFuEkaDf/GFTCz+Xq/dGh4cXyvrMOegn1hQYSI
         JvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgdeRrn/rBQnDRJ3mL6h7kSEUvCqL6QpWixhCtowYGU=;
        b=CtfladR8A795EqX7El89g6YqZhNaEC4aPnYXg1CbMEhb3X4ydH6JiCL8NB268dHMP2
         Bm98Pmlb/1TrkSMaCGa0xCDm0FODsCtq0NihlxmmkQhahFMJ4NJY57t6qTDvESOghKaP
         tCKXQcXNAub2yiXEWyh32z1dJ6IRsYWNKfm6HNglgibnkjIKBKutzqaBV4ZumX3fKjtf
         o2Bu07E36Y/X1b1LYc/mcPy5icY0SzViAg0zQZ9x1A+PN6GTum/NTphkymQn5gfUv5ha
         e55o+4Ykua4qS30j/NMuUQssg02JlhB7LqQ3btddEHQP/pjEU8QdosXJyq/O6GNcv87n
         fUMQ==
X-Gm-Message-State: AOAM532pumUA3exr4KkHQkpMt5T+ZEGb2DI56Zhk28CbdKQdmmT+AvsS
        ITqHSeqKUC53EXKO0GA+SHk=
X-Google-Smtp-Source: ABdhPJz7v8pqOW8HbAt4OAC8CJIPaQr22L2+ae0oPP67b13Heqip3VN/9OBZhY8k6g10Rc9FEbsKrQ==
X-Received: by 2002:a17:90a:fcc:: with SMTP id 70mr8498192pjz.168.1606666034208;
        Sun, 29 Nov 2020 08:07:14 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:07:13 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] usb: misc: isight_firmware: update to use usb_control_msg_send()
Date:   Sun, 29 Nov 2020 21:36:07 +0530
Message-Id: <20201129160612.1908074-11-anant.thazhemadam@gmail.com>
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
For this reason, the instances of usb_control_msg() have been replaced with
usb_control_msg_send(), and return value checking has also been
appropriately enforced.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/isight_firmware.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/misc/isight_firmware.c b/drivers/usb/misc/isight_firmware.c
index 4d30095d6ad2..d3fa6fa81e6c 100644
--- a/drivers/usb/misc/isight_firmware.c
+++ b/drivers/usb/misc/isight_firmware.c
@@ -53,11 +53,11 @@ static int isight_firmware_load(struct usb_interface *intf,
 	ptr = firmware->data;
 
 	buf[0] = 0x01;
-	if (usb_control_msg
-	    (dev, usb_sndctrlpipe(dev, 0), 0xa0, 0x40, 0xe600, 0, buf, 1,
-	     300) != 1) {
+	ret = usb_control_msg_send(dev, 0, 0xa0, 0x40, 0xe600,
+				   0, buf, 1, 300, GFP_KERNEL);
+	if (ret != 0) {
 		printk(KERN_ERR
-		       "Failed to initialise isight firmware loader\n");
+			"Failed to initialise isight firmware loader\n");
 		ret = -ENODEV;
 		goto out;
 	}
@@ -86,11 +86,11 @@ static int isight_firmware_load(struct usb_interface *intf,
 
 			ptr += llen;
 
-			if (usb_control_msg
-			    (dev, usb_sndctrlpipe(dev, 0), 0xa0, 0x40, req, 0,
-			     buf, llen, 300) != llen) {
+			ret = usb_control_msg_send(dev, 0, 0xa0, 0x40, req, 0,
+						   buf, llen, 300, GFP_KERNEL);
+			if (ret != 0) {
 				printk(KERN_ERR
-				       "Failed to load isight firmware\n");
+					"Failed to load isight firmware\n");
 				ret = -ENODEV;
 				goto out;
 			}
@@ -99,9 +99,9 @@ static int isight_firmware_load(struct usb_interface *intf,
 	}
 
 	buf[0] = 0x00;
-	if (usb_control_msg
-	    (dev, usb_sndctrlpipe(dev, 0), 0xa0, 0x40, 0xe600, 0, buf, 1,
-	     300) != 1) {
+	ret = usb_control_msg_send(dev, 0, 0xa0, 0x40, 0xe600,
+				   0, buf, 1, 300, GFP_KERNEL);
+	if (ret != 0) {
 		printk(KERN_ERR "isight firmware loading completion failed\n");
 		ret = -ENODEV;
 	}
-- 
2.25.1

