Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2813D2B91A5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgKSLpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727292AbgKSLml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:41 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ADDC08C5F2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:37 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so6157252wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O3s/VEMpzG+winwl4C4IVipyH/L37fv4iSYi9XYEL3k=;
        b=s6CwWhPWAt3p5n5GmcWH/T+9n2XxL6qWjcheJYyezA7BAblgPE5tX+2L/rx9GprHKT
         lpRRrBeiNC3LeUxkOX0IChLSRNHGmLmGX43Y25A237gCA4AYO5OOBg+rUzvncvqsQYsw
         1s34FjRajwa3h0IMdTFB3KxEjwj4A/TeddtcYeRWM8UdWMhsOP2UOmH8UmuIIUb7BG2z
         xpcfa89tLzSCjhkXnDsUPYIDUWnZTgBNzBmIECDJnP+v4vRGp25fUVCvKIE9iKsWzJcf
         t+ty196BUBGkjGdm2n2txu9A+Zh+ZyPNckn+menHohwgt/NOHMmN7iYzrXGTk+ELhUZk
         sdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O3s/VEMpzG+winwl4C4IVipyH/L37fv4iSYi9XYEL3k=;
        b=bmyjJrmOjCDwxzIZhDORgMXhHdA/5mEOmIkJYRnXvAIT4pFvObBbpL6hPjcygI6B60
         VDetXSh9gYrNdAqKmLsNXRQzZlZoP6Zjy2LhcNveW5sZje50b25MK/NbpJbKhKJ7pM3u
         hVSQYMBzrceY0q6BMCPdPEx5nZeEJ2DVGK76q4ryyYyC88BucBx56E3ZRTa3fXGZEP/H
         q5dAZylBWkPiwj/92Foffr8v1a6PXkl4a/J2QUjaUwj6WQG1Xru1XXg0k5NPevHStBw6
         pmUP8jL2Q0nLlsapaxkzkJoME+DOFJEvl7TEwZAfRip2wQDlcV28Ff/lSfD/0DS1JtsU
         sH6A==
X-Gm-Message-State: AOAM530aqPWdvtpKNba3bakhGf3C2YL683n7xdQw1Pc/f2vOU3X+6rgv
        9w0ZaAu+MEr92Q8yxC3w4L/FVg==
X-Google-Smtp-Source: ABdhPJyqYvPsvlNt5OBziLy8AcbakLpJZp5TyJrC0FIi0pwsfn0pND48l2E1Q0mEz1xKqe2xW+E7ng==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr9556325wrp.209.1605786155996;
        Thu, 19 Nov 2020 03:42:35 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:35 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 30/59] rtc: s3c: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:20 +0100
Message-Id: <20201119114149.4117-31-brgl@bgdev.pl>
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
 drivers/rtc/rtc-s3c.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 24a41909f049..119ce2c08e00 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -527,14 +527,14 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 	}
 
 	/* register RTC and exit */
-	info->rtc = devm_rtc_device_register(&pdev->dev, "s3c", &s3c_rtcops,
-					     THIS_MODULE);
+	info->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(info->rtc)) {
-		dev_err(&pdev->dev, "cannot attach rtc\n");
 		ret = PTR_ERR(info->rtc);
 		goto err_nortc;
 	}
 
+	info->rtc->ops = &s3c_rtcops;
+
 	ret = devm_request_irq(&pdev->dev, info->irq_alarm, s3c_rtc_alarmirq,
 			       0, "s3c2410-rtc alarm", info);
 	if (ret) {
@@ -549,6 +549,10 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 		goto err_nortc;
 	}
 
+	ret = devm_rtc_register_device(info->rtc);
+	if (ret)
+		goto err_nortc;
+
 	if (info->data->select_tick_clk)
 		info->data->select_tick_clk(info);
 
-- 
2.29.1

