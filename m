Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769432E066F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgLVHGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:06:41 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53958 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgLVHGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:06:40 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BM75q5b064209;
        Tue, 22 Dec 2020 01:05:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608620752;
        bh=+nl8LicT//augqm13+dqzPO4Zt/8O9Pq6Zxz1AFAlx0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FCyNlspiaiecTPXXKhCqzUiTYG7F3pAupprbPJIGE8NiBpaaFn42DKOO7rZ2LzeKl
         yINXDv/qWE8EVv0O665zJqv1mCX0B1IBdWeTz8KJQrw5K73lLvCf+PV70gN7/nVBTw
         jxWgRzLjOJGF6EcKpgsi0+bdu4WIR5GVpFh/buCk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BM75qUn011420
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 01:05:52 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 01:05:52 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 01:05:52 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BM75N7G050344;
        Tue, 22 Dec 2020 01:05:48 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nishanth Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 07/14] phy: cadence: cadence-sierra: Move all reset_control_get*() to a separate function
Date:   Tue, 22 Dec 2020 12:35:13 +0530
Message-ID: <20201222070520.28132-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222070520.28132-1-kishon@ti.com>
References: <20201222070520.28132-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Group devm_reset_control_get() and
devm_reset_control_get_optional() to a separate function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 36 ++++++++++++++++--------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 7bf1b4c7774a..935f165404e4 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -509,6 +509,28 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
 	return 0;
 }
 
+static int cdns_sierra_phy_get_resets(struct cdns_sierra_phy *sp,
+				      struct device *dev)
+{
+	struct reset_control *rst;
+
+	rst = devm_reset_control_get(dev, "sierra_reset");
+	if (IS_ERR(rst)) {
+		dev_err(dev, "failed to get reset\n");
+		return PTR_ERR(rst);
+	}
+	sp->phy_rst = rst;
+
+	rst = devm_reset_control_get_optional(dev, "sierra_apb");
+	if (IS_ERR(rst)) {
+		dev_err(dev, "failed to get apb reset\n");
+		return PTR_ERR(rst);
+	}
+	sp->apb_rst = rst;
+
+	return 0;
+}
+
 static int cdns_sierra_phy_probe(struct platform_device *pdev)
 {
 	struct cdns_sierra_phy *sp;
@@ -559,17 +581,9 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
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
+	ret = cdns_sierra_phy_get_resets(sp, dev);
+	if (ret)
+		return ret;
 
 	ret = clk_prepare_enable(sp->clk);
 	if (ret)
-- 
2.17.1

