Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3DB2C79E1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbgK2QIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387408AbgK2QIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:08:05 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5D2C061A49;
        Sun, 29 Nov 2020 08:07:04 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id e23so3553041pgk.12;
        Sun, 29 Nov 2020 08:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rlm5PUymFHRx39FCcGjfRRBHQ3f0wd7qTZT6jsgLwkA=;
        b=u2gftksmKXDhcqV1TTEzrprq0GntFOdlbKLKYtZKVg0aT6jSDI633ex4dB88cWjIFl
         63w/Huy/IuPUCeZeEuryqAmYHQ5Baw/Ewyte5CNt6nd2OmVg6vlY1vbqFOpFz/1UW/Ob
         XPWy7PiJoHhll7Fyog+N75aA4K81ABbJ7A/9pkXdstNAmoxje4jj7jSTE4dM8lOVp8Ah
         YHySrrFbITGrndH+odcN1F4+SlyD0VoyMgQjaavLmk8c1cUbhFgBp5AsOGSeVM+RhY8E
         5e5EGkgaysJd7Mbvgeu2QsqtJEuXFWPOpVxZP0Mb+IF8M2OCEmViI+p2ucYovqEnX0Ei
         CgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rlm5PUymFHRx39FCcGjfRRBHQ3f0wd7qTZT6jsgLwkA=;
        b=cIB2+ficO8kDeOMTuctg5N4nqUWSS8FDUiixkGwSfGXAnAXDX4NW4j+oXoHc4tBc3p
         gpmaeTm76xcfCxSG2KDh7qpS5xkNn4rnElVz3GOHHoe1GU5XdcXmVY/TzGVAArqXwocM
         oSr2X90epTYpbdtPr9hJJN8JTUB8XlOFPTe8yxm+yxjPih2nas6Q3eaacEw9+BS/aBqg
         11O94GALgD1PomxYXLDggCcY3tTVo9lPLyz3f7h8IM/eOJWTpiFxBuAerxD+HzmB9Ofx
         7YO2QNNnEzRI461jZCjtEK6iQGJuLe5Zz/iTAOwuhl22QWbnclkhOjeIItEIV8VnWw40
         MaUg==
X-Gm-Message-State: AOAM531DesjykmLdT7ZjMEzykzjea5PJkJu3jPeLAVmT5zm0U6NkEgv2
        o3b9Rcrkf5oDTt5YrmgBdtCYYS8LwZO+YzkMl5A=
X-Google-Smtp-Source: ABdhPJyfD/UeJNBQCR+1E9Z9FdCM62YisFBFrFlU1OrrCs9PGb7V89bAA1aM7Q+GWDGjFENokPXzsA==
X-Received: by 2002:a17:90b:374f:: with SMTP id ne15mr21666351pjb.57.1606666024437;
        Sun, 29 Nov 2020 08:07:04 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:07:03 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] usb: misc: ezusb: update to use usb_control_msg_send()
Date:   Sun, 29 Nov 2020 21:36:04 +0530
Message-Id: <20201129160612.1908074-8-anant.thazhemadam@gmail.com>
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
For this reason, the instance of usb_control_msg() has been replaced with
usb_control_msg_send() appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/ezusb.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/misc/ezusb.c b/drivers/usb/misc/ezusb.c
index f058d8029761..78aaee56c2b7 100644
--- a/drivers/usb/misc/ezusb.c
+++ b/drivers/usb/misc/ezusb.c
@@ -31,24 +31,12 @@ static const struct ezusb_fx_type ezusb_fx1 = {
 static int ezusb_writememory(struct usb_device *dev, int address,
 				unsigned char *data, int length, __u8 request)
 {
-	int result;
-	unsigned char *transfer_buffer;
-
 	if (!dev)
 		return -ENODEV;
 
-	transfer_buffer = kmemdup(data, length, GFP_KERNEL);
-	if (!transfer_buffer) {
-		dev_err(&dev->dev, "%s - kmalloc(%d) failed.\n",
-							__func__, length);
-		return -ENOMEM;
-	}
-	result = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), request,
+	return usb_control_msg_send(dev, 0, request,
 				 USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				 address, 0, transfer_buffer, length, 3000);
-
-	kfree(transfer_buffer);
-	return result;
+				 address, 0, data, length, 3000, GFP_KERNEL);
 }
 
 static int ezusb_set_reset(struct usb_device *dev, unsigned short cpucs_reg,
-- 
2.25.1

