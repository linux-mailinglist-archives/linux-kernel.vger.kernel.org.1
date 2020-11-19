Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692722B9157
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgKSLnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbgKSLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:53 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD68C08C5F2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:53 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r17so6157774wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qe64UAh6vuon0ziKW8xzw0ROoo8RamQkTQ/rMabYI0=;
        b=V/zDrUkVE9bJHdvmS/NwndN+y0BJptqchBiGF4e4O34qrVFMZIA8uN17WidzR/cuQK
         diRiIiEMEu0HqdwZLUGMPPHhDXJtfrqAgA1Lz/awTm1C9+8NpP/tzJBWzBTWpYZe/3AG
         DGTDHbKQ10r4jIuXQ0N6+lydLBEyISh0onTR3QY1HR5jEE/mzvVH1n21tYlWrlapsXh3
         7/vQ2YCvrmzNkRFP8Gj0ejJtyGNqVMr95Md+1dOFMECK42kfFXMXhhy1PCo4RN78Aula
         uPzxnPUKZOr5vTzivfeFS5tiTAfa1Oz9+Tv6XIu9sJkqOT2SQuBuosC1w6B9B2Ul06yP
         K5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qe64UAh6vuon0ziKW8xzw0ROoo8RamQkTQ/rMabYI0=;
        b=Tm9LN5QjPI8USuczM/QkO7dQNxAKBexIkPyUqKPG96SjUJ0bNitmzUQtVm6JBBBm1D
         o+CSwzgjzgVERT6KPepX9vPLkmFjOZWzO+jHs232XEr+5RiF/kPQySx5bSHwnYB38C0W
         VmHHUO6t84bnYhUvzr89y2KkbQKudgCoF/d5wSKBhXq6ygioQDJFHsZ5Hm9mG3AqSxPd
         eSaSmxOmuuEz2Y44A5hucLxvQqLfk477AdaRXOfpbaKmWFIDRaKQY8BKo9mcMzEDSa/S
         3F3PFzBQ4ny73z8zjUfoQad0bRCMXn2CDwOiYCFKeQ3PJmPKA+orpl/kQudvLTPANmWa
         wcfg==
X-Gm-Message-State: AOAM532NCLTPE7gP4n+LEKoSZsJW1J0xIt8ozVB0zcBbFJD2fx9eflDr
        cVp436uPVqnGGgXgc1h0Kela+Q==
X-Google-Smtp-Source: ABdhPJw96Cxht6fwOle4+uVEI0+3zhrwuSByHiLmQcBDFIgyGuRgRUcXYbtuOzy0k7JXvpUv8ScG9g==
X-Received: by 2002:adf:9b98:: with SMTP id d24mr9538285wrc.17.1605786172290;
        Thu, 19 Nov 2020 03:42:52 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:51 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 45/59] rtc: mt7622: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:35 +0100
Message-Id: <20201119114149.4117-46-brgl@bgdev.pl>
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
 drivers/rtc/rtc-mt7622.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-mt7622.c b/drivers/rtc/rtc-mt7622.c
index f1e356394814..20db5ea43309 100644
--- a/drivers/rtc/rtc-mt7622.c
+++ b/drivers/rtc/rtc-mt7622.c
@@ -342,14 +342,18 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, true);
 
-	hw->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-					   &mtk_rtc_ops, THIS_MODULE);
+	hw->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(hw->rtc)) {
 		ret = PTR_ERR(hw->rtc);
-		dev_err(&pdev->dev, "Unable to register device\n");
 		goto err;
 	}
 
+	hw->rtc->ops = &mtk_rtc_ops;
+
+	ret = devm_rtc_register_device(hw->rtc);
+	if (ret)
+		goto err;
+
 	return 0;
 err:
 	clk_disable_unprepare(hw->clk);
-- 
2.29.1

