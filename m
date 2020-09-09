Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3568F2630E1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbgIIPsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 11:48:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730446AbgIIPpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:45:15 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 43882EA083EC8B2B931C;
        Wed,  9 Sep 2020 21:43:31 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:43:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <stefan@agner.ch>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <yuehaibing@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mtd: rawnand: vf610_nfc: Remove unused function vf610_nfc_transfer_size()
Date:   Wed, 9 Sep 2020 21:43:18 +0800
Message-ID: <20200909134318.36340-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ecc40b8df59a ("mtd: rawnand: vf610_nfc: remove old hooks")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/nand/raw/vf610_nfc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 7248c5901183..ed8e0928c0b2 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -323,11 +323,6 @@ static inline void vf610_nfc_ecc_mode(struct vf610_nfc *nfc, int ecc_mode)
 			    CONFIG_ECC_MODE_SHIFT, ecc_mode);
 }
 
-static inline void vf610_nfc_transfer_size(struct vf610_nfc *nfc, int size)
-{
-	vf610_nfc_write(nfc, NFC_SECTOR_SIZE, size);
-}
-
 static inline void vf610_nfc_run(struct vf610_nfc *nfc, u32 col, u32 row,
 				 u32 cmd1, u32 cmd2, u32 trfr_sz)
 {
-- 
2.17.1


