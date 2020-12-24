Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C982E2638
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgLXLSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:18:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35640 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgLXLSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:18:50 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBH9Uw076183;
        Thu, 24 Dec 2020 05:17:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608808629;
        bh=1m1jaw1QKhWt1my5TiZgSyHmcvod41lJIai7xVZR3M8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cEibqEjQraJ7+w4VekW7WSpX5ZurAcvq2zKqU+iCU89UhhQabxm9qsK3PEq99J9w+
         722vlx6Hk7u1c2JBpoP6yXkLKoywGMWKNLLjm1af/N/p7G6aF6LnU6oU9P2gzQigCQ
         I+lJTH9gy8xSb6cNscQj4uVnMfm4MNBQrGGnhFOY=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBH9gU098731
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:17:09 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:17:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:17:08 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBGWGC116630;
        Thu, 24 Dec 2020 05:17:05 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 06/15] phy: cadence: cadence-sierra: Move all clk_get_*() to a separate function
Date:   Thu, 24 Dec 2020 16:46:18 +0530
Message-ID: <20201224111627.32590-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224111627.32590-1-kishon@ti.com>
References: <20201224111627.32590-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Group all devm_clk_get_optional() to a
separate function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 57 +++++++++++++++---------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index f7ba0ed416bc..7bf1b4c7774a 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -477,6 +477,38 @@ static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
 	return 0;
 }
 
+static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
+				      struct device *dev)
+{
+	struct clk *clk;
+	int ret;
+
+	clk = devm_clk_get_optional(dev, "phy_clk");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "failed to get clock phy_clk\n");
+		return PTR_ERR(clk);
+	}
+	sp->clk = clk;
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
@@ -487,7 +519,6 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	unsigned int id_value;
 	int i, ret, node = 0;
 	void __iomem *base;
-	struct clk *clk;
 	struct device_node *dn = dev->of_node, *child;
 
 	if (of_get_child_count(dn) == 0)
@@ -524,11 +555,9 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sp);
 
-	sp->clk = devm_clk_get_optional(dev, "phy_clk");
-	if (IS_ERR(sp->clk)) {
-		dev_err(dev, "failed to get clock phy_clk\n");
-		return PTR_ERR(sp->clk);
-	}
+	ret = cdns_sierra_phy_get_clocks(sp, dev);
+	if (ret)
+		return ret;
 
 	sp->phy_rst = devm_reset_control_get(dev, "sierra_reset");
 	if (IS_ERR(sp->phy_rst)) {
@@ -542,22 +571,6 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(sp->apb_rst);
 	}
 
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
-	}
-	sp->cmn_refclk1_dig_div = clk;
-
 	ret = clk_prepare_enable(sp->clk);
 	if (ret)
 		return ret;
-- 
2.17.1

