Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA10626F7C9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIRIPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:15:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgIRIPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:15:25 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8AF6957B860F91DB3E72;
        Fri, 18 Sep 2020 16:15:16 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 16:15:06 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next] crypto: atmel-{aes,sha,tdes} - Use devm_platform_get_and_ioremap_resource()
Date:   Fri, 18 Sep 2020 16:14:34 +0800
Message-ID: <20200918081434.32179-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of devm_platform_get_and_ioremap_resource() provided by
driver core platform instead of duplicated analogue, dev_err() is
removed because it has been done in devm_ioremap_resource().

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/crypto/atmel-aes.c  | 16 +++++-----------
 drivers/crypto/atmel-sha.c  | 16 +++++-----------
 drivers/crypto/atmel-tdes.c | 16 +++++-----------
 3 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index a6e14491e080..7895d37319a0 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -2507,12 +2507,13 @@ static int atmel_aes_probe(struct platform_device *pdev)
 	crypto_init_queue(&aes_dd->queue, ATMEL_AES_QUEUE_LENGTH);
 
 	/* Get the base address */
-	aes_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!aes_res) {
-		dev_err(dev, "no MEM resource info\n");
-		err = -ENODEV;
+	aes_dd->io_base = devm_platform_get_and_ioremap_resource(pdev, 0,
+					&aes_res);
+	if (IS_ERR(aes_dd->io_base)) {
+		err = PTR_ERR(aes_dd->io_base);
 		goto err_tasklet_kill;
 	}
+
 	aes_dd->phys_base = aes_res->start;
 
 	/* Get the IRQ */
@@ -2537,13 +2538,6 @@ static int atmel_aes_probe(struct platform_device *pdev)
 		goto err_tasklet_kill;
 	}
 
-	aes_dd->io_base = devm_ioremap_resource(&pdev->dev, aes_res);
-	if (IS_ERR(aes_dd->io_base)) {
-		dev_err(dev, "can't ioremap\n");
-		err = PTR_ERR(aes_dd->io_base);
-		goto err_tasklet_kill;
-	}
-
 	err = clk_prepare(aes_dd->iclk);
 	if (err)
 		goto err_tasklet_kill;
diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 75ccf41a7cb9..d7233311d836 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -2578,12 +2578,13 @@ static int atmel_sha_probe(struct platform_device *pdev)
 	crypto_init_queue(&sha_dd->queue, ATMEL_SHA_QUEUE_LENGTH);
 
 	/* Get the base address */
-	sha_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!sha_res) {
-		dev_err(dev, "no MEM resource info\n");
-		err = -ENODEV;
+	sha_dd->io_base = devm_platform_get_and_ioremap_resource(pdev, 0,
+					&sha_res);
+	if (IS_ERR(sha_dd->io_base)) {
+		err = PTR_ERR(sha_dd->io_base);
 		goto err_tasklet_kill;
 	}
+
 	sha_dd->phys_base = sha_res->start;
 
 	/* Get the IRQ */
@@ -2608,13 +2609,6 @@ static int atmel_sha_probe(struct platform_device *pdev)
 		goto err_tasklet_kill;
 	}
 
-	sha_dd->io_base = devm_ioremap_resource(&pdev->dev, sha_res);
-	if (IS_ERR(sha_dd->io_base)) {
-		dev_err(dev, "can't ioremap\n");
-		err = PTR_ERR(sha_dd->io_base);
-		goto err_tasklet_kill;
-	}
-
 	err = clk_prepare(sha_dd->iclk);
 	if (err)
 		goto err_tasklet_kill;
diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index ed40dbb98c6b..5b894cb80490 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -1185,12 +1185,13 @@ static int atmel_tdes_probe(struct platform_device *pdev)
 	crypto_init_queue(&tdes_dd->queue, ATMEL_TDES_QUEUE_LENGTH);
 
 	/* Get the base address */
-	tdes_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!tdes_res) {
-		dev_err(dev, "no MEM resource info\n");
-		err = -ENODEV;
+	tdes_dd->io_base = devm_platform_get_and_ioremap_resource(pdev, 0,
+					&tdes_res);
+	if (IS_ERR(tdes_dd->io_base)) {
+		err = PTR_ERR(tdes_dd->io_base);
 		goto err_tasklet_kill;
 	}
+
 	tdes_dd->phys_base = tdes_res->start;
 
 	/* Get the IRQ */
@@ -1215,13 +1216,6 @@ static int atmel_tdes_probe(struct platform_device *pdev)
 		goto err_tasklet_kill;
 	}
 
-	tdes_dd->io_base = devm_ioremap_resource(&pdev->dev, tdes_res);
-	if (IS_ERR(tdes_dd->io_base)) {
-		dev_err(dev, "can't ioremap\n");
-		err = PTR_ERR(tdes_dd->io_base);
-		goto err_tasklet_kill;
-	}
-
 	err = atmel_tdes_hw_version_init(tdes_dd);
 	if (err)
 		goto err_tasklet_kill;
-- 
2.17.1

