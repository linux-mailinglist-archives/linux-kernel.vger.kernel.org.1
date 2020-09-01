Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D58259A88
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 18:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbgIAQuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 12:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730093AbgIAP0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:26:14 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858AE2158C;
        Tue,  1 Sep 2020 15:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973970;
        bh=Ji7tBqTrt9Gluqit0pT2CuNHp+ScPqperCb3R3BIM60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RxTTonRRtLwSkZCojYHmzzpAAVAqDBa5NITg4LvridMsSkn+D0UJegHD4Xqjw3Es0
         RUDJINkCENGy34CQ8DPBCcghDuYxaxWZxVVj/X2U0SLs+6KyW4O/Byvpfmikw8VxNi
         QL5OqU8TUQjBmHyVODbOiRDnCNS80pr1bBiFoZBQ=
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
Subject: [PATCH 4/6] mtd: rawnand: marvell: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 16:25:33 +0200
Message-Id: <20200901142535.12819-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901142535.12819-1-krzk@kernel.org>
References: <20200901142535.12819-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mtd/nand/raw/marvell_nand.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 8482d3bd8b1f..52cb7da2fc02 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2759,10 +2759,7 @@ static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
 	if (IS_ERR(nfc->dma_chan)) {
 		ret = PTR_ERR(nfc->dma_chan);
 		nfc->dma_chan = NULL;
-		if (ret != -EPROBE_DEFER)
-			dev_err(nfc->dev, "DMA channel request failed: %d\n",
-				ret);
-		return ret;
+		return dev_err_probe(nfc->dev, ret, "DMA channel request failed\n");
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.17.1

