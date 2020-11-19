Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814542B9182
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgKSLoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgKSLm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:56 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8328DC08E85F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:54 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a186so4090590wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aByO6DL0wDbk3HzAdUJqboBaZ/3ycC97lV3fXAcuoGo=;
        b=kA7xpXCDXZYVoAxd0XJCrnub7/jXthSa+Gcmk/WkV+lGTKwn0DfH/5hIb/MOqis4UI
         D2aOsQ3mmJfs1YDW2JlaHBrwGLdVXcEaR8QvASSMz0Oaw29XRowmp/GeM+6p2G49hymT
         X1du/RbUHqZQhtyuPeTDKIOQyJRtywvJhyhTEzYNIGrdAzMQ4zD4oozFeesctFK2bUWH
         z194HeYPJ9oSQdbd1PkNHRM3MioRqzBfSiw6vDn0dT/n1V4mRVcSuN1TDKnkc9q6nr9t
         w1tGOzJv445cvPOYfee9dW8DLmk+Vkoz6MiwOsx2rwaursxzKTmnykx5gzM5wJRvY5f/
         ycZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aByO6DL0wDbk3HzAdUJqboBaZ/3ycC97lV3fXAcuoGo=;
        b=KSTsZKnOxUQa+6TdMhlKCivun9ZPFGCU+hEb2WjUZRAUK1C9VbGlQGzpeecRuxvmAT
         RqZlfg+KE08R3nhx9cbk7IC+uGL4Ij6yL14LBX5T/kMVrf1nlADU6f84bw4nn3EQTSCn
         js183O2hsqUEpZwCnfW/uoBOsiCgEKZMppwGXERSHzCsSJkE7OIADLPrJb1E+hQfbKqf
         /aeeyiFrNZ9ajVokatqklj0MUUII+purKa6/i2JbGpPlLKJGaDMreBxTdtRVvR+4ou+K
         Mcja3vbmpoHxlGx2agANFF9C0yiDk6KBKqrloXlG7ftnyCIYiKvjsH3l/Y24S2G08qpn
         KmUA==
X-Gm-Message-State: AOAM530P7Y14sGYs3tn3lbq1+kpwXwl08kiv1/2Zhxub4rYj1wSl11/D
        DGnrHHnF7m26VH+IvtPo4+DDLw==
X-Google-Smtp-Source: ABdhPJzfsFltulwuVxtTrXN/FY8DRhyita06PJ+1IMjX4Zz4f47M9h/+9TwNjllbAMKDJGMp5gORaw==
X-Received: by 2002:a05:600c:4101:: with SMTP id j1mr4019457wmi.35.1605786173320;
        Thu, 19 Nov 2020 03:42:53 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:52 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 46/59] rtc: ds1302: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:36 +0100
Message-Id: <20201119114149.4117-47-brgl@bgdev.pl>
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
 drivers/rtc/rtc-ds1302.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-ds1302.c b/drivers/rtc/rtc-ds1302.c
index b3de6d2e680a..2ab0d6ea3a1c 100644
--- a/drivers/rtc/rtc-ds1302.c
+++ b/drivers/rtc/rtc-ds1302.c
@@ -174,15 +174,13 @@ static int ds1302_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, spi);
 
-	rtc = devm_rtc_device_register(&spi->dev, "ds1302",
-			&ds1302_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc)) {
-		status = PTR_ERR(rtc);
-		dev_err(&spi->dev, "error %d registering rtc\n", status);
-		return status;
-	}
+	rtc = devm_rtc_allocate_device(&spi->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	return 0;
+	rtc->ops = &ds1302_rtc_ops;
+
+	return devm_rtc_register_device(rtc);
 }
 
 static int ds1302_remove(struct spi_device *spi)
-- 
2.29.1

