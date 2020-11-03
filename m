Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DE82A3B36
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgKCD4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:56:40 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41920 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbgKCD4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:56:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A33uVAX034215;
        Mon, 2 Nov 2020 21:56:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604375791;
        bh=RIVx4Nuxu5qZjDapNR/qyXoVvAzyEQ5UPTMKLfWMEWY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DRuWjLQTMnEbxEHEdLT7eSWsauKfVpK2R0KwXD8Tx4iPg4x3Trwg9nuF52mT8QXSO
         N2E/CPPbAemyYyL2c67ydfZWJ89PJir9nXWN5wo6W+PLHDWaguDG6HzfB3VtepeC0P
         rZbVtjpRYbr713W7VhN9Cuyn0TBVihuqOAbEIMPg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A33uVTk112377
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 21:56:31 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 21:56:30 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 21:56:30 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A33tuqT101157;
        Mon, 2 Nov 2020 21:56:28 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 8/9] phy: cadence: sierra: Model PLL_CMNLC and PLL_CMNLC1 as clocks (mux clocks)
Date:   Tue, 3 Nov 2020 09:25:55 +0530
Message-ID: <20201103035556.21260-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103035556.21260-1-kishon@ti.com>
References: <20201103035556.21260-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sierra has two PLLs, PLL_CMNLC and PLL_CMNLC1 and each of these PLLs has
two inputs, plllc_refclk and refrcv. Model PLL_CMNLC and PLL_CMNLC1 as
clocks so that it's possible to select one of these two inputs from
device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 158 +++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index ab7a3e2795cd..c4751fe9edfd 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -25,6 +25,7 @@
 /* PHY register offsets */
 #define SIERRA_COMMON_CDB_OFFSET			0x0
 #define SIERRA_MACRO_ID_REG				0x0
+#define SIERRA_CMN_PLLLC_GEN_PREG			0x42
 #define SIERRA_CMN_PLLLC_MODE_PREG			0x48
 #define SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG		0x49
 #define SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG		0x4A
@@ -34,6 +35,7 @@
 #define SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG	0x62
 #define SIERRA_CMN_REFRCV_PREG				0x98
 #define SIERRA_CMN_REFRCV1_PREG				0xB8
+#define SIERRA_CMN_PLLLC1_GEN_PREG			0xC2
 
 #define SIERRA_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
 				((0x4000 << (block_offset)) + \
@@ -183,6 +185,36 @@ struct cdns_sierra_refrcv {
 #define to_cdns_sierra_refrcv(_hw)	\
 			container_of(_hw, struct cdns_sierra_refrcv, hw)
 
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
@@ -231,6 +263,7 @@ struct cdns_sierra_phy {
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
 	struct regmap_field *cmn_refrcv_refclk_plllc1en_preg[SIERRA_NUM_REFRCV];
 	struct regmap_field *cmn_refrcv_refclk_termen_preg[SIERRA_NUM_REFRCV];
+	struct regmap_field *cmn_plllc_pfdclk1_sel_preg[SIERRA_NUM_CMN_PLLC];
 	struct clk *clk;
 	struct clk *cmn_refclk_dig_div;
 	struct clk *cmn_refclk1_dig_div;
@@ -402,6 +435,117 @@ static const struct phy_ops noop_ops = {
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
+static int cdns_sierra_phy_register_pll_mux(struct cdns_sierra_phy *sp,
+					    struct device_node *dn)
+{
+	struct regmap_field *pfdclk1_sel_field;
+	struct device_node *of_node = NULL;
+	struct device *dev = sp->dev;
+	int ret = 0, i;
+
+	for (i = 0; i < SIERRA_NUM_CMN_PLLC; i++) {
+		of_node = of_get_child_by_name(dn, cmn_plllc_node_name[i]);
+		if (!of_node)
+			return 0;
+
+		pfdclk1_sel_field = sp->cmn_plllc_pfdclk1_sel_preg[i];
+		ret = cdns_sierra_pll_mux_register(sp, of_node,
+						   pfdclk1_sel_field);
+		if (ret) {
+			dev_err(dev, "Fail to register cmn plllc mux %s\n",
+				cmn_plllc_node_name[i]);
+			goto err;
+		}
+	}
+
+err:
+	of_node_put(of_node);
+
+	return 0;
+}
+
 static int cdns_sierra_refrcv_enable(struct clk_hw *hw)
 {
 	struct cdns_sierra_refrcv *refrcv = to_cdns_sierra_refrcv(hw);
@@ -557,6 +701,16 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 		sp->cmn_refrcv_refclk_termen_preg[i] = field;
 	}
 
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
@@ -758,6 +912,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
+		ret = cdns_sierra_phy_register_pll_mux(sp, dn);
+		if (ret)
+			return ret;
+
 		ret = cdns_sierra_phy_get_clocks(sp, dev);
 		if (ret)
 			return ret;
-- 
2.17.1

