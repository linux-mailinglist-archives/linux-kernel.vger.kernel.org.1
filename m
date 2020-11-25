Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304582C4094
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgKYMvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:51:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8034 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKYMvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:51:13 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ch12v4z9lzhZdw;
        Wed, 25 Nov 2020 20:50:47 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 25 Nov 2020
 20:51:01 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <linux@dominikbrodowski.net>
CC:     <clabbe@baylibre.com>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>,
        <bobo.shaobowang@huawei.com>
Subject: [PATCH] pcmcia: omap: Fix error return code in omap_cf_probe()
Date:   Wed, 25 Nov 2020 20:50:57 +0800
Message-ID: <20201125125057.30669-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return proper error code instaed of 0 in omap_cf_probe(), as done
elsewhere in this function.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/pcmcia/omap_cf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index d3ef5534991e..f0b2c2d03469 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -252,11 +252,15 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 	/* pcmcia layer only remaps "real" memory */
 	cf->socket.io_offset = (unsigned long)
 			ioremap(cf->phys_cf + SZ_4K, SZ_2K);
-	if (!cf->socket.io_offset)
+	if (!cf->socket.io_offset) {
+		status = -ENOMEM;
 		goto fail1;
+	}
 
-	if (!request_mem_region(cf->phys_cf, SZ_8K, driver_name))
+	if (!request_mem_region(cf->phys_cf, SZ_8K, driver_name)) {
+		status = -ENXIO;
 		goto fail1;
+	}
 
 	/* NOTE:  CF conflicts with MMC1 */
 	omap_cfg_reg(W11_1610_CF_CD1);
-- 
2.17.1

