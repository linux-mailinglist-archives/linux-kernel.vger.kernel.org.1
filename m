Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641E92FE68A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbhAUJkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:40:23 -0500
Received: from m12-17.163.com ([220.181.12.17]:50367 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbhAUJjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=LcPAqHxUl72bUh++s/
        JaCuY9FecmEkxLra2ChECTzy8=; b=jV5R1Z7YTjED/uiqTKAEe+MEhWS3H1hPAe
        rfeFA3ct7btWUh6VAj4Eg4LnO8L+hGSN+HTV5d4tWkowd2y66dE5P0mx1cDPRu8F
        9Jygm/kAaUZRLCOX4D83f4gPXSQF+lbgLJQuWB53dwN6puYryLTKmMvSab1x4qdO
        FQWZAs2Lw=
Received: from localhost.localdomain (unknown [119.3.119.20])
        by smtp13 (Coremail) with SMTP id EcCowABXXZ38RglgC3Gogw--.2681S4;
        Thu, 21 Jan 2021 17:18:56 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] mtd: spi-nor: hisi-sfc: Put child node np on error path
Date:   Thu, 21 Jan 2021 01:18:47 -0800
Message-Id: <20210121091847.85362-1-bianpan2016@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EcCowABXXZ38RglgC3Gogw--.2681S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1xJw48uFyxKr4kWw1rJFb_yoWfWrcE9F
        4xuFyxZrs2kF4rKwnFkw18uryYka1FgryfCa1SyF9xt3y7WrnYga4DZrW5Zwn8Ar42yryD
        uw4qvryxCr47CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj-6pJUUUUU==
X-Originating-IP: [119.3.119.20]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiDgAhclXly8wsIwAAsl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the child node np when it fails to get or register device.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/mtd/spi-nor/controllers/hisi-sfc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/controllers/hisi-sfc.c b/drivers/mtd/spi-nor/controllers/hisi-sfc.c
index 7c26f8f565cb..47fbf1d1e557 100644
--- a/drivers/mtd/spi-nor/controllers/hisi-sfc.c
+++ b/drivers/mtd/spi-nor/controllers/hisi-sfc.c
@@ -399,8 +399,10 @@ static int hisi_spi_nor_register_all(struct hifmc_host *host)
 
 	for_each_available_child_of_node(dev->of_node, np) {
 		ret = hisi_spi_nor_register(np, host);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			goto fail;
+		}
 
 		if (host->num_chip == HIFMC_MAX_CHIP_NUM) {
 			dev_warn(dev, "Flash device number exceeds the maximum chipselect number\n");
-- 
2.17.1


