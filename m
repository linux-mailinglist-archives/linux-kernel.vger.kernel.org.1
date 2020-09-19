Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222BB270D5D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 13:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgISLCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 07:02:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbgISLCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 07:02:12 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0B7B4FB3D20829E1D781;
        Sat, 19 Sep 2020 19:02:00 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 19:01:53 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 1/1] libnvdimm/namespace: avoid repeated judgment in nvdimm_namespace_disk_name()
Date:   Sat, 19 Sep 2020 19:01:46 +0800
Message-ID: <20200919110146.3909-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The judgment (suffix ? suffix : "") appears three times, we do this just
because the initial value of local variable "suffix" is NULL, should be
replaced with empty string "" to avoid null pointer reference. It's easy
to get rid of it as below:
-	const char *suffix = NULL;
+	const char *suffix = "";

To avoid having rows that exceed 80 columns, add a new local variable
"region_id".

No functional change, but it can reduce the code size.
Before:
   text    data     bss     dec     hex filename
  41749    3697      16   45462    b196 drivers/nvdimm/namespace_devs.o

After:
   text    data     bss     dec     hex filename
  41653    3697      16   45366    b136 drivers/nvdimm/namespace_devs.o

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
v1 --> v2:
1. Only the title and description are modified.

v1:
https://lore.kernel.org/patchwork/patch/1292584/

 drivers/nvdimm/namespace_devs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 6da67f4d641a27c..ef2800c5da4c99c 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -157,7 +157,8 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 		char *name)
 {
 	struct nd_region *nd_region = to_nd_region(ndns->dev.parent);
-	const char *suffix = NULL;
+	const char *suffix = "";
+	int region_id = nd_region->id;
 
 	if (ndns->claim && is_nd_btt(ndns->claim))
 		suffix = "s";
@@ -173,17 +174,14 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 		}
 
 		if (nsidx)
-			sprintf(name, "pmem%d.%d%s", nd_region->id, nsidx,
-					suffix ? suffix : "");
+			sprintf(name, "pmem%d.%d%s", region_id, nsidx, suffix);
 		else
-			sprintf(name, "pmem%d%s", nd_region->id,
-					suffix ? suffix : "");
+			sprintf(name, "pmem%d%s", region_id, suffix);
 	} else if (is_namespace_blk(&ndns->dev)) {
 		struct nd_namespace_blk *nsblk;
 
 		nsblk = to_nd_namespace_blk(&ndns->dev);
-		sprintf(name, "ndblk%d.%d%s", nd_region->id, nsblk->id,
-				suffix ? suffix : "");
+		sprintf(name, "ndblk%d.%d%s", region_id, nsblk->id, suffix);
 	} else {
 		return NULL;
 	}
-- 
1.8.3


