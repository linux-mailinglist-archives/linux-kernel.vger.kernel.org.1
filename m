Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF4B2C7C71
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgK3Bdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbgK3Bdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:33:49 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E72C0613D2;
        Sun, 29 Nov 2020 17:33:09 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id b23so5564262pls.11;
        Sun, 29 Nov 2020 17:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oMoEajyDR9iy/8AmtoE+xZAQV9/TdmV8a3AZX9/gsow=;
        b=YcmE0ZRcv9ZdFuMrDXDVIiiYSheIGN3T2L13gXLZf7thOK9mdeH6w95wlnKreceqf/
         +sPtTnI7ucwXOsaLf7osxdMGoh81GpGsEWK33GBLECx2rk86KyiMIisFZwngHwudBn7+
         pOcDtZlrKGhEKAA74Stm8ELEfdyi1IDGmwYEtigAj3lHLyMnBfPF2frz13ES81yZWAua
         E6kP/I+a7EcMzjt7ejIw98YfBovx4SugpVtiBfgyE2cwrDLbxXc5zE1FOeqmw9YyE9G6
         W1PhjYBGlpPcHy34KlFF9baBwIsTKGj1bHM20rxz6yx808Ys6EHZgbXRrBiTLmP8Um/D
         6HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMoEajyDR9iy/8AmtoE+xZAQV9/TdmV8a3AZX9/gsow=;
        b=IVhe8+BG58guONKCRAqWFtqFge6LcOzut9l62ndmERn/0JuaZraF0+YI0+m9EK+5HA
         2ktHr9C0doHcS8IgyH7UleJLkhCCU0a6/eEwcQ8fxDe46qks2OLJoxxK+VPQRpIeOpo3
         z03yInBCMR0GD/PX38limsLUAKjBFbQCJpl63O4O6AH63Xkqx9Y8tu+i6qvjpZh6YDce
         hhzR8PCmnsS0hbQCgGJbF5dTXIBmKwLwgTrf03Nf3m+6ldVisulVrpEaZmRJs+jVaMsk
         jLAuYpCGueRuoboPtNVwXKQ2zkf/FPzF2cnmEaKRd4HQ/OX4WUPFFuG5sBEfMrH6/hvq
         AjDg==
X-Gm-Message-State: AOAM532U0we4PD1vzaZlFdtobr0vwStOUmqMWfdzCkpqACr5b28tH/MV
        TrO+/JOk6RrbgeClQ2O5hpY=
X-Google-Smtp-Source: ABdhPJxTaUh6PgwHoSpw9N670578+JxdXCsZa06WsHSiz60yFAz7Mm3thgEJYCH42tyo1yClRJc/Iw==
X-Received: by 2002:a17:90a:4601:: with SMTP id w1mr23468441pjg.109.1606699988738;
        Sun, 29 Nov 2020 17:33:08 -0800 (PST)
Received: from localhost.localdomain ([49.207.197.72])
        by smtp.gmail.com with ESMTPSA id r15sm20579565pjp.51.2020.11.29.17.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:33:08 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/15] usb: misc: trancevibrator: update to use usb_control_msg_send()
Date:   Mon, 30 Nov 2020 07:03:02 +0530
Message-Id: <20201130013302.2581300-1-anant.thazhemadam@gmail.com>
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
usb_control_msg_send() and the return value checking condition has also
been modified appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/trancevibrator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/trancevibrator.c b/drivers/usb/misc/trancevibrator.c
index a3dfc77578ea..c50807b4f4ef 100644
--- a/drivers/usb/misc/trancevibrator.c
+++ b/drivers/usb/misc/trancevibrator.c
@@ -59,11 +59,11 @@ static ssize_t speed_store(struct device *dev, struct device_attribute *attr,
 	dev_dbg(&tv->udev->dev, "speed = %d\n", tv->speed);
 
 	/* Set speed */
-	retval = usb_control_msg(tv->udev, usb_sndctrlpipe(tv->udev, 0),
+	retval = usb_control_msg_send(tv->udev, 0,
 				 0x01, /* vendor request: set speed */
 				 USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 				 tv->speed, /* speed value */
-				 0, NULL, 0, USB_CTRL_GET_TIMEOUT);
+				 0, NULL, 0, USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
 	if (retval) {
 		tv->speed = old;
 		dev_dbg(&tv->udev->dev, "retval = %d\n", retval);
-- 
2.25.1

