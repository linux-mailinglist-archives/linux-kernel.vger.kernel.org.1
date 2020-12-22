Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C12E066C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgLVHGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:06:33 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53900 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgLVHGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:06:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BM75j9t064152;
        Tue, 22 Dec 2020 01:05:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608620745;
        bh=VxF8kGigCKqkh77tBFluIHDcpsujh9oOUvSPK2P6qiw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RLlwWNvRkf1IPPSBFf7xqnQZC1ZMudC+O9gjmx06EtgwguWYUsqUtOGiAPfxHo+JF
         fuMoOXCMLsMx7fOQ9OrXLiQv5rNnLgR0w9i+jRnOVooyj0M/JoG1a1dpGLQnRZJBBs
         66wsbwZdSccm7V1vSRCIF2k2l4sKRaq6eigUZZvA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BM75jZ3014866
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 01:05:45 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 01:05:44 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 01:05:44 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BM75N7E050344;
        Tue, 22 Dec 2020 01:05:41 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nishanth Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 05/14] phy: cadence: cadence-sierra: Create PHY only for "phy" or "link" sub-nodes
Date:   Tue, 22 Dec 2020 12:35:11 +0530
Message-ID: <20201222070520.28132-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222070520.28132-1-kishon@ti.com>
References: <20201222070520.28132-1-kishon@ti.com>
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

