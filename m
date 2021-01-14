Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883112F5EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbhANKXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbhANKXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:23:04 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A0C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:22:24 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w5so5159878wrm.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hXpzk7OffqSrHKLaiatk3ajUz4KlXJ/8J4lT5+GFR1I=;
        b=cWyvmtck+Ru9tLEC4AUdUbsEbLrYRwRdybsVkqPeCM2TUIIjtN3OHHDW3IdyMudlYj
         5f2VFMwVgFP6SSaYv5z1jl2LZaiRZjVJ2k8DtX6P3hdDyKjFVK6q8hu379tYgf021QB5
         kswXTpkzhVU3ZKCbX0+krkA9oAiiAxEnDg7iPptBxcEROkJrpxV21vZnLH9Pje/eOUKB
         CT8SzZftfVBQi2Mo3LCIekP9hfjc1D2UDeafyPA2/pVp7zIjGU0ITBMaJ60RG2AoowoB
         lbrqpKeHqvhIvOfwMlV8Ph8uFput3brC3y6nCOAMFQWfryZl9PYBfU5qcXvGTD+Kt864
         V0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hXpzk7OffqSrHKLaiatk3ajUz4KlXJ/8J4lT5+GFR1I=;
        b=DG/q7+QfTrTjDZOJWbU6C914C0WCTGWByaXaCeZ+8b6m3YOamyn3RPfPB2ATgSprgc
         kFnyGbdA+nydB5XG4KHzIT5dv+9SqIszX5LOn8Rdw0FXc4uiv6iYpWRBGWhjxRD9EJ45
         cSXCCxUFecDamS88YkOh6usjsuQcLyxxVkBJ2AZugQiqdqiXDW4eQKuvTwIUq9ERp/2a
         DOUNokvjop4ZrZMSTz1SIekkQVmbWln1/eJXXrPmjcbwLjk/GygeI0MzOetZpRWMTXHh
         ztD6qbjvI9URz5NLpQ0eEXAjq1hLOxWyb0dc2HqP9bY0+tg1Os9VWX0qwYN2lqbRQBgM
         zU9A==
X-Gm-Message-State: AOAM530bjApTS60isnghdoOxfjeHnQjfqRu0LLAlIZsqWdkbGz/i27fR
        3czfzxu3c08s7Or4ThCl88PsGQ==
X-Google-Smtp-Source: ABdhPJy9v8GD2EuiKN4Wxze5S5VeDveDx+zR3Z0+C06KqZtUssyCPZ/2SPqRiLUhxyOD++aqmszTDA==
X-Received: by 2002:a5d:6045:: with SMTP id j5mr6863125wrt.223.1610619743596;
        Thu, 14 Jan 2021 02:22:23 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id l7sm2468467wmg.41.2021.01.14.02.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 02:22:23 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 1/3] rtc: s5m: select REGMAP_I2C
Date:   Thu, 14 Jan 2021 11:22:17 +0100
Message-Id: <20210114102219.23682-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20210114102219.23682-1-brgl@bgdev.pl>
References: <20210114102219.23682-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The rtc-s5m uses the I2C regmap but doesn't select it in Kconfig so
depending on the configuration the build may fail. Fix it.

Fixes: 959df7778bbd ("rtc: Enable compile testing for Maxim and Samsung drivers")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/rtc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 6123f9f4fbc9..e4bef40831c7 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -692,6 +692,7 @@ config RTC_DRV_S5M
 	tristate "Samsung S2M/S5M series"
 	depends on MFD_SEC_CORE || COMPILE_TEST
 	select REGMAP_IRQ
+	select REGMAP_I2C
 	help
 	  If you say yes here you will get support for the
 	  RTC of Samsung S2MPS14 and S5M PMIC series.
-- 
2.29.1

