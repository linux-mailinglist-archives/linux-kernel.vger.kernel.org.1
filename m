Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C8F2C79E3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbgK2QIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387408AbgK2QII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:08:08 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891C1C0613D2;
        Sun, 29 Nov 2020 08:07:27 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id k11so8425270pgq.2;
        Sun, 29 Nov 2020 08:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJaJ+n9dxBN9XvisaJB9i6SIdnN8VB9cyAZ8b/vmHqM=;
        b=uTtCl40EyY1q+sS4wPaENTllPz8QahDq5kyaxqJZPeeFZMW8yonUWc3I0ncT8Dfwae
         e0hAy1KUVOM4Uq+P9TZc9bD47P45KF55hyVmhHNUAodsFpJwW89ciuoyg2o4dq9a9TVj
         DAxMiPssZFn1GZiWcH/2SqGbhXiep5Z7wW553blUMFcA2bsjdphMfgjFNemM2HYwj4eM
         CiY3nKbuIwA1Hjfdjp5oZK9lr8XSeyB59H3kfcGWAg02q91AWfKJkf48hgpFl5ybOIAR
         w0uLsWh++9BaYeewOptPmoDgPzS1WJvRWSOqMbmWR53GB077sRVTo1G7e00A5q/WbYLm
         GcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJaJ+n9dxBN9XvisaJB9i6SIdnN8VB9cyAZ8b/vmHqM=;
        b=TnOaI/hNLxgZiBuVpJfEgt10adhi6hME5hQJAYLJQpLkIc41iqLdvqOOBpCjGnhGxx
         BK6IX8g9blGmXeKuBK0IviUSCdnqAmOgrLTSpHh6XDZrH0Njm104i/weJVbOpQyuL4lo
         cxhPy/nhA0AuBaIW+/cQBj//bRVwQraKf7Y898zPWSJzv7qqvFDItZexYQxjAl2/TXTT
         Er7vIrC6NSgMgiY/+ZnXGu56B/nKlQY4f0gkvQzdUFKsB43rmDNO4ivngatToVrENC8T
         LJ0Lk/PbsvSQRzo5/Yl4B4mexvVZ8280oGmQ+udfKQKUd2EHXBiC/PgCF5mI4jy5RuyZ
         qA5g==
X-Gm-Message-State: AOAM530SK/6CJloFvxSEFTwCs/eyftyCFcDX6H04Ti5wSNShxiY744n8
        ejPsZ2nLJ2llUdPDa25rpCo=
X-Google-Smtp-Source: ABdhPJyp3LW5aJBiIXX0HT3urNa6kc/g2TQ4lDrB7freuZHcjFOqyQblfvRa7mWUpBdwAQTgYxauHw==
X-Received: by 2002:a17:90a:e610:: with SMTP id j16mr3172079pjy.170.1606666047040;
        Sun, 29 Nov 2020 08:07:27 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:07:26 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] usb: misc: usbsevseg: update to use usb_control_msg_send()
Date:   Sun, 29 Nov 2020 21:36:11 +0530
Message-Id: <20201129160612.1908074-15-anant.thazhemadam@gmail.com>
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
usb_control_msg_send() appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/usbsevseg.c | 52 +++++++++++-------------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/misc/usbsevseg.c b/drivers/usb/misc/usbsevseg.c
index 551074f5b7ad..f0f6728a8b54 100644
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
@@ -131,15 +121,10 @@ static void update_display_visual(struct usb_sevsegdev *mydev, gfp_t mf)
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
+				  buffer, mydev->textlength, 2000, GFP_KERNEL);
 
 	if (rc < 0)
 		dev_dbg(&mydev->udev->dev, "write retval = %d\n", rc);
@@ -150,15 +135,10 @@ static void update_display_visual(struct usb_sevsegdev *mydev, gfp_t mf)
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
+				  NULL, 0, 2000, GFP_KERNEL);
 
 	if (rc < 0)
 		dev_dbg(&mydev->udev->dev, "decimal retval = %d\n", rc);
-- 
2.25.1

