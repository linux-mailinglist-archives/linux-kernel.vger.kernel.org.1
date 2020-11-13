Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B66B2B1FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgKMQNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:13:18 -0500
Received: from mail.ispras.ru ([83.149.199.84]:50100 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgKMQNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:13:18 -0500
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Nov 2020 11:13:17 EST
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id 327B040A1DDF;
        Fri, 13 Nov 2020 16:05:41 +0000 (UTC)
From:   Baskov Evgeiny <baskov@ispras.ru>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Baskov Evgeiny <baskov@ispras.ru>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] mtd-ram: correctly free memory on error path in platram_probe()
Date:   Fri, 13 Nov 2020 19:05:37 +0300
Message-Id: <20201113160537.899-1-baskov@ispras.ru>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error happens in mtd_device_parse_register or mtd_device_register,
memory allocated for struct platram_info is leaked.

Make platram_probe() call platram_remove() on all error paths
after struct platram_info allocation to correctly free resources.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Baskov Evgeiny <baskov@ispras.ru>
---
 drivers/mtd/maps/plat-ram.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/maps/plat-ram.c b/drivers/mtd/maps/plat-ram.c
index 311742c78155..0bec7c791d17 100644
--- a/drivers/mtd/maps/plat-ram.c
+++ b/drivers/mtd/maps/plat-ram.c
@@ -177,8 +177,12 @@ static int platram_probe(struct platform_device *pdev)
 	err = mtd_device_parse_register(info->mtd, pdata->probes, NULL,
 					pdata->partitions,
 					pdata->nr_partitions);
-	if (!err)
-		dev_info(&pdev->dev, "registered mtd device\n");
+	if (err) {
+		dev_err(&pdev->dev, "failed to register mtd device\n");
+		goto exit_free;
+	}
+
+	dev_info(&pdev->dev, "registered mtd device\n");
 
 	if (pdata->nr_partitions) {
 		/* add the whole device. */
@@ -186,10 +190,11 @@ static int platram_probe(struct platform_device *pdev)
 		if (err) {
 			dev_err(&pdev->dev,
 				"failed to register the entire device\n");
+			goto exit_free;
 		}
 	}
 
-	return err;
+	return 0;
 
  exit_free:
 	platram_remove(pdev);
-- 
2.29.2

