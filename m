Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811A02A3B39
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgKCD4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:56:48 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41962 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgKCD4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:56:46 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A33uYcM034258;
        Mon, 2 Nov 2020 21:56:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604375794;
        bh=AXhNXHOr+VyAniFYjJswkrsFdoNebi4aG14xbbJAakk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=g4q4T+bDoSUdK4QUV7Msjd92MYE95Gn7Z+zvl3vAzjfxREdoQ2/hCFivmXn7ZuKt8
         lnlVFC/TV6Zqf1zbBs5rMBUwgAvtv8In9JSRw2+hx22JFKjNSNdc8U47PqZd3J+4WT
         E2buGaBwAogE6qaBCe8RVYyLylY3cfD3qIwFGvGM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A33uYTk091062
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 21:56:34 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 21:56:34 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 21:56:34 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A33tuqU101157;
        Mon, 2 Nov 2020 21:56:31 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 9/9] phy: cadence: sierra: Enable pll_cmnlc and pll_cmnlc1 clocks
Date:   Tue, 3 Nov 2020 09:25:56 +0530
Message-ID: <20201103035556.21260-10-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103035556.21260-1-kishon@ti.com>
References: <20201103035556.21260-1-kishon@ti.com>
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
 drivers/phy/cadence/phy-cadence-sierra.c | 39 +++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index c4751fe9edfd..94fd9ce4223e 100644
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
@@ -847,6 +849,41 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
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
+	return 0;
+}
+
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
+		return ret;
+
+	ret = clk_prepare_enable(sp->pll_cmnlc1);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -920,7 +957,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
-		ret = clk_prepare_enable(sp->clk);
+		ret = cdns_sierra_phy_enable_clocks(sp);
 		if (ret)
 			return ret;
 
-- 
2.17.1

