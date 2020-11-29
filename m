Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B472C79D8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgK2QHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2QHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:07:33 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B03C0613D3;
        Sun, 29 Nov 2020 08:06:47 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e23so3552698pgk.12;
        Sun, 29 Nov 2020 08:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OeM4m0IbwLytr9GIwsSVrv4uTq97qX9ObS/vezts+wA=;
        b=koTRXhfp+w/oxoWlk2B7qlb5CWzYoIg0/DiGgGrnuPiI1oHCG7nx8r9Askn+kTjMUq
         zAYrp4yOjaUcik+XT+jVI8/ZaR2zA2DBQHC5QEyS2D+eSo4+QHV92WYsyv8pMCyczK3Q
         R000j/Eo7NpCWWKT3ZRg2vf/MgZGoViHOTHJq5FL20WARaX9ruFaOX1IL0u0nGOiaXVy
         bWTZRjvy18tiYWkVdkDInJftzcJigMkRcamU/7Slt6zTD5Od2PTogcFwbfFp3KK6YCUQ
         wrpvn5oCUIu4cL7kHWd8MJEcRVj5QYZe851CD9wQh889JQ7l7krYkPqJSB1CJ4kmcpv/
         cd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OeM4m0IbwLytr9GIwsSVrv4uTq97qX9ObS/vezts+wA=;
        b=SgJlDmvMqAonPW3DdSsFuMBu2Y5SSkfy5P7aLNz5dc+33PDfrHRRAyOIWmTuRiBIpK
         QzEr5+hYN0y/4LKcDioVX9GXEeo+SSyrwEfX8xkhoUQyGNsmk1VqXdy98llpyGhYbdRK
         EbBzbHqyC7PKPmiXhdNccXNZepnHfXMiw0QSt/4CzWvLo77U1h7LUp61JHcZdMi+RWCR
         wCli/ccXMVJ1zrhN0T/MT0CH/pCNOCtza3P35uNMDCBY+D3NTbmq0j2UYBpw2m/CBGg1
         XTtAf6V6KaQbsc9bNkepWsYCewVo437OLx/ZJV2K/xWm8l9898iQNVjjhNUhwqNwHzba
         FIjQ==
X-Gm-Message-State: AOAM531rKmjSXdcj52SihMKp6p18QE8zHiBhIBOeatrGpNj5T3hhP+5i
        QN5tyLHhcTX/LE08YbFNLi8=
X-Google-Smtp-Source: ABdhPJyd8GjBeevYOY520PSK5ccsCHlRJGEKNQDIzy+WLi4ZI5Go/T5hjdkXY0P5RBNHK9lZSXshKQ==
X-Received: by 2002:a63:4743:: with SMTP id w3mr14261697pgk.147.1606666007385;
        Sun, 29 Nov 2020 08:06:47 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:06:46 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] usb: misc: cypress_cy7c63: update to use usb_control_msg_recv()
Date:   Sun, 29 Nov 2020 21:35:59 +0530
Message-Id: <20201129160612.1908074-3-anant.thazhemadam@gmail.com>
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
For this reason, the instance of usb_control_msg() has been replaced with
usb_control_msg_recv().

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/cypress_cy7c63.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/misc/cypress_cy7c63.c b/drivers/usb/misc/cypress_cy7c63.c
index 14faec51d7a5..fc09251fc87c 100644
--- a/drivers/usb/misc/cypress_cy7c63.c
+++ b/drivers/usb/misc/cypress_cy7c63.c
@@ -70,7 +70,6 @@ static int vendor_command(struct cypress *dev, unsigned char request,
 			  unsigned char address, unsigned char data)
 {
 	int retval = 0;
-	unsigned int pipe;
 	unsigned char *iobuf;
 
 	/* allocate some memory for the i/o buffer*/
@@ -83,11 +82,10 @@ static int vendor_command(struct cypress *dev, unsigned char request,
 	dev_dbg(&dev->udev->dev, "Sending usb_control_msg (data: %d)\n", data);
 
 	/* prepare usb control message and send it upstream */
-	pipe = usb_rcvctrlpipe(dev->udev, 0);
-	retval = usb_control_msg(dev->udev, pipe, request,
-				 USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-				 address, data, iobuf, CYPRESS_MAX_REQSIZE,
-				 USB_CTRL_GET_TIMEOUT);
+	retval = usb_control_msg_recv(dev->udev, 0, request,
+				      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+				      address, data, iobuf, CYPRESS_MAX_REQSIZE,
+				      USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
 
 	/* store returned data (more READs to be added) */
 	switch (request) {
-- 
2.25.1

