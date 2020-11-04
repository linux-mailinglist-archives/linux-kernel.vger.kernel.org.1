Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7A02A5E50
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgKDGsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgKDGsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:48:04 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF48C061A4D;
        Tue,  3 Nov 2020 22:48:03 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t22so9819633plr.9;
        Tue, 03 Nov 2020 22:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l8NSTxxpQrexkPYVhXT7jvvYAIXTQNPEWoW4LpKJ/RY=;
        b=EPFgct1dcoqTz7O1M327HwD+IZWgzUe5fzd7bcCEVLeuBTFY+Xh3FiLDgwRbOthgFE
         Mb8aQA1XYkqVQI6I2LazCjQzy6pJStpC4OKpSeOp7T63ju8SGeHQTIzlsOL2KA7WOs8Y
         yicCT3K+Tgj/EBEi9y+0knIqkUokXN/kt93MR+40bEbMTcO4RkEAyCmLaKzLRSmB6f2X
         1qG3ilfmdt9ER3217RFUm2xWame3Df97ffKO+3Zg6IRZvfcg8zmS+7/+VAvGY9Q55GOJ
         1jRESsr4tt8HBjkEVbeLnDZ8zXC934qignZ2vEET2P7QNLaV+/CxG29CjHNDqnZcNYrV
         g8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l8NSTxxpQrexkPYVhXT7jvvYAIXTQNPEWoW4LpKJ/RY=;
        b=RTmlmAwAOFSYdm8v+K8n6m4sxlIFLuaPpiA180asC+ZyvDWWuAVifMRZ7HXLzK5NBy
         kxtqIMCxcnOQUZGiXECBABMjbcfBGiw7HNE8brqYBUqgk5CulAay111H0V3OybM5FtTR
         LUinxDzSwpHzGZ/lbsINYObu4qNe0P9gZtAT5FFLJYFnbVyd0KhfGqtivClVDEdaJ54b
         SLllG+SRp7jpS5Ff6PeehHOIS4cVtL/X+jrsWRK9I78i8ShVaalRdE1YH+O85Ib9bIK5
         2K/gEU3AieBCakJxlhDdd8WuNmkPeVi11f812WwoypHhe3MQTh4ZyJntOQCKt/tLbzPj
         ZSWA==
X-Gm-Message-State: AOAM531upjjK9ekqqG1cezQRMrnPK85pnTp8jEzuQu8MHfREbCYM6EUA
        wuNI0aL2xZnevW6K7Gq5TsY=
X-Google-Smtp-Source: ABdhPJzPQj7n6uicFaevWxSN0ch/aIA432vzngGoXIpK795g7+01js+d+9OiTwm6HL/9MW7/aUTcCw==
X-Received: by 2002:a17:902:c20a:b029:d6:b2d6:8006 with SMTP id 10-20020a170902c20ab02900d6b2d68006mr19396172pll.31.1604472483191;
        Tue, 03 Nov 2020 22:48:03 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:48:02 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 09/15] usb: serial: io_edgeport: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:16:57 +0530
Message-Id: <20201104064703.15123-10-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104064703.15123-1-himadrispandya@gmail.com>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
usb_control_msg() with proper error check. Hence use the wrappers
instead of calling usb_control_msg() directly.

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
 drivers/usb/serial/io_edgeport.c | 73 ++++++++++++--------------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index ba5d8df69518..8479d5684af7 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -568,34 +568,29 @@ static int get_epic_descriptor(struct edgeport_serial *ep)
 	int result;
 	struct usb_serial *serial = ep->serial;
 	struct edgeport_product_info *product_info = &ep->product_info;
-	struct edge_compatibility_descriptor *epic;
+	struct edge_compatibility_descriptor epic;
 	struct edge_compatibility_bits *bits;
 	struct device *dev = &serial->dev->dev;
 
 	ep->is_epic = 0;
 
-	epic = kmalloc(sizeof(*epic), GFP_KERNEL);
-	if (!epic)
-		return -ENOMEM;
-
-	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
-				 USB_REQUEST_ION_GET_EPIC_DESC,
-				 0xC0, 0x00, 0x00,
-				 epic, sizeof(*epic),
-				 300);
-	if (result == sizeof(*epic)) {
+	result = usb_control_msg_recv(serial->dev, 0,
+				      USB_REQUEST_ION_GET_EPIC_DESC, 0xC0,
+				      0x00, 0x00, &epic, sizeof(epic), 300,
+				      GFP_KERNEL);
+	if (result) {
 		ep->is_epic = 1;
-		memcpy(&ep->epic_descriptor, epic, sizeof(*epic));
+		memcpy(&ep->epic_descriptor, &epic, sizeof(epic));
 		memset(product_info, 0, sizeof(struct edgeport_product_info));
 
-		product_info->NumPorts = epic->NumPorts;
+		product_info->NumPorts = epic.NumPorts;
 		product_info->ProdInfoVer = 0;
-		product_info->FirmwareMajorVersion = epic->MajorVersion;
-		product_info->FirmwareMinorVersion = epic->MinorVersion;
-		product_info->FirmwareBuildNumber = epic->BuildNumber;
-		product_info->iDownloadFile = epic->iDownloadFile;
-		product_info->EpicVer = epic->EpicVer;
-		product_info->Epic = epic->Supports;
+		product_info->FirmwareMajorVersion = epic.MajorVersion;
+		product_info->FirmwareMinorVersion = epic.MinorVersion;
+		product_info->FirmwareBuildNumber = epic.BuildNumber;
+		product_info->iDownloadFile = epic.iDownloadFile;
+		product_info->EpicVer = epic.EpicVer;
+		product_info->Epic = epic.Supports;
 		product_info->ProductId = ION_DEVICE_ID_EDGEPORT_COMPATIBLE;
 		dump_product_info(ep, product_info);
 
@@ -614,16 +609,12 @@ static int get_epic_descriptor(struct edgeport_serial *ep)
 		dev_dbg(dev, "  IOSPWriteLCR     : %s\n", bits->IOSPWriteLCR	? "TRUE": "FALSE");
 		dev_dbg(dev, "  IOSPSetBaudRate  : %s\n", bits->IOSPSetBaudRate	? "TRUE": "FALSE");
 		dev_dbg(dev, "  TrueEdgeport     : %s\n", bits->TrueEdgeport	? "TRUE": "FALSE");
-
-		result = 0;
-	} else if (result >= 0) {
+	} else {
 		dev_warn(&serial->interface->dev, "short epic descriptor received: %d\n",
 			 result);
 		result = -EIO;
 	}
 
-	kfree(epic);
-
 	return result;
 }
 
@@ -2168,11 +2159,6 @@ static int rom_read(struct usb_serial *serial, __u16 extAddr,
 {
 	int result;
 	__u16 current_length;
-	unsigned char *transfer_buffer;
-
-	transfer_buffer =  kmalloc(64, GFP_KERNEL);
-	if (!transfer_buffer)
-		return -ENOMEM;
 
 	/* need to split these reads up into 64 byte chunks */
 	result = 0;
@@ -2181,25 +2167,18 @@ static int rom_read(struct usb_serial *serial, __u16 extAddr,
 			current_length = 64;
 		else
 			current_length = length;
-		result = usb_control_msg(serial->dev,
-					usb_rcvctrlpipe(serial->dev, 0),
-					USB_REQUEST_ION_READ_ROM,
-					0xC0, addr, extAddr, transfer_buffer,
-					current_length, 300);
-		if (result < current_length) {
-			if (result >= 0)
-				result = -EIO;
+		result = usb_control_msg_recv(serial->dev, 0,
+					      USB_REQUEST_ION_READ_ROM, 0xC0,
+					      addr, extAddr, data,
+					      current_length, 300, GFP_KERNEL);
+		if (result)
 			break;
-		}
-		memcpy(data, transfer_buffer, current_length);
+
 		length -= current_length;
 		addr += current_length;
 		data += current_length;
 
-		result = 0;
 	}
-
-	kfree(transfer_buffer);
 	return result;
 }
 
@@ -2801,10 +2780,12 @@ static void load_application_firmware(struct edgeport_serial *edge_serial)
 	}
 
 	dev_dbg(dev, "sending exec_dl_code\n");
-	response = usb_control_msg (edge_serial->serial->dev,
-				    usb_sndctrlpipe(edge_serial->serial->dev, 0),
-				    USB_REQUEST_ION_EXEC_DL_CODE,
-				    0x40, 0x4000, 0x0001, NULL, 0, 3000);
+	response = usb_control_msg_send(edge_serial->serial->dev, 0,
+					USB_REQUEST_ION_EXEC_DL_CODE,
+					0x40, 0x4000, 0x0001, NULL, 0, 3000,
+					GFP_KERNEL);
+	if (response)
+		dev_err(dev, "failed sending exec_dl_decode %d\n", response);
 
 	release_firmware(fw);
 }
-- 
2.17.1

