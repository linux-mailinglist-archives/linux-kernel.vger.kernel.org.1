Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C792C79F1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbgK2QIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387408AbgK2QIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:08:11 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E63C061A4A;
        Sun, 29 Nov 2020 08:07:08 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so8391166pgg.13;
        Sun, 29 Nov 2020 08:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDOpWxXfNZ312yhyl51Y7bEUu6zDTfPu30AJ2VVW3j8=;
        b=qhxudp8PVkUP/lbksQXE9i19mfvs5SKAqy9qF0dpjvCKwPdYU5iAE4xU95CkqDaUAl
         w95Qi+sgXd4F73f3188Itu00YzjCDQkeuUtKtrNz/y7u+8A50mVX5o3z36u2fGRn4IT0
         ASch1WGw1OpaHHChIJPd75zYQDAFJ/6gQ0BTbkKOBjOYOc+LNxChVJUPNppAFwsJnWQ/
         8TC6P8BMCsH03BuQCBIZlVonTVSbtfJfrNw17JFJITq8aKOCg1VgNLO/VUAVN0+Xd53R
         UAcOAlYZWNUH0T+g6eq7vNI+433fq5k4hq3XC+HElBSO+jZJBIT0MP2OVvQ/zdc6pfEi
         m2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDOpWxXfNZ312yhyl51Y7bEUu6zDTfPu30AJ2VVW3j8=;
        b=JzCDIUyW+UkdgwRK+hR4BMmXBrjQlKMkzyhkq0z0yaH80jYuIiY7kn+ADE6ohfu2w9
         jRqDDDTJhoNE9pcaKP5yHHKa/ljWGZSHOi7Zv6KL0md1YUkJLs3ExuoEyJ7jO+Wo9UEt
         PM8W8tnoSvDWO32qUrCYmmmHgWg2ueITr2X2QPOXcOLmrkXxwPlnPPDR/BYMSmknUEdJ
         lU6FIMHvknFAd31wiZDMIRlsNLekRMn9c4cwog+ewfTavmSzyKencAFVbu/IS8UtEBqh
         /FHq9Wb3l3EOVd+CYVifIymqto2yYiICD4Ccpag5nIwYyVhC9qV7IYlXbRHB3H/v6FaP
         bVOQ==
X-Gm-Message-State: AOAM533ItNVtDtnMZoDEBotXDI/jM/oaf+i+smFQoLuD+v1AYgV3RecB
        kEM61E3vCkltpl1EOaD0nMw=
X-Google-Smtp-Source: ABdhPJxIQD+H77NlTQboQEfL3ak09BrLLoNfkuvPrIu+GxZvnK6Rw1IYaKC5G7DzWFrMurunGnaNoA==
X-Received: by 2002:a63:455e:: with SMTP id u30mr14244106pgk.113.1606666027735;
        Sun, 29 Nov 2020 08:07:07 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:07:07 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] usb: misc: idmouse: update to use usb_control_msg_send()
Date:   Sun, 29 Nov 2020 21:36:05 +0530
Message-Id: <20201129160612.1908074-9-anant.thazhemadam@gmail.com>
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
 drivers/usb/misc/idmouse.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/idmouse.c b/drivers/usb/misc/idmouse.c
index e9437a176518..52126441a633 100644
--- a/drivers/usb/misc/idmouse.c
+++ b/drivers/usb/misc/idmouse.c
@@ -56,8 +56,9 @@ static const struct usb_device_id idmouse_table[] = {
 #define FTIP_SCROLL  0x24
 
 #define ftip_command(dev, command, value, index) \
-	usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0), command, \
-	USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT, value, index, NULL, 0, 1000)
+	usb_control_msg_send(dev->udev, 0, command, \
+	USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT, \
+	value, index, NULL, 0, 1000, GFP_KERNEL)
 
 MODULE_DEVICE_TABLE(usb, idmouse_table);
 
-- 
2.25.1

