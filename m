Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75274268494
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgINGMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:12:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbgINGMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:12:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D6A3689830B199538E1C;
        Mon, 14 Sep 2020 14:12:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 14 Sep 2020 14:12:36 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] mtd: spear_smi: use for_each_child_of_node() macro
Date:   Mon, 14 Sep 2020 14:13:24 +0800
Message-ID: <20200914061324.3230-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use for_each_child_of_node() macro instead of open coding it.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/mtd/devices/spear_smi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/spear_smi.c b/drivers/mtd/devices/spear_smi.c
index 79dcca164..2e0086238 100644
--- a/drivers/mtd/devices/spear_smi.c
+++ b/drivers/mtd/devices/spear_smi.c
@@ -793,7 +793,7 @@ static int spear_smi_probe_config_dt(struct platform_device *pdev,
 				     struct device_node *np)
 {
 	struct spear_smi_plat_data *pdata = dev_get_platdata(&pdev->dev);
-	struct device_node *pp = NULL;
+	struct device_node *pp;
 	const __be32 *addr;
 	u32 val;
 	int len;
@@ -812,7 +812,7 @@ static int spear_smi_probe_config_dt(struct platform_device *pdev,
 		return -ENOMEM;
 
 	/* Fill structs for each subnode (flash device) */
-	while ((pp = of_get_next_child(np, pp))) {
+	for_each_child_of_node(np, pp) {
 		pdata->np[i] = pp;
 
 		/* Read base-addr and size from DT */
-- 
2.23.0

