Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DF32C79D5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgK2QHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2QHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:07:25 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED922C0613D2;
        Sun, 29 Nov 2020 08:06:44 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 131so8706465pfb.9;
        Sun, 29 Nov 2020 08:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBTsPIheAREODwP7ehxYmG/rqbt0+8mgZWOAMNTxbTk=;
        b=qydIOokw2Re/YuYWXJauusN5uESxZCIIW6aCdBgluPCoWysPPFDeGn3FlZcfzyCLX5
         aBNJ3nK59ovgVNLhlg0Ppmn0nCSAQ9Kx7PvaVr2rHCRreye7HOMhKCO11kzgvRYHX3t+
         z0yva3s2q+AwLtqO+SdmvWQiqSwXzzJ20TheK6yBIMMp+F7An0M6X4nSzrVil8/edjos
         60jYMDO3TYNWS5TwNVGS5cTJL5pTgfVbQq0oUDYcDIuKeOF3DzVyO5bsOeuV7EIQZIAT
         e1gnP8bxX8pe84RO40bup8SGMi0jJpDCGar+/g+lMTclN6ymr5niTcPeJRMhU7BT1HLI
         oSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBTsPIheAREODwP7ehxYmG/rqbt0+8mgZWOAMNTxbTk=;
        b=jtwquaSeyLHS054R0R83EedB1EiUim+bS7wgpn0XhwTEda9dlUzn0qeKnWEfSBGeNR
         BLTqYoE/71a57qvb0fsgUB2EOU671b0nSJrXKjb9DG7wliyk5dThnemFvszCaUI1UuVe
         SvmuTAl3kThrKZMSp2+AnhmZqtA3hlyVhlAdOzGZmZCw5KImx6DzXDzSGd8w07XfRB8w
         ysK4JNSpb4P2COIg9Si0kg+Bsj8xlMqIHv/Fy5Q+0TOg+eYbOlftv4huwaCl6lT0KoKz
         Z6BxVBRZkuD8uhCAKsbvJ3gaFoPZXcw8dU59CPGDjRy+dHPESGyuSBMN4YzRjLosrgNv
         7ncQ==
X-Gm-Message-State: AOAM531CR+PnRO3sZCXTIgEa4wE0XVbtlxiMrkGCmPdvv/ZPN3EwmG4H
        NZaCPNOHBqZG7Nd1TPYVjSk=
X-Google-Smtp-Source: ABdhPJwQtNEjxcK454KvvMov3fJIFKaXWf6eIuD+5dUDh+BSyS1tPQhWEsFWe0MmlydSZkGlI9+xRQ==
X-Received: by 2002:a17:90a:178b:: with SMTP id q11mr21178239pja.132.1606666004396;
        Sun, 29 Nov 2020 08:06:44 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:06:43 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Xu Wang <vulab@iscas.ac.cn>,
        Liu Shixin <liushixin2@huawei.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] usb: misc: appledisplay: update to use the usb_control_msg_{send|recv}() API
Date:   Sun, 29 Nov 2020 21:35:58 +0530
Message-Id: <20201129160612.1908074-2-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201129160612.1908074-1-anant.thazhemadam@gmail.com>
References: <20201129160612.1908074-1-anant.thazhemadam@gmail.com>
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

