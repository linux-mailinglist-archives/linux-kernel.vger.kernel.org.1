Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538E2304F01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405180AbhA0Bdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732119AbhAZSh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:37:56 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B08C061793;
        Tue, 26 Jan 2021 10:35:33 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id a20so2510295pjs.1;
        Tue, 26 Jan 2021 10:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95JYXv08LkqT4lJAkAX254N/wQjJtpCwzdAOrY3gErU=;
        b=Dolr8a9elQ0PIDTVE7L2/3E4EEbsuNSxB0POXTZggKOXxEC16AYD67PxbG/y+9VZt2
         NhkfThCDS6LFCKVSaffoL2SUg1DxktM3jYqkgQIESkEoycu26cPJe7aYGzptVzAJ4C4b
         SZJYU1fPIKOYsg87iWRsRU+aEg60/W+RFyKao9sCZMHwxaS463VVq+Oisuj0BxZFysWw
         5YkNxEKdoQx4AcPOmOdsMRvJyRUHSyd+Dy5GUX/qRy6hohOxa96RJrNFyS1MmBblRVLm
         lLgOY3+bwZvlDgy4BxhXaCJGDKyc/0RI2CvMphFbun+c1G1Z38MJqTfImFduJARcFB5b
         LnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95JYXv08LkqT4lJAkAX254N/wQjJtpCwzdAOrY3gErU=;
        b=svl8wxFhiJmw7kfIy88tx6EZf5ioW6ixuY0lKtXUB0cupriuxYh7qbCLo1oyZAD5d9
         OaXhhgOCh6vvO9tzaFgPfrH0/Al1/XF4XmCY6TW0VriXT5Cd/2hnKPUpMv3XXWLtYQlc
         /6+RFvnHkZumOLZeVmaetahglNyWiIcoWVYOPz1jtcw182sRjtTwgfBQQ9rADOG6MGyJ
         cuT+2bNuqlvM9PhOoXt+cPWN7JxbSiW+nTQSm3mgWeYBlAgw69hCVdXg1PKU8h6Veixa
         7fZl9PEum0OPNcs1mLbTw3S0C1buyWpVLRz5expm6P1ii5QgFkoZDGSswjKtqZZ6FfU9
         EQyA==
X-Gm-Message-State: AOAM533tAlPUgzcpko3N+LCixoiN7fpb84haGqwIuqivPEtQBkQkDtaZ
        G5/p0KoUnRugFb+2wMqd1JA=
X-Google-Smtp-Source: ABdhPJxBMu87daLeeLaodAkuXJ/Peu/ZZtm3MNLhjGUOFLlBWGJ5LAus9xQej+0yDB4i0H+E2Ds7/g==
X-Received: by 2002:a17:90a:9602:: with SMTP id v2mr1190230pjo.28.1611686132693;
        Tue, 26 Jan 2021 10:35:32 -0800 (PST)
Received: from localhost.localdomain ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id y75sm472711pfg.119.2021.01.26.10.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:35:31 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Tom Rix <trix@redhat.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/12] usb: misc: iowarrior: update to use the usb_control_msg_{send|recv}() API
Date:   Wed, 27 Jan 2021 00:03:57 +0530
Message-Id: <20210126183403.911653-7-anant.thazhemadam@gmail.com>
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
usb_control_msg_{recv|send}() appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/iowarrior.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index efbd317f2f25..9d6a7548e537 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -109,12 +109,12 @@ static int usb_get_report(struct usb_device *dev,
 			  struct usb_host_interface *inter, unsigned char type,
 			  unsigned char id, void *buf, int size)
 {
-	return usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
-			       USB_REQ_GET_REPORT,
-			       USB_DIR_IN | USB_TYPE_CLASS |
-			       USB_RECIP_INTERFACE, (type << 8) + id,
-			       inter->desc.bInterfaceNumber, buf, size,
-			       GET_TIMEOUT*HZ);
+	return usb_control_msg_recv(dev, 0,
+				    USB_REQ_GET_REPORT,
+				    USB_DIR_IN | USB_TYPE_CLASS |
+				    USB_RECIP_INTERFACE, (type << 8) + id,
+				    inter->desc.bInterfaceNumber, buf, size,
+				    GET_TIMEOUT*HZ, GFP_KERNEL);
 }
 //#endif
 
@@ -123,13 +123,13 @@ static int usb_get_report(struct usb_device *dev,
 static int usb_set_report(struct usb_interface *intf, unsigned char type,
 			  unsigned char id, void *buf, int size)
 {
-	return usb_control_msg(interface_to_usbdev(intf),
-			       usb_sndctrlpipe(interface_to_usbdev(intf), 0),
-			       USB_REQ_SET_REPORT,
-			       USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			       (type << 8) + id,
-			       intf->cur_altsetting->desc.bInterfaceNumber, buf,
-			       size, HZ);
+	return usb_control_msg_send(interface_to_usbdev(intf),
+				    0,
+				    USB_REQ_SET_REPORT,
+				    USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+				    (type << 8) + id,
+				    intf->cur_altsetting->desc.bInterfaceNumber, buf,
+				    size, HZ, GFP_KERNEL);
 }
 
 /*---------------------*/
@@ -851,10 +851,10 @@ static int iowarrior_probe(struct usb_interface *interface,
 
 	/* Set the idle timeout to 0, if this is interface 0 */
 	if (dev->interface->cur_altsetting->desc.bInterfaceNumber == 0) {
-	    usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-			    0x0A,
-			    USB_TYPE_CLASS | USB_RECIP_INTERFACE, 0,
-			    0, NULL, 0, USB_CTRL_SET_TIMEOUT);
+		usb_control_msg_send(udev, 0,
+				     0x0A,
+				     USB_TYPE_CLASS | USB_RECIP_INTERFACE, 0,
+				     0, NULL, 0, USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
 	}
 	/* allow device read and ioctl */
 	dev->present = 1;
-- 
2.25.1

