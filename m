Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B2229DFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbgJ2BFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:05:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:6979 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbgJ1WFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:05:44 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CLjT50CB5zhbds;
        Wed, 28 Oct 2020 17:10:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 17:09:47 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH] i3c master: fix missing destroy_workqueue() on error in i3c_master_register
Date:   Wed, 28 Oct 2020 17:15:43 +0800
Message-ID: <20201028091543.136167-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing destroy_workqueue() before return from
i3c_master_register in the error handling case.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/i3c/master.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index cc7564446..c45b59bb7 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2514,7 +2514,7 @@ int i3c_master_register(struct i3c_master_controller *master,
 
 	ret = i3c_master_bus_init(master);
 	if (ret)
-		goto err_put_dev;
+		goto err_destroy_wq;
 
 	ret = device_add(&master->dev);
 	if (ret)
@@ -2545,6 +2545,9 @@ int i3c_master_register(struct i3c_master_controller *master,
 err_cleanup_bus:
 	i3c_master_bus_cleanup(master);
 
+err_destroy_wq:
+	destroy_workqueue(master->wq);
+
 err_put_dev:
 	put_device(&master->dev);
 
-- 
2.23.0

