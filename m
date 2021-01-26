Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427F1304F03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405220AbhA0Bd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388986AbhAZSiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:38:22 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDF7C061797;
        Tue, 26 Jan 2021 10:35:41 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id my11so1676515pjb.1;
        Tue, 26 Jan 2021 10:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ulF9m3lqljtgmnGhz+SzghBzSRKlHANlsmi6yEyMAeU=;
        b=mdkARqUaBx6BYjBGoLgLYxqnNyDZzozEta95Nt4Wx+CmpeY4Su3Ep4Km/eXaTqawLd
         FhfPBg0TUjr/icrS2cKTIKKjeMsuKstqollbCzy9YqsyxFLt0FkGWttEVeQ/dFu00dbX
         sKifMG8oLeya/Gw2htNKn1tVBNQzSteP4nDca/kbfYpE6/9qvTxlvOYR9+bj/2xkLuYA
         cdxG4Jv9HJvHkWbRXEZImf220S1xG0i7aFN+62T3SGt8PQWgwn6CCzu/ONpkOS/UTQ93
         +pmHze667S3uRvaRTm59DqbiRg/XV7LZ6h8K4SlrW7ANISM0iMmjPcXL12/EP4iolqIf
         joag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulF9m3lqljtgmnGhz+SzghBzSRKlHANlsmi6yEyMAeU=;
        b=jw3PMn1gOQvH5fc0n96k29VGcW9Dae5rd6OU+Tv0i7kxTf7figXOAIG5zHefVu9XDN
         OKPcDisKiWly1usjX06mt0Jf8trky8zCKMY/mxoljzb7aM3NM8OYE9q9JjThBvTc9+uz
         aNne9xIOmRfgvdQNCQToZJepXiMdLNwcjx/pGkPRu24uGY/olK9VT7A+L2I8cCGhYsl2
         99GXfZAVpxPbzcfNVQtlTe/wkYPbKwXJ7hk86uYtVURDJuGPiRF3e1VGqKZazTtB3Y/u
         uGbJDywNgQllDG965bzYUXI2YQjaXx6Gy++6DXzNXNef6USUZUkzKIcJ38CzReoAcqRN
         IIvw==
X-Gm-Message-State: AOAM530AOYdd0D/gJbrz4CSWQWwOW/nV3ARTjI8Z5WI8vVRuqTu3piyw
        dWxYXPmfzWP5wMOZcrIIonY=
X-Google-Smtp-Source: ABdhPJy6lhnce8iilLJcfvNf5E8E51/GvUznO8hznRRkxLqV7nDlbWGG5fGC75DRp6djnGnL1uVNUQ==
X-Received: by 2002:a17:90b:8d1:: with SMTP id ds17mr1149476pjb.194.1611686140789;
        Tue, 26 Jan 2021 10:35:40 -0800 (PST)
Received: from localhost.localdomain ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id y75sm472711pfg.119.2021.01.26.10.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:35:40 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/12] usb: misc: ldusb: update to use usb_control_msg_send()
Date:   Wed, 27 Jan 2021 00:03:59 +0530
Message-Id: <20210126183403.911653-9-anant.thazhemadam@gmail.com>
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

