Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6165304EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404970AbhA0Bai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394775AbhAZSfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:35:42 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414A3C0613D6;
        Tue, 26 Jan 2021 10:35:02 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id g15so2754036pjd.2;
        Tue, 26 Jan 2021 10:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6xBjojemrIICF/vl8V5tDr3Zp6uDLBqRICYfScnuO8M=;
        b=iruQUIgQiNgJrLRO9/EBb3aqH5y6+bSnQbUFW3wyjWa4lSEi++Y2ZDT2nqXgPJVzHe
         8Pb1mDxiD3J2VJxL46JPGIeQrDPHBckHM8Ax7IQRLuOFO84QZzGWHbr+LVy0pYoGHcvH
         b/sFebwHyZW44POLqm4selzpRdsmw3+QqLS2tUXMMBCIPM46P36W85mGAlB8yCQnN56A
         FGW71RLo6+Z+JgJXU4qSeAVMEH4ZNDqq+j5G2Sr4znexaU1MS3MGPDd50iHoCLMhySai
         VWzCQJIcrsYkdj/y1QCTY9Qi2wmfsHZ6ot8FDqx7s75vwqBC4S0WvVQ+sHmZPRfcJi1m
         vQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xBjojemrIICF/vl8V5tDr3Zp6uDLBqRICYfScnuO8M=;
        b=WA9YalZb/lYlMoLvciPlhGp4mPZSFyd/Q13OGz4AKcobIh5XoXKgschIHwygUxi8Yb
         7uih2gTOYVeqpBFcPTACt0Nqg5CDXND08k1Inri28LLaFs9Yum5/ePX8oFz4NO38FEjS
         7sSHtrelHwSpGil59gL3yWzHLWztU6ZSuS/pUPogVFIF6wrB8c3/dbGhyJmOF9C2/RVM
         VIyQAgfrXni7gJ6VHJBJOdC0S2JVKTkl8jH2TDGc8WoFAdks1lZ9igkXCUw5Knb9Pll6
         iTDMVh2dC121ihG3+Qp2XygB3EN9MhoJZDOyromALgrrXnWFdYVkBOVPdWy2aMtRV2QA
         OUrQ==
X-Gm-Message-State: AOAM533lQjKF/vbNvBIkByPwF/u/VkUAfeXJ4aob1KQ88HJhCO+F5n51
        c71dX3wSGvTWOwmG8I2nFCg=
X-Google-Smtp-Source: ABdhPJyAlS3QOBvfItT197fMR9Vyp0UPTGYb6PrNqASrRoR4ARWHSy+ZqpF/uruk/NwnkG0SB6FlaQ==
X-Received: by 2002:a17:90a:ab8e:: with SMTP id n14mr1130385pjq.96.1611686101757;
        Tue, 26 Jan 2021 10:35:01 -0800 (PST)
Received: from localhost.localdomain ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id y75sm472711pfg.119.2021.01.26.10.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:35:01 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/12] usb: misc: cytherm: update to use usb_control_msg_recv()
Date:   Wed, 27 Jan 2021 00:03:54 +0530
Message-Id: <20210126183403.911653-4-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
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
 drivers/usb/misc/cytherm.c | 128 +++++++++++++------------------------
 1 file changed, 43 insertions(+), 85 deletions(-)

diff --git a/drivers/usb/misc/cytherm.c b/drivers/usb/misc/cytherm.c
index 3e3802aaefa3..2ca36ea5b76a 100644
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
 
 
@@ -78,33 +78,27 @@ static ssize_t brightness_store(struct device *dev, struct device_attribute *att
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
 
-	unsigned char *buffer;
+	unsigned char buffer[8];
 	int retval;
-   
-	buffer = kmalloc(8, GFP_KERNEL);
-	if (!buffer)
-		return 0;
 
 	cytherm->brightness = simple_strtoul(buf, NULL, 10);
-   
+
 	if (cytherm->brightness > 0xFF)
 		cytherm->brightness = 0xFF;
 	else if (cytherm->brightness < 0)
 		cytherm->brightness = 0;
-   
+
 	/* Set brightness */
 	retval = vendor_command(cytherm->udev, WRITE_RAM, BRIGHTNESS, 
-				cytherm->brightness, buffer, 8);
-	if (retval)
-		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
+				cytherm->brightness, &buffer, 8);
+	if (!retval)
+		dev_dbg(&cytherm->udev->dev, "brightness set correctly\n");
 	/* Inform µC that we have changed the brightness setting */
 	retval = vendor_command(cytherm->udev, WRITE_RAM, BRIGHTNESS_SEM,
-				0x01, buffer, 8);
-	if (retval)
-		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
-   
-	kfree(buffer);
-   
+				0x01, &buffer, 8);
+	if (!retval)
+		dev_dbg(&cytherm->udev->dev, "µC informed of change in brightness setting\n");
+
 	return count;
 }
 static DEVICE_ATTR_RW(brightness);
@@ -120,28 +114,22 @@ static ssize_t temp_show(struct device *dev, struct device_attribute *attr, char
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
 
 	int retval;
-	unsigned char *buffer;
+	unsigned char buffer[8];
 
 	int temp, sign;
    
-	buffer = kmalloc(8, GFP_KERNEL);
-	if (!buffer)
-		return 0;
-
 	/* read temperature */
-	retval = vendor_command(cytherm->udev, READ_RAM, TEMP, 0, buffer, 8);
-	if (retval)
-		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
+	retval = vendor_command(cytherm->udev, READ_RAM, TEMP, 0, &buffer, 8);
+	if (!retval)
+		dev_dbg(&cytherm->udev->dev, "read temperature successfully\n");
 	temp = buffer[1];
    
 	/* read sign */
-	retval = vendor_command(cytherm->udev, READ_RAM, SIGN, 0, buffer, 8);
-	if (retval)
-		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
+	retval = vendor_command(cytherm->udev, READ_RAM, SIGN, 0, &buffer, 8);
+	if (!retval)
+		dev_dbg(&cytherm->udev->dev, "read sign successfully\n");
 	sign = buffer[1];
 
-	kfree(buffer);
-   
 	return sprintf(buf, "%c%i.%i", sign ? '-' : '+', temp >> 1,
 		       5*(temp - ((temp >> 1) << 1)));
 }
@@ -157,21 +145,15 @@ static ssize_t button_show(struct device *dev, struct device_attribute *attr, ch
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
 
 	int retval;
-	unsigned char *buffer;
-
-	buffer = kmalloc(8, GFP_KERNEL);
-	if (!buffer)
-		return 0;
+	unsigned char buffer[8];
 
 	/* check button */
-	retval = vendor_command(cytherm->udev, READ_RAM, BUTTON, 0, buffer, 8);
-	if (retval)
-		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
+	retval = vendor_command(cytherm->udev, READ_RAM, BUTTON, 0, &buffer, 8);
+	if (!retval)
+		dev_dbg(&cytherm->udev->dev, "checked button successfully\n");
    
 	retval = buffer[1];
 
-	kfree(buffer);
-
 	if (retval)
 		return sprintf(buf, "1");
 	else
@@ -186,20 +168,14 @@ static ssize_t port0_show(struct device *dev, struct device_attribute *attr, cha
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
 
 	int retval;
-	unsigned char *buffer;
-
-	buffer = kmalloc(8, GFP_KERNEL);
-	if (!buffer)
-		return 0;
+	unsigned char buffer[8];
 
-	retval = vendor_command(cytherm->udev, READ_PORT, 0, 0, buffer, 8);
-	if (retval)
+	retval = vendor_command(cytherm->udev, READ_PORT, 0, 0, &buffer, 8);
+	if (!retval)
 		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
 
 	retval = buffer[1];
 
-	kfree(buffer);
-
 	return sprintf(buf, "%d", retval);
 }
 
@@ -209,28 +185,22 @@ static ssize_t port0_store(struct device *dev, struct device_attribute *attr, co
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
 
-	unsigned char *buffer;
+	unsigned char buffer[8];
 	int retval;
 	int tmp;
-   
-	buffer = kmalloc(8, GFP_KERNEL);
-	if (!buffer)
-		return 0;
 
 	tmp = simple_strtoul(buf, NULL, 10);
-   
+
 	if (tmp > 0xFF)
 		tmp = 0xFF;
 	else if (tmp < 0)
 		tmp = 0;
-   
+
 	retval = vendor_command(cytherm->udev, WRITE_PORT, 0,
-				tmp, buffer, 8);
-	if (retval)
+				tmp, &buffer, 8);
+	if (!retval)
 		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
 
-	kfree(buffer);
-
 	return count;
 }
 static DEVICE_ATTR_RW(port0);
@@ -241,19 +211,13 @@ static ssize_t port1_show(struct device *dev, struct device_attribute *attr, cha
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
 
 	int retval;
-	unsigned char *buffer;
+	unsigned char buffer[8];
 
-	buffer = kmalloc(8, GFP_KERNEL);
-	if (!buffer)
-		return 0;
-
-	retval = vendor_command(cytherm->udev, READ_PORT, 1, 0, buffer, 8);
-	if (retval)
+	retval = vendor_command(cytherm->udev, READ_PORT, 1, 0, &buffer, 8);
+	if (!retval)
 		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
-   
-	retval = buffer[1];
 
-	kfree(buffer);
+	retval = buffer[1];
 
 	return sprintf(buf, "%d", retval);
 }
@@ -264,13 +228,9 @@ static ssize_t port1_store(struct device *dev, struct device_attribute *attr, co
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
 
-	unsigned char *buffer;
+	unsigned char buffer[8];
 	int retval;
 	int tmp;
-   
-	buffer = kmalloc(8, GFP_KERNEL);
-	if (!buffer)
-		return 0;
 
 	tmp = simple_strtoul(buf, NULL, 10);
    
@@ -278,14 +238,12 @@ static ssize_t port1_store(struct device *dev, struct device_attribute *attr, co
 		tmp = 0xFF;
 	else if (tmp < 0)
 		tmp = 0;
-   
+
 	retval = vendor_command(cytherm->udev, WRITE_PORT, 1,
-				tmp, buffer, 8);
-	if (retval)
+				tmp, &buffer, 8);
+	if (!retval)
 		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
 
-	kfree(buffer);
-
 	return count;
 }
 static DEVICE_ATTR_RW(port1);
-- 
2.25.1

