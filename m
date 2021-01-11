Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F7A2F1082
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbhAKKu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbhAKKu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:50:26 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC66C061786;
        Mon, 11 Jan 2021 02:49:45 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id t22so10719728pfl.3;
        Mon, 11 Jan 2021 02:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WvyqgYj7Ogyaz0kas4Z5Pi8oEJj2mW0UBIvV4QHkFC8=;
        b=Zhmo13M1NRzd64WXyNSNM/ELmgFlPeNBhQSVbZ2aErRBwnkhlPXhaVde9Sg6CSyH4M
         /ffijtV3GuxXhBtvxQIoDMjOtMzf/ALJus7aH+R4uhUWms34aPztMFZ343kHSjwUXuHz
         SdDCs4xDb43ZtCEYQOTH5zCDFYKx17iqo+sBhBw+SzSSvORBsgCiPF/ciGpuwRmNFX3h
         cYuiNx2x8Mwp6ST0ZW5go1XJStd04dJyQ1RYe7a2jy49Uqq2Yvfp3fhm7fzN9lOpGZjf
         lSQ9qkQIA5mU6r8xqVdo/cHje3YgQqFricbg7ODm1zmVM7ONrqRkwu6gvDz1/XYs9cqA
         jqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WvyqgYj7Ogyaz0kas4Z5Pi8oEJj2mW0UBIvV4QHkFC8=;
        b=XzIRgwkajLCULN7g97kOuyLDPauh4c1K7HSl6b13YOUyZE4xSlTI7cdg1pMtPBBBG6
         CYPNhNsw0iiAGXweI1x8oak2NsCTobMMk2IR6jIwSRje6tcTSsqSRwrs9OCElf86Dy3A
         lJjjxIzVgE6nTRLmKlvwOws+Cp8EM8x9DK+Q4inICrUvk/d3qJW6bdES8CYG3CEveB0z
         4uAcunYkZ3+Zr7a8mG3hbnL/bBo3kwiXLPU0tUlVD9iiwhGJ9fr7Y4vdAFigxokD1MtG
         X1OAQ2N9VHuHFqPfZWwnABI2Obp/eu2CUQOTt0e8rTOAx1bA+dcCyfcc3ep9GCi2ZoOH
         J7AQ==
X-Gm-Message-State: AOAM531Sb6+j50NvM+8SCFBow3vFQQD7wVROLguzJPLR2rnPlXQ71K3e
        lLC8TEV1yufi1teT2g167gKvsaIo24ohT00T
X-Google-Smtp-Source: ABdhPJyqRtP+kYJTMNLshOXjOVYqr2Hu9YokOxgaF+bQMYvG9GmHNnShUyQ7AB0aTKm4jVfOIsWZ5A==
X-Received: by 2002:a62:7f4c:0:b029:19e:23d1:cf0a with SMTP id a73-20020a627f4c0000b029019e23d1cf0amr15377008pfd.67.1610362185176;
        Mon, 11 Jan 2021 02:49:45 -0800 (PST)
Received: from android.asia-east2-a.c.savvy-summit-295307.internal (53.207.96.34.bc.googleusercontent.com. [34.96.207.53])
        by smtp.googlemail.com with ESMTPSA id s1sm23579177pjk.1.2021.01.11.02.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 02:49:44 -0800 (PST)
From:   Bui Quang Minh <minhquangbui99@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     a.darwish@linutronix.de, bigeasy@linutronix.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        minhquangbui99@gmail.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: [PATCH v2] can: mcba_usb: Fix memory leak when cancelling urb
Date:   Mon, 11 Jan 2021 10:49:27 +0000
Message-Id: <20210111104927.2561-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mcba_usb_read_bulk_callback(), when we don't resubmit or fails to
resubmit the urb, we need to deallocate the transfer buffer that is
allocated in mcba_usb_start().

Reported-by: syzbot+57281c762a3922e14dfe@syzkaller.appspotmail.com
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
v1: add memory leak fix when not resubmitting urb
v2: add memory leak fix when failing to resubmit urb

 drivers/net/can/usb/mcba_usb.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index df54eb7d4b36..30236e640116 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -584,6 +584,8 @@ static void mcba_usb_read_bulk_callback(struct urb *urb)
 	case -EPIPE:
 	case -EPROTO:
 	case -ESHUTDOWN:
+		usb_free_coherent(urb->dev, urb->transfer_buffer_length,
+				  urb->transfer_buffer, urb->transfer_dma);
 		return;
 
 	default:
@@ -615,11 +617,14 @@ static void mcba_usb_read_bulk_callback(struct urb *urb)
 
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
 
-	if (retval == -ENODEV)
-		netif_device_detach(netdev);
-	else if (retval)
+	if (retval < 0) {
 		netdev_err(netdev, "failed resubmitting read bulk urb: %d\n",
 			   retval);
+		usb_free_coherent(urb->dev, urb->transfer_buffer_length,
+				  urb->transfer_buffer, urb->transfer_dma);
+		if (retval == -ENODEV)
+			netif_device_detach(netdev);
+	}
 }
 
 /* Start USB device */
-- 
2.17.1

