Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DCE2AC0ED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgKIQeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbgKIQeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:34:21 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56423C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 08:34:21 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so8557633wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/duoUCbLOM0QFQ/QGXANkt+cjZ5PU0ZBTqU1VBXp8I=;
        b=cYIY0EwoyCnJZ4DJixNxtNSlZKaThhyWl0cZA88Hvjjq6nR/RdFYlDNUZuSeNLpnDd
         yPHSLmCoVC5UuZ1GwzLe9z7smYNFAC8V9Yf2gXtt0WqRgWrFwyHJEwMEnoe/C6v4XE22
         OgFfsaNjwNNZyoXV4sVhOxHN3VRLWoKkJ2GQDI4ANOuQCsKGgOh79QW7zDPi2zORpQSB
         Z7ign7C2hXr7Bf8PcDxdTyoStDhsTe1dupsnk0T/uUA8BnS9xBGo0LkTuIGpsPhFO3jJ
         N8rKbBrV+gHvi7gdaMRbwo0eJz3gd8WJkf0ZxlP1Qq/TmfhojfZOaTG4EALwmHqGPECW
         RGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/duoUCbLOM0QFQ/QGXANkt+cjZ5PU0ZBTqU1VBXp8I=;
        b=FWDD5fAkxyS90EUj9nebbBQXSw55FRC7w7mOvdPgQ9oT49m/wNHDvGZOgSZFI4ZN/h
         fOvg4J9pe4rpebFbKgl3O/XkfCovRaBdhf77uTshXtdslxZS3r5DJ09AQdeWXte7EIBQ
         pv7VMjnH49rFoluoe4Uo0rbq/WJ7Ij7rhrbL7bSdoY6SELCBz6P3HW5yEPYMKoaOLc0s
         5JOEVb2YpVVv4JvlP76ykDup5/HTC4ftYSJbZSGav10w0whjAsGkiWBUd6FXInDkcSKo
         XPITkk9i2SGuvmGl2P8jhsORlw2iMQMdDJOv55SFoZ3o79V1bZJBteHHhy/nhI9AUMQL
         YYvg==
X-Gm-Message-State: AOAM530itR7dSmKqBHsPUkmvxjxwLhfZr7DUvI1442fI7bbISS3VId0k
        PR1a2HR6AGYcJu4rJObqBVQ8mg==
X-Google-Smtp-Source: ABdhPJyHkPNhmfT8JFojH4HNxgsBWeTp+E2FgCZmKUHOuHsoYIKdOpHCmzSY4624MbTpsfkc4X9aaA==
X-Received: by 2002:adf:db8e:: with SMTP id u14mr18213052wri.233.1604939660064;
        Mon, 09 Nov 2020 08:34:20 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id 89sm15072542wrp.58.2020.11.09.08.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:34:19 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/8] rtc: omap: use devm_pinctrl_register()
Date:   Mon,  9 Nov 2020 17:34:02 +0100
Message-Id: <20201109163409.24301-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201109163409.24301-1-brgl@bgdev.pl>
References: <20201109163409.24301-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use a managed variant of pinctrl_register(). This way we can shorten
the remove() callback as well as drop a goto label from probe().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-omap.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index c20fc7937dfa..606fa80ad6e0 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -879,7 +879,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	/* Support ext_wakeup pinconf */
 	rtc_pinctrl_desc.name = dev_name(&pdev->dev);
 
-	rtc->pctldev = pinctrl_register(&rtc_pinctrl_desc, &pdev->dev, rtc);
+	rtc->pctldev = devm_pinctrl_register(&pdev->dev, &rtc_pinctrl_desc, rtc);
 	if (IS_ERR(rtc->pctldev)) {
 		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
 		ret = PTR_ERR(rtc->pctldev);
@@ -888,7 +888,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 
 	ret = rtc_register_device(rtc->rtc);
 	if (ret)
-		goto err_deregister_pinctrl;
+		goto err;
 
 	rtc_nvmem_register(rtc->rtc, &omap_rtc_nvmem_config);
 
@@ -901,8 +901,6 @@ static int omap_rtc_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_deregister_pinctrl:
-	pinctrl_unregister(rtc->pctldev);
 err:
 	clk_disable_unprepare(rtc->clk);
 	device_init_wakeup(&pdev->dev, false);
@@ -945,9 +943,6 @@ static int omap_rtc_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	/* Remove ext_wakeup pinconf */
-	pinctrl_unregister(rtc->pctldev);
-
 	return 0;
 }
 
-- 
2.29.1

