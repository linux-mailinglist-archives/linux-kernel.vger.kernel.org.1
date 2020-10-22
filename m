Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A670296170
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901129AbgJVPI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901118AbgJVPI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:08:26 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E292CC0613CE;
        Thu, 22 Oct 2020 08:08:25 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j8so2042582ilk.0;
        Thu, 22 Oct 2020 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2MOY+ZaVepofvkcPaB+A3eJVV+cDeUcoXdal+BmA0U=;
        b=qI2r4ewSF6urt6YW0VSNKi61S5CAY3C3NQl5hp0vBBV1GK/cvD50bV4Mq6iFnF7A4n
         6RcAOb/BKeBhwzMSP73EHfFRfd/hr0Q6W9UbeARWv/31RjsiZthZ3qO6qBPfCPsVAeQI
         YCOJM+6Sh2NmHjl3p3pwQdPEpBd7lTv+SeAfNpbx9VIxl/gqgPrQAUKKbMlmx4vvV7eH
         YJZH8sx7h/uB3e7McFweEm9bS8MqTWxCujwk2YmKJx7TcH4+h8vmec5wTpUvn301AykU
         XV9L2bmjb0JRuZ7etRSpfXYSmL2xIehG/iMJH3+P3qblVGAJaitq18KIVQT39tGKhEy0
         wX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2MOY+ZaVepofvkcPaB+A3eJVV+cDeUcoXdal+BmA0U=;
        b=nkUvF5FLJDyfSbXOuSGnI8p39Dj7Y3VfKWLryMPUwrrzyVY7AMwaciMAkzcnBpCSqE
         PniN7JSXqPDAx9miEqDMSxPkcvKtAPQfqhv/smYoCvkCIi6WdSMtKnJBINu2NtA540fh
         0r2rgGlhoXN88AmtKCctT5EhdX+useEbfDqsB9fVxJvW2HcLp+jAzIs/QFiSufiBXzF7
         i6bN1wFnXqcrw2zC9KL0iWDZ3f7SW7bZZf1xlEvbl8tq6axLWFgv5Fx1C+m0AXt7yOZN
         63SCmJy9oKYL5b+hNylsonqlL69J/U+uarZbm77woAJrwrxtN1eAFh7Nu4BTFLHmHWqt
         eIyA==
X-Gm-Message-State: AOAM531RTLoE4Leey/Wuk2scQMSfxFGKfqVSUW1rzZZl/OExTNzontlD
        YZ/2gEl1cFisPg0bv3IPokQ=
X-Google-Smtp-Source: ABdhPJzNMt/BU7q0Hv/5ZCUxIEMWrtH0zXFQkQ3rk5k7v51vWW9GNH83MFNU2rgPb++Wom3qz/t47A==
X-Received: by 2002:a05:6e02:4c8:: with SMTP id f8mr1991123ils.159.1603379305045;
        Thu, 22 Oct 2020 08:08:25 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:527:767:b750:2d3c])
        by smtp.gmail.com with ESMTPSA id y6sm1233816ilj.59.2020.10.22.08.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 08:08:24 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, l.stach@pengutronix.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] soc: imx: gpcv2: add support for i.MX8MN power domains
Date:   Thu, 22 Oct 2020 10:08:05 -0500
Message-Id: <20201022150808.763082-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201022150808.763082-1-aford173@gmail.com>
References: <20201022150808.763082-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the power domains founds on i.MX8MN. The Nano
has fewer domains than the Mini, and the access to some of these domains
is different than that of the Mini, the Mini power domains cannot be
reused.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index a118eb9ff8b7..91aad9ea74ee 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -20,6 +20,7 @@
 #include <dt-bindings/power/imx7-power.h>
 #include <dt-bindings/power/imx8mq-power.h>
 #include <dt-bindings/power/imx8mm-power.h>
+#include <dt-bindings/power/imx8mn-power.h>
 
 #define GPC_LPCR_A_CORE_BSC			0x000
 
@@ -58,6 +59,12 @@
 #define IMX8MM_PCIE_A53_DOMAIN			BIT(3)
 #define IMX8MM_MIPI_A53_DOMAIN			BIT(2)
 
+#define IMX8MN_DISPMIX_A53_DOMAIN		BIT(12)
+#define IMX8MN_GPUMIX_A53_DOMAIN		BIT(9)
+#define IMX8MN_DDR1_A53_DOMAIN		BIT(7)
+#define IMX8MN_OTG1_A53_DOMAIN		BIT(4)
+#define IMX8MN_MIPI_A53_DOMAIN		BIT(2)
+
 #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ		0x104
 
@@ -94,6 +101,12 @@
 #define IMX8MM_PCIE_SW_Pxx_REQ			BIT(1)
 #define IMX8MM_MIPI_SW_Pxx_REQ			BIT(0)
 
+#define IMX8MN_DISPMIX_SW_Pxx_REQ		BIT(10)
+#define IMX8MN_GPUMIX_SW_Pxx_REQ		BIT(7)
+#define IMX8MN_DDR1_SW_Pxx_REQ		BIT(5)
+#define IMX8MN_OTG1_SW_Pxx_REQ		BIT(2)
+#define IMX8MN_MIPI_SW_Pxx_REQ		BIT(0)
+
 #define GPC_M4_PU_PDN_FLG		0x1bc
 
 #define GPC_PU_PWRHSK			0x1fc
@@ -116,6 +129,14 @@
 #define IMX8MM_VPUMIX_HSK_PWRDNREQN		BIT(8)
 #define IMX8MM_DISPMIX_HSK_PWRDNREQN		BIT(7)
 #define IMX8MM_HSIO_HSK_PWRDNREQN		(BIT(5) | BIT(6))
+
+#define IMX8MN_GPUMIX_HSK_PWRDNACKN		(BIT(29) | BIT(27))
+#define IMX8MN_DISPMIX_HSK_PWRDNACKN		BIT(25)
+#define IMX8MN_HSIO_HSK_PWRDNACKN		BIT(23)
+#define IMX8MN_GPUMIX_HSK_PWRDNREQN		(BIT(11) | BIT(9))
+#define IMX8MN_DISPMIX_HSK_PWRDNREQN		BIT(7)
+#define IMX8MN_HSIO_HSK_PWRDNREQN		BIT(5)
+
 /*
  * The PGC offset values in Reference Manual
  * (Rev. 1, 01/2018 and the older ones) GPC chapter's
@@ -152,6 +173,12 @@
 #define IMX8MM_PGC_VPUG2		28
 #define IMX8MM_PGC_VPUH1		29
 
+#define IMX8MN_PGC_MIPI		16
+#define IMX8MN_PGC_OTG1		18
+#define IMX8MN_PGC_DDR1		21
+#define IMX8MN_PGC_GPUMIX		23
+#define IMX8MN_PGC_DISPMIX		26
+
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
 #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
 
@@ -766,6 +793,95 @@ static const struct imx_pgc_domain_data imx8mm_pgc_domain_data = {
 	.reg_access_table = &imx8mm_access_table,
 };
 
+
+static const struct imx_pgc_domain imx8mn_pgc_domains[] = {
+	[IMX8MN_POWER_DOMAIN_HSIOMIX] = {
+		.genpd = {
+			.name = "hsiomix",
+		},
+		.bits  = {
+			.pxx = 0, /* no power sequence control */
+			.map = 0, /* no power sequence control */
+			.hskreq = IMX8MN_HSIO_HSK_PWRDNREQN,
+			.hskack = IMX8MN_HSIO_HSK_PWRDNACKN,
+		},
+	},
+
+	[IMX8MN_POWER_DOMAIN_OTG1] = {
+		.genpd = {
+			.name = "usb-otg1",
+		},
+		.bits  = {
+			.pxx = IMX8MN_OTG1_SW_Pxx_REQ,
+			.map = IMX8MN_OTG1_A53_DOMAIN,
+		},
+		.pgc   = IMX8MN_PGC_OTG1,
+	},
+
+	[IMX8MN_POWER_DOMAIN_GPUMIX] = {
+		.genpd = {
+			.name = "gpumix",
+		},
+		.bits  = {
+			.pxx = IMX8MN_GPUMIX_SW_Pxx_REQ,
+			.map = IMX8MN_GPUMIX_A53_DOMAIN,
+			.hskreq = IMX8MN_GPUMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MN_GPUMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = IMX8MN_PGC_GPUMIX,
+	},
+
+	[IMX8MN_POWER_DOMAIN_DISPMIX] = {
+		.genpd = {
+			.name = "dispmix",
+		},
+		.bits  = {
+			.pxx = IMX8MN_DISPMIX_SW_Pxx_REQ,
+			.map = IMX8MN_DISPMIX_A53_DOMAIN,
+			.hskreq = IMX8MN_DISPMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MN_DISPMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = IMX8MN_PGC_DISPMIX,
+	},
+
+	[IMX8MN_POWER_DOMAIN_MIPI] = {
+		.genpd = {
+			.name = "mipi",
+		},
+		.bits  = {
+			.pxx = IMX8MN_MIPI_SW_Pxx_REQ,
+			.map = IMX8MN_MIPI_A53_DOMAIN,
+		},
+		.pgc   = IMX8MN_PGC_MIPI,
+	},
+};
+
+static const struct regmap_range imx8mn_yes_ranges[] = {
+	regmap_reg_range(GPC_LPCR_A_CORE_BSC,
+			 GPC_PU_PWRHSK),
+	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_MIPI),
+			 GPC_PGC_SR(IMX8MN_PGC_MIPI)),
+	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_OTG1),
+			 GPC_PGC_SR(IMX8MN_PGC_OTG1)),
+	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_DDR1),
+			 GPC_PGC_SR(IMX8MN_PGC_DDR1)),
+	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_GPUMIX),
+			 GPC_PGC_SR(IMX8MN_PGC_GPUMIX)),
+	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_DISPMIX),
+			 GPC_PGC_SR(IMX8MN_PGC_DISPMIX)),
+};
+
+static const struct regmap_access_table imx8mn_access_table = {
+	.yes_ranges	= imx8mn_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(imx8mn_yes_ranges),
+};
+
+static const struct imx_pgc_domain_data imx8mn_pgc_domain_data = {
+	.domains = imx8mn_pgc_domains,
+	.domains_num = ARRAY_SIZE(imx8mn_pgc_domains),
+	.reg_access_table = &imx8mn_access_table,
+};
+
 static int imx_pgc_get_clocks(struct imx_pgc_domain *domain)
 {
 	int i, ret;
@@ -995,6 +1111,7 @@ static const struct of_device_id imx_gpcv2_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
 	{ .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
 	{ .compatible = "fsl,imx8mm-gpc", .data = &imx8mm_pgc_domain_data, },
+	{ .compatible = "fsl,imx8mn-gpc", .data = &imx8mn_pgc_domain_data, },
 	{ }
 };
 
-- 
2.25.1

