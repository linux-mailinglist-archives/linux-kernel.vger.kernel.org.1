Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006122D7278
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437323AbgLKJBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:01:38 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9873 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389430AbgLKJBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:01:15 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Csl9D5Xr2z7Cf0;
        Fri, 11 Dec 2020 17:00:00 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 17:00:26 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] mtd: nand: raw: convert comma to semicolon
Date:   Fri, 11 Dec 2020 17:00:55 +0800
Message-ID: <20201211090055.3250-1-zhengyongjun3@huawei.com>
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
 drivers/mtd/nand/raw/mxc_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 684c51e5e60d..aa61b64a8abd 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1787,7 +1787,7 @@ static int mxcnd_probe(struct platform_device *pdev)
 	this->legacy.chip_delay = 5;
 
 	nand_set_controller_data(this, host);
-	nand_set_flash_node(this, pdev->dev.of_node),
+	nand_set_flash_node(this, pdev->dev.of_node);
 	this->legacy.dev_ready = mxc_nand_dev_ready;
 	this->legacy.cmdfunc = mxc_nand_command;
 	this->legacy.read_byte = mxc_nand_read_byte;
-- 
2.22.0

