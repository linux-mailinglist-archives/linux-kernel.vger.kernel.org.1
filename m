Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4EA2C79E6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbgK2QIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbgK2QIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:08:11 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5120C061A4B;
        Sun, 29 Nov 2020 08:07:11 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b10so7318144pfo.4;
        Sun, 29 Nov 2020 08:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5CycBkayIPEKy8ugUk9noRpeNNqE1DQEMX4hGWZ348I=;
        b=PIxXXNg+pnWRPHUK0/ek9Amg+GWPUzIPcCxMkrD0JgekPFsMvsn2tea/kJpNr42GwR
         ETzQTHgxZgqXz35xtWHca1u+uz7B6tcFDgi8vdlX4FIe0hihQZcTMYzOtIAaixeJqJ87
         2pdHicfjVOaB/iQs4UprYt0kSO6jhYN5ZKmmoOD01j5M+M1PMxR8km8HOcZ1AMLRaPjZ
         1yI/Ls++eDxbTRMYUOsCI/YDM40HcuwPo8Tljpgkkof+c1yrpoBDTykrw70B8HFw0yBY
         yoLMrbB6SXCXf1BZ48jiNT0mO7M8nuv9oKGRfDxvRLN1VkwcQ7hAmsc3+gAyAdyH0gUr
         VCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5CycBkayIPEKy8ugUk9noRpeNNqE1DQEMX4hGWZ348I=;
        b=A7Mgb1toC1zVKQPLIh7A2gj16MFyOD0xtOwlteSzSyhhXrZlPVguieoqyC3MhOmaKv
         rpZl806dlGFWjp2wt/rwVRfNN5mKdPXj40BXCjE58mSNRGyGY+LQDHhVE506J0IEFiON
         vl3v40d8SAsfG0H6lHJtOov27ugUS6bL5Ny8Bticq6XJAiSR8oL1/7X9VsN2wjABKyKJ
         j56f4v54v5u5CbvLOad5DSBXGdC2Ab4V/wWm9zX+djoTm0WAEDXFHYM7D7hgvIZLa8Z4
         +Qiy/rJgrgjw1T+/TZ1w/CSloYAXijXfPzLcpD3ZKdHu56Flq+ccdyaSQhSgz68YtzvS
         3TTg==
X-Gm-Message-State: AOAM533Axzw75AJx0W6X4XlmLPKH81lEop6O68pZ311MlIhTlZbP2DKS
        /pafqD4WBWSstBRdH1dp/qg=
X-Google-Smtp-Source: ABdhPJz59fCfpH/zm5j8/sl9EhXbXXVXZ2drRtTHFYUB5mfSK3+CUEvrHEB0leb9GFaBg+ZE77H8kg==
X-Received: by 2002:a17:90b:3687:: with SMTP id mj7mr1192547pjb.76.1606666031200;
        Sun, 29 Nov 2020 08:07:11 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:07:10 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] usb: misc: iowarrior: update to use the usb_control_msg_{send|recv}() API
Date:   Sun, 29 Nov 2020 21:36:06 +0530
Message-Id: <20201129160612.1908074-10-anant.thazhemadam@gmail.com>
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
usb_control_msg_{recv|send}() appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/iowarrior.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 70ec29681526..53726fffe5df 100644
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
@@ -854,10 +854,10 @@ static int iowarrior_probe(struct usb_interface *interface,
 
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

