Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F0252E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 14:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgHZMTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 08:19:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10265 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729369AbgHZMTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:19:00 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6307F1CE024FDD78DF13;
        Wed, 26 Aug 2020 20:18:55 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 26 Aug 2020
 20:18:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>, <mingo@kernel.org>
CC:     <linux-nvdimm@lists.01.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] libnvdimm/e820: Fix build error without MEMORY_HOTPLUG
Date:   Wed, 26 Aug 2020 20:18:00 +0800
Message-ID: <20200826121800.732-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If MEMORY_HOTPLUG is n, build fails:

drivers/nvdimm/e820.c: In function ‘e820_register_one’:
drivers/nvdimm/e820.c:24:12: error: implicit declaration of function ‘phys_to_target_node’; did you mean ‘set_page_node’? [-Werror=implicit-function-declaration]
  int nid = phys_to_target_node(res->start);
            ^~~~~~~~~~~~~~~~~~~
            set_page_node

Fixes: 7b27a8622f80 ("libnvdimm/e820: Retrieve and populate correct 'target_node' info")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/nvdimm/e820.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvdimm/e820.c b/drivers/nvdimm/e820.c
index 4cd18be9d0e9..c741f029f215 100644
--- a/drivers/nvdimm/e820.c
+++ b/drivers/nvdimm/e820.c
@@ -17,6 +17,13 @@ static int e820_pmem_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifndef CONFIG_MEMORY_HOTPLUG
+static inline int phys_to_target_node(u64 start)
+{
+	return 0;
+}
+#endif
+
 static int e820_register_one(struct resource *res, void *data)
 {
 	struct nd_region_desc ndr_desc;
-- 
2.17.1


