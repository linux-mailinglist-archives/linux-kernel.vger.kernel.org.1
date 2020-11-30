Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9782C7C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgK3B2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgK3B2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:28:00 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1893BC0613CF;
        Sun, 29 Nov 2020 17:27:14 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id bj5so5568840plb.4;
        Sun, 29 Nov 2020 17:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6xBjojemrIICF/vl8V5tDr3Zp6uDLBqRICYfScnuO8M=;
        b=jHyddAFSy3yEXVajRASCAZvkgE5J8XfJt3PuzkiIj0wgnWYdQwBSMkQkNTUK1V6FyP
         Ni1QrhiDfjtExCvtRoQP3tnvY71Md468LX/5R4t139aURisGpid+EkTaRCYv56hZNWYt
         vsvydHoSxZgU5D5uLfGGD4SnmqWP/DBd6i+5E25MyC2qwRpxFtZowtrLiXExUCpa69wS
         vAaIlrMZqiC0g5IqblkCDsJ5QSeWoIauUPe8QGLmrJup+ZTxqIK5dt7mo1PZqZR3RBf6
         6vdN5cd1vkKZGQplyh2Tp701+hAI4kG5hgAXtPRAzydPxiZAhzV0CqvlKoIjXbh5qAYQ
         F9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xBjojemrIICF/vl8V5tDr3Zp6uDLBqRICYfScnuO8M=;
        b=PTbDg8edImEahpUGG+EHv4bAoHNYzgmZAmWR/e9uIVBoM5H7SpI9q7GAeMzDYvCqPm
         xFk67JP7+dlTvOwDf7kR2yR4sm/krEUb0Pz4el/cSJH/KhLgBnaQgPHS4+RRaflWj1VS
         M+v+ewpEZUCrN9BFtrCgRa9DCrO7QWVQ668KQyCG4IQ5jnGbmHKARP2SCVJJirt9LUDS
         SvcF6vWJVBnHjrUqt1j+2xchuark+UXj96QVAHZHABaKyWeUksFqHsz14djXP+ajnovD
         DosqRMeFOj/ydE9+9w5fQFSAYpYTG9mIHLZwf56frSZnY938nxC58ig2O+m8VjAep2Tb
         oxKw==
X-Gm-Message-State: AOAM533bbMQ2sSqhcVBnzYudm6hVK8FzRMrhJE5ZY+gMtshT3EFk0xlJ
        hNb2DRJUcmpPxzYmdBZiPaqX3rKTYGdaI5TeVWw=
X-Google-Smtp-Source: ABdhPJymmucrxNeI8pFidRH1l5xI9arCyKp9HE18/dslVeW9nUIsjsxsqhOKs6ifbdlUWoDsAhxcTQ==
X-Received: by 2002:a17:902:b691:b029:d8:ebc8:385e with SMTP id c17-20020a170902b691b02900d8ebc8385emr16781522pls.48.1606699633563;
        Sun, 29 Nov 2020 17:27:13 -0800 (PST)
Received: from localhost.localdomain ([49.207.197.72])
        by smtp.gmail.com with ESMTPSA id q200sm14341308pfq.95.2020.11.29.17.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:27:12 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/15] usb: misc: cytherm: update to use usb_control_msg_recv()
Date:   Mon, 30 Nov 2020 06:57:07 +0530
Message-Id: <20201130012707.2578797-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
References: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
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

