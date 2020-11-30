Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F4E2C7C68
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgK3Bby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgK3Bbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:31:53 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC191C0613D2;
        Sun, 29 Nov 2020 17:31:13 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w202so9372295pff.10;
        Sun, 29 Nov 2020 17:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5CycBkayIPEKy8ugUk9noRpeNNqE1DQEMX4hGWZ348I=;
        b=vGXHs16X2MF2DjnkBqRJw/m30w6G7WZqBnHtoCcR92+2a4886nq/4jhrToqCpyfTDK
         S+EST94Xac05QbbqfkjatTJtoPnZZ8yJ4oib/7O8SGfhqxFlMsmeCgmkG8N2BhplP+48
         PL4p9ktfWGOlnPNP52X6Dm+02ALrA1Xip3Hedvr0oVljnEDIBHZOLjYJLVlGq8BZRKqg
         jr50UOxUasRw48NGE5WQ8Z4kKXHt/myl4c4ykPTq1IYBNXxWyYx9hvOBaaUIr38yz1rK
         Y909hN59xQgwWwgFo60EtArO5TRddN45BLhKIO4y70Ez5oz1CZSSafAX/gXx6st6Cwv1
         2vJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5CycBkayIPEKy8ugUk9noRpeNNqE1DQEMX4hGWZ348I=;
        b=NSi8eQx74QA8M3agnufJqbHfaj1o9F17HyCAyjMKX+rtPSGW91X8EmOW6U8aHY4WEv
         esg9Mx7djn6eLRFz4CD45g0Bi4TAwySrJ4Z/+q2JlHVCWzADBrLC2+QLSkW8huApMG1I
         4vaTSqbJpo7nppQSRACE3UfBcnQSk8nB5LQJ7jniVd0UAYa/EGC0xHVHj1k7vS8BqMW9
         TJ1L9xJw7WGlPLTcHdXPDwW0bB/8sK69+XqTiUp/oMXv6Av1ssOF95vmAr58xo2Z3zys
         SUyU0IrTGcBd+icVV25JrdgVjgZM6+DV/aDsojqyUTsRu+tCIxbzzIKefkp0nn9pF9B6
         at5w==
X-Gm-Message-State: AOAM532K/g8lZalXUnevmW0VM8pL5oiga33kP50rSUOng9I2hvGqOqsA
        9VrgjDybfhg7UXHbE/lK95k=
X-Google-Smtp-Source: ABdhPJwush27084ownRR7LQvdQzXAJeIAPcwg6gV5PwbWkR1xYbqSBWHbj4N+JNCLZT9ExU87KGfvg==
X-Received: by 2002:a62:78d3:0:b029:198:ad8:7d05 with SMTP id t202-20020a6278d30000b02901980ad87d05mr16538003pfc.18.1606699873090;
        Sun, 29 Nov 2020 17:31:13 -0800 (PST)
Received: from localhost.localdomain ([49.207.197.72])
        by smtp.gmail.com with ESMTPSA id l23sm13747168pgn.40.2020.11.29.17.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:31:12 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/15] usb: misc: iowarrior: update to use the usb_control_msg_{send|recv}() API
Date:   Mon, 30 Nov 2020 07:01:03 +0530
Message-Id: <20201130013103.2580467-1-anant.thazhemadam@gmail.com>
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

