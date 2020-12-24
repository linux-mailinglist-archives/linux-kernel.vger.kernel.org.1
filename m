Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA3D2E263C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgLXLTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:19:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37852 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgLXLTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:19:15 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBHXLC041986;
        Thu, 24 Dec 2020 05:17:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608808653;
        bh=tCte5VmsqyuWZlnMxjL6FOlYoAUA5RMWxhxB99I34cQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GNrI2r42yVsxdEgLc+qmClzxo4K2RPtu+yO75wX7uEtReeFsHkBafgVey+kt85u05
         LA7VgQP6kvHPm2EVkef5ey/MUTq29I25wBNO221hUqOKMeN9Z9IMSopl1S3Ej1srdj
         fT5uKHbEFe2q4X8LT272Ruu6Rlykh2OTOTPR9XP4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBHXkT058795
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:17:33 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:17:32 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:17:32 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBGWGH116630;
        Thu, 24 Dec 2020 05:17:29 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 11/15] phy: cadence: sierra: Enable pll_cmnlc and pll_cmnlc1 clocks
Date:   Thu, 24 Dec 2020 16:46:23 +0530
Message-ID: <20201224111627.32590-12-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224111627.32590-1-kishon@ti.com>
References: <20201224111627.32590-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get pll_cmnlc and pll_cmnlc1 optional clocks and enable them.
This will enable REFRCV/1 in case the pll_cmnlc/1 takes input
from REFRCV/1 respectively.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 57 +++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 2a509be80c80..ad0ea74515d6 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -267,6 +267,8 @@ struct cdns_sierra_phy {
 	struct clk *clk;
 	struct clk *cmn_refclk_dig_div;
 	struct clk *cmn_refclk1_dig_div;
+	struct clk *pll_cmnlc;
+	struct clk *pll_cmnlc1;
 	int nsubnodes;
 	u32 num_lanes;
 	bool autoconf;
@@ -874,9 +876,59 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
 	}
 	sp->cmn_refclk1_dig_div = clk;
 
+	clk = devm_clk_get_optional(dev, "pll_cmnlc");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "pll_cmnlc clock not found\n");
+		ret = PTR_ERR(clk);
+		return ret;
+	}
+	sp->pll_cmnlc = clk;
+
+	clk = devm_clk_get_optional(dev, "pll_cmnlc1");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "pll_cmnlc1 clock not found\n");
+		ret = PTR_ERR(clk);
+		return ret;
+	}
+	sp->pll_cmnlc1 = clk;
+
 	return 0;
 }
 
+static int cdns_sierra_phy_enable_clocks(struct cdns_sierra_phy *sp)
+{
+	int ret;
+
+	ret = clk_prepare_enable(sp->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(sp->pll_cmnlc);
+	if (ret)
+		goto err_pll_cmnlc;
+
+	ret = clk_prepare_enable(sp->pll_cmnlc1);
+	if (ret)
+		goto err_pll_cmnlc1;
+
+	return 0;
+
+err_pll_cmnlc:
+	clk_disable_unprepare(sp->clk);
+
+err_pll_cmnlc1:
+	clk_disable_unprepare(sp->pll_cmnlc);
+
+	return 0;
+}
+
+static void cdns_sierra_phy_disable_clocks(struct cdns_sierra_phy *sp)
+{
+	clk_disable_unprepare(sp->pll_cmnlc1);
+	clk_disable_unprepare(sp->pll_cmnlc);
+	clk_disable_unprepare(sp->clk);
+}
+
 static int cdns_sierra_phy_get_resets(struct cdns_sierra_phy *sp,
 				      struct device *dev)
 {
@@ -961,7 +1013,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_pll_mux;
 
-	ret = clk_prepare_enable(sp->clk);
+	ret = cdns_sierra_phy_enable_clocks(sp);
 	if (ret)
 		goto unregister_pll_mux;
 
@@ -1038,7 +1090,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		reset_control_put(sp->phys[i].lnk_rst);
 	of_node_put(child);
 clk_disable:
-	clk_disable_unprepare(sp->clk);
+	cdns_sierra_phy_disable_clocks(sp);
 	reset_control_assert(sp->apb_rst);
 unregister_pll_mux:
 	cdns_sierra_pll_mux_unregister(sp, dn);
@@ -1059,6 +1111,7 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 	reset_control_assert(phy->apb_rst);
 	pm_runtime_disable(&pdev->dev);
 
+	cdns_sierra_phy_disable_clocks(phy);
 	/*
 	 * The device level resets will be put automatically.
 	 * Need to put the subnode resets here though.
-- 
2.17.1

