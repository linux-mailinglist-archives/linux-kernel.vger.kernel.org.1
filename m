Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2BB2E2629
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgLXLRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:17:52 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37748 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLXLRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:17:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBH5Ew041788;
        Thu, 24 Dec 2020 05:17:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608808625;
        bh=VxF8kGigCKqkh77tBFluIHDcpsujh9oOUvSPK2P6qiw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BS6JwMZO19mJkwysTfsduFTm/cj4ckpewYhxavid51HFwrX/1z1LyIYgH4QvqtwC1
         LPduf46Ml1/oBh6OIubYSP/xtwENJ+rsQY/xUXM8t+UHrMPWoPCYVe24hY3eED+u4T
         gaHyGG8c7BIbr5Kp2F4ybYRlZ/1MOJjjUpZn8DPI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBH5G7060608
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:17:05 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:17:04 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:17:04 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBGWGB116630;
        Thu, 24 Dec 2020 05:17:00 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 05/15] phy: cadence: cadence-sierra: Create PHY only for "phy" or "link" sub-nodes
Date:   Thu, 24 Dec 2020 16:46:17 +0530
Message-ID: <20201224111627.32590-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224111627.32590-1-kishon@ti.com>
References: <20201224111627.32590-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence Sierra PHY driver registers PHY using devm_phy_create()
for all sub-nodes of Sierra device tree node. However Sierra device
tree node can have sub-nodes for the various clocks in addtion to the
PHY. Use devm_phy_create() only for nodes with name "phy" (or "link"
for old device tree) which represent the actual PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 19f32ae877b9..f7ba0ed416bc 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -577,6 +577,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(dn, child) {
 		struct phy *gphy;
 
+		if (!(of_node_name_eq(child, "phy") ||
+		      of_node_name_eq(child, "link")))
+			continue;
+
 		sp->phys[node].lnk_rst =
 			of_reset_control_array_get_exclusive(child);
 
-- 
2.17.1

