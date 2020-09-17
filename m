Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D0C26D7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgIQJdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:33:02 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49698 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIQJc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:32:57 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08H7mOEw098051;
        Thu, 17 Sep 2020 02:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600328904;
        bh=XUWlwYnEa2/3Aqan6ilt7Si/rPK+fDEzdyGLCe7s26s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XfVFDzffOZH+snsOjD7l30rhEKKlaWkQe+vP9JTPKsrN4oJGGx9RYZzs6jKALZTbm
         T0CAPjJWaUFqZJjV28Yok/6HEaG3nygfk6zWCc9Aiyv8Jh3AmlsosBv7CKSwsikuND
         zRQymHVKRpvLF87NLuxW0wPHWMC1UWBs3v/9u4GA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08H7mOQl102335
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 02:48:24 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 02:48:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 02:48:24 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08H7mEdu100359;
        Thu, 17 Sep 2020 02:48:22 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] mtd: hyperbus: hbmc-am654: Drop pm_runtime* calls from probe
Date:   Thu, 17 Sep 2020 13:17:48 +0530
Message-ID: <20200917074749.8957-4-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917074749.8957-1-vigneshr@ti.com>
References: <20200917074749.8957-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent genpd changes for K3 platform ensure device is ON before driver
probe is called. Therefore, drop redundant pm_runtime_* calls from
driver to simplify the code.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/hyperbus/hbmc-am654.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/hyperbus/hbmc-am654.c b/drivers/mtd/hyperbus/hbmc-am654.c
index 1e70ecfffa39..b6a2400fcaa9 100644
--- a/drivers/mtd/hyperbus/hbmc-am654.c
+++ b/drivers/mtd/hyperbus/hbmc-am654.c
@@ -13,7 +13,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/types.h>
 
 #define AM654_HBMC_CALIB_COUNT 25
@@ -89,13 +88,6 @@ static int am654_hbmc_probe(struct platform_device *pdev)
 		priv->mux_ctrl = control;
 	}
 
-	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
-		goto disable_pm;
-	}
-
 	priv->hbdev.map.size = resource_size(&res);
 	priv->hbdev.map.virt = devm_ioremap_resource(dev, &res);
 	if (IS_ERR(priv->hbdev.map.virt))
@@ -107,13 +99,11 @@ static int am654_hbmc_probe(struct platform_device *pdev)
 	ret = hyperbus_register_device(&priv->hbdev);
 	if (ret) {
 		dev_err(dev, "failed to register controller\n");
-		pm_runtime_put_sync(&pdev->dev);
-		goto disable_pm;
+		goto disable_mux;
 	}
 
 	return 0;
-disable_pm:
-	pm_runtime_disable(dev);
+disable_mux:
 	if (priv->mux_ctrl)
 		mux_control_deselect(priv->mux_ctrl);
 	return ret;
@@ -127,8 +117,6 @@ static int am654_hbmc_remove(struct platform_device *pdev)
 	ret = hyperbus_unregister_device(&priv->hbdev);
 	if (priv->mux_ctrl)
 		mux_control_deselect(priv->mux_ctrl);
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
-- 
2.28.0

