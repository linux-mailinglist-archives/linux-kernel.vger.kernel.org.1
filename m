Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98823304EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404930AbhA0Ba0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392183AbhAZSfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:35:16 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B939C061574;
        Tue, 26 Jan 2021 10:34:36 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id w18so10934662pfu.9;
        Tue, 26 Jan 2021 10:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBTsPIheAREODwP7ehxYmG/rqbt0+8mgZWOAMNTxbTk=;
        b=FLafbb7XTRsKX1L715KcNJg+CKnrIAYDl4z0BCWsEL3BAed2CJrMAruBQHkjGdf9Hd
         JRiDavYtVe2Xen/sfUfAb5EK1/Kh5muVC8EY3FrjO0qfLfkmV8fwOKa2lM1cFbu+RmhT
         B9mNEybzMhPOTuMRk79VmW3MAnTZBoTzofVgNTAagqvp4yRssiYV4+BMTAip7lWbXwAG
         1IICIxLMSxv7ZfmOjbdceUTVDTJ2DFW9BAYPeY4eoFu4Ed5fFvrUXXCL8Y05XqQ9ZkAy
         HSGtojL/GP311Xu+FUv06mzVIdghRzMpjf44DA7xEMgBlj5lACdyKIV3oKAet03DGqfg
         HNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBTsPIheAREODwP7ehxYmG/rqbt0+8mgZWOAMNTxbTk=;
        b=jdugLVhsXtCCg+FFavyuV2bXEGQPE7MzJZnAbgfTV6wAwaPkHiu3BlhwNerBYms/4V
         GyEu6YpthvRQ0VuTmFHNBGgILPguo+eQNmYvgxTZgvBnXhWsNxZBzRcan8ovAcy/Al2t
         xZFDy3Uh3Ebqwo6tTO1RBbLcikLIxmkwAkfnvr6qcYVdCq2sOsPn2rfvX3887oDVCgAs
         GCko836Sj1Kq5qf/QjuwXOoi27q7BpOKv8uUHX/NM7/BbpPzXB1usw47ILV7SnHxKjXB
         Y3E6LyOwgM9PT4Tzvxfn9dbd4Ka8m4OY9FdOBAXk9AvxZkQN5tBPVC04uztruphI6dWW
         5rOg==
X-Gm-Message-State: AOAM531uSVZX9mNB+uiOeK2Tqj/ytGcC/IYH1nt4hCexH3FhlXQl6Rtr
        1s9EwJzA3AySDVPqP7Q61ITfknDF0azM5V9g+ig=
X-Google-Smtp-Source: ABdhPJx+KcEI8M10QX5h8Tn2JGd06zfMciGCORZutfxv+gahx/R8EXxq3UQTRvIhfCtDKIMy4CLBaQ==
X-Received: by 2002:a63:4443:: with SMTP id t3mr6947500pgk.297.1611686075647;
        Tue, 26 Jan 2021 10:34:35 -0800 (PST)
Received: from localhost.localdomain ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id y75sm472711pfg.119.2021.01.26.10.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:34:34 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Xu Wang <vulab@iscas.ac.cn>,
        Liu Shixin <liushixin2@huawei.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/12] usb: misc: appledisplay: update to use the usb_control_msg_{send|recv}() API
Date:   Wed, 27 Jan 2021 00:03:52 +0530
Message-Id: <20210126183403.911653-2-anant.thazhemadam@gmail.com>
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
For this reason, instances of usb_control_msg() have been replaced with
usb_control_msg_{recv|send}(), and all return value checking
conditions have also been modified appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/appledisplay.c | 46 ++++++++++++++-------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledisplay.c
index c8098e9b432e..117deb2fdc29 100644
--- a/drivers/usb/misc/appledisplay.c
+++ b/drivers/usb/misc/appledisplay.c
@@ -132,21 +132,17 @@ static int appledisplay_bl_update_status(struct backlight_device *bd)
 	pdata->msgdata[0] = 0x10;
 	pdata->msgdata[1] = bd->props.brightness;
 
-	retval = usb_control_msg(
-		pdata->udev,
-		usb_sndctrlpipe(pdata->udev, 0),
-		USB_REQ_SET_REPORT,
-		USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-		ACD_USB_BRIGHTNESS,
-		0,
-		pdata->msgdata, 2,
-		ACD_USB_TIMEOUT);
+	retval = usb_control_msg_send(pdata->udev,
+				      0,
+				      USB_REQ_SET_REPORT,
+				      USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+				      ACD_USB_BRIGHTNESS,
+				      0,
+				      pdata->msgdata, 2,
+				      ACD_USB_TIMEOUT, GFP_KERNEL);
 	mutex_unlock(&pdata->sysfslock);
 
-	if (retval < 0)
-		return retval;
-	else
-		return 0;
+	return retval;
 }
 
 static int appledisplay_bl_get_brightness(struct backlight_device *bd)
@@ -155,21 +151,17 @@ static int appledisplay_bl_get_brightness(struct backlight_device *bd)
 	int retval, brightness;
 
 	mutex_lock(&pdata->sysfslock);
-	retval = usb_control_msg(
-		pdata->udev,
-		usb_rcvctrlpipe(pdata->udev, 0),
-		USB_REQ_GET_REPORT,
-		USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-		ACD_USB_BRIGHTNESS,
-		0,
-		pdata->msgdata, 2,
-		ACD_USB_TIMEOUT);
-	if (retval < 2) {
-		if (retval >= 0)
-			retval = -EMSGSIZE;
-	} else {
+	retval = usb_control_msg_recv(pdata->udev,
+				      0,
+				      USB_REQ_GET_REPORT,
+				      USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+				      ACD_USB_BRIGHTNESS,
+				      0,
+				      pdata->msgdata, 2,
+				      ACD_USB_TIMEOUT, GFP_KERNEL);
+	if (retval == 0)
 		brightness = pdata->msgdata[1];
-	}
+
 	mutex_unlock(&pdata->sysfslock);
 
 	if (retval < 0)
-- 
2.25.1

