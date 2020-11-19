Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544BD2B918F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgKSLop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgKSLmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:49 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71EEC061A53
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:48 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id c17so6050057wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0V8zdOUzgRXHvASfvihATg+tUUFn50H95AhpKfaGf7I=;
        b=kW3SSru3FZjdXWya2l2GyIRBdiLdKWQkwv/qduousK2jcP+3SL5HQ0/80xE8XpY87w
         TDd6ulxaTRPWh7/1RliWsB+lbwV/P4caaUQUzbpHdJffizO4Foi/kvqms3G7p+koywLP
         t5rIUmElOLPMXDI+JXxTynzy5OEFCfAidl+0uJoE/K0YiZsasWQaPd2nHAqyjthFPXtT
         /K6FextgWAbJkA/XLXdhwaSMOWyYEXEBpsVS+DOnELGbNp3QvkXAw5C/yhXvUu1QmytI
         6/YKFhyA1aK9KBjMTd0lTAGvxe0PSBGhBFDCSPH4HS5whNahFC6nzHSM3L2ZQOIeeref
         3dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0V8zdOUzgRXHvASfvihATg+tUUFn50H95AhpKfaGf7I=;
        b=iomOLQGTIi7jKwWWfYdfPXKMiKUSxOgpvxGVjXU5Wri1CinF9eAfHnpldYDNTOus4a
         t/nxQCGrfE5i3/cZay0LdFehMGqYK+/jXvtOy5EZVEbFzWJ/66g3ANmd8jfnwo/Bml+O
         38X8MieYNN4tuBdsd5a9OhNGXrbCsHhYLSF4F6v277jK7KGIEqJGPMQ+rPurP5HTiV8u
         VrDOT/tzz43spU4JqCl3cril47EhFUuQm3lOTkvwUCiWGayn67E4qdSCp6/YrWvVUxZR
         Nw945iBixO4183qJZImm2AV347a6mKPHB8HSA8uxQmnnAginVM5FNUzoBXtp3Jgi4rk+
         udEg==
X-Gm-Message-State: AOAM532WOjy2VSVylclbJUB7JsC7dfylI0IQo6lGxMQnw9JfwJkzkWhk
        yWTv0Tjkaz0O7Q1aeOgH/UDxaxFCIz+2jg==
X-Google-Smtp-Source: ABdhPJxKARpUzAB27tutCMMVtNm4X4zd70ozNUS1e+i/8im6DVuGGgEEo3acDUIYuLtCVd2EjaV5bg==
X-Received: by 2002:adf:9d84:: with SMTP id p4mr9776730wre.370.1605786167686;
        Thu, 19 Nov 2020 03:42:47 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 41/59] rtc: max8997: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:31 +0100
Message-Id: <20201119114149.4117-42-brgl@bgdev.pl>
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
 drivers/rtc/rtc-max8997.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
index 20e50d9fdf88..d4d40851aecd 100644
--- a/drivers/rtc/rtc-max8997.c
+++ b/drivers/rtc/rtc-max8997.c
@@ -475,32 +475,29 @@ static int max8997_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	info->rtc_dev = devm_rtc_device_register(&pdev->dev, "max8997-rtc",
-					&max8997_rtc_ops, THIS_MODULE);
+	info->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(info->rtc_dev))
+		return PTR_ERR(info->rtc_dev);
 
-	if (IS_ERR(info->rtc_dev)) {
-		ret = PTR_ERR(info->rtc_dev);
-		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
-		return ret;
-	}
+	info->rtc_dev->ops = &max8997_rtc_ops;
 
 	virq = irq_create_mapping(max8997->irq_domain, MAX8997_PMICIRQ_RTCA1);
 	if (!virq) {
 		dev_err(&pdev->dev, "Failed to create mapping alarm IRQ\n");
-		ret = -ENXIO;
-		goto err_out;
+		return -ENXIO;
 	}
 	info->virq = virq;
 
 	ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
 				max8997_rtc_alarm_irq, 0,
 				"rtc-alarm0", info);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
 			info->virq, ret);
+		return ret;
+	}
 
-err_out:
-	return ret;
+	return devm_rtc_register_device(info->rtc_dev);
 }
 
 static void max8997_rtc_shutdown(struct platform_device *pdev)
-- 
2.29.1

