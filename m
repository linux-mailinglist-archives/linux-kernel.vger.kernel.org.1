Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF372E0685
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgLVHHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:07:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59124 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgLVHHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:07:00 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BM75x68034401;
        Tue, 22 Dec 2020 01:05:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608620759;
        bh=ctjrTLWGVtshZ8EF7r1WXZ19ZgPa6NCq5+743muOnQw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=o9e9EBh4MtMBddIKwbtHGh7hZ5HFPA2+gkvccs/E2qBzPawjcXU7y86oLvb+jRZ5x
         v8vpTEUJcrfLdJP5IOavGYSELN8n2CxcqrztX3+DsbrLxry5LD1W3D/qciBCu09IWG
         YpRedgf1ylCOEkMVGP3l6ctkVDolu1of2mI2/0mQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BM75xuO015001
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 01:05:59 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 01:05:58 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 01:05:58 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BM75N7I050344;
        Tue, 22 Dec 2020 01:05:56 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nishanth Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 09/14] phy: cadence: sierra: Model reference receiver as clocks (gate clocks)
Date:   Tue, 22 Dec 2020 12:35:15 +0530
Message-ID: <20201222070520.28132-10-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222070520.28132-1-kishon@ti.com>
References: <20201222070520.28132-1-kishon@ti.com>
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
 drivers/phy/cadence/phy-cadence-sierra.c | 391 ++++++++++++++++++++++-
 1 file changed, 388 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 44c52a0842dc..2a509be80c80 100644
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
@@ -24,6 +25,7 @@
 /* PHY register offsets */
 #define SIERRA_COMMON_CDB_OFFSET			0x0
 #define SIERRA_MACRO_ID_REG				0x0
+#define SIERRA_CMN_PLLLC_GEN_PREG			0x42
 #define SIERRA_CMN_PLLLC_MODE_PREG			0x48
 #define SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG		0x49
 #define SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG		0x4A
@@ -31,6 +33,9 @@
 #define SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG		0x4F
 #define SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG		0x50
 #define SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG	0x62
+#define SIERRA_CMN_REFRCV_PREG				0x98
+#define SIERRA_CMN_REFRCV1_PREG				0xB8
+#define SIERRA_CMN_PLLLC1_GEN_PREG			0xC2
 
 #define SIERRA_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
 				((0x4000 << (block_offset)) + \
@@ -151,6 +156,65 @@ static const struct reg_field phy_pll_cfg_1 =
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
+enum cdns_sierra_cmn_plllc {
+	CMN_PLLLC,
+	CMN_PLLLC1,
+};
+
+#define SIERRA_NUM_CMN_PLLC	0x2
+
+static const struct reg_field cmn_plllc_pfdclk1_sel_preg[] = {
+	[CMN_PLLLC]	= REG_FIELD(SIERRA_CMN_PLLLC_GEN_PREG, 1, 1),
+	[CMN_PLLLC1]	= REG_FIELD(SIERRA_CMN_PLLLC1_GEN_PREG, 1, 1),
+};
+
+static char *cmn_plllc_node_name[] = { "pll_cmnlc", "pll_cmnlc1" };
+
+struct cdns_sierra_pll_mux {
+	struct clk_hw		hw;
+	struct regmap_field	*pfdclk_sel_preg;
+	u32			*table;
+	struct clk_init_data	clk_data;
+};
+
+#define to_cdns_sierra_pll_mux(_hw)	\
+			container_of(_hw, struct cdns_sierra_pll_mux, hw)
+
+/*
+ * Mux value to be configured for each of the input clocks
+ * in the order populated in device tree
+ */
+static u32 cdns_sierra_pll_mux_table[] = { 0, 1 };
+
 struct cdns_sierra_inst {
 	struct phy *phy;
 	u32 phy_type;
@@ -197,6 +261,9 @@ struct cdns_sierra_phy {
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
+	struct regmap_field *cmn_refrcv_refclk_plllc1en_preg[SIERRA_NUM_REFRCV];
+	struct regmap_field *cmn_refrcv_refclk_termen_preg[SIERRA_NUM_REFRCV];
+	struct regmap_field *cmn_plllc_pfdclk1_sel_preg[SIERRA_NUM_CMN_PLLC];
 	struct clk *clk;
 	struct clk *cmn_refclk_dig_div;
 	struct clk *cmn_refclk1_dig_div;
@@ -364,6 +431,278 @@ static const struct phy_ops ops = {
 	.owner		= THIS_MODULE,
 };
 
+static u8 cdns_sierra_pll_mux_get_parent(struct clk_hw *hw)
+{
+	struct cdns_sierra_pll_mux *mux = to_cdns_sierra_pll_mux(hw);
+	struct regmap_field *field = mux->pfdclk_sel_preg;
+	unsigned int val;
+
+	regmap_field_read(field, &val);
+	return clk_mux_val_to_index(hw, mux->table, 0, val);
+}
+
+static int cdns_sierra_pll_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct cdns_sierra_pll_mux *mux = to_cdns_sierra_pll_mux(hw);
+	struct regmap_field *field = mux->pfdclk_sel_preg;
+	int val;
+
+	val = mux->table[index];
+	return regmap_field_write(field, val);
+}
+
+static const struct clk_ops cdns_sierra_pll_mux_ops = {
+	.set_parent = cdns_sierra_pll_mux_set_parent,
+	.get_parent = cdns_sierra_pll_mux_get_parent,
+};
+
+static int cdns_sierra_pll_mux_register(struct cdns_sierra_phy *sp,
+					struct device_node *node,
+					struct regmap_field *field)
+{
+	struct cdns_sierra_pll_mux *mux;
+	struct device *dev = sp->dev;
+	struct clk_init_data *init;
+	const char **parent_names;
+	unsigned int num_parents;
+	char clk_name[100];
+	struct clk *clk;
+	int ret;
+
+	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return -ENOMEM;
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 2) {
+		dev_err(dev, "SERDES clock must have parents\n");
+		return -EINVAL;
+	}
+
+	parent_names = devm_kzalloc(dev, (sizeof(char *) * num_parents),
+				    GFP_KERNEL);
+	if (!parent_names)
+		return -ENOMEM;
+
+	of_clk_parent_fill(node, parent_names, num_parents);
+
+	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
+		 node->name);
+
+	init = &mux->clk_data;
+
+	init->ops = &cdns_sierra_pll_mux_ops;
+	init->flags = CLK_SET_RATE_NO_REPARENT;
+	init->parent_names = parent_names;
+	init->num_parents = num_parents;
+	init->name = clk_name;
+
+	mux->pfdclk_sel_preg = field;
+	mux->table = cdns_sierra_pll_mux_table;
+	mux->hw.init = init;
+
+	clk = devm_clk_register(dev, &mux->hw);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (ret)
+		dev_err(dev, "Fail to add pll mux clock provider: %s\n",
+			clk_name);
+
+	return ret;
+}
+
+static void cdns_sierra_pll_mux_unregister(struct cdns_sierra_phy *sp,
+					   struct device_node *node)
+{
+	struct device_node *of_node;
+	int i;
+
+	for (i = 0; i < SIERRA_NUM_CMN_PLLC; i++) {
+		of_node = of_get_child_by_name(node, cmn_plllc_node_name[i]);
+		if (!of_node)
+			return;
+
+		of_clk_del_provider(of_node);
+		of_node_put(of_node);
+	}
+}
+
+static int cdns_sierra_phy_register_pll_mux(struct cdns_sierra_phy *sp,
+					    struct device_node *node)
+{
+	struct regmap_field *pfdclk1_sel_field;
+	struct device_node *of_node = NULL;
+	struct device *dev = sp->dev;
+	int ret = 0, i;
+
+	for (i = 0; i < SIERRA_NUM_CMN_PLLC; i++) {
+		of_node = of_get_child_by_name(node, cmn_plllc_node_name[i]);
+		if (!of_node)
+			return 0;
+
+		pfdclk1_sel_field = sp->cmn_plllc_pfdclk1_sel_preg[i];
+		ret = cdns_sierra_pll_mux_register(sp, of_node,
+						   pfdclk1_sel_field);
+		if (ret) {
+			dev_err(dev, "Fail to register cmn plllc mux %s\n",
+				cmn_plllc_node_name[i]);
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
+	cdns_sierra_pll_mux_unregister(sp, node);
+
+	return 0;
+}
+
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
@@ -402,6 +741,7 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 {
 	struct device *dev = sp->dev;
 	struct regmap_field *field;
+	struct reg_field reg_field;
 	struct regmap *regmap;
 	int i;
 
@@ -413,6 +753,34 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
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
+	for (i = 0; i < SIERRA_NUM_CMN_PLLC; i++) {
+		reg_field = cmn_plllc_pfdclk1_sel_preg[i];
+		field = devm_regmap_field_alloc(dev, regmap, reg_field);
+		if (IS_ERR(field)) {
+			dev_err(dev, "PLLLC%d_PFDCLK1_SEL failed\n", i);
+			return PTR_ERR(field);
+		}
+		sp->cmn_plllc_pfdclk1_sel_preg[i] = field;
+	}
+
 	regmap = sp->regmap_phy_config_ctrl;
 	field = devm_regmap_field_alloc(dev, regmap, phy_pll_cfg_1);
 	if (IS_ERR(field)) {
@@ -577,17 +945,25 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sp);
 
-	ret = cdns_sierra_phy_get_clocks(sp, dev);
+	ret = cdns_sierra_phy_register_refrcv(sp, dn);
 	if (ret)
 		return ret;
 
+	ret = cdns_sierra_phy_register_pll_mux(sp, dn);
+	if (ret)
+		goto unregister_refrcv;
+
+	ret = cdns_sierra_phy_get_clocks(sp, dev);
+	if (ret)
+		goto unregister_pll_mux;
+
 	ret = cdns_sierra_phy_get_resets(sp, dev);
 	if (ret)
-		return ret;
+		goto unregister_pll_mux;
 
 	ret = clk_prepare_enable(sp->clk);
 	if (ret)
-		return ret;
+		goto unregister_pll_mux;
 
 	/* Enable APB */
 	reset_control_deassert(sp->apb_rst);
@@ -664,12 +1040,19 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 clk_disable:
 	clk_disable_unprepare(sp->clk);
 	reset_control_assert(sp->apb_rst);
+unregister_pll_mux:
+	cdns_sierra_pll_mux_unregister(sp, dn);
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
@@ -684,6 +1067,8 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 		reset_control_assert(phy->phys[i].lnk_rst);
 		reset_control_put(phy->phys[i].lnk_rst);
 	}
+	cdns_sierra_pll_mux_unregister(phy, dn);
+	cdns_sierra_refrcv_unregister(phy, dn);
 	return 0;
 }
 
-- 
2.17.1

