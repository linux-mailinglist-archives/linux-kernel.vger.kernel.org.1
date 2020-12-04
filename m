Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9932CF2FF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbgLDRTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731316AbgLDRTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:19:31 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607E2C061A56
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:18:03 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id i15so79182ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 09:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8YfEG9oKKaMqVPYw/jtrgZil+AeegBiwDuRLZB+MuA=;
        b=MK7cjZibFFFs9z74Z6tNIwRPvfrs2yZy4unB5YGFbojgD5aAaJfZUHRGpKcJpanbPA
         Y4/PWHhaP+EZZijbpas281WwGDlfh13Tv8jaO+7f/k0Ym+legwAgSYz89Kk1+R7O02Tm
         o1OUtrnSuCa808WBeaM8cMQjXQcPn/tcA+O46fV2mnDrrb8azFmZPkESaXDwxT7NZbYk
         cywgv0Nc8H36TLsDFQoRADXRiJ+huanpr5xMwlEIfRJFAXjoEuc7V9YRXZH1JcQN2N4H
         A0i9ynxHdNmWx1vYAZ10u8uaXroqUybJdbhP3rD6uay336yTHN+FNzPLQ4t14aMfzd1a
         RVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8YfEG9oKKaMqVPYw/jtrgZil+AeegBiwDuRLZB+MuA=;
        b=ukpBYpoS8//I1/3aJCUm9XAvz0JEk/s4n8o7+Dat5wBcyu66HGTGso05gY9d65xMr5
         SHfm8ATP5bHRjzOlww5sbFJVsR2imVbwz/uE+SqphX4PqA4LFbFbeAfvyuCDBlo6CanY
         I4RMcfU0yeYxX55HjNyWy/iTM9yZK4H71NR6FP1uBeakrfiyjSW8qK4x6TU5DeRUWfRP
         Bf4p4lKC45KUyJ6rpivh8/dxwaE6AXmlMhrqsePGAiGby4fvRFb1mS9Fk29dexCtSih4
         2Wgb7LSrF5DeaRqh4l7GiDOHTNgUj8/FXsmN2k+9yv+s+TI8OrgvF41VnLVJr61YGlxF
         c5Tw==
X-Gm-Message-State: AOAM5306rFNzGNjsC6MY0h9Am3EXlBfNMlFVzpTI6eDDQO95L1najsvN
        pu2nnXw78Io0AY8m7AY2D3Zftr7w4tQbDAl1
X-Google-Smtp-Source: ABdhPJx3kvdC1ut6g2A4yPQvu7ecf+GCMpo/W97CIyeqcJ7QLEGrVXy878wJLs3NliFOF+hhqXTwWw==
X-Received: by 2002:a2e:8504:: with SMTP id j4mr3805749lji.169.1607102281438;
        Fri, 04 Dec 2020 09:18:01 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id w12sm1919802ljo.67.2020.12.04.09.18.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 09:18:00 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v4 3/4] mmc: sdhci-xenon: use clk only with DT
Date:   Fri,  4 Dec 2020 18:16:25 +0100
Message-Id: <20201204171626.10935-4-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201204171626.10935-1-mw@semihalf.com>
References: <20201204171626.10935-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparation for supporting ACPI, modify the driver
to use the clk framework only when booting with DT -
otherwise rely on the configuration done by firmware.
For that purpose introduce also a custom SDHCI get_max_clock
callback.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/mmc/host/sdhci-xenon.c | 51 ++++++++++++--------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index bfc76b0e3eaa..7d9335857715 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -247,6 +247,16 @@ static void xenon_voltage_switch(struct sdhci_host *host)
 	sdhci_readw(host, SDHCI_HOST_CONTROL2);
 }
 
+static unsigned int xenon_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	if (pltfm_host->clk)
+		return sdhci_pltfm_clk_get_max_clock(host);
+	else
+		return pltfm_host->clock;
+}
+
 static const struct sdhci_ops sdhci_xenon_ops = {
 	.voltage_switch		= xenon_voltage_switch,
 	.set_clock		= sdhci_set_clock,
@@ -254,7 +264,7 @@ static const struct sdhci_ops sdhci_xenon_ops = {
 	.set_bus_width		= sdhci_set_bus_width,
 	.reset			= xenon_reset,
 	.set_uhs_signaling	= xenon_set_uhs_signaling,
-	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
+	.get_max_clock		= xenon_get_max_clock,
 };
 
 static const struct sdhci_pltfm_data sdhci_xenon_pdata = {
@@ -483,6 +493,7 @@ static void xenon_sdhc_unprepare(struct sdhci_host *host)
 static int xenon_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
+	struct device *dev = &pdev->dev;
 	struct sdhci_host *host;
 	struct xenon_priv *priv;
 	int err;
@@ -503,25 +514,27 @@ static int xenon_probe(struct platform_device *pdev)
 	 */
 	xenon_replace_mmc_host_ops(host);
 
-	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
-	if (IS_ERR(pltfm_host->clk)) {
-		err = PTR_ERR(pltfm_host->clk);
-		dev_err(&pdev->dev, "Failed to setup input clk: %d\n", err);
-		goto free_pltfm;
-	}
-	err = clk_prepare_enable(pltfm_host->clk);
-	if (err)
-		goto free_pltfm;
-
-	priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
-	if (IS_ERR(priv->axi_clk)) {
-		err = PTR_ERR(priv->axi_clk);
-		if (err == -EPROBE_DEFER)
-			goto err_clk;
-	} else {
-		err = clk_prepare_enable(priv->axi_clk);
+	if (dev->of_node) {
+		pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
+		if (IS_ERR(pltfm_host->clk)) {
+			err = PTR_ERR(pltfm_host->clk);
+			dev_err(&pdev->dev, "Failed to setup input clk: %d\n", err);
+			goto free_pltfm;
+		}
+		err = clk_prepare_enable(pltfm_host->clk);
 		if (err)
-			goto err_clk;
+			goto free_pltfm;
+
+		priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
+		if (IS_ERR(priv->axi_clk)) {
+			err = PTR_ERR(priv->axi_clk);
+			if (err == -EPROBE_DEFER)
+				goto err_clk;
+		} else {
+			err = clk_prepare_enable(priv->axi_clk);
+			if (err)
+				goto err_clk;
+		}
 	}
 
 	err = mmc_of_parse(host->mmc);
-- 
2.29.0

