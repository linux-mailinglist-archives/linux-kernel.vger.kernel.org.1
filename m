Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD2F2B9167
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgKSLn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgKSLnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:43:03 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D5EC061A49
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:43:01 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a186so4090915wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKpHBnJOxeNfseDIbAnBRefqDh1bNvtW26xYHmaRAOI=;
        b=pXe2/+X8kiGPNLJQT01Tv+hEayd1byb5VROT6MoCs2fBuCiOSnwnbCCTpHFA0JHnXe
         TV4LwAD3FZfsq9ZHvNcqB8vj51+7cHXYcH6ihKhohWiFwsaJo3MhCx3s38XYJpbEFu9R
         Cb1+FiOUni1/pC1w9f5jeDlMTvILcshUvJT+DEvsSjSJgb92+8QL9X/L2fYbUu4g2jZt
         6EkMbCiQQBGVe9k3UPYXkbVf2LeXekkwB6gmm1U1Pv4K2IZHIsTAYWSxpVsarM4yNGcZ
         1Kra1r81kXcBdLb5C1DSDWFUr/eSWhGu+77B0Z//oSigDdibhvyksEWhJqE/xBN0uC/1
         WXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKpHBnJOxeNfseDIbAnBRefqDh1bNvtW26xYHmaRAOI=;
        b=UzxBcnz/LFdClsafWiqk/keJTpSHvasV9fVqDIOdI6yWEKPRQzVFDKl13pcH7OuK7p
         gx0VBJUv/o0PzHfgLZwGz+04/SE2TYPN0OC9lGcwZcqKM4SIgOqz9QqB+PxpZ964wEGS
         Yv82j55L7J22iRJhX9Z0RrbnSsiEEKDIMmS5wgHQHd5L7SEb22Yo3V5KAxppTx2fEiQp
         SKwPcKXqcyort87+PL3hk7/BsODMYfiRUQ6rQsmHTvjHGOQKqUCkbsUSx6uvFYW+vQCV
         olJZzT8aydYgoDQ7BSrFIHWc/N5m9K3ppSsL5/rohN5RY1l3KL8B4t9BVZYS9b3mSG+f
         tCrw==
X-Gm-Message-State: AOAM533GGOqxD8wSEnkEHcU2IhPVgVrTClVhPztX3E3zaIwXbe2UbIAt
        s6CvRdQvxxFLkTom/Ky8L6STww==
X-Google-Smtp-Source: ABdhPJxeul1MeGOvy60f2Vi7YQ8dy5jvk/a1/kohfcB2ZyuhFCV83t12JDRTKRLPXNwo/pqfY7k4yQ==
X-Received: by 2002:a05:600c:4101:: with SMTP id j1mr4019930wmi.35.1605786180384;
        Thu, 19 Nov 2020 03:43:00 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:59 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 52/59] rtc: rx4581: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:42 +0100
Message-Id: <20201119114149.4117-53-brgl@bgdev.pl>
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
 drivers/rtc/rtc-rx4581.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rx4581.c b/drivers/rtc/rtc-rx4581.c
index c092e0452347..5d42aa051b4c 100644
--- a/drivers/rtc/rtc-rx4581.c
+++ b/drivers/rtc/rtc-rx4581.c
@@ -261,13 +261,14 @@ static int rx4581_probe(struct spi_device *spi)
 	if (res != 0)
 		return res;
 
-	rtc = devm_rtc_device_register(&spi->dev, "rx4581",
-				&rx4581_rtc_ops, THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&spi->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
+	rtc->ops = &rx4581_rtc_ops;
 	spi_set_drvdata(spi, rtc);
-	return 0;
+
+	return devm_rtc_register_device(rtc);
 }
 
 static const struct spi_device_id rx4581_id[] = {
-- 
2.29.1

