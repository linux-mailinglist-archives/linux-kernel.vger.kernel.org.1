Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5042B1302
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgKMAGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMAGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:06:51 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8ECC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:06:35 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so7856605wrl.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZVUOLs2+wec7oUYLZkwPoiWAkG2vGu94t71XbGuqA0A=;
        b=niMmvWPEl0fnMO6tMTcfpoR9YBUgH9zZ+Dt+igR122IRwmctAz3bKbFzybFAGY4KTn
         rBgHRqd+5WTm1+K4iHBPxBXjNjxewOhhq3oGz6A12hEUj5QytNgYQc7zZZPTM937L6b9
         lEOGfiE06I38tAMZxkJMGCb0D7EryshByXQUhSVfAo2CFCgwzcJh909decva2s/PSriB
         MkdMo50zmMS/bWfNuECwrXRWxamjBQJ/f7EM+wzu0BCr/N5nOHvprUi2hKLOvG4PZ6ie
         bXk+lvywpWHOm1vL/5Y2ZAF9yEdl4HAxALCaKk/gg6n+JLKgWdBegvdV+Fj9yjwIlyJV
         xcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZVUOLs2+wec7oUYLZkwPoiWAkG2vGu94t71XbGuqA0A=;
        b=Ajj+FcifSGq/mQdZKxStFwIYt5TNXv6KWa7T4eHzncglc5h9Jac2sf8Jrctl/dHetA
         TszfgbGnP2QorjzEEhEI4pLFgA65VY7qnRJWaO6ZGRX648Kh35o8m543Nb2jtCd6cZ1Q
         d8x5e0SY9wGvd5VbnHRVE9SW7kXRfm+3qDM4DtAyjFZN+DuDdQ1K6ocS2/GsyW/vmQf5
         G/tE6yWCwXOUl1jgw1MNyHgmgskRqWEiMp7UsSrjwNUCunnqhUF87T92c6MMl3kF/AvL
         ZhE+ScxDZrDdkJP40gyM64Uj3tJ22pZFKiK+qx9R0mg1VMsOFGAXkuGft0+/FJU0cFJ8
         W5pg==
X-Gm-Message-State: AOAM532LS3ADeM9W5IukT1Y1Ey0AlMBWnJEPxYCqm1fjsuklgkJJYhQ4
        7foXVRya2b9HKBdDNdiDYIfFYg==
X-Google-Smtp-Source: ABdhPJz5fA46WACqLV9OOTCsKZrq/SjPVyoU2kKp5ypsUk30uRkroMV0nCS3uH3iuH+sVFpdC+luNA==
X-Received: by 2002:adf:f083:: with SMTP id n3mr2382435wro.391.1605225993485;
        Thu, 12 Nov 2020 16:06:33 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3a84:7260:5d3c:83d5:8524:33ca])
        by smtp.googlemail.com with ESMTPSA id t11sm2010114wrm.8.2020.11.12.16.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:06:33 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 2/3] usb: dwc3: meson-g12a: fix shared reset control use
Date:   Fri, 13 Nov 2020 01:05:07 +0100
Message-Id: <20201113000508.14702-3-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113000508.14702-1-aouledameur@baylibre.com>
References: <20201113000508.14702-1-aouledameur@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reset_control_(de)assert() calls are called on a shared reset line when
reset_control_reset has been used. This is not allowed by the reset
framework.

Use reset_control_rearm() call in suspend() and remove() as a way to state
that the resource is no longer used, hence the shared reset line
may be triggered again by other devices. Use reset_control_rearm() also in
case probe fails after reset() has been called.

reset_control_rearm() keeps use of triggered_count sane in the reset
framework, use of reset_control_reset() on shared reset line should be
balanced with reset_control_rearm().

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reported-by: Jerome Brunet <jbrunet@baylibre.com>
---
Important:
Please DO NOT merge before this patch [0] is merged, it adds 
reset_control_rearm() call to the reset framework API.

[0] https://lore.kernel.org/lkml/20201112230043.28987-1-aouledameur@baylib
re.com/

 drivers/usb/dwc3/dwc3-meson-g12a.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 417e05381b5d..3fec8f591c93 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -750,7 +750,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	ret = dwc3_meson_g12a_get_phys(priv);
 	if (ret)
-		goto err_disable_clks;
+		goto err_rearm;
 
 	ret = priv->drvdata->setup_regmaps(priv, base);
 	if (ret)
@@ -759,7 +759,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	if (priv->vbus) {
 		ret = regulator_enable(priv->vbus);
 		if (ret)
-			goto err_disable_clks;
+			goto err_rearm;
 	}
 
 	/* Get dr_mode */
@@ -772,13 +772,13 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	ret = priv->drvdata->usb_init(priv);
 	if (ret)
-		goto err_disable_clks;
+		goto err_rearm;
 
 	/* Init PHYs */
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
 		ret = phy_init(priv->phys[i]);
 		if (ret)
-			goto err_disable_clks;
+			goto err_rearm;
 	}
 
 	/* Set PHY Power */
@@ -816,6 +816,9 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	for (i = 0 ; i < PHY_COUNT ; ++i)
 		phy_exit(priv->phys[i]);
 
+err_rearm:
+	reset_control_rearm(priv->reset);
+
 err_disable_clks:
 	clk_bulk_disable_unprepare(priv->drvdata->num_clks,
 				   priv->drvdata->clks);
@@ -843,6 +846,8 @@ static int dwc3_meson_g12a_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(dev);
 	pm_runtime_set_suspended(dev);
 
+	reset_control_rearm(priv->reset);
+
 	clk_bulk_disable_unprepare(priv->drvdata->num_clks,
 				   priv->drvdata->clks);
 
@@ -883,7 +888,7 @@ static int __maybe_unused dwc3_meson_g12a_suspend(struct device *dev)
 		phy_exit(priv->phys[i]);
 	}
 
-	reset_control_assert(priv->reset);
+	reset_control_rearm(priv->reset);
 
 	return 0;
 }
@@ -893,7 +898,9 @@ static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
 	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
 	int i, ret;
 
-	reset_control_deassert(priv->reset);
+	ret = reset_control_reset(priv->reset);
+	if (ret)
+		return ret;
 
 	ret = priv->drvdata->usb_init(priv);
 	if (ret)
-- 
2.17.1

