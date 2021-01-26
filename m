Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EE4304EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405035AbhA0BcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394789AbhAZSgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:36:01 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D827DC061786;
        Tue, 26 Jan 2021 10:35:20 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u11so10222004plg.13;
        Tue, 26 Jan 2021 10:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rlm5PUymFHRx39FCcGjfRRBHQ3f0wd7qTZT6jsgLwkA=;
        b=pldzPP87+IAjdQFo5gB4mTAxJDiykolSRf9RJD1R29q+gjloKdScXFVNudyO2fzqLd
         pKGc4a8CbMMLXXFffBakorBGXvFI86RZ4j54HqOtEntkoiiBUjp223sTRA+iSmxpftjA
         xLKf34yLq+7cgACxqGLUK7nVpQDDrtZcgzdz8ppQTvf0MLoYNkD0fbs+XTrLz9qVo9Uv
         4qRfAPcsocDP0VYL6DYm6hCQRQJpXlLUOJb1Bk9mKW21y4Py/bP4/h9mJPrlQJXqurAH
         qBOlxTdCrH6skMWJ5s4Ix/QoYqGxilFFEXgDpfGN+vcQUZf8M/B+T0PE8QCqCkIB0p5+
         9i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rlm5PUymFHRx39FCcGjfRRBHQ3f0wd7qTZT6jsgLwkA=;
        b=d9F0KGX3HtxxiydluBJ9QGcKZa2a3ZOlng1+IFzPP3tAw//6spQAhEknBwgfzApfX/
         sD/0KIVldUwq9b7T1opzraPqlhopK+LbNmEWzr6OfT1Vtxfl0Ekh1U4/ETkS+nlEg0JI
         nX6mhC5gaP0WqyMMaL9MoBF018/+qXoxOauBZu3cWiF2/SrNAsCOSLisx8ZArISXt4Ls
         zlmvF8tOTZ6yaAs5TXLyrdEEb1J+gAEU24IDdopEjzysP4VCtZqRbmC2MfWM02bmU0Dn
         8bg4dJ/kWX6UgKbuHOlclYpSnJdje0QxIYt5OqGgXVBbuzzEZOXRiSmemq5upC/4KquI
         rlbA==
X-Gm-Message-State: AOAM531YqJHyzE8f1SdbuK2LbYQs1pulML/sx9wuo4DvL7KV6waHkn44
        56KC+2g0/Gv4qrJTt7xXSrE=
X-Google-Smtp-Source: ABdhPJx3PTeB+SUcDOUGdw45AWK8WChpigGSoWVxOGNYaACq2CBMS5O81epaga9lJRTIOjl3cqyexg==
X-Received: by 2002:a17:90b:4a4d:: with SMTP id lb13mr1164903pjb.44.1611686120413;
        Tue, 26 Jan 2021 10:35:20 -0800 (PST)
Received: from localhost.localdomain ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id y75sm472711pfg.119.2021.01.26.10.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:35:19 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/12] usb: misc: ezusb: update to use usb_control_msg_send()
Date:   Wed, 27 Jan 2021 00:03:56 +0530
Message-Id: <20210126183403.911653-6-anant.thazhemadam@gmail.com>
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
usb_control_msg_send() appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/ezusb.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/misc/ezusb.c b/drivers/usb/misc/ezusb.c
index f058d8029761..78aaee56c2b7 100644
--- a/drivers/usb/misc/ezusb.c
+++ b/drivers/usb/misc/ezusb.c
@@ -31,24 +31,12 @@ static const struct ezusb_fx_type ezusb_fx1 = {
 static int ezusb_writememory(struct usb_device *dev, int address,
 				unsigned char *data, int length, __u8 request)
 {
-	int result;
-	unsigned char *transfer_buffer;
-
 	if (!dev)
 		return -ENODEV;
 
-	transfer_buffer = kmemdup(data, length, GFP_KERNEL);
-	if (!transfer_buffer) {
-		dev_err(&dev->dev, "%s - kmalloc(%d) failed.\n",
-							__func__, length);
-		return -ENOMEM;
-	}
-	result = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), request,
+	return usb_control_msg_send(dev, 0, request,
 				 USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				 address, 0, transfer_buffer, length, 3000);
-
-	kfree(transfer_buffer);
-	return result;
+				 address, 0, data, length, 3000, GFP_KERNEL);
 }
 
 static int ezusb_set_reset(struct usb_device *dev, unsigned short cpucs_reg,
-- 
2.25.1

