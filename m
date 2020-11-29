Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BBB2C79EF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbgK2QIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgK2QIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:08:20 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEA3C061A4C;
        Sun, 29 Nov 2020 08:07:18 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id b23so5088900pls.11;
        Sun, 29 Nov 2020 08:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ulF9m3lqljtgmnGhz+SzghBzSRKlHANlsmi6yEyMAeU=;
        b=LRMgPa2dW5KmBLDrlMn8DAlzYuuCRsoXCIZVDU/n1JTBvWM5lPI8PUKoSl0GAvVhqf
         sJo/NOOweogMOpuK4Y7GpetLA0ee064PrQqEkIdCN9fpJNgmnnOhbO2sxxu3yN6pbJL7
         VmWDEQTikyWSE0M/zenKQqYCJ9FwEET/FhPShQIBXs6UiTUEl5NHDNz1E5KiCdwbhRNe
         mFpdIf9PFijkovCghAQB8kU5uSoUxBM/GnQETMAeR6OikXXwDQAWirCTnGKaFcBHxlMx
         DYckY+ezfq7FC/kSPfUu8SK15SF2c8Ys1Mhh34fMMPFBHbokcRkMBJJ84HJkb/1Y1Eub
         UrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulF9m3lqljtgmnGhz+SzghBzSRKlHANlsmi6yEyMAeU=;
        b=FmfjljMLVe/JzW64rVZA54/F0XodVxqZbU+O1+g9EipaTsYORTkn5boCwuHnA27REU
         k9DPPjgQZmTcHUR8GbHo1RDfGGvWIQnpTXsv5erpedqyq1yF8JrbNSk6GD25W3osqzdO
         3aHbYXynoOvXYpPxThwcy0TEuL7/EG8LNCmJsrrUfK+WLvFBRL63jraXsM399ur7Zt+K
         BST448ZC3s1sCfW5UvlWAPmFvDworhSJqrk3Kd3FUAkWngw7tDHUS/YtiL0pODWEZAjF
         TWR9Pjt8dDi6Fe7xFTLMLkT+878tb0qWlgkh3nXR4nws4dejbuSFIEBFNGx1YI5iYIQz
         pRRQ==
X-Gm-Message-State: AOAM531N5GECxAblfBm/21JDSjgGuTFsGU8AjX+QKwSoOODY9mvn9Bui
        jJTi6Bydk+NWeonkGzdeM/w=
X-Google-Smtp-Source: ABdhPJyKtNmL5wNGicC6Geed00X/lthoJxMcyxq1jRzaURDjTcMrD+MgRLqJfnkUSchyiGmL2Wzt2A==
X-Received: by 2002:a17:902:76c5:b029:d6:a399:8231 with SMTP id j5-20020a17090276c5b02900d6a3998231mr14718033plt.3.1606666037690;
        Sun, 29 Nov 2020 08:07:17 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:07:16 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] usb: misc: ldusb: update to use usb_control_msg_send()
Date:   Sun, 29 Nov 2020 21:36:08 +0530
Message-Id: <20201129160612.1908074-12-anant.thazhemadam@gmail.com>
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

