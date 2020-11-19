Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94AD2B9159
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgKSLnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbgKSLnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:43:01 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB4C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:43:00 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so6472054wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+jKx/KylEoEPXl1ksUY+ZSMBN+gdF7Yb4Tzz+/gCV1U=;
        b=XsUpgDbKoyrVyJrJV0XOeH7r0E5135RoW75nMdoz65LW7XWWr63/BcxD7nkQF6WMXd
         AJkUV52N1OyLVe659c3vDC2rLqd4ac961FJ3kuicJxP+0cQ55QuPF1a++RdvkwEY5Ccz
         swcCs1HzdD24Q7Qa1K7MxEQjY2pnKFCQH7iwjloOtVrQvMyBWLpB69I035fQfbDkGvYq
         Azt6tg9EUUpS3GYOoqDXcma6uem547lGEbakQs97EV97hW7bIIEmSy8+RXqZEGzJaqdS
         lt2BCSlgXcHMy0u2K1PhMW+I0YOjjMATu+0fiujm+XqTUPaHUs8vspW5KrT3TOiUtiVt
         tpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+jKx/KylEoEPXl1ksUY+ZSMBN+gdF7Yb4Tzz+/gCV1U=;
        b=jJWU3yGOGMzDzZ/diReuNlLu+RZ11FyOaF4nR/OBQznOXNBMBl9ytnj/9Xlq7aMh4z
         HKmwOO/5SpvavQEUJ0X81zT3ANZPWcJCMwn3sKqsy2nnlHDuIUrQhYEINx3aYFTiqlNF
         1JIOdCyl4/m/a1Mh1JSjC0x+p5TDQp/sUwOmlH3MDCtmUsc61EGnC1JmoRFrxuA0ia4E
         8X5ETPS9ugIvz7vDoMOdPL52vOYTyu9q0oDr4X/DW+MCj38VtSjyKrlgZSbEs5l+Mr+c
         NDWwdPKFe4ck877N9P/c8fH8E2i8Z5l0dWG006l9gwRQDCc1YzDwvlK+4SgRDyiHhzwy
         zydg==
X-Gm-Message-State: AOAM530kw+SznXhkxJR0JRQcIM6XKJPco2aQ3yKlVeVcpIFiaJK9WSZ7
        J0gEv7FIBylolw+Qukt078zMNw==
X-Google-Smtp-Source: ABdhPJz52VhAEKWyFtzl3tertRvZQaNMscL7PdRyAPbHmG+svElXy0IuKgRYepVwfhVQQuHhQJzTww==
X-Received: by 2002:a05:600c:2c50:: with SMTP id r16mr3953962wmg.153.1605786179367;
        Thu, 19 Nov 2020 03:42:59 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 51/59] rtc: ds1216: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:41 +0100
Message-Id: <20201119114149.4117-52-brgl@bgdev.pl>
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
 drivers/rtc/rtc-ds1216.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1216.c b/drivers/rtc/rtc-ds1216.c
index 7eeb3f359de8..594f39d4e916 100644
--- a/drivers/rtc/rtc-ds1216.c
+++ b/drivers/rtc/rtc-ds1216.c
@@ -150,14 +150,16 @@ static int __init ds1216_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->ioaddr))
 		return PTR_ERR(priv->ioaddr);
 
-	priv->rtc = devm_rtc_device_register(&pdev->dev, "ds1216",
-					&ds1216_rtc_ops, THIS_MODULE);
+	priv->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(priv->rtc))
 		return PTR_ERR(priv->rtc);
 
+	priv->rtc->ops = &ds1216_rtc_ops;
+
 	/* dummy read to get clock into a known state */
 	ds1216_read(priv->ioaddr, dummy);
-	return 0;
+
+	return devm_rtc_register_device(priv->rtc);
 }
 
 static struct platform_driver ds1216_rtc_platform_driver = {
-- 
2.29.1

