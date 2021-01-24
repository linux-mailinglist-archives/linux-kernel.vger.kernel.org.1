Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C30B301A54
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 08:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbhAXHlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 02:41:44 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:54747 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbhAXHlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 02:41:42 -0500
Received: from localhost.localdomain ([92.131.99.25])
        by mwinf5d58 with ME
        id LXfx2400C0Ys01Y03XfyzX; Sun, 24 Jan 2021 08:40:00 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 24 Jan 2021 08:40:00 +0100
X-ME-IP: 92.131.99.25
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mtd: rawnand: Fix an error handling path in 'ebu_dma_start()'
Date:   Sun, 24 Jan 2021 08:39:55 +0100
Message-Id: <20210124073955.728797-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'dmaengine_prep_slave_single()' fails, we must undo a previous
'dma_map_single()' call, as already done in all the other error handling
paths of this function.

Fixes: 0b1039f016e8 ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index a304fda5d1fa..8b49fd56cf96 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -318,8 +318,10 @@ static int ebu_dma_start(struct ebu_nand_controller *ebu_host, u32 dir,
 	}
 
 	tx = dmaengine_prep_slave_single(chan, buf_dma, len, dir, flags);
-	if (!tx)
-		return -ENXIO;
+	if (!tx) {
+		ret = -ENXIO;
+		goto err_unmap;
+	}
 
 	tx->callback = callback;
 	tx->callback_param = ebu_host;
-- 
2.27.0

