Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDC02A3B2E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgKCD4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:56:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39526 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgKCD4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:56:22 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A33uFx5023685;
        Mon, 2 Nov 2020 21:56:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604375775;
        bh=eMj8XstivoruLPX0OnPBgk0XuR0TBVAsG5hVa9Q7tIA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BsnbF3G1zRX1dgqBObs0+in5CdLIkDvhAxc5VKnOAnXuoQpxgUuC8ttTZdZYWwhxz
         51f4H5CMcM77NNrQhzZAE0fl/v0pcVN43BExw3BVx2uyzW6h+jj6czA/0CmOPavEoy
         oMUE1t/IMrRDy3xvVeCeQuPzngsVpvJOIKXKEsig=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A33uFLM126296
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 21:56:15 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 21:56:15 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 21:56:15 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A33tuqP101157;
        Mon, 2 Nov 2020 21:56:12 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 4/9] phy: cadence: cadence-sierra: Create PHY only for "phy" sub-nodes
Date:   Tue, 3 Nov 2020 09:25:51 +0530
Message-ID: <20201103035556.21260-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103035556.21260-1-kishon@ti.com>
References: <20201103035556.21260-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence Sierra PHY driver registers PHY using devm_phy_create()
for all sub-nodes of Sierra device tree node. However Sierra device
tree node can have sub-nodes for the various clocks in addtion to the
PHY. Use devm_phy_create() only for nodes with name "phy" which
represent the actual PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 453ef26fa1c7..4429f41a8f58 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -573,6 +573,9 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(dn, child) {
 		struct phy *gphy;
 
+		if (!(of_node_name_eq(child, "phy")))
+			continue;
+
 		sp->phys[node].lnk_rst =
 			of_reset_control_array_get_exclusive(child);
 
-- 
2.17.1

