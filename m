Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D732DEDD5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 09:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgLSIUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 03:20:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9231 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgLSIUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 03:20:10 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cydsh3D3wzksGC;
        Sat, 19 Dec 2020 16:18:32 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 19 Dec 2020 16:19:14 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] device-dax: avoid an unnecessary check in alloc_dev_dax_range()
Date:   Sat, 19 Dec 2020 16:18:40 +0800
Message-ID: <20201219081840.1149-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201219081840.1149-1-thunder.leizhen@huawei.com>
References: <20201219081840.1149-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap the calling sequence of krealloc() and __request_region(), call the
latter first. In this way, the value of dev_dax->nr_range does not need to
be considered when __request_region() failed.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/dax/bus.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index de7b74505e75e72..359e22ece425ad2 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -772,22 +772,14 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		return 0;
 	}
 
-	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
-			* (dev_dax->nr_range + 1), GFP_KERNEL);
-	if (!ranges)
+	alloc = __request_region(res, start, size, dev_name(dev), 0);
+	if (!alloc)
 		return -ENOMEM;
 
-	alloc = __request_region(res, start, size, dev_name(dev), 0);
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
+	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
+			* (dev_dax->nr_range + 1), GFP_KERNEL);
+	if (!ranges) {
+		__release_region(res, alloc->start, resource_size(alloc));
 		return -ENOMEM;
 	}
 
-- 
2.26.0.106.g9fadedd


