Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25ABA2B91C4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbgKSLra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgKSLmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:24 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B71C061A56
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:22 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id m6so6074669wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TmWuZVwdN+t8/RAdygzqc8Z/RnbV1ga4qbZZVtpG4+4=;
        b=y2c+hwABAUOuq528RSdsIGHR3kPrw8eNTpsyW1Q/ppafSACidh3OgBMKP6iUBkTZk5
         DXAM0bNh/4RXjbxX16lA+4NEA5YHBkaA5C7ducsxrgaGPVHRI+tMZ27GcfiIDJJpUIDk
         kncBTCBuES6SDoDOrmdK8mn/anJe5C9kQn6Cx5ZgLIw8vKPgdd+6Ie7wvRNtjG3m161+
         3UEooaODU0AubbsEiIKSL8eOMLYp5Ku+sHoXuqjKtTEWChSvOdtaVNSKV5aYJ+TdAwaH
         xVfQ/KqpRPfHQC6RtfxZTlFNGMiRINUV/Eg9H1GAdSTqGkLodiZ1c+ukvon9EWp1B88G
         v8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmWuZVwdN+t8/RAdygzqc8Z/RnbV1ga4qbZZVtpG4+4=;
        b=ukUSqQnJudxce3y+ZRYESekQvuPil84m2X7ftUn5f9TNjj6Oc3Ep1CdsBXhc5oa9ak
         dxHnNHL74Fp0H37+rRPof0/SPCzn3iUTmUfqD/8aT76CkksLH5tfpob5NJQbu/6jDB5M
         CI1kbbeLxh7ezR45USgUVb/x1jLl+DjqOH6FBeSGeiie1+g6xM5Hi0vfKn3nbijg9MZd
         Y6uGZ9QD2gLlRZZut4HXY7lMWi0bLem1v0AURXBySfTMdszLSnx2JYLxznEn0KpoaODE
         IkDZC0WQYqvY/VPKEPDoeNNqvE9FteDBnd3jhoMUNejDPVoaU0qji0hJdeFxYsY3EqGN
         4fXg==
X-Gm-Message-State: AOAM532X/wCkRUMcakDdZoGQgRb9nrHSIaxiU8lSZpfwN7eIejZLq4HZ
        ERtitpMCSLksbS/j6ufsUOx0uQ==
X-Google-Smtp-Source: ABdhPJyCczP5NwNOjagFhvY1qeOSgcBlLanG+LIldCaH3fyM2BwWlO6qdlgadBK9pPr3s1ORYUdvGg==
X-Received: by 2002:a05:6000:182:: with SMTP id p2mr10429587wrx.116.1605786141340;
        Thu, 19 Nov 2020 03:42:21 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:20 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 16/59] rtc: pxa: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:06 +0100
Message-Id: <20201119114149.4117-17-brgl@bgdev.pl>
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
 drivers/rtc/rtc-pxa.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index d2f1d8f754bf..56d22576ae0e 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -351,17 +351,14 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 
 	rtsr_clear_bits(pxa_rtc, RTSR_PIALE | RTSR_RDALE1 | RTSR_HZE);
 
-	pxa_rtc->rtc = devm_rtc_device_register(&pdev->dev, "pxa-rtc",
-						&pxa_rtc_ops, THIS_MODULE);
-	if (IS_ERR(pxa_rtc->rtc)) {
-		ret = PTR_ERR(pxa_rtc->rtc);
-		dev_err(dev, "Failed to register RTC device -> %d\n", ret);
-		return ret;
-	}
+	pxa_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(pxa_rtc->rtc))
+		return PTR_ERR(pxa_rtc->rtc);
 
+	pxa_rtc->rtc->ops = &pxa_rtc_ops;
 	device_init_wakeup(dev, 1);
 
-	return 0;
+	return devm_rtc_register_device(pxa_rtc->rtc);
 }
 
 static int __exit pxa_rtc_remove(struct platform_device *pdev)
-- 
2.29.1

