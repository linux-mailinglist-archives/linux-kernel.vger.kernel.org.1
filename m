Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4232B919A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgKSLpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgKSLmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:45 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB9CC061A4C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:44 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id o15so6109917wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D6cp2h2eDlsrEeECPXrUz6ZUKBrx5tQ9jmWqw1vAecM=;
        b=Wcn0gnk7Tf9Qc3WdfgQ9eqDwynxfbx22bsGGxSuoLvRCm5Ay9Nn53ATNxYtn8c9mOD
         6Ulzz4WrqC5ukiJQZCHHY4FLes/sbO3ODgwxzT3odPEIzmspq8efiPqQB1I5QNx5Gtz4
         0z4vReSn4N1W/iLeIdfsXAvSlsKnzXtSguZVQpggiCzL19boufJw0tspzSnW01Y6efj6
         ESVZhok6bbRziYINtyinFYUQiyOUYQ7aDBAyQJG3tatdHF367fc+/rGg34gniG/w1qfq
         4LVdFFCdjDRR96/d/HaO2XlyyfC89SgHdEDU2jKV/TJHAWtJzDOgFysZ2JPTiCFU3rsW
         d86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D6cp2h2eDlsrEeECPXrUz6ZUKBrx5tQ9jmWqw1vAecM=;
        b=lVlxS7VHC749rcZi7fqVsrRXQitqNoDVvJW4sIp4e2u5abKwdj9doovuV23q2x3HdG
         4Rx+nAfDPt1BzCvZfDvgfc2TUaLxwYl3QAo2mwtrOHP/4G6NaDW1WZXMTjbLXN7NbJXB
         d/j7MNWPt9OmwJSV9fXia77h9uOFXMLUl5csfn1VhTtaYA2nHZZDJQ6Zmr9Zz/Rx9ob0
         2pNTdLWcQcC3EYWQwKYW4sYMUXfjE406hgNTi/rldaO/RDIjy9EoL5ZAJWuTF8LjMrwv
         9r3BEYYDconkFCt8S3EpFpgciKJjrvYS2rBT8LVlfpHYWV9ejgZjzA7+s8paahxyhMLW
         8Hjw==
X-Gm-Message-State: AOAM533Sruije1+i8XFEdxg42XpWGXS5EcvjcKY/AYx1nzT0qG3L4F8k
        BtbFqhEmVCLbpAFIU0CwYBLyUQ==
X-Google-Smtp-Source: ABdhPJwf0g/XSjG9tS98yl0GA8zzdd4S/7J0Gw7+Q1cm62sDQrBNL606jqVOywlx7j575b9sLcfn9A==
X-Received: by 2002:adf:bb92:: with SMTP id q18mr9498648wrg.315.1605786163373;
        Thu, 19 Nov 2020 03:42:43 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:42 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 37/59] rtc: opal: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:27 +0100
Message-Id: <20201119114149.4117-38-brgl@bgdev.pl>
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
 drivers/rtc/rtc-opal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 7b9f8bcf86fe..d0e13635921e 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -242,14 +242,14 @@ static int opal_rtc_probe(struct platform_device *pdev)
 		opal_rtc_ops.alarm_irq_enable = opal_tpo_alarm_irq_enable;
 	}
 
-	rtc = devm_rtc_device_register(&pdev->dev, DRVNAME, &opal_rtc_ops,
-				       THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
+	rtc->ops = &opal_rtc_ops;
 	rtc->uie_unsupported = 1;
 
-	return 0;
+	return devm_rtc_register_device(rtc);
 }
 
 static const struct of_device_id opal_rtc_match[] = {
-- 
2.29.1

