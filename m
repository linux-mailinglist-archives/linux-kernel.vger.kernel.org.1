Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BB12B91B6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgKSLqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgKSLmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:31 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A48C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:29 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so6470628wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VtfKVTltM+2kwsCwOlNHEQkXFC1AIAsWBGivbUY9Pu0=;
        b=cQqaSErY42qgAzhxduKK6x/GBq+vWkWnDQIPxhdQQXfNjM9MEBz1IlEJ8ZL6zZOCBK
         19ILAcGOlHp1yzMvY1bl5cDvFGOq0oX30h8z9/Uz/NRzzb5z1kSvBVAeeFjvRPwNX7ge
         nHynedNKT8ETQR7KE3VWkshlmrCHasOuJ+adiaMF7lgRi2EOXquzxXw77J/C7BCO3zBg
         QeQPy7jrYvwDWtpv3X7JnlNLA0mqHLCfxxRbY+ymPyGaiCeTTY93y6BdM2OsyI/B2xhi
         4D9bCQUd9fhCWpC9Bk7VP2MuLNvDWPwI5m9w43o0d0abxOv69XjreKtjkcHW+xc3YPz+
         p0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VtfKVTltM+2kwsCwOlNHEQkXFC1AIAsWBGivbUY9Pu0=;
        b=KANv+FVCWZFfGx/XWJemjqT6qs53niU3DEuv3ofc0iZAR50dH6ENYBXRt6LyY0bTns
         rsk+AR/wUEPdCvZ7XxeHX9Nrj5wQIYS+I/bD6ORTzXpbBqkgTSzHaP82CsZypxcqpRqC
         AUoXhbyx+SDLGhPROaT0mLLhkc9hfRsTvZPQDwpa3W3izSGxtst5JNKJFR7lrI6SfLcu
         iiw2f9iF2XVmBcdzMfAOF9EZZbqnUlyRG+UwZNgSfMMTvQHPsVx3JVchW4RtFhDLPKPA
         Dq9AM1joiU0xRsnicRlmsgdrTQOaf6u4vAOAK5u+6NBctYNRYDnmOEhRxpnJ0lLJzVQt
         iRWA==
X-Gm-Message-State: AOAM532HTc4P+YIr3xSUX7T5Eir0BEXysHnD8II869PvkHM8SYp2XmkX
        5y8vABA5f2wXhX0wbULTVlp8+w==
X-Google-Smtp-Source: ABdhPJyXdAgtHBMH5jYhpCugQN7AIRlDGwOZqVCyE/oWtco6mkDDRe6yU5j5HY2zuF6rKbK/hd5I7Q==
X-Received: by 2002:a1c:c909:: with SMTP id f9mr3973182wmb.87.1605786148730;
        Thu, 19 Nov 2020 03:42:28 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:28 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 23/59] rtc: hid: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:13 +0100
Message-Id: <20201119114149.4117-24-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201119114149.4117-1-brgl@bgdev.pl>
References: <20201119114149.4117-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

devm_rtc_device_register() is deprecated. Use devm_rtc_allocate_device()
and devm_rtc_register_device() pair instead.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-hid-sensor-time.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-hid-sensor-time.c b/drivers/rtc/rtc-hid-sensor-time.c
index 1b42ee0758d2..06cd21d6d2d1 100644
--- a/drivers/rtc/rtc-hid-sensor-time.c
+++ b/drivers/rtc/rtc-hid-sensor-time.c
@@ -267,21 +267,18 @@ static int hid_time_probe(struct platform_device *pdev)
 		goto err_open;
 	}
 
-	/*
-	 * Enable HID input processing early in order to be able to read the
-	 * clock already in devm_rtc_device_register().
-	 */
-	hid_device_io_start(hsdev->hdev);
+	time_state->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(time_state->rtc)) {
+		ret = PTR_ERR(time_state->rtc);
+		goto err_rtc;
+	}
 
-	time_state->rtc = devm_rtc_device_register(&pdev->dev,
-					"hid-sensor-time", &hid_time_rtc_ops,
-					THIS_MODULE);
+	time_state->rtc->ops = &hid_time_rtc_ops;
+	hid_device_io_start(hsdev->hdev);
 
-	if (IS_ERR(time_state->rtc)) {
+	ret = devm_rtc_register_device(time_state->rtc);
+	if (ret) {
 		hid_device_io_stop(hsdev->hdev);
-		ret = PTR_ERR(time_state->rtc);
-		time_state->rtc = NULL;
-		dev_err(&pdev->dev, "rtc device register failed!\n");
 		goto err_rtc;
 	}
 
-- 
2.29.1

