Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270AA259A92
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 18:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbgIAQvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 12:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729878AbgIAP0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:26:08 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75FA721534;
        Tue,  1 Sep 2020 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973967;
        bh=ovBGAei74FK31o+QhuioieTu3Pt4iRVAUaBnNVTmqlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENsm4EAunS7F0nL8ERbt7m49X1AAhazZmdqrJAKGLhvfbXPue8ndX2hBMLaTjLddr
         DmNx5oAebQp59W9Zg44YMxdwAcVh5LGaBsdLueaRUhFM/hO7SEafKAf8kidMDoJVio
         dZwoZdKnJbXdfU1g2oqZx4K/Md9MaPV0A4wVAPX8=
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
Subject: [PATCH 3/6] mtd: rawnand: gpmi: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 16:25:32 +0200
Message-Id: <20200901142535.12819-3-krzk@kernel.org>
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
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 5d4aee46cc55..3d8fe0d0721f 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1003,10 +1003,8 @@ static int acquire_dma_channels(struct gpmi_nand_data *this)
 	/* request dma channel */
 	dma_chan = dma_request_chan(&pdev->dev, "rx-tx");
 	if (IS_ERR(dma_chan)) {
-		ret = PTR_ERR(dma_chan);
-		if (ret != -EPROBE_DEFER)
-			dev_err(this->dev, "DMA channel request failed: %d\n",
-				ret);
+		ret = dev_err_probe(this->dev, PTR_ERR(dma_chan),
+				    "DMA channel request failed\n");
 		release_dma_channels(this);
 	} else {
 		this->dma_chans[0] = dma_chan;
-- 
2.17.1

