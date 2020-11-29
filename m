Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588B52C79D7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgK2QHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2QHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:07:31 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DEDC0613D4;
        Sun, 29 Nov 2020 08:06:51 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id l17so8429517pgk.1;
        Sun, 29 Nov 2020 08:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wYgJ36S1d93ExxyZRxjjA6kLMdxalPYMh/Ef3UGOiwQ=;
        b=bTT+7/DyFAtjDaSlJcGjkyPWp3JqxBfCQYatinU9uZ1zytBCosuJT80ZZXPx9PdOUT
         9QzgUqrkUva1MldSbOlcyax5WH9IpV2xmeTiOXety5CPjt5AImUoNyqs2qFqsSn+3v2Z
         F73CPOx1ss1YWhWEez0ejdVpixxz+f/6zOiWaKaz/hOelkQ4yEbMvUTi0okA7bk1Ehan
         rTRg+cRxU2fOGGZjR/fBZ1Y6MjlFu+EgmBjr2JqbXmkF3xMCuB03OQj4bbKcUXTUd0xp
         LJROBMgxqJ/l12jHDwcynEjh8G4j4VSSRv7lRLl32LgbuIDe5jiJ9oV+gR6CTxaxj2zU
         N8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYgJ36S1d93ExxyZRxjjA6kLMdxalPYMh/Ef3UGOiwQ=;
        b=ALnsTrLlo7uyKIxm29F99jnl+SbPZ9EIklYecPBhiOJd81m3Ap7jh67nuNKXgYXeZY
         vjF0ljHnJs+5G2C1JGXDS6LuwIvsE8bhlbcQ95V6mC+qXgvsF5vr4VAZAxywtdXoXazR
         A2J1FeBfgkSTE6hWE17OLKHPQHr+b2cRu5sUemvhfB77mkBpoxH1t3JDERJNqHCmPnJc
         U6SGogos+AY4tZvlNClxzzWbSlUGPpoOJeIqOk5rfVGdF3aiiPdhDtuc+9IaS7owuNuS
         +LQvQomN81aSh6LDlpfOTisFQ2uSQhr8uIM6JWC2OiuYA80CyieMXvXxJDO+P/LBQ/r3
         DfUw==
X-Gm-Message-State: AOAM533Wd2Ny5JslIrC0awADLp9g2LVTynMoCCF5b8pf9N/+zGTmI+pN
        7ezDpTdUHf/wza9MjDw+7mM=
X-Google-Smtp-Source: ABdhPJyutdZ0cpo1qS5hyIx4JVtcFmG0PF5e8CI4v4xhEXBCa6Skb4vPtTVRqs9evx/ZUTDaNZRKpw==
X-Received: by 2002:a62:5b05:0:b029:197:fafb:50f3 with SMTP id p5-20020a625b050000b0290197fafb50f3mr15050321pfb.76.1606666010509;
        Sun, 29 Nov 2020 08:06:50 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:06:49 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] usb: misc: cytherm: update to use usb_control_msg_recv()
Date:   Sun, 29 Nov 2020 21:36:00 +0530
Message-Id: <20201129160612.1908074-4-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201129160612.1908074-1-anant.thazhemadam@gmail.com>
References: <20201129160612.1908074-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The return value checking enforced by callers of the updated function have
also been appropriately updated.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/cytherm.c | 42 +++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/misc/cytherm.c b/drivers/usb/misc/cytherm.c
index 3e3802aaefa3..75fa4d806a77 100644
--- a/drivers/usb/misc/cytherm.c
+++ b/drivers/usb/misc/cytherm.c
@@ -51,12 +51,12 @@ static int vendor_command(struct usb_device *dev, unsigned char request,
 			  unsigned char value, unsigned char index,
 			  void *buf, int size)
 {
-	return usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
-			       request, 
-			       USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			       value, 
-			       index, buf, size,
-			       USB_CTRL_GET_TIMEOUT);
+	return usb_control_msg_recv(dev, 0,
+				    request,
+				    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+				    value,
+				    index, buf, size,
+				    USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
 }
 
 
@@ -95,14 +95,14 @@ static ssize_t brightness_store(struct device *dev, struct device_attribute *att
 	/* Set brightness */
 	retval = vendor_command(cytherm->udev, WRITE_RAM, BRIGHTNESS, 
 				cytherm->brightness, buffer, 8);
-	if (retval)
-		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
+	if (!retval)
+		dev_dbg(&cytherm->udev->dev, "brightness set correctly\n");
 	/* Inform µC that we have changed the brightness setting */
 	retval = vendor_command(cytherm->udev, WRITE_RAM, BRIGHTNESS_SEM,
 				0x01, buffer, 8);
-	if (retval)
-		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
-   
+	if (!retval)
+		dev_dbg(&cytherm->udev->dev, "µC informed of change in brightness setting\n");
+
 	kfree(buffer);
    
 	return count;
@@ -130,14 +130,14 @@ static ssize_t temp_show(struct device *dev, struct device_attribute *attr, char
 
 	/* read temperature */
 	retval = vendor_command(cytherm->udev, READ_RAM, TEMP, 0, buffer, 8);
-	if (retval)
-		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
+	if (!retval)
+		dev_dbg(&cytherm->udev->dev, "read temperature successfully\n");
 	temp = buffer[1];
    
 	/* read sign */
 	retval = vendor_command(cytherm->udev, READ_RAM, SIGN, 0, buffer, 8);
-	if (retval)
-		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
+	if (!retval)
+		dev_dbg(&cytherm->udev->dev, "read sign successfully\n");
 	sign = buffer[1];
 
 	kfree(buffer);
@@ -165,8 +165,8 @@ static ssize_t button_show(struct device *dev, struct device_attribute *attr, ch
 
 	/* check button */
 	retval = vendor_command(cytherm->udev, READ_RAM, BUTTON, 0, buffer, 8);
-	if (retval)
-		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
+	if (!retval)
+		dev_dbg(&cytherm->udev->dev, "checked button successfully\n");
    
 	retval = buffer[1];
 
@@ -193,7 +193,7 @@ static ssize_t port0_show(struct device *dev, struct device_attribute *attr, cha
 		return 0;
 
 	retval = vendor_command(cytherm->udev, READ_PORT, 0, 0, buffer, 8);
-	if (retval)
+	if (!retval)
 		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
 
 	retval = buffer[1];
@@ -226,7 +226,7 @@ static ssize_t port0_store(struct device *dev, struct device_attribute *attr, co
    
 	retval = vendor_command(cytherm->udev, WRITE_PORT, 0,
 				tmp, buffer, 8);
-	if (retval)
+	if (!retval)
 		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
 
 	kfree(buffer);
@@ -248,7 +248,7 @@ static ssize_t port1_show(struct device *dev, struct device_attribute *attr, cha
 		return 0;
 
 	retval = vendor_command(cytherm->udev, READ_PORT, 1, 0, buffer, 8);
-	if (retval)
+	if (!retval)
 		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
    
 	retval = buffer[1];
@@ -281,7 +281,7 @@ static ssize_t port1_store(struct device *dev, struct device_attribute *attr, co
    
 	retval = vendor_command(cytherm->udev, WRITE_PORT, 1,
 				tmp, buffer, 8);
-	if (retval)
+	if (!retval)
 		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
 
 	kfree(buffer);
-- 
2.25.1

