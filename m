Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC64D2B91C1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgKSLrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbgKSLmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:25 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FD6C08C5F2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:23 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 1so6466739wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GvTtoNfPAwDYShFchSKCn3Eemr2qz/Dv7hBEmSvAX08=;
        b=UoXXcQv0Hio1fe3RsOra9aCqRjeQffuFh0m8SKo5rkq+y8er/Beh21MfH62eQrBXWw
         xN3PT7Sjlqwwbymb6cdFK8LgYNnkCV6KG76UQBOPTHHVDMw1KYU4uRMouse//aOsq3DO
         2LwTfkFwPefbvBnknRHfj9wwEH01JHaTqYrogBFxzarGDE68VOmHZhMMv7CL9snbnPJv
         MuP3ecDHLjxVht5uaPBsiGlCwhyV8mzvHnZPVy1vMmi/tsKyWbi3lILR/iYAixR4fEYg
         joDdInt3sIR0GTHTCR590vQYJ8rLSAumNvzH053XHgbrVMGntsUa9S4XTiCurApohXL9
         0Qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GvTtoNfPAwDYShFchSKCn3Eemr2qz/Dv7hBEmSvAX08=;
        b=cyfeU6ECrXjgd5+1USYfbupAr22+XkO2dnhv3jgk/CXt99if7q75sR3oGntnpK/Fqj
         P9AjvMJ+OCFmNhreJQVDaAeD6rywer9bz/xN4jbrgGxfgj+mAIcwMOL5KtUqgoUdnw4P
         qIm4NcKP/MsKgicMQDCGD+kcnR3C2Gd6mViJtsfsbtdk9+zBSp0GDVTIyP7dWj+cPU60
         UZOtM+/Av2d1jJ8yHsMI9tYlhtqwelIq0x3nW/D/rpvXxHiVruDGyMecCooPkdAYI2EB
         4EZARCGGIZ0r/2URw0sccommNZ17OCw1wp6utoMQjidbaCyU1QgyLLlSRQNOQJRj5AcQ
         WNlQ==
X-Gm-Message-State: AOAM530I6R5hEANTQqbAaZiVB5M7Yn11/Eudn4z+hfCDpm1foGC9aPSi
        dHn9L+EuQ2C0no1IQBmebo2EhQ==
X-Google-Smtp-Source: ABdhPJxkO8vRz/sYIAmoOdMqUl1xpu41+9Vw1tpFB182EQNhftKAZUfOmlol4bAzGoWkJtOeql6kdQ==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr4294337wma.151.1605786142316;
        Thu, 19 Nov 2020 03:42:22 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 17/59] rtc: hym8563: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:07 +0100
Message-Id: <20201119114149.4117-18-brgl@bgdev.pl>
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
 drivers/rtc/rtc-hym8563.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 24e0095be058..f39568c6d390 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -558,11 +558,11 @@ static int hym8563_probe(struct i2c_client *client,
 	dev_dbg(&client->dev, "rtc information is %s\n",
 		(ret & HYM8563_SEC_VL) ? "invalid" : "valid");
 
-	hym8563->rtc = devm_rtc_device_register(&client->dev, client->name,
-						&hym8563_rtc_ops, THIS_MODULE);
+	hym8563->rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(hym8563->rtc))
 		return PTR_ERR(hym8563->rtc);
 
+	hym8563->rtc->ops = &hym8563_rtc_ops;
 	/* the hym8563 alarm only supports a minute accuracy */
 	hym8563->rtc->uie_unsupported = 1;
 
@@ -570,7 +570,7 @@ static int hym8563_probe(struct i2c_client *client,
 	hym8563_clkout_register_clk(hym8563);
 #endif
 
-	return 0;
+	return devm_rtc_register_device(hym8563->rtc);
 }
 
 static const struct i2c_device_id hym8563_id[] = {
-- 
2.29.1

