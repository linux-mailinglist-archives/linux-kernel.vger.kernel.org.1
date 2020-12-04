Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23F32CF2F5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbgLDRSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730983AbgLDRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:18:46 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAD8C061A52
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:18:00 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z21so8633258lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 09:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XrHwQaCMJh08ONMTBH+6V1+tkj13F2Y4HGn4qByhl4o=;
        b=KnilYHhKeuVdqmrWi/z9O/I/EVAwBIIH02suya9Z10fm6kcp0jQztxd/fkRSuYWGxF
         ir77PSCd717QcSV5Rle9mRFQ0amA5iH8obROda/Q/C3TeGku86INOLYT6CBF4zpwB/np
         D7VD39Nrae3XkM1MbtedU+I8TIvfIhT767h1PiN3TZCdnnF/MHlN3ktz52i+Ke8LOLcm
         tBdFqLZf+xPj+dMyeJwaCzMuJn1R6U1eu0XrO6/E1tYdguLAgyyc6js5x1KIhjiYv8EI
         1dbLYubwkFZpSLFH3WV1q/xHdHzDY6jq3UxW/YgFRKeBB3crwQmeWaL+LLBohBeMeo9m
         JY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XrHwQaCMJh08ONMTBH+6V1+tkj13F2Y4HGn4qByhl4o=;
        b=JFagsAQLPkZ7sbHInqZsqtHmV1JVPVW3tasak3OMhDiSpsUDnTrURAL1S6qZo9Xxgr
         XIBxeInhMFTPoH8Rh5ov6xLFWEe1cR61z2bp3LlqRBG7isTaiYuT8DdkCxXr59/+FGYv
         Qcf1BVGnSL+mkT/DjHzt0C9H5VNXt8hC6IFXsG3KIhV1lhNn93qiEzvpuFYoOZKqjKgM
         yTtunDPKvZ+ReEB/CdFT1M8J85p34CmokeuEQbeRGZ5DO+U189KN6yJaKOkQjjCWCZAq
         GeN5SY4IYorIieTIsvnxgRYGxzVP+8EoFBr9SlNQXG8ZnRvVCGN8pSYXQBjFEyv2iMxQ
         inkA==
X-Gm-Message-State: AOAM5323CuhTv1X5p+Yu0tRjI2rpqv8IejmnlIrxVSu0bt+nDGS8IycY
        pZaQTuE2qIFnUKtfOvMm5wktduAqzUEwuh8x
X-Google-Smtp-Source: ABdhPJwytuzrz1KxxofoZGtuH6P4bqMg2uH5BJFD3Jry042z/OjZArTQ4P6ZvNDqjVucE0CaDR2DFQ==
X-Received: by 2002:a05:6512:491:: with SMTP id v17mr3629809lfq.142.1607102278594;
        Fri, 04 Dec 2020 09:17:58 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id w12sm1919802ljo.67.2020.12.04.09.17.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 09:17:57 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v4 1/4] mmc: sdhci-xenon: use match data for controllers variants
Date:   Fri,  4 Dec 2020 18:16:23 +0100
Message-Id: <20201204171626.10935-2-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201204171626.10935-1-mw@semihalf.com>
References: <20201204171626.10935-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a part of the ACPI support preparation resign from checking
compatible strings in the driver. Instead of that use a new
enum and assign the values to match data accordingly.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/mmc/host/sdhci-xenon.h     |  8 ++++++++
 drivers/mmc/host/sdhci-xenon-phy.c |  4 +++-
 drivers/mmc/host/sdhci-xenon.c     | 10 ++++++----
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
index 593b82d7b68a..39e898605937 100644
--- a/drivers/mmc/host/sdhci-xenon.h
+++ b/drivers/mmc/host/sdhci-xenon.h
@@ -53,6 +53,13 @@
 #define XENON_CTRL_HS200			0x5
 #define XENON_CTRL_HS400			0x6
 
+enum xenon_variant {
+	XENON_A3700,
+	XENON_AP806,
+	XENON_AP807,
+	XENON_CP110
+};
+
 struct xenon_priv {
 	unsigned char	tuning_count;
 	/* idx of SDHC */
@@ -90,6 +97,7 @@ struct xenon_priv {
 	void		*phy_params;
 	struct xenon_emmc_phy_regs *emmc_phy_regs;
 	bool restore_needed;
+	enum xenon_variant hw_version;
 };
 
 int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index 03ce57ef4585..c33e0cddc81a 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -651,11 +651,13 @@ static int get_dt_pad_ctrl_data(struct sdhci_host *host,
 				struct device_node *np,
 				struct xenon_emmc_phy_params *params)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret = 0;
 	const char *name;
 	struct resource iomem;
 
-	if (of_device_is_compatible(np, "marvell,armada-3700-sdhci"))
+	if (priv->hw_version == XENON_A3700)
 		params->pad_ctrl.set_soc_pad = armada_3700_soc_pad_voltage_set;
 	else
 		return 0;
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 24c978de2a3f..1e7ce9b1a143 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -418,7 +418,7 @@ static int xenon_probe_dt(struct platform_device *pdev)
 	u32 tuning_count;
 
 	/* Disable HS200 on Armada AP806 */
-	if (of_device_is_compatible(np, "marvell,armada-ap806-sdhci"))
+	if (priv->hw_version == XENON_AP806)
 		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
 
 	sdhc_id = 0x0;
@@ -495,6 +495,8 @@ static int xenon_probe(struct platform_device *pdev)
 	pltfm_host = sdhci_priv(host);
 	priv = sdhci_pltfm_priv(pltfm_host);
 
+	priv->hw_version = (unsigned long)device_get_match_data(&pdev->dev);
+
 	/*
 	 * Link Xenon specific mmc_host_ops function,
 	 * to replace standard ones in sdhci_ops.
@@ -667,9 +669,9 @@ static const struct dev_pm_ops sdhci_xenon_dev_pm_ops = {
 };
 
 static const struct of_device_id sdhci_xenon_dt_ids[] = {
-	{ .compatible = "marvell,armada-ap806-sdhci",},
-	{ .compatible = "marvell,armada-cp110-sdhci",},
-	{ .compatible = "marvell,armada-3700-sdhci",},
+	{ .compatible = "marvell,armada-ap806-sdhci", .data = (void *)XENON_AP806},
+	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
+	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
-- 
2.29.0

