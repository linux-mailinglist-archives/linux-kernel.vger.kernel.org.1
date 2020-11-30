Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD62C7C57
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgK3BYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgK3BYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:24:14 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3BAC0613D3;
        Sun, 29 Nov 2020 17:23:34 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id t21so311723pjw.2;
        Sun, 29 Nov 2020 17:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBTsPIheAREODwP7ehxYmG/rqbt0+8mgZWOAMNTxbTk=;
        b=sOIIrb2ge9ByKCOwVRraxrZb42+0eKIIh9/KwI88AapVeOifgOAUSh+SV72ZD7OJiO
         O7PSp3o5W6g3tU3atxT3nH2r8T+2+/GDb0acoGFnMOEU7/7NgH4rXEvU54V02jRDH8Sg
         4XU/XRulSzAUse66AHvXeQYZEgnSOAaaKgrjcmIRS/mwIjRAlYpxDCi/I3BfaMpQ6vYQ
         TThHuWrIT6NiQuk3VKGw07BWJoAJoB0mZBvoY4J/1CL+QLMjh8nrA0MpytYCnYGKAixc
         HaY6yjYw1WZ0vnc8UDvvBobyH7Rb7fry7ydyzz7V74bb3SVpQ9w1Mo4m5oiYnKmY5sqI
         jQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBTsPIheAREODwP7ehxYmG/rqbt0+8mgZWOAMNTxbTk=;
        b=VkoG/bBZRD+N6kKOk8Hi4zs2xefSAHSW9vD2W8aEJraY3+RRs1qJAHzv3yrePzfvAn
         ekUMN6KjXTPwaXIu7UNwdTfnRPpJnY0ra9G9TP+CTkH7hpdwF5M3whbsa85HMCG9LXnM
         sKXGENexEtVxp1Sa21/rzaPvlyuray3svHH/pnTesWcAUcu/PPIbpH662s0joVSqzjTb
         NF8uDNG7TUxi3ztBo3KRJI20mpwZyHA7COmJlSiR62Jb4mUBjI1NkXo68NY9Q515Sy6D
         R4AvB5cxLjaN6Ckvsn9NplFcuiU37vOKhcc7dkGC7YXaQJ41GmEQUQF3sAoAL9lBn2xi
         cJhg==
X-Gm-Message-State: AOAM530kcw3YaDsSQCozyxL56ILOgjsMdBcHjtYrocLVpHfbqRgmSBJl
        y4gpgKui9DsvzJOxmS4NQ6C90wh6LdDzSM7DoO4=
X-Google-Smtp-Source: ABdhPJxOEBBAQJP/L/NnOm+nJUbdgvpayTNcNXn28TnZyKKTqgS8CdmZNpNps4+CuhELzP0g9zW+pg==
X-Received: by 2002:a17:902:b70d:b029:da:5196:1181 with SMTP id d13-20020a170902b70db02900da51961181mr11610150pls.81.1606699414111;
        Sun, 29 Nov 2020 17:23:34 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id ds24sm4373196pjb.30.2020.11.29.17.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:23:33 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Xu Wang <vulab@iscas.ac.cn>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/15] usb: misc: appledisplay: update to use the usb_control_msg_{send|recv}() API
Date:   Mon, 30 Nov 2020 06:53:13 +0530
Message-Id: <20201130012313.2577352-1-anant.thazhemadam@gmail.com>
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

