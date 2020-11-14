Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A446E2B2D2B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 13:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgKNMnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 07:43:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51275 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKNMnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 07:43:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id 19so18318321wmf.1;
        Sat, 14 Nov 2020 04:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cdrvsLUz/w0ysSu+S5S32Vims6n1V9dJUKCYLfM1QfE=;
        b=S+BcjaG1/CmWL6pdVR5Zou7CaX2Nf8SvtxebIqeV+Z30vn8TcFn5rWG811OiIxVere
         7mS9d/ZJr3qkBjNrVMaXoW4ShN12b8HIQ8de36wA11wIltO9CL1lh2QrS08XIqAFLu6i
         97pJptnymudvXdRpZypAu7OZRspBCZ6HWndCxrvludYALiruZeMMXGTuEwiNvrJ8cuiT
         UPQjkPqkeitsmMb0jz7BZsiAIlJ2E2yLx6+KGrPQISE7fzSMAqNpnw1/uuFz4yZZW7iz
         ZyrQa7IxqGhJnVnEovRAwkhuHxuJH4ZUvjCWAhhiCxRp+IQi/l1NIt9EZBwvCd8g8FsK
         9iRw==
X-Gm-Message-State: AOAM533BySLYxEed4WVVAM9BJyp7ogGHtz1BizsFo/RtiqAAjfUBERPy
        GW+uPaeTptHMIdUV3ylZ4r0=
X-Google-Smtp-Source: ABdhPJzVcELzWKFmlso1HdyGZEs/y8xKYIFVGOXgqzfDXLGr8nQHKXf/i6LWAcSHaFA8EcYhX/wzLA==
X-Received: by 2002:a1c:2041:: with SMTP id g62mr7003249wmg.118.1605357778758;
        Sat, 14 Nov 2020 04:42:58 -0800 (PST)
Received: from archtower.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id o197sm12964945wme.17.2020.11.14.04.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 04:42:58 -0800 (PST)
From:   Lucas Tanure <tanure@linux.com>
To:     Bastien Nocera <hadess@hadess.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH] USB: apple-mfi-fastcharge: Use devm_kzalloc and simplify the code
Date:   Sat, 14 Nov 2020 12:42:49 +0000
Message-Id: <20201114124249.634234-1-tanure@linux.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/usb/misc/apple-mfi-fastcharge.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/misc/apple-mfi-fastcharge.c b/drivers/usb/misc/apple-mfi-fastcharge.c
index 9de0171b5177..de86e389a008 100644
--- a/drivers/usb/misc/apple-mfi-fastcharge.c
+++ b/drivers/usb/misc/apple-mfi-fastcharge.c
@@ -178,16 +178,13 @@ static int mfi_fc_probe(struct usb_device *udev)
 {
 	struct power_supply_config battery_cfg = {};
 	struct mfi_device *mfi = NULL;
-	int err;
 
 	if (!mfi_fc_match(udev))
 		return -ENODEV;
 
-	mfi = kzalloc(sizeof(struct mfi_device), GFP_KERNEL);
-	if (!mfi) {
-		err = -ENOMEM;
-		goto error;
-	}
+	mfi = devm_kzalloc(&udev->dev, sizeof(*mfi), GFP_KERNEL);
+	if (!mfi)
+		return -ENOMEM;
 
 	battery_cfg.drv_data = mfi;
 
@@ -197,8 +194,7 @@ static int mfi_fc_probe(struct usb_device *udev)
 						&battery_cfg);
 	if (IS_ERR(mfi->battery)) {
 		dev_err(&udev->dev, "Can't register battery\n");
-		err = PTR_ERR(mfi->battery);
-		goto error;
+		return PTR_ERR(mfi->battery);
 	}
 
 	mfi->udev = usb_get_dev(udev);
@@ -206,9 +202,6 @@ static int mfi_fc_probe(struct usb_device *udev)
 
 	return 0;
 
-error:
-	kfree(mfi);
-	return err;
 }
 
 static void mfi_fc_disconnect(struct usb_device *udev)
@@ -220,7 +213,7 @@ static void mfi_fc_disconnect(struct usb_device *udev)
 		power_supply_unregister(mfi->battery);
 	dev_set_drvdata(&udev->dev, NULL);
 	usb_put_dev(mfi->udev);
-	kfree(mfi);
+	devm_kfree(&udev->dev, mfi);
 }
 
 static struct usb_device_driver mfi_fc_driver = {
-- 
2.29.2

