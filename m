Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7542E2677
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgLXLoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:44:24 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39704 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgLXLoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:44:23 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBhUps083394;
        Thu, 24 Dec 2020 05:43:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608810210;
        bh=R5Xa44jBVuv2Xt7dKXCPPYky4afTZPCkQ/UEaLszPCE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lDZtUI0ekK5fU4lirGgmSO0Y7kMlkvBbp3bXcE5Qs2OtDgWF4eZ0FBjYCWZMF4hio
         sTHrKhi8fbjeiBHPx56Y7C3Wcu6JAxMy2M8U8OSX50tttpQOIeY62SVXfh9H+9vfZD
         lux2Af+8tU/t9SuzM4y7V6XnAWIZFyqoJOPy444U=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBhUMC097972
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:43:30 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:43:30 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:43:30 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBgtwZ026267;
        Thu, 24 Dec 2020 05:43:26 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Peter Rosin <peda@axentia.se>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 6/7] phy: ti: j721e-wiz: Enable reference clock output in cmn_refclk_<p/m>
Date:   Thu, 24 Dec 2020 17:12:49 +0530
Message-ID: <20201224114250.1083-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224114250.1083-1-kishon@ti.com>
References: <20201224114250.1083-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmn_refclk_<p/m> lines in Torrent SERDES is used for connecting external
reference clock. cmn_refclk_<p/m> can also be configured to output the
reference clock. In order to drive the refclk out from the SERDES
(Cadence Torrent), PHY_EN_REFCLK should be set in SERDES_RST of WIZ.
Model PHY_EN_REFCLK as a clock, so that platforms like AM642 EVM can
enable it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 115 +++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 08acfab1ebe6..d60a9a01a8b2 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -54,6 +54,7 @@ enum wiz_refclk_div_sel {
 
 static const struct reg_field por_en = REG_FIELD(WIZ_SERDES_CTRL, 31, 31);
 static const struct reg_field phy_reset_n = REG_FIELD(WIZ_SERDES_RST, 31, 31);
+static const struct reg_field phy_en_refclk = REG_FIELD(WIZ_SERDES_RST, 30, 30);
 static const struct reg_field pll1_refclk_mux_sel =
 					REG_FIELD(WIZ_SERDES_RST, 29, 29);
 static const struct reg_field pll0_refclk_mux_sel =
@@ -141,6 +142,15 @@ struct wiz_clk_div_sel {
 	const char		*node_name;
 };
 
+struct wiz_phy_en_refclk {
+	struct clk_hw		hw;
+	struct regmap_field	*phy_en_refclk;
+	struct clk_init_data	clk_data;
+};
+
+#define to_wiz_phy_en_refclk(_hw)	\
+			container_of(_hw, struct wiz_phy_en_refclk, hw)
+
 static struct wiz_clk_mux_sel clk_mux_sel_16g[] = {
 	{
 		/*
@@ -214,6 +224,7 @@ struct wiz {
 	unsigned int		clk_div_sel_num;
 	struct regmap_field	*por_en;
 	struct regmap_field	*phy_reset_n;
+	struct regmap_field	*phy_en_refclk;
 	struct regmap_field	*p_enable[WIZ_MAX_LANES];
 	struct regmap_field	*p_align[WIZ_MAX_LANES];
 	struct regmap_field	*p_raw_auto_start[WIZ_MAX_LANES];
@@ -450,9 +461,96 @@ static int wiz_regfield_init(struct wiz *wiz)
 		return PTR_ERR(wiz->typec_ln10_swap);
 	}
 
+	wiz->phy_en_refclk = devm_regmap_field_alloc(dev, regmap,
+						     phy_en_refclk);
+	if (IS_ERR(wiz->phy_en_refclk)) {
+		dev_err(dev, "PHY_EN_REFCLK reg field init failed\n");
+		return PTR_ERR(wiz->phy_en_refclk);
+	}
+
 	return 0;
 }
 
+static int wiz_phy_en_refclk_enable(struct clk_hw *hw)
+{
+	struct wiz_phy_en_refclk *wiz_phy_en_refclk = to_wiz_phy_en_refclk(hw);
+	struct regmap_field *phy_en_refclk = wiz_phy_en_refclk->phy_en_refclk;
+
+	regmap_field_write(phy_en_refclk, 1);
+
+	return 0;
+}
+
+static void wiz_phy_en_refclk_disable(struct clk_hw *hw)
+{
+	struct wiz_phy_en_refclk *wiz_phy_en_refclk = to_wiz_phy_en_refclk(hw);
+	struct regmap_field *phy_en_refclk = wiz_phy_en_refclk->phy_en_refclk;
+
+	regmap_field_write(phy_en_refclk, 0);
+}
+
+static int wiz_phy_en_refclk_is_enabled(struct clk_hw *hw)
+{
+	struct wiz_phy_en_refclk *wiz_phy_en_refclk = to_wiz_phy_en_refclk(hw);
+	struct regmap_field *phy_en_refclk = wiz_phy_en_refclk->phy_en_refclk;
+	int val;
+
+	regmap_field_read(phy_en_refclk, &val);
+
+	return !!val;
+}
+
+static const struct clk_ops wiz_phy_en_refclk_ops = {
+	.enable = wiz_phy_en_refclk_enable,
+	.disable = wiz_phy_en_refclk_disable,
+	.is_enabled = wiz_phy_en_refclk_is_enabled,
+};
+
+static int wiz_phy_en_refclk_register(struct wiz *wiz, struct device_node *node,
+				      struct regmap_field *phy_en_refclk)
+{
+	struct wiz_phy_en_refclk *wiz_phy_en_refclk;
+	struct device *dev = wiz->dev;
+	struct clk_init_data *init;
+	unsigned int num_parents;
+	const char *parent_name;
+	char clk_name[100];
+	struct clk *clk;
+	int ret;
+
+	wiz_phy_en_refclk = devm_kzalloc(dev, sizeof(*wiz_phy_en_refclk),
+					 GFP_KERNEL);
+	if (!wiz_phy_en_refclk)
+		return -ENOMEM;
+
+	num_parents = of_clk_get_parent_count(node);
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
+		 node->name);
+
+	init = &wiz_phy_en_refclk->clk_data;
+
+	init->ops = &wiz_phy_en_refclk_ops;
+	init->flags = 0;
+	init->parent_names = parent_name ? &parent_name : NULL;
+	init->num_parents = num_parents ? 1 : 0;
+	init->name = clk_name;
+
+	wiz_phy_en_refclk->phy_en_refclk = phy_en_refclk;
+	wiz_phy_en_refclk->hw.init = init;
+
+	clk = devm_clk_register(dev, &wiz_phy_en_refclk->hw);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (ret)
+		dev_err(dev, "Fail to add clock provider: %s\n", clk_name);
+
+	return ret;
+}
+
 static u8 wiz_clk_mux_get_parent(struct clk_hw *hw)
 {
 	struct wiz_clk_mux *mux = to_wiz_clk_mux(hw);
@@ -713,6 +811,20 @@ static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
 		of_node_put(clk_node);
 	}
 
+	clk_node = of_get_child_by_name(node, "phy-en-refclk");
+	if (clk_node) {
+		ret = wiz_phy_en_refclk_register(wiz, clk_node,
+						 wiz->phy_en_refclk);
+		if (ret) {
+			dev_err(dev, "Failed to register %s clock\n",
+				node_name);
+			of_node_put(clk_node);
+			goto err;
+		}
+
+		of_node_put(clk_node);
+	}
+
 	return 0;
 err:
 	wiz_clock_cleanup(wiz, node);
@@ -828,6 +940,9 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
 		      of_node_name_eq(subnode, "link")))
 			continue;
 
+		if (!(of_node_name_eq(subnode, "link")))
+			continue;
+
 		ret = of_property_read_u32(subnode, "reg", &reg);
 		if (ret) {
 			dev_err(dev,
-- 
2.17.1

