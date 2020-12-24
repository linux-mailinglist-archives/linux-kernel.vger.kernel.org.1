Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E172E2626
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgLXLRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:17:47 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35612 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLXLRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:17:46 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBH0Tp076156;
        Thu, 24 Dec 2020 05:17:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608808620;
        bh=FjCTHLq/sEj9KXmxRwSejCjWFaAdBEX/mJW7iTNR8qs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=X3+dSNCPUoYrOSo+cUtMslyKIXOcB/rqFWb59dEjOAR7Y25Q7KVS5t0yeMy59nyne
         bwDSu9xokFEVMA2Ufysi8vq1FZ618JK0q0bQdgdlfJD9sMWThMZBQJPq9xq0lALIot
         xX+xhTLTOjbbAdTlv4THcPCNSk1gBIiRAIW4ubs4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBH0V5093262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:17:00 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:16:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:16:59 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBGWGA116630;
        Thu, 24 Dec 2020 05:16:55 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 04/15] phy: ti: j721e-wiz: Get PHY properties only for "phy" or "link" subnode
Date:   Thu, 24 Dec 2020 16:46:16 +0530
Message-ID: <20201224111627.32590-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224111627.32590-1-kishon@ti.com>
References: <20201224111627.32590-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"serdes" node (child node of WIZ) can have sub-nodes for representing links
or it can have sub-nodes for representing the various clocks within the
serdes. Instead of trying to read "reg" from every child node used for
assigning "lane_phy_type", read only if the child node's name is "phy"
or "link" subnode.
Ideally all PHY dt nodes should have node name as "phy", however
existing devicetree used "link" as subnode. So in order to maintain old
DT compatibility get PHY properties for "phy" or "link" subnode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index a75433b459dd..2a03191eac64 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -787,6 +787,10 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
 		u32 reg, num_lanes = 1, phy_type = PHY_NONE;
 		int ret, i;
 
+		if (!(of_node_name_eq(subnode, "phy") ||
+		      of_node_name_eq(subnode, "link")))
+			continue;
+
 		ret = of_property_read_u32(subnode, "reg", &reg);
 		if (ret) {
 			dev_err(dev,
-- 
2.17.1

