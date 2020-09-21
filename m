Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7992724ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgIUNMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:12:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727369AbgIUNKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:34 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2B434B8E9FC984643587;
        Mon, 21 Sep 2020 21:10:33 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:23 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] ocxl: simplify the return expression of free_function_dev()
Date:   Mon, 21 Sep 2020 21:10:47 +0800
Message-ID: <20200921131047.92526-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/misc/ocxl/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/misc/ocxl/core.c b/drivers/misc/ocxl/core.c
index b7a09b21a..aebfc53a2 100644
--- a/drivers/misc/ocxl/core.c
+++ b/drivers/misc/ocxl/core.c
@@ -327,14 +327,9 @@ static void free_function_dev(struct device *dev)
 
 static int set_function_device(struct ocxl_fn *fn, struct pci_dev *dev)
 {
-	int rc;
-
 	fn->dev.parent = &dev->dev;
 	fn->dev.release = free_function_dev;
-	rc = dev_set_name(&fn->dev, "ocxlfn.%s", dev_name(&dev->dev));
-	if (rc)
-		return rc;
-	return 0;
+	return dev_set_name(&fn->dev, "ocxlfn.%s", dev_name(&dev->dev));
 }
 
 static int assign_function_actag(struct ocxl_fn *fn)
-- 
2.23.0

