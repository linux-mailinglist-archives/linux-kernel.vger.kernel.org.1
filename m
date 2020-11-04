Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5532A5E46
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgKDGry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgKDGrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:47:52 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C91C040203;
        Tue,  3 Nov 2020 22:47:52 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x13so16489698pfa.9;
        Tue, 03 Nov 2020 22:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XBI1Crl/gsGXbbSC9BdECEbU8Eop484Fu7YnX4s2KCI=;
        b=m+E6aOegAQX7/eaZA7zz/VkVlNlQU1g1l4KUxB/l05xKwUXlPo91NshtD7iV/dNcP8
         pUIhatW7I6vplsSlVMkbHyP+Rkw8OqMqkuptDmJK5WgR1tvOrmVH6lehbvz/Z0IJCmeI
         HvJEBWb7e70+rlWkFwuNT1NrCLkk5p5FoPPKW6x0tCTgmIlLyFoT+FFlbLlcTib1oy1R
         pn8XwZIFTv6hWjkX++sYVO67pRewBrWKuTci2KPuWF3q5mQZQi68xhRbHQNwN69E9WSn
         z9exQzlAZglQXOEJbMfgSNmFDj8arz1I/ygfxQa39D/jTd7qYTPwJxpoPckGD+b8rPN7
         FYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XBI1Crl/gsGXbbSC9BdECEbU8Eop484Fu7YnX4s2KCI=;
        b=eU2TCtyvuKNnVq3D+SmUDdZufGg523Nz6gI5rWXAbuFYhEN8dhtetGQp8z3KNgdJxk
         A5GE0LXoXEus+hAULyMxy7w9oCuExRbsVqVxJolu2HVQ79FtpQOK+tu50pVKfl6T96dw
         Tixvwmvt9Krb1zZABiTr63bxKhi9rLnFdCZkLHVmV4ZwJdJV1dk/50dppFSVW7+PsFsi
         7ctJqzSPQTkxZoaQGad7o3+PScywDh1Z1BT7TceV5AwguMXoP0xipLINc+gAXpcIAYnp
         lyZyevJluAKivsHV7mLoCiWxKguxFTVphty3g0370RYP+Or7tp7ibZQlXLB5m13A063q
         cDjQ==
X-Gm-Message-State: AOAM530aIyijQHGkCFZJu8FJ45FMGEAJg4c+ZKSKYxYM0N3tevPXtqHX
        CF+nTB0ATqfZiOVJJtKLz3Q=
X-Google-Smtp-Source: ABdhPJxyahSG3Vg1L10IOgHREuHBbGgfWEMvNNEfg8kcJOgNP3l4vTYkhWXcdi1L8TDTBk4Blnx9nQ==
X-Received: by 2002:a63:4825:: with SMTP id v37mr20000208pga.256.1604472471640;
        Tue, 03 Nov 2020 22:47:51 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:47:51 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 06/15] usb: serial: f81232: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:16:54 +0530
Message-Id: <20201104064703.15123-7-himadrispandya@gmail.com>
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
 drivers/usb/serial/f81232.c | 88 ++++++++-----------------------------
 1 file changed, 18 insertions(+), 70 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 0c7eacc630e0..78107feef8a8 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -139,71 +139,36 @@ static int calc_baud_divisor(speed_t baudrate, speed_t clockrate)
 static int f81232_get_register(struct usb_serial_port *port, u16 reg, u8 *val)
 {
 	int status;
-	u8 *tmp;
 	struct usb_device *dev = port->serial->dev;
 
-	tmp = kmalloc(sizeof(*val), GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
-
-	status = usb_control_msg(dev,
-				usb_rcvctrlpipe(dev, 0),
-				F81232_REGISTER_REQUEST,
-				F81232_GET_REGISTER,
-				reg,
-				0,
-				tmp,
-				sizeof(*val),
-				USB_CTRL_GET_TIMEOUT);
-	if (status != sizeof(*val)) {
+	status = usb_control_msg_recv(dev, 0, F81232_REGISTER_REQUEST,
+				      F81232_GET_REGISTER, reg, 0, val,
+				      sizeof(*val), USB_CTRL_GET_TIMEOUT,
+				      GFP_KERNEL);
+	if (status) {
 		dev_err(&port->dev, "%s failed status: %d\n", __func__, status);
 
-		if (status < 0)
-			status = usb_translate_errors(status);
-		else
-			status = -EIO;
-	} else {
-		status = 0;
-		*val = *tmp;
+		status = usb_translate_errors(status);
 	}
 
-	kfree(tmp);
 	return status;
 }
 
 static int f81232_set_register(struct usb_serial_port *port, u16 reg, u8 val)
 {
 	int status;
-	u8 *tmp;
 	struct usb_device *dev = port->serial->dev;
 
-	tmp = kmalloc(sizeof(val), GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
-
-	*tmp = val;
-
-	status = usb_control_msg(dev,
-				usb_sndctrlpipe(dev, 0),
-				F81232_REGISTER_REQUEST,
-				F81232_SET_REGISTER,
-				reg,
-				0,
-				tmp,
-				sizeof(val),
-				USB_CTRL_SET_TIMEOUT);
-	if (status != sizeof(val)) {
+	status = usb_control_msg_send(dev, 0,
+				      F81232_REGISTER_REQUEST,
+				      F81232_SET_REGISTER, reg, 0,
+				      &val, sizeof(val), USB_CTRL_SET_TIMEOUT,
+				      GFP_KERNEL);
+	if (status) {
 		dev_err(&port->dev, "%s failed status: %d\n", __func__, status);
 
-		if (status < 0)
-			status = usb_translate_errors(status);
-		else
-			status = -EIO;
-	} else {
-		status = 0;
+		status = usb_translate_errors(status);
 	}
-
-	kfree(tmp);
 	return status;
 }
 
@@ -866,32 +831,16 @@ static int f81534a_ctrl_set_register(struct usb_interface *intf, u16 reg,
 	struct usb_device *dev = interface_to_usbdev(intf);
 	int retry = F81534A_ACCESS_REG_RETRY;
 	int status;
-	u8 *tmp;
-
-	tmp = kmemdup(val, size, GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
 
 	while (retry--) {
-		status = usb_control_msg(dev,
-					usb_sndctrlpipe(dev, 0),
-					F81232_REGISTER_REQUEST,
-					F81232_SET_REGISTER,
-					reg,
-					0,
-					tmp,
-					size,
-					USB_CTRL_SET_TIMEOUT);
-		if (status < 0) {
+		status = usb_control_msg_send(dev, 0, F81232_REGISTER_REQUEST,
+					      F81232_SET_REGISTER, reg, 0, val,
+					      size, USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+		if (status) {
+			/* Retry on error or short transfers */
 			status = usb_translate_errors(status);
 			if (status == -EIO)
 				continue;
-		} else if (status != size) {
-			/* Retry on short transfers */
-			status = -EIO;
-			continue;
-		} else {
-			status = 0;
 		}
 
 		break;
@@ -902,7 +851,6 @@ static int f81534a_ctrl_set_register(struct usb_interface *intf, u16 reg,
 				reg, status);
 	}
 
-	kfree(tmp);
 	return status;
 }
 
-- 
2.17.1

