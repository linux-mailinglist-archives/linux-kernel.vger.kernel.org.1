Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC489259A99
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbgIAQvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 12:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbgIAPZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:25:59 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 904D620BED;
        Tue,  1 Sep 2020 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973959;
        bh=iZRokT/LvXKNu2UX1Yb/TKfow/L5EMf/GiV8BC/Qzd4=;
        h=From:To:Cc:Subject:Date:From;
        b=B+rmydmoDRrQML/RdSKE568dtNtwlYkX47MCkTwC1WwxV3RyIRMaMUYIQBmn426PA
         fZbb36fPUQn29OkEmMkOmoYYdWCA4abcNOWWx5vkolnzIUbSv6cshrN7mL6QufCw1R
         jSHLBjWdVwBCqvyjYreyYuG5ackDdKuVVVhLA5Cc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Han Xu <han.xu@nxp.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/6] mtd: onenand: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 16:25:30 +0200
Message-Id: <20200901142535.12819-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mtd/nand/onenand/onenand_omap2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/onenand/onenand_omap2.c b/drivers/mtd/nand/onenand/onenand_omap2.c
index aa9368bf7a0c..d8c0bd002c2b 100644
--- a/drivers/mtd/nand/onenand/onenand_omap2.c
+++ b/drivers/mtd/nand/onenand/onenand_omap2.c
@@ -494,11 +494,8 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 
 	c->int_gpiod = devm_gpiod_get_optional(dev, "int", GPIOD_IN);
 	if (IS_ERR(c->int_gpiod)) {
-		r = PTR_ERR(c->int_gpiod);
 		/* Just try again if this happens */
-		if (r != -EPROBE_DEFER)
-			dev_err(dev, "error getting gpio: %d\n", r);
-		return r;
+		return dev_err_probe(dev, PTR_ERR(c->int_gpiod), "error getting gpio\n");
 	}
 
 	if (c->int_gpiod) {
-- 
2.17.1

