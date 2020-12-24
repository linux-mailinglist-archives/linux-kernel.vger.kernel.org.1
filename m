Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AF92E267D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgLXLpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:45:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39682 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgLXLpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:45:10 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBhQac083386;
        Thu, 24 Dec 2020 05:43:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608810206;
        bh=Vz2S1Lgq/nohS1dKmSuXj6sZuS4dVt0If4oumnEmOOI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wCdyM6k5tIH51U1b+FqqTy3WyGK9OIHQ8QyF8msHEphu8uMSdtqBFRFqlqG1mLbDj
         Owg/QhSIgcThbggdx6RG4IY4LpcdOcFsbt5k7NztNQzv8+Zq00HmM2dDUjFodczXIu
         +weDJvU93M40R/r+WX/iq9cu7oa/I+DAXYMy992I=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBhQ0Z000767
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:43:26 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:43:25 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:43:25 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBgtwY026267;
        Thu, 24 Dec 2020 05:43:21 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Peter Rosin <peda@axentia.se>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 5/7] phy: ti: j721e-wiz: Configure full rate divider for AM64
Date:   Thu, 24 Dec 2020 17:12:48 +0530
Message-ID: <20201224114250.1083-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224114250.1083-1-kishon@ti.com>
References: <20201224114250.1083-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The frequency of the txmclk between PCIe and SERDES has
changed to 250MHz from 500MHz. Configure full rate divider
for AM64 accordingly.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 43 +++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 2a03191eac64..08acfab1ebe6 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -101,6 +101,13 @@ static const struct reg_field p_standard_mode[WIZ_MAX_LANES] = {
 	REG_FIELD(WIZ_LANECTL(3), 24, 25),
 };
 
+static const struct reg_field p0_fullrt_div[WIZ_MAX_LANES] = {
+	REG_FIELD(WIZ_LANECTL(0), 22, 23),
+	REG_FIELD(WIZ_LANECTL(1), 22, 23),
+	REG_FIELD(WIZ_LANECTL(2), 22, 23),
+	REG_FIELD(WIZ_LANECTL(3), 22, 23),
+};
+
 static const struct reg_field typec_ln10_swap =
 					REG_FIELD(WIZ_SERDES_TYPEC, 30, 30);
 
@@ -193,6 +200,7 @@ static struct wiz_clk_div_sel clk_div_sel[] = {
 enum wiz_type {
 	J721E_WIZ_16G,
 	J721E_WIZ_10G,
+	AM64_WIZ_10G,
 };
 
 #define WIZ_TYPEC_DIR_DEBOUNCE_MIN	100	/* ms */
@@ -210,6 +218,7 @@ struct wiz {
 	struct regmap_field	*p_align[WIZ_MAX_LANES];
 	struct regmap_field	*p_raw_auto_start[WIZ_MAX_LANES];
 	struct regmap_field	*p_standard_mode[WIZ_MAX_LANES];
+	struct regmap_field	*p0_fullrt_div[WIZ_MAX_LANES];
 	struct regmap_field	*pma_cmn_refclk_int_mode;
 	struct regmap_field	*pma_cmn_refclk_mode;
 	struct regmap_field	*pma_cmn_refclk_dig_div;
@@ -380,7 +389,7 @@ static int wiz_regfield_init(struct wiz *wiz)
 	}
 
 	clk_mux_sel = &wiz->clk_mux_sel[REFCLK_DIG];
-	if (wiz->type == J721E_WIZ_10G)
+	if (wiz->type == J721E_WIZ_10G || wiz->type == AM64_WIZ_10G)
 		clk_mux_sel->field =
 			devm_regmap_field_alloc(dev, regmap,
 						refclk_dig_sel_10g);
@@ -424,6 +433,14 @@ static int wiz_regfield_init(struct wiz *wiz)
 				i);
 			return PTR_ERR(wiz->p_standard_mode[i]);
 		}
+
+		wiz->p0_fullrt_div[i] =
+			devm_regmap_field_alloc(dev, regmap, p0_fullrt_div[i]);
+		if (IS_ERR(wiz->p0_fullrt_div[i])) {
+			dev_err(dev, "P%d_FULLRT_DIV reg field init failed\n",
+				i);
+			return PTR_ERR(wiz->p0_fullrt_div[i]);
+		}
 	}
 
 	wiz->typec_ln10_swap = devm_regmap_field_alloc(dev, regmap,
@@ -719,6 +736,19 @@ static int wiz_phy_reset_assert(struct reset_controller_dev *rcdev,
 	return ret;
 }
 
+static int wiz_phy_fullrt_div(struct wiz *wiz, int lane)
+{
+	int ret = 0;
+
+	if (wiz->type != AM64_WIZ_10G)
+		return 0;
+
+	if (wiz->lane_phy_type[lane] == PHY_TYPE_PCIE)
+		ret = regmap_field_write(wiz->p0_fullrt_div[lane], 0x1);
+
+	return ret;
+}
+
 static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
 				  unsigned long id)
 {
@@ -742,6 +772,10 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
 		return ret;
 	}
 
+	ret = wiz_phy_fullrt_div(wiz, id - 1);
+	if (ret)
+		return ret;
+
 	if (wiz->lane_phy_type[id - 1] == PHY_TYPE_DP)
 		ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE);
 	else
@@ -769,6 +803,9 @@ static const struct of_device_id wiz_id_table[] = {
 	{
 		.compatible = "ti,j721e-wiz-10g", .data = (void *)J721E_WIZ_10G
 	},
+	{
+		.compatible = "ti,am64-wiz-10g", .data = (void *)AM64_WIZ_10G
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, wiz_id_table);
@@ -904,14 +941,14 @@ static int wiz_probe(struct platform_device *pdev)
 	wiz->dev = dev;
 	wiz->regmap = regmap;
 	wiz->num_lanes = num_lanes;
-	if (wiz->type == J721E_WIZ_10G)
+	if (wiz->type == J721E_WIZ_10G || wiz->type == AM64_WIZ_10G)
 		wiz->clk_mux_sel = clk_mux_sel_10g;
 	else
 		wiz->clk_mux_sel = clk_mux_sel_16g;
 
 	wiz->clk_div_sel = clk_div_sel;
 
-	if (wiz->type == J721E_WIZ_10G)
+	if (wiz->type == J721E_WIZ_10G || wiz->type == AM64_WIZ_10G)
 		wiz->clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_10G;
 	else
 		wiz->clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_16G;
-- 
2.17.1

