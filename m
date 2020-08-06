Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9139D23D740
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 09:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgHFH0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 03:26:40 -0400
Received: from mail.ispras.ru ([83.149.199.84]:50820 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgHFH0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 03:26:38 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPS id E051740D4004;
        Thu,  6 Aug 2020 07:26:35 +0000 (UTC)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Aditya Pakki <pakki001@umn.edu>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] mtd: rawnand: vf610: disable clk on error handling path in probe
Date:   Thu,  6 Aug 2020 10:26:34 +0300
Message-Id: <20200806072634.23528-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vf610_nfc_probe() does not invoke clk_disable_unprepare() on one error
handling path. The patch fixes that.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 6f0ce4dfc5a3 ("mtd: rawnand: vf610: Avoid a potential NULL pointer dereference")
Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/mtd/nand/raw/vf610_nfc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 7248c5901183..fcca45e2abe2 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -852,8 +852,10 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 	}
 
 	of_id = of_match_device(vf610_nfc_dt_ids, &pdev->dev);
-	if (!of_id)
-		return -ENODEV;
+	if (!of_id) {
+		err = -ENODEV;
+		goto err_disable_clk;
+	}
 
 	nfc->variant = (enum vf610_nfc_variant)of_id->data;
 
-- 
2.26.2

