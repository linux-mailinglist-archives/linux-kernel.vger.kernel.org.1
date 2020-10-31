Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DC62A1555
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 11:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgJaKu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 06:50:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:7390 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgJaKuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 06:50:55 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CNbZ06Wbvz6xFt;
        Sat, 31 Oct 2020 18:50:48 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sat, 31 Oct 2020
 18:50:41 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paul@crapouillou.net>, <harveyhuntnexus@gmail.com>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] mtd: rawnand: ingenic: remove redundant get_device() in ingenic_ecc_get()
Date:   Sat, 31 Oct 2020 18:54:39 +0800
Message-ID: <20201031105439.2304211-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_device_by_node() already takes a reference to the device, and
ingenic_ecc_release() will drop the reference. So, the get_device() in
ingenic_ecc_get() is redundand.

Fixes: 15de8c6efd0e("mtd: rawnand: ingenic: Separate top-level and SoC specific code")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
index 8e22cd6ec71f..efe0ffe4f1ab 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
@@ -71,8 +71,6 @@ static struct ingenic_ecc *ingenic_ecc_get(struct device_node *np)
 	if (!pdev || !platform_get_drvdata(pdev))
 		return ERR_PTR(-EPROBE_DEFER);
 
-	get_device(&pdev->dev);
-
 	ecc = platform_get_drvdata(pdev);
 	clk_prepare_enable(ecc->clk);
 
-- 
2.25.4

