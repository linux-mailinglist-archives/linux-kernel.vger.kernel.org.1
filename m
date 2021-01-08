Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227492EEF76
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbhAHJXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:23:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10562 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbhAHJXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:23:19 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DByK20ryDzMHL3;
        Fri,  8 Jan 2021 17:21:26 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 8 Jan 2021 17:22:29 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH v2 -next] mtd: rawnand: marvell: convert comma to semicolon
Date:   Fri, 8 Jan 2021 17:23:14 +0800
Message-ID: <20210108092314.18972-1-zhengyongjun3@huawei.com>
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
 drivers/mtd/nand/raw/marvell_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index f5ca2002d08e..3e01b11c87f8 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2396,7 +2396,7 @@ static int marvell_nfc_setup_interface(struct nand_chip *chip, int chipnr,
 	 * be greater than that to be sure tCCS delay is respected.
 	 */
 	nfc_tmg.tWHR = TO_CYCLES(max_t(int, sdr->tWHR_min, sdr->tCCS_min),
-				 period_ns) - 2,
+				 period_ns) - 2;
 	nfc_tmg.tRHW = TO_CYCLES(max_t(int, sdr->tRHW_min, sdr->tCCS_min),
 				 period_ns);
 
-- 
2.22.0

