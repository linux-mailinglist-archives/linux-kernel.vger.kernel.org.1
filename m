Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7315D2A5E55
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgKDGsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729214AbgKDGsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:48:16 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6BEC061A4D;
        Tue,  3 Nov 2020 22:48:15 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id k7so538464plk.3;
        Tue, 03 Nov 2020 22:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s90dzJNynJlXhu5PFXW3xxoyQNWm3vOkTOAC4HZYz6M=;
        b=GoC8DcFIeGeve61407Y1kAJsW0emtoExF3ZW1bYgNGvd8lw2rSd/bX2YMnzsHSfLP4
         WLxx1vZ9gYbUzyYG7pn5TyQ0O6Cp1nIAtE62V4UMmRL9yoCClSIRAlLqB2igWMJ6+gEO
         Yfo4nrQZzwM832c+C14C+bWbXgEiX11EczJp77IA4p2SL53F473qZkyJn5tdJSLRvVOe
         lDY9E9Y9LDz0nNbuBw9liCcQAvLiljJP+prf2mZHyXZZljlyEjVKWrl2+UD2Ll/HKbt7
         +Q4yAb2r3mRUlgeFpDRNc6as/L9Lv4RUsXhLc2pkVGl+1/QPfUEtpQ6vgfdT/EsKaD9M
         t3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s90dzJNynJlXhu5PFXW3xxoyQNWm3vOkTOAC4HZYz6M=;
        b=Ap3G21OeYrVWGZCpM5HJxM2CXbml4i8SQcdXBSRB5Ek8nvgIhVzR9FS8rc/Ps3GhO6
         l/WN/Cm3Gy5zU0QmKzBc1Hfl9gaXacal7rLuK2SpZzTGKRyAShl2QJNgKDYUXeQLez+r
         IoJtfM+ATxUSmKWB+BBQ1xq2zsIxHFuQmsXopXok2h98FGaoHfw7fZuaWsInf39HS4Dt
         wJ0v6iT51jNv2WL90XjAJ1My8LMUSklmBfGZjlOzDHQCJ+eOwSg64k6XV4yZiwlsYxGT
         AtztxnopEDJhxYI/gach62qvM5VjWcle7n0Bm9rdQISr0EqML3fp0NJQrSQm6e7robPN
         KxOw==
X-Gm-Message-State: AOAM532JwHXPaxVsjxqigsCSOsPavojIndIgBBlF0fcBe2Xa7lB1cXrY
        wELmb4VIAPaf4HWwvB1Cb9s=
X-Google-Smtp-Source: ABdhPJwozhFZg8sFa6GjYjDZ6TJ0QDReAQ3JswDWFl8ldK9dTIXvTW7GEenCRHqg9sWFdeBDO9IaMg==
X-Received: by 2002:a17:902:864b:b029:d3:ce46:2829 with SMTP id y11-20020a170902864bb02900d3ce462829mr29662922plt.16.1604472495216;
        Tue, 03 Nov 2020 22:48:15 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:48:14 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 12/15] usb: serial: ipw: use usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:17:00 +0530
Message-Id: <20201104064703.15123-13-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104064703.15123-1-himadrispandya@gmail.com>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new usb_control_msg_send() nicely wraps usb_control_msg() with proper
error check. Hence use the wrapper instead of calling usb_control_msg()
directly.

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
 drivers/usb/serial/ipw.c | 107 +++++++++++++--------------------------
 1 file changed, 36 insertions(+), 71 deletions(-)

diff --git a/drivers/usb/serial/ipw.c b/drivers/usb/serial/ipw.c
index d04c7cc5c1c2..3c3895b4dff8 100644
--- a/drivers/usb/serial/ipw.c
+++ b/drivers/usb/serial/ipw.c
@@ -134,26 +134,16 @@ static int ipw_open(struct tty_struct *tty, struct usb_serial_port *port)
 	struct usb_device *udev = port->serial->dev;
 	struct device *dev = &port->dev;
 	u8 buf_flow_static[16] = IPW_BYTES_FLOWINIT;
-	u8 *buf_flow_init;
 	int result;
 
-	buf_flow_init = kmemdup(buf_flow_static, 16, GFP_KERNEL);
-	if (!buf_flow_init)
-		return -ENOMEM;
-
 	/* --1: Tell the modem to initialize (we think) From sniffs this is
 	 *	always the first thing that gets sent to the modem during
 	 *	opening of the device */
 	dev_dbg(dev, "%s: Sending SIO_INIT (we guess)\n", __func__);
-	result = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-			 IPW_SIO_INIT,
-			 USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
-			 0,
-			 0, /* index */
-			 NULL,
-			 0,
-			 100000);
-	if (result < 0)
+	result = usb_control_msg_send(udev, 0, IPW_SIO_INIT, USB_TYPE_VENDOR |
+				      USB_RECIP_INTERFACE | USB_DIR_OUT, 0,
+				      0,  NULL, 0, 100000, GFP_KERNEL);
+	if (result)
 		dev_err(dev, "Init of modem failed (error = %d)\n", result);
 
 	/* reset the bulk pipes */
@@ -166,31 +156,22 @@ static int ipw_open(struct tty_struct *tty, struct usb_serial_port *port)
 
 	/*--3: Tell the modem to open the floodgates on the rx bulk channel */
 	dev_dbg(dev, "%s:asking modem for RxRead (RXBULK_ON)\n", __func__);
-	result = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-			 IPW_SIO_RXCTL,
-			 USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
-			 IPW_RXBULK_ON,
-			 0, /* index */
-			 NULL,
-			 0,
-			 100000);
-	if (result < 0)
+	result = usb_control_msg_send(udev, 0, IPW_SIO_RXCTL, USB_TYPE_VENDOR |
+				      USB_RECIP_INTERFACE | USB_DIR_OUT,
+				      IPW_RXBULK_ON, 0, NULL, 0, 100000,
+				      GFP_KERNEL);
+	if (result)
 		dev_err(dev, "Enabling bulk RxRead failed (error = %d)\n", result);
 
 	/*--4: setup the initial flowcontrol */
-	dev_dbg(dev, "%s:setting init flowcontrol (%s)\n", __func__, buf_flow_init);
-	result = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-			 IPW_SIO_HANDFLOW,
-			 USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
-			 0,
-			 0,
-			 buf_flow_init,
-			 0x10,
-			 200000);
-	if (result < 0)
+	dev_dbg(dev, "%s:setting init flowcontrol (%s)\n", __func__, buf_flow_static);
+	result = usb_control_msg_send(udev, 0, IPW_SIO_HANDFLOW,
+				      USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
+				      USB_DIR_OUT, 0, 0, &buf_flow_static, 0x10,
+				      200000, GFP_KERNEL);
+	if (result)
 		dev_err(dev, "initial flowcontrol failed (error = %d)\n", result);
 
-	kfree(buf_flow_init);
 	return 0;
 }
 
@@ -223,26 +204,20 @@ static void ipw_dtr_rts(struct usb_serial_port *port, int on)
 
 	dev_dbg(dev, "%s: on = %d\n", __func__, on);
 
-	result = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-			 IPW_SIO_SET_PIN,
-			 USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
-			 on ? IPW_PIN_SETDTR : IPW_PIN_CLRDTR,
-			 0,
-			 NULL,
-			 0,
-			 200000);
-	if (result < 0)
+	result = usb_control_msg_send(udev, 0, IPW_SIO_SET_PIN,
+				      USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
+				      USB_DIR_OUT,
+				      on ? IPW_PIN_SETDTR : IPW_PIN_CLRDTR, 0,
+				      NULL, 0, 200000, GFP_KERNEL);
+	if (result)
 		dev_err(dev, "setting dtr failed (error = %d)\n", result);
 
-	result = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-			 IPW_SIO_SET_PIN, USB_TYPE_VENDOR |
-					USB_RECIP_INTERFACE | USB_DIR_OUT,
-			 on ? IPW_PIN_SETRTS : IPW_PIN_CLRRTS,
-			 0,
-			 NULL,
-			 0,
-			 200000);
-	if (result < 0)
+	result = usb_control_msg_send(udev, 0, IPW_SIO_SET_PIN,
+				      USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
+				      USB_DIR_OUT,
+				      on ? IPW_PIN_SETRTS : IPW_PIN_CLRRTS,
+				      0, NULL, 0, 200000, GFP_KERNEL);
+	if (result)
 		dev_err(dev, "setting rts failed (error = %d)\n", result);
 }
 
@@ -254,30 +229,20 @@ static void ipw_close(struct usb_serial_port *port)
 
 	/*--3: purge */
 	dev_dbg(dev, "%s:sending purge\n", __func__);
-	result = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-			 IPW_SIO_PURGE, USB_TYPE_VENDOR |
-			 		USB_RECIP_INTERFACE | USB_DIR_OUT,
-			 0x03,
-			 0,
-			 NULL,
-			 0,
-			 200000);
-	if (result < 0)
+	result = usb_control_msg_send(udev, 0, IPW_SIO_PURGE, USB_TYPE_VENDOR |
+				      USB_RECIP_INTERFACE | USB_DIR_OUT, 0x03,
+				      0, NULL, 0, 200000, GFP_KERNEL);
+	if (result)
 		dev_err(dev, "purge failed (error = %d)\n", result);
 
 
 	/* send RXBULK_off (tell modem to stop transmitting bulk data on
 	   rx chan) */
-	result = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-			 IPW_SIO_RXCTL,
-			 USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
-			 IPW_RXBULK_OFF,
-			 0, /* index */
-			 NULL,
-			 0,
-			 100000);
-
-	if (result < 0)
+	result = usb_control_msg_send(udev, 0, IPW_SIO_RXCTL, USB_TYPE_VENDOR |
+				      USB_RECIP_INTERFACE | USB_DIR_OUT,
+				      IPW_RXBULK_OFF, 0, NULL, 0, 100000, GFP_KERNEL);
+
+	if (result)
 		dev_err(dev, "Disabling bulk RxRead failed (error = %d)\n", result);
 
 	usb_wwan_close(port);
-- 
2.17.1

