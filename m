Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313562A3B35
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgKCD4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:56:38 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41912 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbgKCD4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:56:35 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A33uU2c034185;
        Mon, 2 Nov 2020 21:56:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604375790;
        bh=HStXkv9wFRR3rD6VCpH4H1fcX4qHUGOEUyg7wkRYohU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dkGR4DwoJwf2vhy19+tDW+hDcWCpsqRrPYHSeeJsbmV+WpeyFZjuiCedmKCPTMXgU
         1jnV3kKmBJgtchGT2OqLnilECM7zMn3N9zJfP5itMm/DnQmxPqabLl32OeZkbGbyKm
         mzUUvH8cXJuc2z6WjxPMEAUfcv8lAcAtT4QzZ/1E=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A33uTmb126643
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 21:56:30 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 21:56:23 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 21:56:23 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A33tuqR101157;
        Mon, 2 Nov 2020 21:56:20 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 6/9] phy: cadence: sierra: Don't configure if any plls are already locked
Date:   Tue, 3 Nov 2020 09:25:53 +0530
Message-ID: <20201103035556.21260-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103035556.21260-1-kishon@ti.com>
References: <20201103035556.21260-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

Serdes lanes might be shared between multiple cores in some usecases
and its not possible to lock PLLs for both the lanes independently
by the two cores. This requires a bootloader to configure both the
lanes at early boot time.

To handle this case, skip all configuration if any of the plls are
already locked. This is done by adding an already_configured flag
and using it to gate every register access as well as any phy_ops.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 127 ++++++++++++++---------
 1 file changed, 78 insertions(+), 49 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index e08548417bce..145e42837b7b 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -364,6 +364,10 @@ static const struct phy_ops ops = {
 	.owner		= THIS_MODULE,
 };
 
+static const struct phy_ops noop_ops = {
+	.owner		= THIS_MODULE,
+};
+
 static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 				    struct device_node *child)
 {
@@ -477,6 +481,49 @@ static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
 	return 0;
 }
 
+static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
+				      struct device *dev)
+{
+	struct clk *clk;
+	int ret;
+
+	sp->clk = devm_clk_get_optional(dev, "phy_clk");
+	if (IS_ERR(sp->clk)) {
+		dev_err(dev, "failed to get clock phy_clk\n");
+		return PTR_ERR(sp->clk);
+	}
+
+	sp->phy_rst = devm_reset_control_get(dev, "sierra_reset");
+	if (IS_ERR(sp->phy_rst)) {
+		dev_err(dev, "failed to get reset\n");
+		return PTR_ERR(sp->phy_rst);
+	}
+
+	sp->apb_rst = devm_reset_control_get_optional(dev, "sierra_apb");
+	if (IS_ERR(sp->apb_rst)) {
+		dev_err(dev, "failed to get apb reset\n");
+		return PTR_ERR(sp->apb_rst);
+	}
+
+	clk = devm_clk_get_optional(dev, "cmn_refclk_dig_div");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "cmn_refclk_dig_div clock not found\n");
+		ret = PTR_ERR(clk);
+		return ret;
+	}
+	sp->cmn_refclk_dig_div = clk;
+
+	clk = devm_clk_get_optional(dev, "cmn_refclk1_dig_div");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "cmn_refclk1_dig_div clock not found\n");
+		ret = PTR_ERR(clk);
+		return ret;
+	}
+	sp->cmn_refclk1_dig_div = clk;
+
+	return 0;
+}
+
 static int cdns_sierra_phy_probe(struct platform_device *pdev)
 {
 	struct cdns_sierra_phy *sp;
@@ -486,10 +533,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	struct cdns_sierra_data *data;
 	unsigned int id_value;
 	struct resource *res;
-	int i, ret, node = 0;
+	int i, val, ret, node = 0;
 	void __iomem *base;
-	struct clk *clk;
 	struct device_node *dn = dev->of_node, *child;
+	bool already_configured = false;
 
 	if (of_get_child_count(dn) == 0)
 		return -ENODEV;
@@ -524,54 +571,33 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, sp);
-
-	sp->clk = devm_clk_get_optional(dev, "phy_clk");
-	if (IS_ERR(sp->clk)) {
-		dev_err(dev, "failed to get clock phy_clk\n");
-		return PTR_ERR(sp->clk);
-	}
-
-	sp->phy_rst = devm_reset_control_get(dev, "sierra_reset");
-	if (IS_ERR(sp->phy_rst)) {
-		dev_err(dev, "failed to get reset\n");
-		return PTR_ERR(sp->phy_rst);
-	}
-
-	sp->apb_rst = devm_reset_control_get_optional(dev, "sierra_apb");
-	if (IS_ERR(sp->apb_rst)) {
-		dev_err(dev, "failed to get apb reset\n");
-		return PTR_ERR(sp->apb_rst);
-	}
-
-	clk = devm_clk_get_optional(dev, "cmn_refclk_dig_div");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "cmn_refclk_dig_div clock not found\n");
-		ret = PTR_ERR(clk);
-		return ret;
-	}
-	sp->cmn_refclk_dig_div = clk;
-
-	clk = devm_clk_get_optional(dev, "cmn_refclk1_dig_div");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "cmn_refclk1_dig_div clock not found\n");
-		ret = PTR_ERR(clk);
-		return ret;
+	for (i = 0; i < SIERRA_MAX_LANES; i++) {
+		regmap_field_read(sp->pllctrl_lock[i], &val);
+		if (val) {
+			already_configured = true;
+			break;
+		}
 	}
-	sp->cmn_refclk1_dig_div = clk;
 
-	ret = clk_prepare_enable(sp->clk);
-	if (ret)
-		return ret;
-
-	/* Enable APB */
-	reset_control_deassert(sp->apb_rst);
+	platform_set_drvdata(pdev, sp);
 
-	/* Check that PHY is present */
-	regmap_field_read(sp->macro_id_type, &id_value);
-	if  (sp->init_data->id_value != id_value) {
-		ret = -EINVAL;
-		goto clk_disable;
+	if (!already_configured) {
+		ret = cdns_sierra_phy_get_clocks(sp, dev);
+		if (ret)
+			return ret;
+
+		ret = clk_prepare_enable(sp->clk);
+		if (ret)
+			return ret;
+		/* Enable APB */
+		reset_control_deassert(sp->apb_rst);
+
+		/* Check that PHY is present */
+		regmap_field_read(sp->macro_id_type, &id_value);
+		if  (sp->init_data->id_value != id_value) {
+			ret = -EINVAL;
+			goto clk_disable;
+		}
 	}
 
 	sp->autoconf = of_property_read_bool(dn, "cdns,autoconf");
@@ -603,7 +629,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 
 		sp->num_lanes += sp->phys[node].num_lanes;
 
-		gphy = devm_phy_create(dev, child, &ops);
+		if (already_configured)
+			gphy = devm_phy_create(dev, child, &noop_ops);
+		else
+			gphy = devm_phy_create(dev, child, &ops);
 
 		if (IS_ERR(gphy)) {
 			ret = PTR_ERR(gphy);
@@ -622,7 +651,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	}
 
 	/* If more than one subnode, configure the PHY as multilink */
-	if (!sp->autoconf && sp->nsubnodes > 1)
+	if (!sp->autoconf && sp->nsubnodes > 1 && !already_configured)
 		regmap_field_write(sp->phy_pll_cfg_1, 0x1);
 
 	pm_runtime_enable(dev);
-- 
2.17.1

