Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF42E0688
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgLVHHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:07:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54062 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLVHHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:07:08 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BM763o4064278;
        Tue, 22 Dec 2020 01:06:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608620763;
        bh=vQYJz6q3QwL2K0Sik8ruQUMB1sjj3ErMTyA3nnEGtE0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gJo3j3MDLLrFUJMtlQxO+dcRmmFN0ZE8FTm2sEsH7VVHt/JgptyGuJ0+v7XbLOxV/
         GezppDkKvC6EPwEVKcFsN9aBZUql7OP9ZHe9yImAdCuQHYEfhhrNsYZMIEsTbtyPtW
         Kv8AzYf2oq++DLtSWXbooV1kXuY2URlLddnMZ1rk=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BM7633W032169
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 01:06:03 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 01:06:02 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 01:06:02 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BM75N7J050344;
        Tue, 22 Dec 2020 01:05:59 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nishanth Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 10/14] phy: cadence: sierra: Enable pll_cmnlc and pll_cmnlc1 clocks
Date:   Tue, 22 Dec 2020 12:35:16 +0530
Message-ID: <20201222070520.28132-11-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222070520.28132-1-kishon@ti.com>
References: <20201222070520.28132-1-kishon@ti.com>
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
 drivers/phy/cadence/phy-cadence-sierra.c | 56 +++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 2a509be80c80..553971683f2d 100644
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
-- 
2.17.1

