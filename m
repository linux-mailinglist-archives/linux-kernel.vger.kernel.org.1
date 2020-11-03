Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DDC2A3B3B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgKCD4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:56:35 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39586 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbgKCD4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:56:33 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A33uR5b023738;
        Mon, 2 Nov 2020 21:56:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604375787;
        bh=Eyd66bu/B8nY3Xw74Q3lf9TGmxbpqwZIEnWaSeJlbKk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tmG8jJwPgW0x0UpJdg/2giJSj1fhFT6Sb8+xW05+yZ2/sD0n5e7RjpR5zANvjTN4K
         cbbWCKKmUOrbDHVvhTBcEToFAeTNCBnL6Hhq09xtEGW2F4gsxCaI6XoQ9jT7vtuzWd
         OALLXvlhvDQVIVv1xmBSkJzvW+26U5p+PCwHM8XY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A33uRtb031691
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 21:56:27 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 21:56:27 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 21:56:27 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A33tuqS101157;
        Mon, 2 Nov 2020 21:56:24 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 7/9] phy: cadence: sierra: Model reference receiver as clocks (gate clocks)
Date:   Tue, 3 Nov 2020 09:25:54 +0530
Message-ID: <20201103035556.21260-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103035556.21260-1-kishon@ti.com>
References: <20201103035556.21260-1-kishon@ti.com>
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
 drivers/phy/cadence/phy-cadence-sierra.c | 177 +++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 145e42837b7b..ab7a3e2795cd 100644
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
@@ -368,6 +402,93 @@ static const struct phy_ops noop_ops = {
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
 static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 				    struct device_node *child)
 {
@@ -406,6 +527,7 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 {
 	struct device *dev = sp->dev;
 	struct regmap_field *field;
+	struct reg_field reg_field;
 	struct regmap *regmap;
 	int i;
 
@@ -417,6 +539,24 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
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
@@ -481,6 +621,38 @@ static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
 	return 0;
 }
 
+static int cdns_sierra_phy_register_refrcv(struct cdns_sierra_phy *sp,
+					   struct device_node *dn)
+{
+	struct regmap_field *plllc1en_field;
+	struct device_node *of_node = NULL;
+	struct regmap_field *termen_field;
+	struct device *dev = sp->dev;
+	int ret = 0, i;
+
+	for (i = 0; i < SIERRA_NUM_REFRCV; i++) {
+		of_node = of_get_child_by_name(dn, refrcv_node_name[i]);
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
+			goto err;
+		}
+	}
+
+err:
+	of_node_put(of_node);
+
+	return ret;
+}
+
 static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
 				      struct device *dev)
 {
@@ -582,6 +754,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sp);
 
 	if (!already_configured) {
+		ret = cdns_sierra_phy_register_refrcv(sp, dn);
+		if (ret)
+			return ret;
+
 		ret = cdns_sierra_phy_get_clocks(sp, dev);
 		if (ret)
 			return ret;
@@ -589,6 +765,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(sp->clk);
 		if (ret)
 			return ret;
+
 		/* Enable APB */
 		reset_control_deassert(sp->apb_rst);
 
-- 
2.17.1

