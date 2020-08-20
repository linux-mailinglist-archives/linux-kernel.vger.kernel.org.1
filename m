Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F28F24ACE7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 04:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHTCRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 22:17:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9784 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726796AbgHTCR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 22:17:27 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 71C0CF8ADFE834B79346;
        Thu, 20 Aug 2020 10:17:25 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 10:17:18 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 5/7] libnvdimm: reduce an unnecessary if branch in nd_region_activate()
Date:   Thu, 20 Aug 2020 10:16:39 +0800
Message-ID: <20200820021641.3188-6-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200820021641.3188-1-thunder.leizhen@huawei.com>
References: <20200820021641.3188-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the original code logic:
if (!nvdimm->num_flush) {
	flush_data_size += sizeof(void *);
	//nvdimm->num_flush is zero now, add 1) have no side effects
} else {
	flush_data_size += sizeof(void *);
1)	flush_data_size += nvdimm->num_flush * sizeof(void *);
}

Obviously, the above code snippet can be reduced to one statement:
flush_data_size += (nvdimm->num_flush + 1) * sizeof(void *);

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/region_devs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 7cf9c7d857909ce..49be115c9189eff 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -77,11 +77,8 @@ int nd_region_activate(struct nd_region *nd_region)
 		}
 
 		/* at least one null hint slot per-dimm for the "no-hint" case */
-		flush_data_size += sizeof(void *);
+		flush_data_size += (nvdimm->num_flush + 1) * sizeof(void *);
 		num_flush = min_not_zero(num_flush, nvdimm->num_flush);
-		if (!nvdimm->num_flush)
-			continue;
-		flush_data_size += nvdimm->num_flush * sizeof(void *);
 	}
 	nvdimm_bus_unlock(&nd_region->dev);
 
-- 
1.8.3


