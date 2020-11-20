Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5F22BA5EA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgKTJVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:21:38 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8377 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKTJVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:21:36 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CcrdS5SW4z70n0;
        Fri, 20 Nov 2020 17:21:16 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.144) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 17:21:25 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] device-dax: delete a redundancy check in dev_dax_validate_align()
Date:   Fri, 20 Nov 2020 17:20:57 +0800
Message-ID: <20201120092057.2144-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After we have done the alignment check for the length of each range, the
alignment check for dev_dax_size(dev_dax) is no longer needed, because it
get the sum of the length of each range.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/dax/bus.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1efae11d947a..35f9238c0139 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1109,16 +1109,9 @@ static ssize_t align_show(struct device *dev,
 
 static ssize_t dev_dax_validate_align(struct dev_dax *dev_dax)
 {
-	resource_size_t dev_size = dev_dax_size(dev_dax);
 	struct device *dev = &dev_dax->dev;
 	int i;
 
-	if (dev_size > 0 && !alloc_is_aligned(dev_dax, dev_size)) {
-		dev_dbg(dev, "%s: align %u invalid for size %pa\n",
-			__func__, dev_dax->align, &dev_size);
-		return -EINVAL;
-	}
-
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		size_t len = range_len(&dev_dax->ranges[i].range);
 
-- 
2.26.0.106.g9fadedd


