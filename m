Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EBC2FCBD8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbhATHlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:41:21 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:59490 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728982AbhATHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:40:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UMJDD5N_1611128379;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMJDD5N_1611128379)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Jan 2021 15:39:42 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     ludovic.desroches@microchip.com
Cc:     ulf.hansson@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] mmc: Assign boolean values to a bool variable
Date:   Wed, 20 Jan 2021 15:39:37 +0800
Message-Id: <1611128377-66216-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/mmc/host/atmel-mci.c:2436:2-34: WARNING: Assignment
of 0/1 to bool variable.

./drivers/mmc/host/atmel-mci.c:2425:2-20: WARNING: Assignment
of 0/1 to bool variable.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 drivers/mmc/host/atmel-mci.c | 46 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 444bd3a..6324120 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2401,45 +2401,45 @@ static void atmci_get_cap(struct atmel_mci *host)
 	dev_info(&host->pdev->dev,
 			"version: 0x%x\n", version);
 
-	host->caps.has_dma_conf_reg = 0;
-	host->caps.has_pdc = 1;
-	host->caps.has_cfg_reg = 0;
-	host->caps.has_cstor_reg = 0;
-	host->caps.has_highspeed = 0;
-	host->caps.has_rwproof = 0;
-	host->caps.has_odd_clk_div = 0;
-	host->caps.has_bad_data_ordering = 1;
-	host->caps.need_reset_after_xfer = 1;
-	host->caps.need_blksz_mul_4 = 1;
-	host->caps.need_notbusy_for_read_ops = 0;
+	host->caps.has_dma_conf_reg = false;
+	host->caps.has_pdc = true;
+	host->caps.has_cfg_reg = false;
+	host->caps.has_cstor_reg = false;
+	host->caps.has_highspeed = false;
+	host->caps.has_rwproof = false;
+	host->caps.has_odd_clk_div = false;
+	host->caps.has_bad_data_ordering = true;
+	host->caps.need_reset_after_xfer = true;
+	host->caps.need_blksz_mul_4 = true;
+	host->caps.need_notbusy_for_read_ops = false;
 
 	/* keep only major version number */
 	switch (version & 0xf00) {
 	case 0x600:
 	case 0x500:
-		host->caps.has_odd_clk_div = 1;
+		host->caps.has_odd_clk_div = true;
 		fallthrough;
 	case 0x400:
 	case 0x300:
-		host->caps.has_dma_conf_reg = 1;
-		host->caps.has_pdc = 0;
-		host->caps.has_cfg_reg = 1;
-		host->caps.has_cstor_reg = 1;
-		host->caps.has_highspeed = 1;
+		host->caps.has_dma_conf_reg = true;
+		host->caps.has_pdc = false;
+		host->caps.has_cfg_reg = true;
+		host->caps.has_cstor_reg = true;
+		host->caps.has_highspeed = true;
 		fallthrough;
 	case 0x200:
-		host->caps.has_rwproof = 1;
-		host->caps.need_blksz_mul_4 = 0;
-		host->caps.need_notbusy_for_read_ops = 1;
+		host->caps.has_rwproof = true;
+		host->caps.need_blksz_mul_4 = false;
+		host->caps.need_notbusy_for_read_ops = true;
 		fallthrough;
 	case 0x100:
-		host->caps.has_bad_data_ordering = 0;
-		host->caps.need_reset_after_xfer = 0;
+		host->caps.has_bad_data_ordering = false;
+		host->caps.need_reset_after_xfer = false;
 		fallthrough;
 	case 0x0:
 		break;
 	default:
-		host->caps.has_pdc = 0;
+		host->caps.has_pdc = false;
 		dev_warn(&host->pdev->dev,
 				"Unmanaged mci version, set minimum capabilities\n");
 		break;
-- 
1.8.3.1

