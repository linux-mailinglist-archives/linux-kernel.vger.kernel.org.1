Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA142AA5A5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 15:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgKGOAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 09:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgKGOAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 09:00:36 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386EAC0613CF;
        Sat,  7 Nov 2020 06:00:35 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id x7so3969545ili.5;
        Sat, 07 Nov 2020 06:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBheqRYEDCBSmAdfrCLU6uR/r5Vr0X9pAzabfty/Ec8=;
        b=J9kqWkLJ8G0zvhQRbR07g/PmdoQC4+nDjEO/Ir3EsWtmlnUbmXbLmPS/Fvs9peseO5
         6CnzLTc/zImizHowQiv2RD74LuS6/VNJ/6k2pDeFxQm6Wg1vx2lk0QT9hIEXlMpVOvVX
         6MDu6XTyOAoJ78q6F0qpnIACdbieyj2btzWmpKLZbSAPPlMwUfyB4doISaI8QNQoRC/L
         65Xr3R4fnCrLbX9gvmpJCoUeugYCpcxVM1KJ9H0HOCcYIk1E8y5YrE3OoyjjX1Pwj05i
         IsMZ2Vj6e4WdQ2wP/0tAocJKiKR4aYzG+Vczrc91irPASrp42eJ0WOQCqbF1jx2+bLkb
         JXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBheqRYEDCBSmAdfrCLU6uR/r5Vr0X9pAzabfty/Ec8=;
        b=MS/ch6E6ruZbXm6OIJg1B2yeUYJGP1UCxcNz2Wtol/bxxxuEGb9Zgox5mkkWORo51r
         BoZwaa+BT/DLpuNvxTlDtJDyR30/fZfSN1SHS/rniZN0oQDEChZ8KIO99feTpEkYpSnR
         nxpnLLZ1pF6Ps7UQouZi1JgFaYWZ6FHLECGIK4HlY4xAqiU5+1fE0JMzwjgpgF0RPKB9
         vDFi/aPXzcau0cmbVffuKeMWDU0Oq7h8Bihj66jZyOpOd7AJg0cgWflrvdaV7Lymbk2t
         Sf6Ysa3bxtrjGUT6lroJHAQsXCS1TXtjga2nQwH4Pwfo9KB1/GUjvgcLgLs+KtNPZhn6
         bRlA==
X-Gm-Message-State: AOAM531wlOKJgBCuj6n0fXdJenBpf8xVgzEgC8TE45/zX7OKmgk6OfOp
        h6to+C2HqrzDpz2UU4J1gd8=
X-Google-Smtp-Source: ABdhPJy9Da/Va6DIqqd/7B6tKSBCt801+tHiK5TboOIlcftd/0pJrTAh65Sx5cx7EXe5R5WgX99UcQ==
X-Received: by 2002:a05:6e02:ce:: with SMTP id r14mr4902637ilq.240.1604757634411;
        Sat, 07 Nov 2020 06:00:34 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5d9e:32b:1062:f8cd])
        by smtp.gmail.com with ESMTPSA id g5sm3030257ilq.33.2020.11.07.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 06:00:33 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, krzk@kernel.org,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/5] soc: imx: gpcv2: add support for i.MX8MN power domains
Date:   Sat,  7 Nov 2020 08:00:22 -0600
Message-Id: <20201107140026.1974312-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201107140026.1974312-1-aford173@gmail.com>
References: <20201107140026.1974312-1-aford173@gmail.com>
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
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
V2: No change

 drivers/soc/imx/gpcv2.c | 93 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 5642dd236c10..6b5b40a6fb3d 100644
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
 
@@ -690,6 +717,71 @@ static const struct imx_pgc_domain_data imx8mm_pgc_domain_data = {
 	.reg_access_table = &imx8mm_access_table,
 };
 
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
+
 static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
 	struct imx_pgc_domain *domain = pdev->dev.platform_data;
@@ -875,6 +967,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 static const struct of_device_id imx_gpcv2_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
 	{ .compatible = "fsl,imx8mm-gpc", .data = &imx8mm_pgc_domain_data, },
+	{ .compatible = "fsl,imx8mn-gpc", .data = &imx8mn_pgc_domain_data, },
 	{ .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
 	{ }
 };
-- 
2.25.1

