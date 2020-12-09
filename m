Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C882D3ECE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgLIJba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:31:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8736 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbgLIJb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:31:27 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CrWwr0JddzknSf;
        Wed,  9 Dec 2020 17:30:04 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Dec 2020 17:30:35 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] mtd: rawnand: simplify the cs553x_write_ctrl_byte()
Date:   Wed, 9 Dec 2020 17:31:03 +0800
Message-ID: <20201209093103.20742-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/mtd/nand/raw/cs553x_nand.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index 282203debd0c..a616aaa2e3dc 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -105,17 +105,12 @@ static int cs553x_write_ctrl_byte(struct cs553x_nand_controller *cs553x,
 				  u32 ctl, u8 data)
 {
 	u8 status;
-	int ret;
 
 	writeb(ctl, cs553x->mmio + MM_NAND_CTL);
 	writeb(data, cs553x->mmio + MM_NAND_IO);
-	ret = readb_poll_timeout_atomic(cs553x->mmio + MM_NAND_STS, status,
-					!(status & CS_NAND_CTLR_BUSY), 1,
-					100000);
-	if (ret)
-		return ret;
-
-	return 0;
+	return readb_poll_timeout_atomic(cs553x->mmio + MM_NAND_STS, status,
+					 !(status & CS_NAND_CTLR_BUSY), 1,
+					 100000);
 }
 
 static void cs553x_data_in(struct cs553x_nand_controller *cs553x, void *buf,
-- 
2.22.0

