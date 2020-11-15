Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3122B3370
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 11:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKOK2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 05:28:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51536 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgKOK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 05:28:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id 19so21049114wmf.1;
        Sun, 15 Nov 2020 02:28:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hd/6BA2/FqUk3xJgjqh9sLDOObPLauylPm+EH2VcaNQ=;
        b=GLEAEvac3TLKmWsRFcw3ZDAMeAHy7W59eppWrcWWkg8uIwtDtXL4gsr7HtjkANxDwb
         o1RQTrF0W9xSyXIStpkMbqRSr35ksixWTYJRql1uz4N6RKJQe37q6oPXvp6LviuiNlRf
         BUrLXVOP3OKUx3AwZb3wQxGCZsZrZ06x0/y+jQs2269QPoL/J0XJRL9pwdE+EsXx8HCl
         yOh59OA4ZaRVjq+pLO10g/nH3RJ+MncIcFYb4zxeN0ER9VvhSxjiytDUbPXR67ZdY7Kg
         /r4gTTfh3W88BTjTrpQWrRSPQ01OnBsnHcfo5U81IMW9j4o8JpCtfpKVQhXJ7r3+KIVC
         KZaw==
X-Gm-Message-State: AOAM5333He3a15W+BGy+XoZ0GkaThDLybEOyx9KXp7EhXO0WlBBTynzY
        6jC6CpyNNqe1vJnShwpOU5Y=
X-Google-Smtp-Source: ABdhPJx4vKinWHDbM+0hDUJGAgxadt0DtgObJv42ovgIDYbQDAHZAkxVXFeXbkUxTChI94qoTDd09g==
X-Received: by 2002:a1c:9c53:: with SMTP id f80mr10073088wme.19.1605436120554;
        Sun, 15 Nov 2020 02:28:40 -0800 (PST)
Received: from archtower.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id g20sm15656065wmh.20.2020.11.15.02.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 02:28:40 -0800 (PST)
From:   Lucas Tanure <tanure@linux.com>
To:     Bastien Nocera <hadess@hadess.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH] USB: apple-mfi-fastcharge: Fix kfree after failed kzalloc
Date:   Sun, 15 Nov 2020 10:28:37 +0000
Message-Id: <20201115102837.331335-1-tanure@linux.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree don't need to be called after a failed kzalloc

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
Follow up patch from "USB: apple-mfi-fastcharge: Use devm_kzalloc and
simplify the code"

 drivers/usb/misc/apple-mfi-fastcharge.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/misc/apple-mfi-fastcharge.c b/drivers/usb/misc/apple-mfi-fastcharge.c
index 9de0171b5177..6dedd5498e8a 100644
--- a/drivers/usb/misc/apple-mfi-fastcharge.c
+++ b/drivers/usb/misc/apple-mfi-fastcharge.c
@@ -178,16 +178,13 @@ static int mfi_fc_probe(struct usb_device *udev)
 {
 	struct power_supply_config battery_cfg = {};
 	struct mfi_device *mfi = NULL;
-	int err;
 
 	if (!mfi_fc_match(udev))
 		return -ENODEV;
 
 	mfi = kzalloc(sizeof(struct mfi_device), GFP_KERNEL);
-	if (!mfi) {
-		err = -ENOMEM;
-		goto error;
-	}
+	if (!mfi)
+		return -ENOMEM;
 
 	battery_cfg.drv_data = mfi;
 
@@ -197,18 +194,14 @@ static int mfi_fc_probe(struct usb_device *udev)
 						&battery_cfg);
 	if (IS_ERR(mfi->battery)) {
 		dev_err(&udev->dev, "Can't register battery\n");
-		err = PTR_ERR(mfi->battery);
-		goto error;
+		kfree(mfi);
+		return PTR_ERR(mfi->battery);
 	}
 
 	mfi->udev = usb_get_dev(udev);
 	dev_set_drvdata(&udev->dev, mfi);
 
 	return 0;
-
-error:
-	kfree(mfi);
-	return err;
 }
 
 static void mfi_fc_disconnect(struct usb_device *udev)
-- 
2.29.2

