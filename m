Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519652C7C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgK3BdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgK3BdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:33:02 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D72C0613D2;
        Sun, 29 Nov 2020 17:32:22 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id s2so5555833plr.9;
        Sun, 29 Nov 2020 17:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ulF9m3lqljtgmnGhz+SzghBzSRKlHANlsmi6yEyMAeU=;
        b=DeTr/M+8eCuCLV/F6kqkKuqqLF9ULokzQhootagixYA/9rbHXyeUybli+7p/Knxj8B
         KUgKBsBmbWVzmrgWeuZn8u4zuRRH0RWDN3iK8HQcA2pGP35G8kMfOQB8GZ/jWr9+wavN
         LkdzM2Ng7LQp4wVkV7EodCRByF7T+1sNQTLVuV19kmcPPxmIxNBPldBpd9/wOdmRlaTG
         YZKXKyCX43reYmPvNojxus1V2FnRYKX+a9p8Unnuc1HyJ8ljpu9RCx6EY+MJhy6F6+VJ
         eSLNEreJjMAQw8eEsyoZBCmowiYL3OqnEurpt2CezkfzDFjbURS4P4bZc+ILwXaki595
         pbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulF9m3lqljtgmnGhz+SzghBzSRKlHANlsmi6yEyMAeU=;
        b=lHal0tS0caLdPLv+2d274FxVFBHbPW3AlEFV6Hb2LuNhoPaK3iqGsw12qqzHecxO97
         7V7Jr358J1s1Wz4DMkEgnJ2nebPCkKeCr3Pvi66YQGbdefen8w9xSumnaXl3uZUDIwFO
         rNutHeWYyY80bFRlCpuZ0qmImXQHzJbRwyrwiNlgvw3aceOOsc1wiQVkFxS/AO/REsfM
         7DQjb9KJonmyvkaFfE42/FWJ8X2Yl0lrkq/QTF2yAhF4+uefEozI9V2bnNCpquXZqNVq
         685rgh+tWDnxECgl/rxW1PZdLeAAI/uWoKBCZhypIHy3EA7PHwA+0E8CVw7yRMBiLZg+
         eeIg==
X-Gm-Message-State: AOAM531bwrAKH6bob0uG24jrCBycXK1uvNWYkjluGTYIo6MbG5ASFYmi
        kXGVHaS0ovLvalgFL7I+EjU=
X-Google-Smtp-Source: ABdhPJyr5kZGQeFS9YcNm+UDvhuSK0Hr48efv9+8FP6y+RsUNzBnbVXZUi1IfgtN049l1oTPx8TNeQ==
X-Received: by 2002:a17:90a:fa93:: with SMTP id cu19mr23818221pjb.117.1606699941992;
        Sun, 29 Nov 2020 17:32:21 -0800 (PST)
Received: from localhost.localdomain ([49.207.197.72])
        by smtp.gmail.com with ESMTPSA id i4sm13622895pgg.67.2020.11.29.17.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:32:21 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/15] usb: misc: ldusb: update to use usb_control_msg_send()
Date:   Mon, 30 Nov 2020 07:02:07 +0530
Message-Id: <20201130013207.2580849-1-anant.thazhemadam@gmail.com>
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
For this reason, the instance of usb_control_msg_send() has been replaced
with usb_control_msg_send() appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/ldusb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
index 670e4d91e9ca..259ead4edecb 100644
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -573,15 +573,13 @@ static ssize_t ld_usb_write(struct file *file, const char __user *buffer,
 	}
 
 	if (dev->interrupt_out_endpoint == NULL) {
-		/* try HID_REQ_SET_REPORT=9 on control_endpoint instead of interrupt_out_endpoint */
-		retval = usb_control_msg(interface_to_usbdev(dev->intf),
-					 usb_sndctrlpipe(interface_to_usbdev(dev->intf), 0),
-					 9,
+		retval = usb_control_msg_send(interface_to_usbdev(dev->intf),
+					 0, 9,
 					 USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
 					 1 << 8, 0,
 					 dev->interrupt_out_buffer,
 					 bytes_to_write,
-					 USB_CTRL_SET_TIMEOUT);
+					 USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
 		if (retval < 0)
 			dev_err(&dev->intf->dev,
 				"Couldn't submit HID_REQ_SET_REPORT %d\n",
-- 
2.25.1

