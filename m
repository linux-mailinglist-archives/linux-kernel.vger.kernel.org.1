Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A872BA5FF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgKTJXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:23:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7714 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgKTJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:23:11 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CcrgC0fZDzkc9w;
        Fri, 20 Nov 2020 17:22:47 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.144) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 17:22:57 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] device-dax: avoid an unnecessary check in alloc_dev_dax_range()
Date:   Fri, 20 Nov 2020 17:22:51 +0800
Message-ID: <20201120092251.2197-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap the calling sequence of krealloc() and __request_region(), call the
latter first. In this way, the value of dev_dax->nr_range does not need to
be considered when __request_region() failed.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/dax/bus.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 27513d311242..1efae11d947a 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -763,23 +763,15 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		return 0;
 	}
 
-	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
-			* (dev_dax->nr_range + 1), GFP_KERNEL);
-	if (!ranges)
-		return -ENOMEM;
-
 	alloc = __request_region(res, start, size, dev_name(dev), 0);
-	if (!alloc) {
-		/*
-		 * If this was an empty set of ranges nothing else
-		 * will release @ranges, so do it now.
-		 */
-		if (!dev_dax->nr_range) {
-			kfree(ranges);
-			ranges = NULL;
-		}
-		dev_dax->ranges = ranges;
+	if (!alloc)
 		return -ENOMEM;
+
+	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
+			* (dev_dax->nr_range + 1), GFP_KERNEL);
+	if (!ranges) {
+		rc = -ENOMEM;
+		goto err;
 	}
 
 	for (i = 0; i < dev_dax->nr_range; i++)
@@ -808,11 +800,14 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		dev_dbg(dev, "delete range[%d]: %pa:%pa\n", dev_dax->nr_range - 1,
 				&alloc->start, &alloc->end);
 		dev_dax->nr_range--;
-		__release_region(res, alloc->start, resource_size(alloc));
-		return rc;
+		goto err;
 	}
 
 	return 0;
+
+err:
+	__release_region(res, alloc->start, resource_size(alloc));
+	return rc;
 }
 
 static int adjust_dev_dax_range(struct dev_dax *dev_dax, struct resource *res, resource_size_t size)
-- 
2.26.0.106.g9fadedd


