Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F47C2AC0F4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbgKIQec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbgKIQe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:34:27 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203E6C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 08:34:27 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 23so244063wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQ1SOeDpHgoHImJQ2Lag3839uEZ48RpVwk+nINXpJVA=;
        b=zR+QLO3XokQP04ssVFP5l/WmnaAAwwIFKwtoE20DwM3szx5AyXP4hwgTWtx5oNLDel
         X4+TZRZru0VUpguncqAvw8uJ84FIkGPcnRKABnHG7Y7kHp+uoA/ncGOq+mGsi4V106Tu
         zU0/uwlyqOk/c81aQnI1e6zjZKyzrP6Ct297hoqr9BkPxQXGmQiCe7mV4knsLVlp2VfW
         hfWQxV278pOK+1H9a0IfNfrUj9I2aUcy8ALfAbBDh5gHOWIWuwXpZOXXrg9ZdaK/EWkv
         Uv1YOKk+xUrPYnELsaXizPRojSLTf3J4AirzO5R4EKug3NiOS3kYAR5E9Vqae6j4IKki
         Ws6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQ1SOeDpHgoHImJQ2Lag3839uEZ48RpVwk+nINXpJVA=;
        b=Y8a0KdK4GsPDjKMZUaPyAA0IIfc5Zk/sU5JUG0I7kgOFZXoefVZF7vgOP4bhVH8HkO
         6mcHVixIu7ssmNz6vP5veYPCGdQa1O+gXa7zwebIO8al0LkTQDSukAI7mWDCc9DGhaOb
         78CvtM+N2CCPqXDiH2SJFit+Bl97+k30QRE69c25VnufLlxO7Tlv58I0jstFcX3597cD
         BJZz+kHRf6GH3zHnfSrU318HrX2Y11QVDauBAulydET4uibDJ2xsJZJPkvcezr+D3Iub
         wXWQQJmM5gBPznigGV4B/gx255/vvRn1oFQTPK+7xxrnX3SPfKwP0Pkrg4w8LuxpO6pA
         +8GA==
X-Gm-Message-State: AOAM530vmSd7GEuh7rQlKpS2TUrOFoW5jlU3hpnrlPIbBR3oNqncFWsL
        o5o6h3kjozAaGE+Db7Z4Pgh5/PDwqTC2bQ==
X-Google-Smtp-Source: ABdhPJzO46u0zuWawqSKL1wSRT4PxwsoL3g7YDkPiLW9fFSJaNhfPE1laJlzVKH0hLQdOg2k24L0wQ==
X-Received: by 2002:a1c:b0ca:: with SMTP id z193mr1327wme.82.1604939665893;
        Mon, 09 Nov 2020 08:34:25 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id 89sm15072542wrp.58.2020.11.09.08.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:34:25 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 6/8] rtc: nvmem: emit an error message when nvmem registration fails
Date:   Mon,  9 Nov 2020 17:34:07 +0100
Message-Id: <20201109163409.24301-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201109163409.24301-1-brgl@bgdev.pl>
References: <20201109163409.24301-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Some users check the return value of devm_rtc_nvmem_register() only in
order to emit an error message and then continue probing. This is fine
as an rtc can function without exposing nvmem but let's generalize it:
let's make the registration function emit the error message so that
users don't have to.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/nvmem.c      | 7 +++++--
 drivers/rtc/rtc-cmos.c   | 3 +--
 drivers/rtc/rtc-ds1553.c | 3 +--
 drivers/rtc/rtc-ds1742.c | 3 +--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index 7502deb6390e..07ede21cee34 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -13,14 +13,17 @@
 int devm_rtc_nvmem_register(struct rtc_device *rtc,
 		       struct nvmem_config *nvmem_config)
 {
+	struct device *dev = rtc->dev.parent;
 	struct nvmem_device *nvmem;
 
 	if (!nvmem_config)
 		return -ENODEV;
 
-	nvmem_config->dev = rtc->dev.parent;
+	nvmem_config->dev = dev;
 	nvmem_config->owner = rtc->owner;
-	nvmem = devm_nvmem_register(rtc->dev.parent, nvmem_config);
+	nvmem = devm_nvmem_register(dev, nvmem_config);
+	if (IS_ERR(nvmem))
+		dev_err(dev, "failed to register nvmem device for RTC\n");
 
 	return PTR_ERR_OR_ZERO(nvmem);
 }
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index eea91c1538aa..766074c04b53 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -869,8 +869,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 
 	/* export at least the first block of NVRAM */
 	nvmem_cfg.size = address_space - NVRAM_OFFSET;
-	if (devm_rtc_nvmem_register(cmos_rtc.rtc, &nvmem_cfg))
-		dev_err(dev, "nvmem registration failed\n");
+	devm_rtc_nvmem_register(cmos_rtc.rtc, &nvmem_cfg);
 
 	dev_info(dev, "%s%s, %d bytes nvram%s\n",
 		 !is_valid_irq(rtc_irq) ? "no alarms" :
diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
index 2d2eb739d92b..bb40ea8b6373 100644
--- a/drivers/rtc/rtc-ds1553.c
+++ b/drivers/rtc/rtc-ds1553.c
@@ -309,8 +309,7 @@ static int ds1553_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (devm_rtc_nvmem_register(pdata->rtc, &nvmem_cfg))
-		dev_err(&pdev->dev, "unable to register nvmem\n");
+	devm_rtc_nvmem_register(pdata->rtc, &nvmem_cfg);
 
 	return 0;
 }
diff --git a/drivers/rtc/rtc-ds1742.c b/drivers/rtc/rtc-ds1742.c
index 29792a8cce97..39c6c3a85b34 100644
--- a/drivers/rtc/rtc-ds1742.c
+++ b/drivers/rtc/rtc-ds1742.c
@@ -195,8 +195,7 @@ static int ds1742_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (devm_rtc_nvmem_register(rtc, &nvmem_cfg))
-		dev_err(&pdev->dev, "Unable to register nvmem\n");
+	devm_rtc_nvmem_register(rtc, &nvmem_cfg);
 
 	return 0;
 }
-- 
2.29.1

