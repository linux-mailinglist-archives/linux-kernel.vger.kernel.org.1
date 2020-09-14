Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE49269056
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgINPnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgINPik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:38:40 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F76221F0;
        Mon, 14 Sep 2020 15:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600097906;
        bh=9e9ZbvMGYk/Ejz0s9gld8mWLyBfUmNRh8gmdGNZ//Vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFV00sYPH5iGgMgQ1McSQ7D8AQH69Ut47xObQdZ5OVRKlLtMK/L3RiVy5XiPHTPx8
         LhUw+tqv2+TB/TbU8aHYgasjMi9b4nWrlHxUyitVJkYbgpy/02ztqU+l40noTn8Wxk
         85cSJqJ3o6Htt3anFz5qtG3o3oXXSjOEXryd4sjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3 08/11] sound: line6: move to use usb_control_msg_send() and usb_control_msg_recv()
Date:   Mon, 14 Sep 2020 17:37:53 +0200
Message-Id: <20200914153756.3412156-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914153756.3412156-1-gregkh@linuxfoundation.org>
References: <20200914153756.3412156-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb_control_msg_send() and usb_control_msg_recv() calls can return
an error if a "short" write/read happens, and they can handle data off
of the stack, so move the driver over to using those calls instead,
saving some logic when dynamically allocating memory.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
 - no change from v2

v2:
 - Added reviewed-by from Takashi

 sound/usb/line6/driver.c   | 69 +++++++++++++++-----------------------
 sound/usb/line6/podhd.c    | 17 ++++------
 sound/usb/line6/toneport.c |  8 ++---
 3 files changed, 37 insertions(+), 57 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 60674ce4879b..601292c51491 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -337,23 +337,18 @@ int line6_read_data(struct usb_line6 *line6, unsigned address, void *data,
 {
 	struct usb_device *usbdev = line6->usbdev;
 	int ret;
-	unsigned char *len;
+	u8 len;
 	unsigned count;
 
 	if (address > 0xffff || datalen > 0xff)
 		return -EINVAL;
 
-	len = kmalloc(1, GFP_KERNEL);
-	if (!len)
-		return -ENOMEM;
-
 	/* query the serial number: */
-	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0), 0x67,
-			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			      (datalen << 8) | 0x21, address,
-			      NULL, 0, LINE6_TIMEOUT * HZ);
-
-	if (ret < 0) {
+	ret = usb_control_msg_send(usbdev, 0, 0x67,
+				   USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
+				   (datalen << 8) | 0x21, address, NULL, 0,
+				   LINE6_TIMEOUT * HZ);
+	if (ret) {
 		dev_err(line6->ifcdev, "read request failed (error %d)\n", ret);
 		goto exit;
 	}
@@ -362,45 +357,41 @@ int line6_read_data(struct usb_line6 *line6, unsigned address, void *data,
 	for (count = 0; count < LINE6_READ_WRITE_MAX_RETRIES; count++) {
 		mdelay(LINE6_READ_WRITE_STATUS_DELAY);
 
-		ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0), 0x67,
-				      USB_TYPE_VENDOR | USB_RECIP_DEVICE |
-				      USB_DIR_IN,
-				      0x0012, 0x0000, len, 1,
-				      LINE6_TIMEOUT * HZ);
-		if (ret < 0) {
+		ret = usb_control_msg_recv(usbdev, 0, 0x67,
+					   USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
+					   0x0012, 0x0000, &len, 1,
+					   LINE6_TIMEOUT * HZ);
+		if (ret) {
 			dev_err(line6->ifcdev,
 				"receive length failed (error %d)\n", ret);
 			goto exit;
 		}
 
-		if (*len != 0xff)
+		if (len != 0xff)
 			break;
 	}
 
 	ret = -EIO;
-	if (*len == 0xff) {
+	if (len == 0xff) {
 		dev_err(line6->ifcdev, "read failed after %d retries\n",
 			count);
 		goto exit;
-	} else if (*len != datalen) {
+	} else if (len != datalen) {
 		/* should be equal or something went wrong */
 		dev_err(line6->ifcdev,
 			"length mismatch (expected %d, got %d)\n",
-			(int)datalen, (int)*len);
+			(int)datalen, len);
 		goto exit;
 	}
 
 	/* receive the result: */
-	ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0), 0x67,
-			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			      0x0013, 0x0000, data, datalen,
-			      LINE6_TIMEOUT * HZ);
-
-	if (ret < 0)
+	ret = usb_control_msg_recv(usbdev, 0, 0x67,
+				   USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
+				   0x0013, 0x0000, data, datalen, LINE6_TIMEOUT * HZ);
+	if (ret)
 		dev_err(line6->ifcdev, "read failed (error %d)\n", ret);
 
 exit:
-	kfree(len);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(line6_read_data);
@@ -423,12 +414,10 @@ int line6_write_data(struct usb_line6 *line6, unsigned address, void *data,
 	if (!status)
 		return -ENOMEM;
 
-	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0), 0x67,
-			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			      0x0022, address, data, datalen,
-			      LINE6_TIMEOUT * HZ);
-
-	if (ret < 0) {
+	ret = usb_control_msg_send(usbdev, 0, 0x67,
+				   USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
+				   0x0022, address, data, datalen, LINE6_TIMEOUT * HZ);
+	if (ret) {
 		dev_err(line6->ifcdev,
 			"write request failed (error %d)\n", ret);
 		goto exit;
@@ -437,14 +426,10 @@ int line6_write_data(struct usb_line6 *line6, unsigned address, void *data,
 	for (count = 0; count < LINE6_READ_WRITE_MAX_RETRIES; count++) {
 		mdelay(LINE6_READ_WRITE_STATUS_DELAY);
 
-		ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0),
-				      0x67,
-				      USB_TYPE_VENDOR | USB_RECIP_DEVICE |
-				      USB_DIR_IN,
-				      0x0012, 0x0000,
-				      status, 1, LINE6_TIMEOUT * HZ);
-
-		if (ret < 0) {
+		ret = usb_control_msg_recv(usbdev, 0, 0x67,
+					   USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
+					   0x0012, 0x0000, status, 1, LINE6_TIMEOUT * HZ);
+		if (ret) {
 			dev_err(line6->ifcdev,
 				"receiving status failed (error %d)\n", ret);
 			goto exit;
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index eef45f7fef0d..a1261f55d62b 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -183,29 +183,25 @@ static const struct attribute_group podhd_dev_attr_group = {
 static int podhd_dev_start(struct usb_line6_podhd *pod)
 {
 	int ret;
-	u8 *init_bytes;
+	u8 init_bytes[8];
 	int i;
 	struct usb_device *usbdev = pod->line6.usbdev;
 
-	init_bytes = kmalloc(8, GFP_KERNEL);
-	if (!init_bytes)
-		return -ENOMEM;
-
-	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0),
+	ret = usb_control_msg_send(usbdev, 0,
 					0x67, USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
 					0x11, 0,
 					NULL, 0, LINE6_TIMEOUT * HZ);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(pod->line6.ifcdev, "read request failed (error %d)\n", ret);
 		goto exit;
 	}
 
 	/* NOTE: looks like some kind of ping message */
-	ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0), 0x67,
+	ret = usb_control_msg_recv(usbdev, 0, 0x67,
 					USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
 					0x11, 0x0,
 					init_bytes, 3, LINE6_TIMEOUT * HZ);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(pod->line6.ifcdev,
 			"receive length failed (error %d)\n", ret);
 		goto exit;
@@ -220,13 +216,12 @@ static int podhd_dev_start(struct usb_line6_podhd *pod)
 			goto exit;
 	}
 
-	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0),
+	ret = usb_control_msg_send(usbdev, 0,
 					USB_REQ_SET_FEATURE,
 					USB_TYPE_STANDARD | USB_RECIP_DEVICE | USB_DIR_OUT,
 					1, 0,
 					NULL, 0, LINE6_TIMEOUT * HZ);
 exit:
-	kfree(init_bytes);
 	return ret;
 }
 
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 94dd5e7ab2e6..a9b56085b76a 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -126,11 +126,11 @@ static int toneport_send_cmd(struct usb_device *usbdev, int cmd1, int cmd2)
 {
 	int ret;
 
-	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0), 0x67,
-			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			      cmd1, cmd2, NULL, 0, LINE6_TIMEOUT * HZ);
+	ret = usb_control_msg_send(usbdev, 0, 0x67,
+				   USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
+				   cmd1, cmd2, NULL, 0, LINE6_TIMEOUT * HZ);
 
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&usbdev->dev, "send failed (error %d)\n", ret);
 		return ret;
 	}
-- 
2.28.0

