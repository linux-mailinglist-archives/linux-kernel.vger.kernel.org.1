Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8BA2B91B5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgKSLq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgKSLmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:33 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024C9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:33 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r17so6156599wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOdMgmRPW212YndSnPHiJLqW5WhErPY60YEPYmAU1R8=;
        b=tTUdt8EFr9An4ob7ERIoDtjN5Al+81KQZR1em0r2duWW83htffHiamhPXrr4SNtw0e
         gyz2G/ZOvDRF5Ae3xt7pvDCiCc+i1WQUxegf+2cQWBn1CU28D/whpu2QtwQrnkkq7+J5
         Wpsep/E/t80Ua1cqxB+S0G+B7SXKJJ1srCNlOcrDeoOfaCGdA8OUH33MixbAcqtl3fQ0
         Fod1RJOKpk1wYhp+kwt7X5h/l1QWZipbO0oy/YxxiB58K0+utw/kpr31cPccWXH9dcU2
         V2YtK6b5CIT9koJpOQg/RI5sZadM39PSMTtHpZDl+lTAm9VwFJUhjRpIp7UeeXbKYr8X
         i9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOdMgmRPW212YndSnPHiJLqW5WhErPY60YEPYmAU1R8=;
        b=Csb2ja0g2I/50NCCk92UooOKItnqgw1V3jjeYoOlh9LyHo864XrPcrtFJhOQriCb40
         X2ED4+UNez4JaAawaQXQU0xMItX6B3o6C8jI+e9XBSKK2l15L5pAvze3zjFLyEddyHW2
         AZ+JTJCvlxfNEMIu3pN1k6gIk1akH9l8tHc3PGsgZ/RPKRa3Y1Ui8rusVRvjQHSON7lw
         j3OLqR4WA0Y5Yo9Ft4qmGPmcqeE+yPTSP19pPPvy9VjvjNiOrJ/RXx3NGqhwiTjVWnrG
         SM92x5ft1XgftyJuk/wCK2oMxADx+TOpo5FbNHs6LcKnc/1zLzwcBxEhx6Ns3EKhb6Lq
         pPsA==
X-Gm-Message-State: AOAM533tF/NXJcIg29spHBiOA3LNjneIUETJOQ8DLOC6rBFKEk39pZTN
        8cO1ycw13Fh9p8zXpEfL2cvXapaFU6DoNg==
X-Google-Smtp-Source: ABdhPJxYBxFqvHwIGZioiB4EDGQhqYkun71ps5kot9PHtNbUwzmar4rJEiMG3gxAWQmY7ZpjylwYUg==
X-Received: by 2002:adf:8169:: with SMTP id 96mr9535932wrm.418.1605786151735;
        Thu, 19 Nov 2020 03:42:31 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:31 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 26/59] rtc: spear: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:16 +0100
Message-Id: <20201119114149.4117-27-brgl@bgdev.pl>
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
 drivers/rtc/rtc-spear.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index 833daeb7b60e..acdb37b98cc5 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -383,17 +383,19 @@ static int spear_rtc_probe(struct platform_device *pdev)
 	spin_lock_init(&config->lock);
 	platform_set_drvdata(pdev, config);
 
-	config->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-					&spear_rtc_ops, THIS_MODULE);
+	config->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(config->rtc)) {
-		dev_err(&pdev->dev, "can't register RTC device, err %ld\n",
-				PTR_ERR(config->rtc));
 		status = PTR_ERR(config->rtc);
 		goto err_disable_clock;
 	}
 
+	config->rtc->ops = &spear_rtc_ops;
 	config->rtc->uie_unsupported = 1;
 
+	status = devm_rtc_register_device(config->rtc);
+	if (status)
+		goto err_disable_clock;
+
 	if (!device_can_wakeup(&pdev->dev))
 		device_init_wakeup(&pdev->dev, 1);
 
-- 
2.29.1

