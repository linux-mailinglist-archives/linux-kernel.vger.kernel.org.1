Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2EE2CC5ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389603AbgLBSwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbgLBSwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:52:36 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454B8C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:51:56 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id i17so5026809ljd.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDSZ9LQfiI7RAcYP99dceWkwh9+x1mJX2TPk+zqGzss=;
        b=NMiwARSCvvUaEEPbp4WsfuZAT8L1Fmxn63F54s3S/pAuEDOdzOE7ndfhAHhVgXAAxw
         M6L/DG8ZR9ZRc1IuuBlNbYTEm+Gt0/eEvxAwlinf7sHlPJvlt4n0lV3KIK1M8PJsj5Aq
         LZOT1edihJPk8635E7OqSG0RDJOeAfXK2GZyZPIIXzS4PUKMEwbFLe/vMOsqE0Ee3ZAh
         TuxNVcM7m0PB3OH5O822frSRLwK82op1XtaZ8z4pc6AzE41H8FLhYQi23lQaWdycB3Qu
         6oTLZjwLkyghaloSH3n3PmTULBP6LnVrqxSzk+gQWqZUXMtmPuInQ8k5Q3IAxg0V4x9q
         97HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDSZ9LQfiI7RAcYP99dceWkwh9+x1mJX2TPk+zqGzss=;
        b=uoDd1m9QAEVgRfMOa8W/b2gtZpGyF3maFuoWYKq+I3nkoN1tqchaDlcWwA2jnuD8be
         pinxlVNEzjbYtng2tXzLtj+ZnBCr8u8imQQ98o0dVMm1LhksULTBxtw29Lu741NvWn17
         P/TROjqA8PJO5bR6qvQH46AKf41IzQfwvY2FG1PYCIX1DMEZK0VtfkwAGzlFHDX0GkT9
         YLqVYqHN8uOyolZFVoOWUNZZVtkOZA1nN0cwQQvUuTakWTavvz+Ntdf+PUX7+rxioIrW
         PmdqArqIvZGS1KnUGBQxJiawmtg/dEvI7zPJVMyjqXbTdUISNKPTNNd5ktlAtqOpRiKF
         z4Ag==
X-Gm-Message-State: AOAM530ROaQVwYVtRjWK+AJR5TZG5TMsqdAtu5T2FU41Qwx27wZajgEm
        8tYLRUhDECnkfYV+qtl4AmjoL3ZwuiRrdyG4
X-Google-Smtp-Source: ABdhPJwT9WnyVczi4HuabClulH6LU7mz9RvmCawt8ItaFY5zzsrwHhXkWm7/ZrTZ8V24xprKazb+gw==
X-Received: by 2002:a2e:924f:: with SMTP id v15mr1733918ljg.6.1606935114251;
        Wed, 02 Dec 2020 10:51:54 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id y134sm666365lff.162.2020.12.02.10.51.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:51:53 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v3 1/4] mmc: sdhci-xenon: use match data for controllers variants
Date:   Wed,  2 Dec 2020 19:51:15 +0100
Message-Id: <20201202185118.29076-2-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201202185118.29076-1-mw@semihalf.com>
References: <20201202185118.29076-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a part of the ACPI support preparation resign from checking
compatible strings in the driver. Instead of that use a new
enum and assign the values to match data accordingly.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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

