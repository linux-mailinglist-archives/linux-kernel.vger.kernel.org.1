Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22C52EEF73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbhAHJXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:23:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:10418 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbhAHJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:23:09 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DByKK0X3Hzj4Lk;
        Fri,  8 Jan 2021 17:21:41 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Fri, 8 Jan 2021 17:22:17 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH v2 -next] mtd: convert comma to semicolon
Date:   Fri, 8 Jan 2021 17:23:00 +0800
Message-ID: <20210108092300.18909-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/mtd/maps/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/maps/pci.c b/drivers/mtd/maps/pci.c
index 377ef0fc4e3e..ca00d211e73e 100644
--- a/drivers/mtd/maps/pci.c
+++ b/drivers/mtd/maps/pci.c
@@ -90,8 +90,8 @@ intel_iq80310_init(struct pci_dev *dev, struct map_pci_info *map)
 	u32 win_base;
 
 	map->map.bankwidth = 1;
-	map->map.read = mtd_pci_read8,
-	map->map.write = mtd_pci_write8,
+	map->map.read = mtd_pci_read8;
+	map->map.write = mtd_pci_write8;
 
 	map->map.size     = 0x00800000;
 	map->base         = ioremap(pci_resource_start(dev, 0),
@@ -185,8 +185,8 @@ intel_dc21285_init(struct pci_dev *dev, struct map_pci_info *map)
 		return -ENXIO;
 
 	map->map.bankwidth = 4;
-	map->map.read = mtd_pci_read32,
-	map->map.write = mtd_pci_write32,
+	map->map.read = mtd_pci_read32;
+	map->map.write = mtd_pci_write32;
 	map->map.size     = len;
 	map->base         = ioremap(base, len);
 
-- 
2.22.0

