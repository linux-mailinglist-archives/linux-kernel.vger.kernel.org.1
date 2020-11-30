Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBE62C7C64
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgK3Bam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgK3Bal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:30:41 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE4AC0613D2;
        Sun, 29 Nov 2020 17:30:01 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id r20so288875pjp.1;
        Sun, 29 Nov 2020 17:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rlm5PUymFHRx39FCcGjfRRBHQ3f0wd7qTZT6jsgLwkA=;
        b=JzrdzN27W7cLCCdg2aMntMtj//R/354K+/dW4g6ZP/qiMxzVMJCK0crSVzz4mfEJhp
         UTdriCCD+3CKFQPaSdImgxWkq0KCvCN0F989zwlXJaTdXJOioJg4I+ZMimHW52PRWCvl
         QaXUzcHoqdXh6jZcGt2xpJEhCw1wxVaHNStTx1r5D/1RwDpNOfGlpEZwQYdxgCe2P2Z9
         sI2tEDnQ3H1niW5JzF/F4f2ZO2uxLJ7acZEzoz1/57v5LpcDgXM8Xu4N+5ol2N2CK0/3
         JnCjqaaY+SH+IEuBtyV4BNUr/tGUG2yYneirpls4I/aBIzfyUApbXm6Y8wlqJEgWkOvC
         6Rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rlm5PUymFHRx39FCcGjfRRBHQ3f0wd7qTZT6jsgLwkA=;
        b=rV0thk9vb/ozvuAuCZcRrT+qqPOnW0XyPIFVTxH6b8gek9TwH6dy26sT6TwboFRgA5
         l7k7eQPIMFZwTTi2+Bckyg6HSnXNVc/lHOeDU9+WeCSeURJjMInz/IMufI/eFYpYTP7m
         sZB8vO5I/dG3bZIpsoxoTpIJYFDyFY4z1TAIXV41IeGs4TPvpJTZDrKhvAAT9N27/xWD
         0s0Z1A7JtdNpL1yhyHi4sZJCfg66tpJgA0C+T/ymwS9q28qWjudG6oKx8gn62Fb8ZZ7t
         WZMxSqNUo7EUjswqR7kjdLYh+bg7KGJcEOQrpsPjZos0w7Pz4OukD+PLirFueYGGG8jb
         ESsQ==
X-Gm-Message-State: AOAM533motlzxqLo/3IuZFJ01Gm29rdiZqBz1iLjBAp2mAkVX8tBoHqy
        5w0/TvQWA9fuDlP0SqFFddA=
X-Google-Smtp-Source: ABdhPJzYbrUiYyUPRkjeKRyyqoRSKMvqVC9Sst+yJ1xi3++Xe5VbaZ3jjO89zlocflcbdOmU5APoiA==
X-Received: by 2002:a17:902:eb53:b029:d9:e57a:e402 with SMTP id i19-20020a170902eb53b02900d9e57ae402mr16620061pli.85.1606699801085;
        Sun, 29 Nov 2020 17:30:01 -0800 (PST)
Received: from localhost.localdomain ([49.207.197.72])
        by smtp.gmail.com with ESMTPSA id u1sm19863599pjn.40.2020.11.29.17.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:30:00 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/15] usb: misc: ezusb: update to use usb_control_msg_send()
Date:   Mon, 30 Nov 2020 06:59:53 +0530
Message-Id: <20201130012953.2579811-1-anant.thazhemadam@gmail.com>
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

