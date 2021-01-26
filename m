Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E678E304F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392252AbhA0Bkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391515AbhAZSlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:41:18 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B6EC0613ED;
        Tue, 26 Jan 2021 10:40:37 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 11so10953621pfu.4;
        Tue, 26 Jan 2021 10:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idqo+EX1CIZxF2ePxyjSJLOfFZLABQRqNBSPoIAo4yo=;
        b=JSjq6hw/4Q+OJ/8jKFtDDBalwqLAyr72EP5vqQPoaXDN1Tcd2WYE/XfM/GgHMddqV3
         JRfFdcrEfnmpSgxM0dW/mnVsEZKgzfzk+QRtfYSVruEJY+EeabHSpqqT/kJdmWgbSWZw
         Rt83Wbit9FA5fK1BoFwGadywKsLjnmthQvEsMEg2pDnxAbVT5FnZXKUlHn5JGe+smGU+
         gN6hDLHxvw5EXhEJS+JqELHsMtSs3skNrqC16RX+sRYkDHATONFBJ5EVGliZ+b5rbWnc
         HzUstc4Q1aeLoEFgo4TmuRLiZjyc4lv5x9ISPQBwqT0u8hh0YpgXiNIB8IgXTAP29lti
         GI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idqo+EX1CIZxF2ePxyjSJLOfFZLABQRqNBSPoIAo4yo=;
        b=mpL4eOjT7p3PYb+z+g/6SRAeYXV40f1j+QPJqXKeiU9De9NlJBdEfQbLH+bR5GebiF
         4wA4aScOMapIqZI2XItzG7RU6ffEZmeLil4g4EE8LvtrIUxTCEgGpjOajRFY4b5qNTI5
         H/ECNKqKy54TmkdQGtpI2sFyP/5IFWU2BjABDjuFoDP1HxImLc8m31kh2gr3dFDTvg/G
         bCDJ3JgUXnqGWN+Sa183AtHcjPTV9HbwpvotiZ70t1vsyGsSrovTjauue0rIE2gu0ur2
         fDLfJ2qzM1wIqDj8OlNwLy7SLV9DpSDPDgd+Ggq69q3bKnhdtNzGZNEAhL2UuLVVCKti
         DshQ==
X-Gm-Message-State: AOAM533QEGFPIv48ebwLoAhPWx+eR/mH6watQNJ0W4VQ1J1fr9ltTO+0
        6yQYP6EgMXVF9mGkThs3E7fXgn5ua8jOoHyehGY=
X-Google-Smtp-Source: ABdhPJxDolp46jsFpRwvuw8qL2oRbxyvF6axLE8GV8jw0vSIKJitluA9VEC1CLfRF7qU3rrcI0/EpA==
X-Received: by 2002:a63:ce42:: with SMTP id r2mr7042705pgi.8.1611686437369;
        Tue, 26 Jan 2021 10:40:37 -0800 (PST)
Received: from localhost.localdomain ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id q17sm14003682pfl.143.2021.01.26.10.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:40:36 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/12] usb: misc: usbsevseg: update to use usb_control_msg_send()
Date:   Wed, 27 Jan 2021 00:10:30 +0530
Message-Id: <20210126184030.915039-1-anant.thazhemadam@gmail.com>
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
usb_control_msg_send() appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/usbsevseg.c | 60 ++++++++++--------------------------
 1 file changed, 17 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/misc/usbsevseg.c b/drivers/usb/misc/usbsevseg.c
index 551074f5b7ad..ade4bc58d5f2 100644
--- a/drivers/usb/misc/usbsevseg.c
+++ b/drivers/usb/misc/usbsevseg.c
@@ -74,15 +74,10 @@ static void update_display_powered(struct usb_sevsegdev *mydev)
 	if (mydev->shadow_power != 1)
 		return;
 
-	rc = usb_control_msg(mydev->udev,
-			usb_sndctrlpipe(mydev->udev, 0),
-			0x12,
-			0x48,
-			(80 * 0x100) + 10, /*  (power mode) */
-			(0x00 * 0x100) + (mydev->powered ? 1 : 0),
-			NULL,
-			0,
-			2000);
+	rc = usb_control_msg_send(mydev->udev, 0, 0x12, 0x48,
+				  (80 * 0x100) + 10, /*  (power mode) */
+				  (0x00 * 0x100) + (mydev->powered ? 1 : 0),
+				  NULL, 0, 2000, GFP_KERNEL);
 	if (rc < 0)
 		dev_dbg(&mydev->udev->dev, "power retval = %d\n", rc);
 
@@ -99,15 +94,10 @@ static void update_display_mode(struct usb_sevsegdev *mydev)
 	if(mydev->shadow_power != 1)
 		return;
 
-	rc = usb_control_msg(mydev->udev,
-			usb_sndctrlpipe(mydev->udev, 0),
-			0x12,
-			0x48,
-			(82 * 0x100) + 10, /* (set mode) */
-			(mydev->mode_msb * 0x100) + mydev->mode_lsb,
-			NULL,
-			0,
-			2000);
+	rc = usb_control_msg_send(mydev->udev, 0, 0x12, 0x48,
+				  (82 * 0x100) + 10, /* (set mode) */
+				  (mydev->mode_msb * 0x100) + mydev->mode_lsb,
+				  NULL, 0, 2000, GFP_KERNEL);
 
 	if (rc < 0)
 		dev_dbg(&mydev->udev->dev, "mode retval = %d\n", rc);
@@ -117,48 +107,32 @@ static void update_display_visual(struct usb_sevsegdev *mydev, gfp_t mf)
 {
 	int rc;
 	int i;
-	unsigned char *buffer;
+	unsigned char buffer[MAXLEN] = {0};
 	u8 decimals = 0;
 
 	if(mydev->shadow_power != 1)
 		return;
 
-	buffer = kzalloc(MAXLEN, mf);
-	if (!buffer)
-		return;
-
 	/* The device is right to left, where as you write left to right */
 	for (i = 0; i < mydev->textlength; i++)
 		buffer[i] = mydev->text[mydev->textlength-1-i];
 
-	rc = usb_control_msg(mydev->udev,
-			usb_sndctrlpipe(mydev->udev, 0),
-			0x12,
-			0x48,
-			(85 * 0x100) + 10, /* (write text) */
-			(0 * 0x100) + mydev->textmode, /* mode  */
-			buffer,
-			mydev->textlength,
-			2000);
+	rc = usb_control_msg_send(mydev->udev, 0, 0x12, 0x48,
+				  (85 * 0x100) + 10, /* (write text) */
+				  (0 * 0x100) + mydev->textmode, /* mode  */
+				  &buffer, mydev->textlength, 2000, mf);
 
 	if (rc < 0)
 		dev_dbg(&mydev->udev->dev, "write retval = %d\n", rc);
 
-	kfree(buffer);
-
 	/* The device is right to left, where as you write left to right */
 	for (i = 0; i < sizeof(mydev->decimals); i++)
 		decimals |= mydev->decimals[i] << i;
 
-	rc = usb_control_msg(mydev->udev,
-			usb_sndctrlpipe(mydev->udev, 0),
-			0x12,
-			0x48,
-			(86 * 0x100) + 10, /* (set decimal) */
-			(0 * 0x100) + decimals, /* decimals */
-			NULL,
-			0,
-			2000);
+	rc = usb_control_msg_send(mydev->udev, 0, 0x12, 0x48,
+				  (86 * 0x100) + 10, /* (set decimal) */
+				  (0 * 0x100) + decimals, /* decimals */
+				  NULL, 0, 2000, mf);
 
 	if (rc < 0)
 		dev_dbg(&mydev->udev->dev, "decimal retval = %d\n", rc);
-- 
2.25.1

