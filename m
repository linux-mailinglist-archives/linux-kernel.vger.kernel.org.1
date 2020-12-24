Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5991A2E267F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgLXLpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:45:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39706 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgLXLpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:45:21 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBhaID083417;
        Thu, 24 Dec 2020 05:43:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608810216;
        bh=C6VmPER5GCq2++TCYUbhbv+YgfcUFKsHywohrusjcBI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yq4RPbttx/GXBAy/ntR7PhVcH7J37Ri+4WUIeUXtKxCyBJHGasoQjrS7mRireyN3z
         xOHtoYOLrv7rhU3JZfjjZOsyDuI1bPBOcS96+GhSHLiZeH7Q29Q7IBCRsy97zDh/mz
         TYlyj192H8X6hWGSS1Z1wuXD0H5TfEYeNb2Goqss=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBhaS8090278
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:43:36 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:43:35 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:43:35 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBgtwa026267;
        Thu, 24 Dec 2020 05:43:31 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Peter Rosin <peda@axentia.se>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 7/7] phy: cadence-torrent: Add support to drive refclk out
Date:   Thu, 24 Dec 2020 17:12:50 +0530
Message-ID: <20201224114250.1083-8-kishon@ti.com>
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
reference clock. Model this derived reference clock as a "clock" so that
platforms like AM642 EVM can enable it.
This is used by PCIe to use the same refclk both in local SERDES
and remote device. Add support here to drive refclk out.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 158 ++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index f310e15d94cb..ad01fb61cfa4 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/phy/phy.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -76,6 +77,8 @@
  * register offsets from SD0801 PHY register block base (i.e MHDP
  * register base + 0x500000)
  */
+#define CMN_CDIAG_REFCLK_OVRD		0x004CU
+#define CMN_CDIAG_REFCLK_DRV0_CTRL	0x0050U
 #define CMN_SSM_BANDGAP_TMR		0x0021U
 #define CMN_SSM_BIAS_TMR		0x0022U
 #define CMN_PLLSM0_PLLPRE_TMR		0x002AU
@@ -206,6 +209,8 @@
 #define RX_DIAG_ACYA			0x01FFU
 
 /* PHY PCS common registers */
+#define PHY_PIPE_CMN_CTRL1		0x0000U
+#define PHY_ISO_CMN_CTRL		0x0008U
 #define PHY_PLL_CFG			0x000EU
 #define PHY_PIPE_USB3_GEN2_PRE_CFG0	0x0020U
 #define PHY_PIPE_USB3_GEN2_POST_CFG0	0x0022U
@@ -231,6 +236,36 @@ static const struct reg_field phy_pma_pll_raw_ctrl =
 static const struct reg_field phy_reset_ctrl =
 				REG_FIELD(PHY_RESET, 8, 8);
 
+#define REFCLK_OUT_NUM_CONFIGURATIONS_PCS_CONFIG	2
+
+enum cdns_torrent_refclk_out_pcs {
+	PHY_ISO_CMN_CTRL_8,
+	PHY_PIPE_CMN_CTRL1_0,
+};
+
+#define REFCLK_OUT_NUM_CONFIGURATIONS_CMN_CONFIG	5
+
+enum cdns_torrent_refclk_out_cmn {
+	CMN_CDIAG_REFCLK_OVRD_4,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_1,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_4,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_5,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_6,
+};
+
+static const struct reg_field refclk_out_pcs_cfg[] = {
+	[PHY_ISO_CMN_CTRL_8]	= REG_FIELD(PHY_ISO_CMN_CTRL, 8, 8),
+	[PHY_PIPE_CMN_CTRL1_0]	= REG_FIELD(PHY_PIPE_CMN_CTRL1, 0, 0),
+};
+
+static const struct reg_field refclk_out_cmn_cfg[] = {
+	[CMN_CDIAG_REFCLK_OVRD_4]	= REG_FIELD(CMN_CDIAG_REFCLK_OVRD, 4, 4),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_1]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 1, 1),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_4]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 4, 4),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_5]  = REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 5, 5),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_6]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 6, 6),
+};
+
 enum cdns_torrent_phy_type {
 	TYPE_NONE,
 	TYPE_DP,
@@ -288,6 +323,16 @@ enum phy_powerstate {
 	POWERSTATE_A3 = 3,
 };
 
+struct cdns_torrent_derived_refclk {
+	struct clk_hw		hw;
+	struct regmap_field	*pcs_fields[REFCLK_OUT_NUM_CONFIGURATIONS_PCS_CONFIG];
+	struct regmap_field	*cmn_fields[REFCLK_OUT_NUM_CONFIGURATIONS_CMN_CONFIG];
+	struct clk_init_data	clk_data;
+};
+
+#define to_cdns_torrent_derived_refclk(_hw)	\
+			container_of(_hw, struct cdns_torrent_derived_refclk, hw)
+
 static int cdns_torrent_phy_init(struct phy *phy);
 static int cdns_torrent_dp_init(struct phy *phy);
 static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
@@ -1604,6 +1649,110 @@ static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
 	return ret;
 }
 
+static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
+{
+	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
+
+	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_6], 0);
+	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_4], 1);
+	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_5], 1);
+	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_1], 0);
+	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_OVRD_4], 1);
+	regmap_field_write(derived_refclk->pcs_fields[PHY_PIPE_CMN_CTRL1_0], 1);
+	regmap_field_write(derived_refclk->pcs_fields[PHY_ISO_CMN_CTRL_8], 1);
+
+	return 0;
+}
+
+static void cdns_torrent_derived_refclk_disable(struct clk_hw *hw)
+{
+	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
+
+	regmap_field_write(derived_refclk->pcs_fields[PHY_ISO_CMN_CTRL_8], 0);
+}
+
+static int cdns_torrent_derived_refclk_is_enabled(struct clk_hw *hw)
+{
+	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
+	int val;
+
+	regmap_field_read(derived_refclk->pcs_fields[PHY_ISO_CMN_CTRL_8], &val);
+
+	return !!val;
+}
+
+static const struct clk_ops cdns_torrent_derived_refclk_ops = {
+	.enable = cdns_torrent_derived_refclk_enable,
+	.disable = cdns_torrent_derived_refclk_disable,
+	.is_enabled = cdns_torrent_derived_refclk_is_enabled,
+};
+
+static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_phy,
+						struct device_node *node)
+{
+	struct cdns_torrent_derived_refclk *derived_refclk;
+	struct device *dev = cdns_phy->dev;
+	struct regmap_field *field;
+	struct clk_init_data *init;
+	unsigned int num_parents;
+	const char *parent_name;
+	struct regmap *regmap;
+	char clk_name[100];
+	struct clk *clk;
+	int ret, i;
+
+	derived_refclk = devm_kzalloc(dev, sizeof(*derived_refclk), GFP_KERNEL);
+	if (!derived_refclk)
+		return -ENOMEM;
+
+	num_parents = of_clk_get_parent_count(node);
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
+		 node->name);
+
+	init = &derived_refclk->clk_data;
+
+	init->ops = &cdns_torrent_derived_refclk_ops;
+	init->flags = 0;
+	init->parent_names = parent_name ? &parent_name : NULL;
+	init->num_parents = num_parents ? 1 : 0;
+	init->name = clk_name;
+
+	regmap = cdns_phy->regmap_phy_pcs_common_cdb;
+	for (i = 0; i < REFCLK_OUT_NUM_CONFIGURATIONS_PCS_CONFIG; i++) {
+		field = devm_regmap_field_alloc(dev, regmap, refclk_out_pcs_cfg[i]);
+		if (IS_ERR(field)) {
+			dev_err(dev, "PCS reg field init failed\n");
+			return PTR_ERR(field);
+		}
+		derived_refclk->pcs_fields[i] = field;
+	}
+
+	regmap = cdns_phy->regmap_common_cdb;
+	for (i = 0; i < REFCLK_OUT_NUM_CONFIGURATIONS_CMN_CONFIG; i++) {
+		field = devm_regmap_field_alloc(dev, regmap, refclk_out_cmn_cfg[i]);
+		if (IS_ERR(field)) {
+			dev_err(dev, "CMN reg field init failed\n");
+			return PTR_ERR(field);
+		}
+		derived_refclk->cmn_fields[i] = field;
+	}
+
+	derived_refclk->hw.init = init;
+
+	clk = devm_clk_register(dev, &derived_refclk->hw);
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
 static int cdns_torrent_phy_on(struct phy *phy)
 {
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
@@ -2150,6 +2299,15 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	/* Enable APB */
 	reset_control_deassert(cdns_phy->apb_rst);
 
+	child = of_get_child_by_name(dev->of_node, "refclk-driver");
+	if (child) {
+		ret = cdns_torrent_derived_refclk_register(cdns_phy, child);
+		if (ret) {
+			dev_err(dev, "failed to register derived refclk\n");
+			return ret;
+		}
+	}
+
 	for_each_available_child_of_node(dev->of_node, child) {
 		struct phy *gphy;
 
-- 
2.17.1

