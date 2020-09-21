Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F152718F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 03:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgIUBPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 21:15:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbgIUBPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 21:15:53 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7E009BE0CB2D04959471;
        Mon, 21 Sep 2020 09:15:51 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 09:15:40 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>
Subject: [PATCH -next] mtd: rawnand: remove redundant dev_err call in cadence_nand_dt_probe
Date:   Mon, 21 Sep 2020 09:38:05 +0800
Message-ID: <20200921013805.1724606-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index db29e5e512df..b46786cd53e0 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -2980,18 +2980,14 @@ static int cadence_nand_dt_probe(struct platform_device *ofdev)
 	dev_info(cdns_ctrl->dev, "IRQ: nr %d\n", cdns_ctrl->irq);
 
 	cdns_ctrl->reg = devm_platform_ioremap_resource(ofdev, 0);
-	if (IS_ERR(cdns_ctrl->reg)) {
-		dev_err(&ofdev->dev, "devm_ioremap_resource res 0 failed\n");
+	if (IS_ERR(cdns_ctrl->reg))
 		return PTR_ERR(cdns_ctrl->reg);
-	}
 
 	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
 	cdns_ctrl->io.dma = res->start;
 	cdns_ctrl->io.virt = devm_ioremap_resource(&ofdev->dev, res);
-	if (IS_ERR(cdns_ctrl->io.virt)) {
-		dev_err(cdns_ctrl->dev, "devm_ioremap_resource res 1 failed\n");
+	if (IS_ERR(cdns_ctrl->io.virt))
 		return PTR_ERR(cdns_ctrl->io.virt);
-	}
 
 	dt->clk = devm_clk_get(cdns_ctrl->dev, "nf_clk");
 	if (IS_ERR(dt->clk))
-- 
2.25.1

