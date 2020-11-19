Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971F32B914A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgKSLmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgKSLmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:08 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4920C061A49
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:07 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w24so6469622wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bW99gdBHcp6/Wgj5kbKnIPrjD6pJqlCtMEvHu/hoqdU=;
        b=Fs5WNQgAUWMiBABbH+g9FLs4Z5RNJoBSr0fHL/YDaRSQS3B/NhRhUdMnJ/2+TsXgEh
         XPfIwyrbe6++Pn1tNn3SG422u3Qlaqb4Tk5AOqEzDYMel4eewDxR83pyvmGP2xzQI6HS
         darYaLwG2pKnRaHCRMEYbrWKtE3v3Mez7Oci0NNMzocB+rnfssg0s+c26mN2hBwCORXP
         B6Ot7UShF3rfa6MACnaMCE2j5qwlVdPldd/7FQSjrhYxMDGSulIG9Izyu0gz4nFjXb2Q
         H2hT7faw00lF6E4Bly3P3Tjj601AEGiAxGM4k77xeu2LTfGU1Kpk11MY3tWBDVNbObaB
         0f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bW99gdBHcp6/Wgj5kbKnIPrjD6pJqlCtMEvHu/hoqdU=;
        b=nn+DOQ3pOagpSsltlt1CeSIPp53zxUjjMlHuxYthQo2oAUKF5sD8sPhddEofnPXben
         nCBk8k1bcbG4xQk3DY8K9nuTwJ4UX8Hc9cw/Htqh9HFy1q5HUH6VxAa3KnKeMDtVBny0
         VwRr9Q867eKD9TO3SIpEZ9RmsTnvq0isK49Ps89jwLy1a+pedH5avLtxOj1LznkRyfB/
         g9mc71Rj2UUiH0J16l57z230DMo09rJLnIKPtllYoPSP1JFP8qQCOOjlxeskt/oX38Vh
         eOC3anDdYGovx/ECVVImzcFlcD+wwVecFtoWZdWk6DgJEKtZhU7f1jq5HMFIdo3LkOCx
         pJIQ==
X-Gm-Message-State: AOAM531PLL7nsB6d5GhUdHRliZqYt3XifZK9B3emI7KXtrzOHQ+Q6HZm
        VUorAgmL5w14uN1OhANTYcY/NA==
X-Google-Smtp-Source: ABdhPJwxbAm7Je1WcgBxcMlNOAN3Z7/oTCfYy0eMccoMnjkh57UVFHXGSsaWmEi+qffjgI8EyDQgcg==
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr4099018wmb.139.1605786126669;
        Thu, 19 Nov 2020 03:42:06 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 02/59] rtc: m41t94: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:40:52 +0100
Message-Id: <20201119114149.4117-3-brgl@bgdev.pl>
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
 drivers/rtc/rtc-m41t94.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-m41t94.c b/drivers/rtc/rtc-m41t94.c
index 6803b0273302..6e970ad350d8 100644
--- a/drivers/rtc/rtc-m41t94.c
+++ b/drivers/rtc/rtc-m41t94.c
@@ -120,14 +120,14 @@ static int m41t94_probe(struct spi_device *spi)
 		return res;
 	}
 
-	rtc = devm_rtc_device_register(&spi->dev, m41t94_driver.driver.name,
-					&m41t94_rtc_ops, THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&spi->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
-	spi_set_drvdata(spi, rtc);
+	rtc->ops = &m41t94_rtc_ops;
 
-	return 0;
+	spi_set_drvdata(spi, rtc);
+	return devm_rtc_register_device(rtc);
 }
 
 static struct spi_driver m41t94_driver = {
-- 
2.29.1

