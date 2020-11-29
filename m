Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4952C79EA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgK2QIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbgK2QIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:08:16 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D96EC061A4F;
        Sun, 29 Nov 2020 08:07:21 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id u2so5082411pls.10;
        Sun, 29 Nov 2020 08:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YPy8zFLlglB838C7tV9i9EHJFUbRPp+lFfFEzIzekqU=;
        b=UsLqSkHna5sXWVzuKrVgppWT+IiSxGI8Ye2QkutFSAJMzs4UBFsHtmEsLUskW40osj
         7wTdbQ/f6VPMSekNcvpabRAB3uYV9geKhaxac59negrmmqAtUeK6NuXZi2ktx6pUYTm4
         G8WenEs1BCN1I5QCXfiBQCE0gdeHe2uNmhLI0KInzZeFpqedkaFVYcNLrvOdOdgKQs9S
         KEpRceI/r9r7YnSCbYMU/8c8kR6d1b4FGCD+Jf0I9aX6tJpxy0M+IQ4fJvQ8aBIVfK4z
         rTgxIzkX/8HALXYfZXKZkEUGFP/Xj+yfpc8OlrGX3PGuqexXwW4AntWmEvh6Rl2R/T06
         De3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YPy8zFLlglB838C7tV9i9EHJFUbRPp+lFfFEzIzekqU=;
        b=Qt4bkVCOiZxxAdwR1NVzNt+pfz02ON1ST5FWMFTp2mCIN9ovpvWsmG6VImmhv2NLSU
         ZBjYYW+X2K2pUnpWCM0LoI38TwU89tDxZq/D0ViBZIiiv8R2U0d0Ce0ILS2fsJ+h7dNb
         l1N7u22NDN8G2aNPG6zqTOhghwchU+8hCmdqLV8PTTfy25Ti6P5rSy0x9sclN7+xBh2q
         qBXAqB2WwqOdJZarmfMkTVtoSOYxCvyXxa0maHeGqZKoPmDGS1VP64aDavvSsuTmkXQX
         AKjOmUym8pjvbpCeOYYdBKbNmSWy/n4ZxD4QRdhpVTUvimEs5yPUWrBXwJouJpo+uLml
         nxcw==
X-Gm-Message-State: AOAM533FupfdpekP/Oi+nt339gqopzEjtt6tXBELCC0VPAP1ntsFMiYB
        u72oQMciUObgZ6JZO5M8ODFInIJJgjvSTOmtyWk=
X-Google-Smtp-Source: ABdhPJwHf+z5//Kl5e1uIGdUj4cb7W+atRQzYlx0xbfR+lzfORAbIm55rvuAdho3NfuPJ6F/4eUEGA==
X-Received: by 2002:a17:902:744b:b029:da:74ca:b5f2 with SMTP id e11-20020a170902744bb02900da74cab5f2mr1682534plt.22.1606666041015;
        Sun, 29 Nov 2020 08:07:21 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:07:20 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Evgeny Novikov <novikov@ispras.ru>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] usb: misc: lvstest: update to use the usb_control_msg_{send|recv}() API
Date:   Sun, 29 Nov 2020 21:36:09 +0530
Message-Id: <20201129160612.1908074-13-anant.thazhemadam@gmail.com>
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
usb_control_msg_{recv|send}() and the return value checking conditions have
also been modified appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/lvstest.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/misc/lvstest.c b/drivers/usb/misc/lvstest.c
index f8686139d6f3..ab08483258d2 100644
--- a/drivers/usb/misc/lvstest.c
+++ b/drivers/usb/misc/lvstest.c
@@ -85,17 +85,17 @@ static void destroy_lvs_device(struct usb_device *udev)
 static int lvs_rh_clear_port_feature(struct usb_device *hdev,
 		int port1, int feature)
 {
-	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
+	return usb_control_msg_send(hdev, 0,
 		USB_REQ_CLEAR_FEATURE, USB_RT_PORT, feature, port1,
-		NULL, 0, 1000);
+		NULL, 0, 1000, GFP_KERNEL);
 }
 
 static int lvs_rh_set_port_feature(struct usb_device *hdev,
 		int port1, int feature)
 {
-	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
+	return usb_control_msg_send(hdev, 0,
 		USB_REQ_SET_FEATURE, USB_RT_PORT, feature, port1,
-		NULL, 0, 1000);
+		NULL, 0, 1000, GFP_KERNEL);
 }
 
 static ssize_t u3_entry_store(struct device *dev,
@@ -271,10 +271,10 @@ static ssize_t get_dev_desc_store(struct device *dev,
 		goto free_desc;
 	}
 
-	ret = usb_control_msg(udev, (PIPE_CONTROL << 30) | USB_DIR_IN,
-			USB_REQ_GET_DESCRIPTOR, USB_DIR_IN, USB_DT_DEVICE << 8,
-			0, descriptor, sizeof(*descriptor),
-			USB_CTRL_GET_TIMEOUT);
+	ret = usb_control_msg_recv(udev, 0, USB_REQ_GET_DESCRIPTOR,
+				   USB_DIR_IN, USB_DT_DEVICE << 8,
+				   0, descriptor, sizeof(*descriptor),
+				   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
 	if (ret < 0)
 		dev_err(dev, "can't read device descriptor %d\n", ret);
 
@@ -336,10 +336,10 @@ static void lvs_rh_work(struct work_struct *work)
 
 	/* Examine each root port */
 	for (i = 1; i <= descriptor->bNbrPorts; i++) {
-		ret = usb_control_msg(hdev, usb_rcvctrlpipe(hdev, 0),
+		ret = usb_control_msg_recv(hdev, 0,
 			USB_REQ_GET_STATUS, USB_DIR_IN | USB_RT_PORT, 0, i,
-			port_status, sizeof(*port_status), 1000);
-		if (ret < 4)
+			port_status, sizeof(*port_status), 1000, GFP_KERNEL);
+		if (ret < 0)
 			continue;
 
 		portchange = le16_to_cpu(port_status->wPortChange);
@@ -420,13 +420,13 @@ static int lvs_rh_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, lvs);
 
 	/* how many number of ports this root hub has */
-	ret = usb_control_msg(hdev, usb_rcvctrlpipe(hdev, 0),
+	ret = usb_control_msg_recv(hdev, 0,
 			USB_REQ_GET_DESCRIPTOR, USB_DIR_IN | USB_RT_HUB,
 			USB_DT_SS_HUB << 8, 0, &lvs->descriptor,
-			USB_DT_SS_HUB_SIZE, USB_CTRL_GET_TIMEOUT);
-	if (ret < (USB_DT_HUB_NONVAR_SIZE + 2)) {
+			USB_DT_SS_HUB_SIZE, USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+	if (ret < 0) {
 		dev_err(&hdev->dev, "wrong root hub descriptor read %d\n", ret);
-		return ret < 0 ? ret : -EINVAL;
+		return ret;
 	}
 
 	/* submit urb to poll interrupt endpoint */
-- 
2.25.1

