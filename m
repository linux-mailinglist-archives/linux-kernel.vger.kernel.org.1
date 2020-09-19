Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32CD270D65
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 13:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgISLDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 07:03:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43554 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726455AbgISLDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 07:03:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3D190658BE13BBBCAC36;
        Sat, 19 Sep 2020 19:03:03 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 19:02:57 +0800
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
Subject: [PATCH v2 1/1] libnvdimm/region: delete a piece of useless code in nd_region_create()
Date:   Sat, 19 Sep 2020 19:02:45 +0800
Message-ID: <20200919110245.3965-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code snippet is as follows:
	if (ndr_desc->flush)
1)		nd_region->flush = ndr_desc->flush;
	else
2)		nd_region->flush = NULL;

When entering the "else" branch, the value of ndr_desc->flush is NULL.
After replaced "NULL" with "ndr_desc->flush" at 2), we will find that
it becomes the same to 1).

So the above code snippet can be reduced to one statement:
nd_region->flush = ndr_desc->flush;

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
v1 --> v2:
1. Only the title and description are modified.

v1:
https://lkml.org/lkml/2020/8/19/1469

 drivers/nvdimm/region_devs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ef23119db574663..7cf9c7d857909ce 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1131,10 +1131,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	nd_region->ndr_size = resource_size(ndr_desc->res);
 	nd_region->ndr_start = ndr_desc->res->start;
 	nd_region->align = default_align(nd_region);
-	if (ndr_desc->flush)
-		nd_region->flush = ndr_desc->flush;
-	else
-		nd_region->flush = NULL;
+	nd_region->flush = ndr_desc->flush;
 
 	nd_device_register(dev);
 
-- 
1.8.3


