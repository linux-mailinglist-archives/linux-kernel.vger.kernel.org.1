Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F52B9174
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgKSLn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgKSLnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:43:06 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D84C08E85E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:43:06 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c198so4991011wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=apiQTlE/nQ6vGfvEi/I7tsjxSIcMbp1twFG9p/luK2k=;
        b=1afVP7tKUbv2dklGMJFaViXca5xz8iWEj0rParlDkrSNicm5jd94KiDoXM2btU40JP
         oByz1D7w5d29n8R60p3mVtuuEpDXcHugNKnz/H/gFCHU6KXIqqxjJJqT+si7zN6wv5md
         JRIe2OTKHNP0+miQHsD+K5sJReNn6GWzCfmEjk51X8hNGaAd3GWsDux1rKZzRD09Xtfs
         0HzgsUV9mR/q2KPzsknFA3YV2zPx3rnRBHt/SmYNBuMlOWYyo14pF/056TVPSsMUu1hu
         20N6tT4TaTVvKHdKodNKuS344VU8iMOrXdNFusjQaEkOS6ZBpd7Vf1RgwIo65eH9/T40
         bLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=apiQTlE/nQ6vGfvEi/I7tsjxSIcMbp1twFG9p/luK2k=;
        b=pVpKte1I0RL32ihs7eZgJlV7I0Mtb5/zaqM5cxP6/lTD6u1gz5KEsnSS2RblmgCxbt
         SyRFei8ZUVmXBOlObPxVySAaEb3N5p1mP9U6ATI2aXad39f2JpQC4sd1y6rWVJng3X3N
         HT6IGhU84oRY+RVCR0ptQOlV3XXnJ/dgvF4doo/X8+31ikxdMcKmFndfIFE5lH4UwvmE
         UvdTXMhYgNgTSL28H3h3kPx+AS9FkbjNN2j7LRLn415jOcoiNa3BpuMM1WQp4f38yJXd
         vuIx4OYH/JgsrzuqDd700RPPlKiJgjZ7EiL20Jm44rq6GB064qX5bnp1BT1DQqXunc5g
         056Q==
X-Gm-Message-State: AOAM533OtzKoFEeNUe4TVL1N5n3ywMjM0JthmfHqy0xQGvNsmU/BsU+d
        k6d6SrrV+o9dIAtDIcYJAw7YtQ==
X-Google-Smtp-Source: ABdhPJxTP3tGPNfscEpaeN4iTtEmTTcAMr21XxGLG4/bW4ptMB/xyBLpxxBns58GS0SQBBO3DHS2sA==
X-Received: by 2002:a1c:4055:: with SMTP id n82mr4441264wma.68.1605786185104;
        Thu, 19 Nov 2020 03:43:05 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:43:04 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 56/59] rtc: msm6242: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:46 +0100
Message-Id: <20201119114149.4117-57-brgl@bgdev.pl>
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
 drivers/rtc/rtc-msm6242.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-msm6242.c b/drivers/rtc/rtc-msm6242.c
index 80e364baac53..b194f8bff403 100644
--- a/drivers/rtc/rtc-msm6242.c
+++ b/drivers/rtc/rtc-msm6242.c
@@ -205,13 +205,14 @@ static int __init msm6242_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, priv);
 
-	rtc = devm_rtc_device_register(&pdev->dev, "rtc-msm6242",
-				&msm6242_rtc_ops, THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
+	rtc->ops = &msm6242_rtc_ops;
 	priv->rtc = rtc;
-	return 0;
+
+	return devm_rtc_register_device(rtc);
 }
 
 static struct platform_driver msm6242_rtc_driver = {
-- 
2.29.1

