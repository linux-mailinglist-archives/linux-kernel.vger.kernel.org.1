Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6F226C9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgIPTmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:42:23 -0400
Received: from mail.ispras.ru ([83.149.199.84]:42006 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbgIPTlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:41:17 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPS id 0F47A40D403E;
        Wed, 16 Sep 2020 19:41:10 +0000 (UTC)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] mtd: rawnand: mtk: avoid underflow in mtk_nfc_nand_chip_init()
Date:   Wed, 16 Sep 2020 22:40:45 +0300
Message-Id: <20200916194045.6378-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If of_get_property() will set nsels to negative values the driver may
allocate insufficient memory for chip. Moreover, there may be underflow
for devm_kzalloc(). This can result in various bad consequences later.
The patch causes mtk_nfc_nand_chip_init() to fail for negative values of
nsels.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/mtd/nand/raw/mtk_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index ad1b55dab211..df98a2eec240 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1376,7 +1376,7 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 		return -ENODEV;
 
 	nsels /= sizeof(u32);
-	if (!nsels || nsels > MTK_NAND_MAX_NSELS) {
+	if (nsels <= 0 || nsels > MTK_NAND_MAX_NSELS) {
 		dev_err(dev, "invalid reg property size %d\n", nsels);
 		return -EINVAL;
 	}
-- 
2.26.2

