Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D364E2C7C73
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgK3Beu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgK3Bet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:34:49 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166BBC0613CF;
        Sun, 29 Nov 2020 17:34:09 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id t12so326481pjq.5;
        Sun, 29 Nov 2020 17:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idqo+EX1CIZxF2ePxyjSJLOfFZLABQRqNBSPoIAo4yo=;
        b=LSQtjKIL9N+y42WJmEkfId0H0TuLAQBIKgpzcKrj7BWehMRwb6c5LHIzQWjDw/SaDs
         pjf4BANMBsuP07I5wkJ5lgO2f1FL4iYfFICwdDZmUGgeQ9yCxQbcJ1mHz/3l1Csh13gV
         cCYQqP+IgfeyL4Y/mwkZoAacTXBCb2NJLMxZhBNaRyhe1QhwZPNRlO3X1AIwaBUKfryJ
         xOENVfrSC6myp5lxPZBF5hmmyf1VEuWX3jk1BKY6oZ6ho55fXhHxj64ytKk3OqLdtmgN
         eiMnhd3+OeOMSKc6r11LBt+ijQXEoFA8UWbap6tzms8n4b5HJr2mIhaFhlfsZOlnWS3L
         Sx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idqo+EX1CIZxF2ePxyjSJLOfFZLABQRqNBSPoIAo4yo=;
        b=CwaHRWYJCkzifHr3Ey83Zj95dclTwtkDdP/9WABBbcKYXE7ZltzHkRaZLUUSIC1iXI
         aZjwn0qsl7rGcU95VyZ2NYXnqGvFqggKO1zOlmv36wuIoflRiZmcELC1becbHQViAShn
         +GrD/vIbJEZ9hMdHSuuV7B9LVyvbJHkQmeYZIJ4Y0Jm+DNCEsJsuIkQ/vED6UMDntdU6
         FzrtUbqdOsedwHBvbTO1H1w1o0QZjoTsKFe4GdVGK4f0uE0F6fQgxFWX5iFARll0gtPX
         1s2DnlcKOQ9kUJxcL9ELJRpwaN12UyoB2k3iRTi6cpfdGv6yHHpCNFxgFI+QVfIJVTus
         ec+Q==
X-Gm-Message-State: AOAM533PlmQOK1R2MlD0+1QpaIfgKcDuES8Eaz5hn28u6MLkGnCpL4sQ
        YnrebyNgFlLWCRsQ4ve9M68=
X-Google-Smtp-Source: ABdhPJyLnQKJcGFYvO7G03Zk5SDRh6FQd/SBrNNmUiLivQYLaPkY/T85NZryYuH2MT3eX2X1H0xbYg==
X-Received: by 2002:a17:90b:614:: with SMTP id gb20mr10130027pjb.34.1606700048506;
        Sun, 29 Nov 2020 17:34:08 -0800 (PST)
Received: from localhost.localdomain ([49.207.197.72])
        by smtp.gmail.com with ESMTPSA id v6sm14916071pgk.2.2020.11.29.17.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:34:07 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/15] usb: misc: usbsevseg: update to use usb_control_msg_send()
Date:   Mon, 30 Nov 2020 07:03:58 +0530
Message-Id: <20201130013358.2581796-1-anant.thazhemadam@gmail.com>
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

