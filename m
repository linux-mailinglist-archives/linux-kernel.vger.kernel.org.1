Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 255931A45EF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 13:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDJLvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 07:51:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58554 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbgDJLvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:51:36 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5BD10F7AA6D541B079DB;
        Fri, 10 Apr 2020 19:51:32 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Apr 2020
 19:51:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harveyhuntnexus@gmail.com>, <paul@crapouillou.net>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mtd: rawnand: ingenic: Make qi_lb60_ooblayout_ops static
Date:   Fri, 10 Apr 2020 19:51:21 +0800
Message-ID: <20200410115121.11852-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c:105:32:
 warning: symbol 'qi_lb60_ooblayout_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
index 935c4902ada7..e7bd845fdbf5 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
@@ -102,7 +102,7 @@ static int qi_lb60_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
-const struct mtd_ooblayout_ops qi_lb60_ooblayout_ops = {
+static const struct mtd_ooblayout_ops qi_lb60_ooblayout_ops = {
 	.ecc = qi_lb60_ooblayout_ecc,
 	.free = qi_lb60_ooblayout_free,
 };
-- 
2.17.1


