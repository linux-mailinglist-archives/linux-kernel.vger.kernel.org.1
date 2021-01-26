Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348C9304EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404946AbhA0Bab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394767AbhAZSfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:35:38 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E250AC061756;
        Tue, 26 Jan 2021 10:34:57 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id q2so7484423plk.4;
        Tue, 26 Jan 2021 10:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OR9wVz2vxGr4uGs0aRUSPWq5Qs/Y5o7RNeRWhP0NrZ0=;
        b=bx7/Of/QgmIIlJDhv2cIBDHcAMgF2psnNmkAvZ6KbKf80bcchoKgJX3ZDVUNhf5w3r
         ZSGqDJh2MBJo0oc9E54zWqgaYh8qFRHXV9kSe7uts1BOck7A+8/oWE+vLvH2f1Gvupo6
         SYOamguevR5Gp3w2Utkivq8XP24pIM3+tQib/1JERwyfbfwda8KjARJoLiAw0qgZUptT
         EL5H2QSsrn03tgP/YvO3q6ae/NEDMGVuOlj1fB+CvZVTOTjy9BOuVNy654DmlrAXB7yS
         VN/WA+/DsX47GvvlTWG8xt19RJ0BSxBjLSIVm5W3xBFu4bTxuUuwKWAwFMGAh0/W+BXY
         fUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OR9wVz2vxGr4uGs0aRUSPWq5Qs/Y5o7RNeRWhP0NrZ0=;
        b=CsiXiJUKp+yM7m3lZvKUI4Z31i5D6tLr/4iVXwk43UqSqR1MtoMXmsGm8VE5yXvJW4
         TXgqJEyHQvHpfAlhKMx6FbVInbOZw3ZPvNl0/7iB1RZWF8TsNJUu3/Of59+DYBJJZiHQ
         tMjzzljbp9v2/ixFtRvyYJFnQfpkq3/OfKQP3JFn5FFHy6M9XqMKmyYmmexSkotsRS8M
         3gsO1LyfN7dHt+rwUt503oga6BYZk+A6Ty3hDja3vv51DDFxWv7poj8AZy+BW0Jh2eKV
         S0x0PIA5U3709BkIGSBdGkWS8GTPjMY33Elp5KUEpe9pN8NKsdg/+SLb4FCQB+9NDCpE
         9oiw==
X-Gm-Message-State: AOAM530Gx2eaDRUEtCxUAd3FjdBGF+UvcEHXbsyFiUssHltagierPIdH
        0O798ueAQxqnQSxaXoGNC3uhU/rwPUw/0eZVMOw=
X-Google-Smtp-Source: ABdhPJwigx9Ufx12ORwvqE9EwFeEjggnfZabvy73Op19avx0lbykcm49Yndao87OO0FjgGbMT5/2CQ==
X-Received: by 2002:a17:90a:a508:: with SMTP id a8mr1146415pjq.75.1611686097307;
        Tue, 26 Jan 2021 10:34:57 -0800 (PST)
Received: from localhost.localdomain ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id y75sm472711pfg.119.2021.01.26.10.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:34:56 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/12] usb: misc: cypress_cy7c63: update to use usb_control_msg_recv()
Date:   Wed, 27 Jan 2021 00:03:53 +0530
Message-Id: <20210126183403.911653-3-anant.thazhemadam@gmail.com>
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
For this reason, the instance of usb_control_msg() has been replaced with
usb_control_msg_recv().

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/cypress_cy7c63.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/misc/cypress_cy7c63.c b/drivers/usb/misc/cypress_cy7c63.c
index 14faec51d7a5..76a320ef17a7 100644
--- a/drivers/usb/misc/cypress_cy7c63.c
+++ b/drivers/usb/misc/cypress_cy7c63.c
@@ -70,24 +70,15 @@ static int vendor_command(struct cypress *dev, unsigned char request,
 			  unsigned char address, unsigned char data)
 {
 	int retval = 0;
-	unsigned int pipe;
-	unsigned char *iobuf;
-
-	/* allocate some memory for the i/o buffer*/
-	iobuf = kzalloc(CYPRESS_MAX_REQSIZE, GFP_KERNEL);
-	if (!iobuf) {
-		retval = -ENOMEM;
-		goto error;
-	}
+	u8 iobuf[CYPRESS_MAX_REQSIZE] = {0};
 
 	dev_dbg(&dev->udev->dev, "Sending usb_control_msg (data: %d)\n", data);
 
 	/* prepare usb control message and send it upstream */
-	pipe = usb_rcvctrlpipe(dev->udev, 0);
-	retval = usb_control_msg(dev->udev, pipe, request,
-				 USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-				 address, data, iobuf, CYPRESS_MAX_REQSIZE,
-				 USB_CTRL_GET_TIMEOUT);
+	retval = usb_control_msg_recv(dev->udev, 0, request,
+				      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+				      address, data, &iobuf, CYPRESS_MAX_REQSIZE,
+				      USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
 
 	/* store returned data (more READs to be added) */
 	switch (request) {
@@ -107,8 +98,6 @@ static int vendor_command(struct cypress *dev, unsigned char request,
 			break;
 	}
 
-	kfree(iobuf);
-error:
 	return retval;
 }
 
-- 
2.25.1

