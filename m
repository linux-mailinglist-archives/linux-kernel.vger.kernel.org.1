Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEB7276B85
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbgIXIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:12:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57668 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbgIXIMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:12:37 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08O8CNNF072450;
        Thu, 24 Sep 2020 03:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600935143;
        bh=SHgXttKECBGQDR9ohxlLnwKQKV//DVB9akw0KXwlW2U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hbitq+eke6rDa6We7VOfsnFO3SOcuHSwp/QJJ79/m7eZUkJnc06VnR1YpQkZ5ESLc
         hbVUUOlItAmx3A1tFaXqpDZizECxtAQKTqpMITyQQziaM5fDbeFLaqDdeFnJV1ESma
         +MWOp4/oVtDwGsmDI6Oiwxu89ZAelG2ogF9uPkuc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08O8CNpd082961
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 03:12:23 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 03:12:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 03:12:23 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08O8CFFJ002000;
        Thu, 24 Sep 2020 03:12:21 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/4] mtd: hyperbus: hbmc-am654: Fix direct mapping setup flash access
Date:   Thu, 24 Sep 2020 13:42:12 +0530
Message-ID: <20200924081214.16934-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924081214.16934-1-vigneshr@ti.com>
References: <20200924081214.16934-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting up of direct mapping should be done with flash node's IO
address space and not with controller's IO region.

Fixes: b6fe8bc67d2d3 ("mtd: hyperbus: move direct mapping setup to AM654 HBMC driver")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/hyperbus/hbmc-am654.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/hyperbus/hbmc-am654.c b/drivers/mtd/hyperbus/hbmc-am654.c
index e0e33f6bf513..1e70ecfffa39 100644
--- a/drivers/mtd/hyperbus/hbmc-am654.c
+++ b/drivers/mtd/hyperbus/hbmc-am654.c
@@ -70,7 +70,8 @@ static int am654_hbmc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	ret = of_address_to_resource(np, 0, &res);
+	priv->hbdev.np = of_get_next_child(np, NULL);
+	ret = of_address_to_resource(priv->hbdev.np, 0, &res);
 	if (ret)
 		return ret;
 
@@ -103,7 +104,6 @@ static int am654_hbmc_probe(struct platform_device *pdev)
 	priv->ctlr.dev = dev;
 	priv->ctlr.ops = &am654_hbmc_ops;
 	priv->hbdev.ctlr = &priv->ctlr;
-	priv->hbdev.np = of_get_next_child(dev->of_node, NULL);
 	ret = hyperbus_register_device(&priv->hbdev);
 	if (ret) {
 		dev_err(dev, "failed to register controller\n");
-- 
2.28.0

