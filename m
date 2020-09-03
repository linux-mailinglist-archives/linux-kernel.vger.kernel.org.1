Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F67325CE44
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 01:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgICXZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 19:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgICXZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 19:25:07 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72426C061247
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 16:25:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mm21so2292195pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3Silfeuvcl4kFvZfCEi0iNKtoIc6amr53FeYznXPLY=;
        b=Fywm/KnARDujk3kviDnTvg5Pzu5ITteK2BzgBrSgWH267O/quBchd8mdypWa+2dAQ4
         I4MfECk2zW6oL11efjvlJ9FO2XMUh/0vsq6+JEgZ9gyS/3f6tyHUkqi0P3/H1ZURF80H
         d12vvD1zoSH6MMHXLbmg5z7NUNja90YIwXbik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e3Silfeuvcl4kFvZfCEi0iNKtoIc6amr53FeYznXPLY=;
        b=DoPzj7s8tZaE1fL6Rybm94tiozK5K3uyPIji4ZMs0tViFqX2XnzNAjLhU+btZqlOg8
         p66yeGnkgkMnIr0htjPQ9QNS2e7Z0K3JS/PwClEiOFYss1xfiOdcvqcS5FkEQ5dnNuYd
         IKb0iBXoDglFGLEFln2wxJ3oo/PFGGdLwA5+QLOWxmntlRj1qgi3Hb+uDQelM9nh5CTM
         51WsWe1guUSphDoOfxyXB1uEyTBxRq8bMbYFH7NGChklq2ad7udU49tntXkM17/geKx8
         MIhhyGlHyVtRckytjHsGS2kUkreskd+nhP5f6xWgT5ytuQsxUOAxJHRD7QQdtrWHWtPP
         BTsw==
X-Gm-Message-State: AOAM530NTCAvtBk8TJAvcErNiqj3Zioe4Qw3Jn5U46ZHtdw6fldjEl1i
        y3xdrtuLljQv4HnlqailLw+dXQ==
X-Google-Smtp-Source: ABdhPJwWfzAZ10vPfR0QJaoB8eHonW3CA+X8yz8LX3T/aJxkGo07VPL8MlU0us3e1q5HTyrCwErD2A==
X-Received: by 2002:a17:90a:8b04:: with SMTP id y4mr5135673pjn.115.1599175507021;
        Thu, 03 Sep 2020 16:25:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q7sm3614459pgg.10.2020.09.03.16.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 16:25:06 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jun Nie <jun.nie@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Ray Jui <rjui@broadcom.com>,
        Robert Richter <rrichter@marvell.com>,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH 3/6] mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.14
Date:   Thu,  3 Sep 2020 16:24:38 -0700
Message-Id: <20200903162412.3.Id1ff21470f08f427aedd0a6535dcd83ccc56b278@changeid>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200903232441.2694866-1-dianders@chromium.org>
References: <20200903232441.2694866-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is like commit 3d3451124f3d ("mmc: sdhci-msm: Prefer asynchronous
probe") but applied to a whole pile of drivers.  This batch converts
the drivers that appeared to be around in the v4.14 timeframe.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/bcm2835.c                    | 1 +
 drivers/mmc/host/cavium-octeon.c              | 1 +
 drivers/mmc/host/dw_mmc-zx.c                  | 1 +
 drivers/mmc/host/meson-gx-mmc.c               | 1 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 1 +
 drivers/mmc/host/sdhci-cadence.c              | 1 +
 drivers/mmc/host/sdhci-xenon.c                | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 35320bc9dc02..8c2361e66277 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1474,6 +1474,7 @@ static struct platform_driver bcm2835_driver = {
 	.remove     = bcm2835_remove,
 	.driver     = {
 		.name		= "sdhost-bcm2835",
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= bcm2835_match,
 	},
 };
diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index e299cdd1e619..2c4b2df52adb 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -327,6 +327,7 @@ static struct platform_driver octeon_mmc_driver = {
 	.remove		= octeon_mmc_remove,
 	.driver		= {
 		.name	= KBUILD_MODNAME,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = octeon_mmc_match,
 	},
 };
diff --git a/drivers/mmc/host/dw_mmc-zx.c b/drivers/mmc/host/dw_mmc-zx.c
index d9e483432a61..51bcc6332f3a 100644
--- a/drivers/mmc/host/dw_mmc-zx.c
+++ b/drivers/mmc/host/dw_mmc-zx.c
@@ -222,6 +222,7 @@ static struct platform_driver dw_mci_zx_pltfm_driver = {
 	.remove		= dw_mci_pltfm_remove,
 	.driver		= {
 		.name		= "dwmmc_zx",
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= dw_mci_zx_match,
 		.pm		= &dw_mci_zx_dev_pm_ops,
 	},
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index a68b43082f61..4ec41579940a 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1264,6 +1264,7 @@ static struct platform_driver meson_mmc_driver = {
 	.remove		= meson_mmc_remove,
 	.driver		= {
 		.name = DRIVER_NAME,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(meson_mmc_of_match),
 	},
 };
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 32ab991544ef..90b395a187fa 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -357,6 +357,7 @@ static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
 static struct platform_driver renesas_internal_dmac_sdhi_driver = {
 	.driver		= {
 		.name	= "renesas_sdhi_internal_dmac",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.pm	= &renesas_sdhi_internal_dmac_dev_pm_ops,
 		.of_match_table = renesas_sdhi_internal_dmac_of_match,
 	},
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 13ff023fbee9..c5f789675302 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -463,6 +463,7 @@ static const struct dev_pm_ops renesas_sdhi_sys_dmac_dev_pm_ops = {
 static struct platform_driver renesas_sys_dmac_sdhi_driver = {
 	.driver		= {
 		.name	= "sh_mobile_sdhi",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.pm	= &renesas_sdhi_sys_dmac_dev_pm_ops,
 		.of_match_table = renesas_sdhi_sys_dmac_of_match,
 	},
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 4d9f7681817c..6f2de54a5987 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -463,6 +463,7 @@ MODULE_DEVICE_TABLE(of, sdhci_cdns_match);
 static struct platform_driver sdhci_cdns_driver = {
 	.driver = {
 		.name = "sdhci-cdns",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.pm = &sdhci_cdns_pm_ops,
 		.of_match_table = sdhci_cdns_match,
 	},
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 4703cd540c7f..24c978de2a3f 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -677,6 +677,7 @@ MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
 static struct platform_driver sdhci_xenon_driver = {
 	.driver	= {
 		.name	= "xenon-sdhci",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_xenon_dt_ids,
 		.pm = &sdhci_xenon_dev_pm_ops,
 	},
-- 
2.28.0.526.ge36021eeef-goog

