Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE162EBE75
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbhAFNTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:19:01 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10397 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbhAFNTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:19:00 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D9qfB3XlJz7ND7;
        Wed,  6 Jan 2021 21:17:22 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 6 Jan 2021 21:18:07 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] mtd: st_spi_fsm: use resource_size
Date:   Wed, 6 Jan 2021 21:18:47 +0800
Message-ID: <20210106131847.443-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use resource_size rather than a verbose computation on
the end and start fields.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/mtd/devices/st_spi_fsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 1888523d9745..983999c020d6 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -924,7 +924,7 @@ static int stfsm_read_status(struct stfsm *fsm, uint8_t cmd,
 	BUG_ON(bytes != 1 && bytes != 2);
 
 	seq->seq_opc[0] = (SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
-			   SEQ_OPC_OPCODE(cmd)),
+			   SEQ_OPC_OPCODE(cmd));
 
 	stfsm_load_seq(fsm, seq);
 
-- 
2.22.0

