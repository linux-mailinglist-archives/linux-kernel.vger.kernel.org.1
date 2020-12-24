Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F262E262D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgLXLSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:18:16 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35712 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgLXLSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:18:15 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBHORo076222;
        Thu, 24 Dec 2020 05:17:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608808644;
        bh=cI1RzCXhjshanMa9/MzV4KMdCSBLf7GenyIxvqdQkrY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dUR7Y0f6gwVL7VzZTSbYifQeLDcsjpDTsurYt4SvHb8OidszexziOiP60FT8v2IcF
         JiBAdTLd4S9poIVVuDp1fwGehxKr5t5UDPdy8y1yEO6PlcCjGPcuGjBdiqRbSlkANt
         RPlgcMcO/jLGscg+hYMTqzJht3BoNvMfzvcNTD0A=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBHOIT098947
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:17:24 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:17:23 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:17:23 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBGWGF116630;
        Thu, 24 Dec 2020 05:17:19 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 09/15] phy: cadence: sierra: Model reference receiver as clocks (gate clocks)
Date:   Thu, 24 Dec 2020 16:46:21 +0530
Message-ID: <20201224111627.32590-10-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224111627.32590-1-kishon@ti.com>
References: <20201224111627.32590-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sierra has two reference recievers REFRCV and REFRCV1. REFRCV is used to
drive reference clock cmn_refclk_m/p to PLL_CMNLC1 and REFRCV1 is used to
drive reference clock cmn_refclk1_m/p to PLL_CMNLC. Model these
reference receivers as clocks in order for PLL_CMNLC and PLL_CMNLC1 to
be able to seamlessly use any of the external reference clocks.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/Kconfig              |   1 +
 drivers/phy/cadence/phy-cadence-sierra.c | 209 ++++++++++++++++++++++-
 2 files changed, 207 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index 432832bdbd16..23d5382c34ed 100644
--- a/drivers/phy/cadence/Kconfig
+++ b/drivers/phy/cadence/Kconfig
@@ -24,6 +24,7 @@ config PHY_CADENCE_DPHY
 config PHY_CADENCE_SIERRA
 	tristate "Cadence Sierra PHY Driver"
 	depends on OF && HAS_IOMEM && RESET_CONTROLLER
+	depends on COMMON_CLK
 	select GENERIC_PHY
 	help
 	  Enable this to support the Cadence Sierra PHY driver
diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 44c52a0842dc..8b7b2a838f5f 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -7,6 +7,7 @@
  *
  */
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -31,6 +32,8 @@
 #define SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG		0x4F
 #define SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG		0x50
 #define SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG	0x62
+#define SIERRA_CMN_REFRCV_PREG				0x98
+#define SIERRA_CMN_REFRCV1_PREG				0xB8
 
 #define SIERRA_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
 				((0x4000 << (block_offset)) + \
@@ -151,6 +154,35 @@ static const struct reg_field phy_pll_cfg_1 =
 static const struct reg_field pllctrl_lock =
 				REG_FIELD(SIERRA_PLLCTRL_STATUS_PREG, 0, 0);
 
+enum cdns_sierra_cmn_refrcv {
+	CMN_REFRCV,
+	CMN_REFRCV1,
+};
+
+#define SIERRA_NUM_REFRCV	0x2
+
+static const struct reg_field cmn_refrcv_refclk_plllc1en_preg[] = {
+	[CMN_REFRCV]	= REG_FIELD(SIERRA_CMN_REFRCV_PREG, 8, 8),
+	[CMN_REFRCV1]	= REG_FIELD(SIERRA_CMN_REFRCV1_PREG, 8, 8),
+};
+
+static const struct reg_field cmn_refrcv_refclk_termen_preg[] = {
+	[CMN_REFRCV]	= REG_FIELD(SIERRA_CMN_REFRCV_PREG, 0, 0),
+	[CMN_REFRCV1]	= REG_FIELD(SIERRA_CMN_REFRCV1_PREG, 0, 0),
+};
+
+static char *refrcv_node_name[] = { "refrcv", "refrcv1" };
+
+struct cdns_sierra_refrcv {
+	struct clk_hw		hw;
+	struct regmap_field	*plllc1en_field;
+	struct regmap_field	*termen_field;
+	struct clk_init_data	clk_data;
+};
+
+#define to_cdns_sierra_refrcv(_hw)	\
+			container_of(_hw, struct cdns_sierra_refrcv, hw)
+
 struct cdns_sierra_inst {
 	struct phy *phy;
 	u32 phy_type;
@@ -197,6 +229,8 @@ struct cdns_sierra_phy {
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
+	struct regmap_field *cmn_refrcv_refclk_plllc1en_preg[SIERRA_NUM_REFRCV];
+	struct regmap_field *cmn_refrcv_refclk_termen_preg[SIERRA_NUM_REFRCV];
 	struct clk *clk;
 	struct clk *cmn_refclk_dig_div;
 	struct clk *cmn_refclk1_dig_div;
@@ -364,6 +398,146 @@ static const struct phy_ops ops = {
 	.owner		= THIS_MODULE,
 };
 
+static int cdns_sierra_refrcv_enable(struct clk_hw *hw)
+{
+	struct cdns_sierra_refrcv *refrcv = to_cdns_sierra_refrcv(hw);
+	struct regmap_field *plllc1en_field = refrcv->plllc1en_field;
+	struct regmap_field *termen_field = refrcv->termen_field;
+
+	regmap_field_write(plllc1en_field, 1);
+	regmap_field_write(termen_field, 1);
+
+	return 0;
+}
+
+static void cdns_sierra_refrcv_disable(struct clk_hw *hw)
+{
+	struct cdns_sierra_refrcv *refrcv = to_cdns_sierra_refrcv(hw);
+	struct regmap_field *plllc1en_field = refrcv->plllc1en_field;
+	struct regmap_field *termen_field = refrcv->termen_field;
+
+	regmap_field_write(plllc1en_field, 0);
+	regmap_field_write(termen_field, 0);
+}
+
+static int cdns_sierra_refrcv_is_enabled(struct clk_hw *hw)
+{
+	struct cdns_sierra_refrcv *refrcv = to_cdns_sierra_refrcv(hw);
+	struct regmap_field *plllc1en_field = refrcv->plllc1en_field;
+	int val;
+
+	regmap_field_read(plllc1en_field, &val);
+
+	return !!val;
+}
+
+static const struct clk_ops cdns_sierra_refrcv_ops = {
+	.enable = cdns_sierra_refrcv_enable,
+	.disable = cdns_sierra_refrcv_disable,
+	.is_enabled = cdns_sierra_refrcv_is_enabled,
+};
+
+static int cdns_sierra_refrcv_register(struct cdns_sierra_phy *sp,
+				       struct device_node *node,
+				       struct regmap_field *plllc1en_field,
+				       struct regmap_field *termen_field)
+{
+	struct cdns_sierra_refrcv *refrcv;
+	struct device *dev = sp->dev;
+	struct clk_init_data *init;
+	unsigned int num_parents;
+	const char *parent_name;
+	char clk_name[100];
+	struct clk *clk;
+	int ret;
+
+	refrcv = devm_kzalloc(dev, sizeof(*refrcv), GFP_KERNEL);
+	if (!refrcv)
+		return -ENOMEM;
+
+	num_parents = of_clk_get_parent_count(node);
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
+		 node->name);
+
+	init = &refrcv->clk_data;
+
+	init->ops = &cdns_sierra_refrcv_ops;
+	init->flags = 0;
+	init->parent_names = parent_name ? &parent_name : NULL;
+	init->num_parents = num_parents ? 1 : 0;
+	init->name = clk_name;
+
+	refrcv->plllc1en_field = plllc1en_field;
+	refrcv->termen_field = termen_field;
+	refrcv->hw.init = init;
+
+	clk = devm_clk_register(dev, &refrcv->hw);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (ret)
+		dev_err(dev, "Failed to add refrcv clock provider: %s\n",
+			clk_name);
+
+	return ret;
+}
+
+static void cdns_sierra_refrcv_unregister(struct cdns_sierra_phy *sp,
+					  struct device_node *node)
+{
+	struct device_node *of_node;
+	int i;
+
+	for (i = 0; i < SIERRA_NUM_REFRCV; i++) {
+		of_node = of_get_child_by_name(node, refrcv_node_name[i]);
+		if (!of_node)
+			return;
+
+		of_clk_del_provider(of_node);
+		of_node_put(of_node);
+	}
+}
+
+static int cdns_sierra_phy_register_refrcv(struct cdns_sierra_phy *sp,
+					   struct device_node *node)
+{
+	struct regmap_field *plllc1en_field;
+	struct device_node *of_node = NULL;
+	struct regmap_field *termen_field;
+	struct device *dev = sp->dev;
+	int ret = 0, i;
+
+	for (i = 0; i < SIERRA_NUM_REFRCV; i++) {
+		of_node = of_get_child_by_name(node, refrcv_node_name[i]);
+		if (!of_node)
+			return 0;
+
+		plllc1en_field = sp->cmn_refrcv_refclk_plllc1en_preg[i];
+		termen_field = sp->cmn_refrcv_refclk_termen_preg[i];
+
+		ret = cdns_sierra_refrcv_register(sp, of_node, plllc1en_field,
+						  termen_field);
+		if (ret) {
+			dev_err(dev, "Fail to register reference receiver %s\n",
+				refrcv_node_name[i]);
+			of_node_put(of_node);
+			goto err;
+		}
+
+		of_node_put(of_node);
+	}
+
+	return 0;
+
+err:
+	cdns_sierra_refrcv_unregister(sp, node);
+
+	return ret;
+}
+
 static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 				    struct device_node *child)
 {
@@ -402,6 +576,7 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 {
 	struct device *dev = sp->dev;
 	struct regmap_field *field;
+	struct reg_field reg_field;
 	struct regmap *regmap;
 	int i;
 
@@ -413,6 +588,24 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 	}
 	sp->macro_id_type = field;
 
+	for (i = 0; i < SIERRA_NUM_REFRCV; i++) {
+		reg_field = cmn_refrcv_refclk_plllc1en_preg[i];
+		field = devm_regmap_field_alloc(dev, regmap, reg_field);
+		if (IS_ERR(field)) {
+			dev_err(dev, "REFRCV%d_REFCLK_PLLLC1EN failed\n", i);
+			return PTR_ERR(field);
+		}
+		sp->cmn_refrcv_refclk_plllc1en_preg[i] = field;
+
+		reg_field = cmn_refrcv_refclk_termen_preg[i];
+		field = devm_regmap_field_alloc(dev, regmap, reg_field);
+		if (IS_ERR(field)) {
+			dev_err(dev, "REFRCV%d_REFCLK_TERMEN failed\n", i);
+			return PTR_ERR(field);
+		}
+		sp->cmn_refrcv_refclk_termen_preg[i] = field;
+	}
+
 	regmap = sp->regmap_phy_config_ctrl;
 	field = devm_regmap_field_alloc(dev, regmap, phy_pll_cfg_1);
 	if (IS_ERR(field)) {
@@ -577,17 +770,21 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sp);
 
-	ret = cdns_sierra_phy_get_clocks(sp, dev);
+	ret = cdns_sierra_phy_register_refrcv(sp, dn);
 	if (ret)
 		return ret;
 
+	ret = cdns_sierra_phy_get_clocks(sp, dev);
+	if (ret)
+		goto unregister_refrcv;
+
 	ret = cdns_sierra_phy_get_resets(sp, dev);
 	if (ret)
-		return ret;
+		goto unregister_refrcv;
 
 	ret = clk_prepare_enable(sp->clk);
 	if (ret)
-		return ret;
+		goto unregister_refrcv;
 
 	/* Enable APB */
 	reset_control_deassert(sp->apb_rst);
@@ -664,12 +861,17 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 clk_disable:
 	clk_disable_unprepare(sp->clk);
 	reset_control_assert(sp->apb_rst);
+unregister_refrcv:
+	cdns_sierra_refrcv_unregister(sp, dn);
+
 	return ret;
 }
 
 static int cdns_sierra_phy_remove(struct platform_device *pdev)
 {
 	struct cdns_sierra_phy *phy = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct device_node *dn = dev->of_node;
 	int i;
 
 	reset_control_assert(phy->phy_rst);
@@ -684,6 +886,7 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 		reset_control_assert(phy->phys[i].lnk_rst);
 		reset_control_put(phy->phys[i].lnk_rst);
 	}
+	cdns_sierra_refrcv_unregister(phy, dn);
 	return 0;
 }
 
-- 
2.17.1

