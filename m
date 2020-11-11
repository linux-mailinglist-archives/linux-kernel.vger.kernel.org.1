Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127252AE6F4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 04:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbgKKDRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 22:17:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7879 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKKDRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:17:06 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CW8zD2zbVz74yF;
        Wed, 11 Nov 2020 11:16:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 11 Nov 2020 11:16:54 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] soc: ti: set ret to -ENODEV when fails to init queue_pools
Date:   Wed, 11 Nov 2020 11:22:04 +0800
Message-ID: <20201111032204.17971-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forget to set error code when queue_pools fails to be inited,
fix it by setting ret to -ENODEV. Remove the redundant blank
by the way.

Fixes: 41f93af900a2 ("soc: ti: add Keystone Navigator QMSS driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index a460f201bf8e..a6a2138d5c29 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1851,9 +1851,10 @@ static int knav_queue_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	regions =  of_get_child_by_name(node, "descriptor-regions");
+	regions = of_get_child_by_name(node, "descriptor-regions");
 	if (!regions) {
 		dev_err(dev, "descriptor-regions not specified\n");
+		ret = -ENODEV;
 		goto err;
 	}
 	ret = knav_queue_setup_regions(kdev, regions);
-- 
2.23.0

