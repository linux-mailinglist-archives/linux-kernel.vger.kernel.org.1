Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C33A2A3B31
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgKCD41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:56:27 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41834 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgKCD4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:56:25 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A33uICH034032;
        Mon, 2 Nov 2020 21:56:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604375778;
        bh=ietypxVfSkAgchVIF6msMfozYmCMk6Fw9P27DKZM/7o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eBplhuu5EJl0zUFolYW3wW4eAzN8xDGqd5IBXXVR/5EQotYEjcguYAmOtzBkkaF//
         kruAyFKh22i/OyhizN0cJ0x4IOmfj0MQeQcYt81fYiL1WeSuhibp9HsD7PSrkGLCKt
         BjzOzkyDlpghulw8w87u7fBiLGaK5nLnksn02fQQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A33uI6V031528
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 21:56:18 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 21:56:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 21:56:11 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A33tuqO101157;
        Mon, 2 Nov 2020 21:56:08 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 3/9] phy: ti: j721e-wiz: Don't configure wiz if its already configured
Date:   Tue, 3 Nov 2020 09:25:50 +0530
Message-ID: <20201103035556.21260-4-kishon@ti.com>
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

To handle this case, skip all configuration if any of the lanes has
already been enabled.

While we are here, also fix the wiz_init() to be called before the
of_platform_device_create() call.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 36 +++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index d57d29382ce4..9786e8aec252 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -816,13 +816,14 @@ static int wiz_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct platform_device *serdes_pdev;
+	bool already_configured = false;
 	struct device_node *child_node;
 	struct regmap *regmap;
 	struct resource res;
 	void __iomem *base;
 	struct wiz *wiz;
 	u32 num_lanes;
-	int ret;
+	int ret, val, i;
 
 	wiz = devm_kzalloc(dev, sizeof(*wiz), GFP_KERNEL);
 	if (!wiz)
@@ -944,10 +945,26 @@ static int wiz_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	ret = wiz_clock_init(wiz, node);
-	if (ret < 0) {
-		dev_warn(dev, "Failed to initialize clocks\n");
-		goto err_get_sync;
+	for (i = 0; i < wiz->num_lanes; i++) {
+		regmap_field_read(wiz->p_enable[i], &val);
+		if (val & (P_ENABLE | P_ENABLE_FORCE)) {
+			already_configured = true;
+			break;
+		}
+	}
+
+	if (!already_configured) {
+		ret = wiz_clock_init(wiz, node);
+		if (ret < 0) {
+			dev_warn(dev, "Failed to initialize clocks\n");
+			goto err_get_sync;
+		}
+
+		ret = wiz_init(wiz);
+		if (ret) {
+			dev_err(dev, "WIZ initialization failed\n");
+			goto err_pdev_create;
+		}
 	}
 
 	serdes_pdev = of_platform_device_create(child_node, NULL, dev);
@@ -958,18 +975,9 @@ static int wiz_probe(struct platform_device *pdev)
 	}
 	wiz->serdes_pdev = serdes_pdev;
 
-	ret = wiz_init(wiz);
-	if (ret) {
-		dev_err(dev, "WIZ initialization failed\n");
-		goto err_wiz_init;
-	}
-
 	of_node_put(child_node);
 	return 0;
 
-err_wiz_init:
-	of_platform_device_destroy(&serdes_pdev->dev, NULL);
-
 err_pdev_create:
 	wiz_clock_cleanup(wiz, node);
 
-- 
2.17.1

