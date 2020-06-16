Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1181FC194
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 00:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgFPWdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 18:33:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbgFPWdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:33:31 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2A5E3746552EF6D3B867;
        Wed, 17 Jun 2020 06:33:29 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.10) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 17 Jun 2020 06:33:19 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "Roman Gushchin" <guro@fb.com>
Subject: [PATCH v2 1/2] mm: cma: fix the name of CMA areas
Date:   Wed, 17 Jun 2020 10:31:30 +1200
Message-ID: <20200616223131.33828-2-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200616223131.33828-1-song.bao.hua@hisilicon.com>
References: <20200616223131.33828-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.10]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if users give a name saved in stack, the current code will generate magic
pointer.
if users don't give a name(NULL), kasprintf() will always return NULL as
we are at the early stage. that means cma_init_reserved_mem() will return
-ENOMEM if users set name parameter as NULL.

Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2:
 rebase to 5.8-rc1
 add acked-by and reviewed-by

 mm/cma.c | 13 ++++++-------
 mm/cma.h |  4 +++-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 0463ad2ce06b..b24151fa2101 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -202,13 +202,12 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	 * subsystems (like slab allocator) are available.
 	 */
 	cma = &cma_areas[cma_area_count];
-	if (name) {
-		cma->name = name;
-	} else {
-		cma->name = kasprintf(GFP_KERNEL, "cma%d\n", cma_area_count);
-		if (!cma->name)
-			return -ENOMEM;
-	}
+
+	if (name)
+		snprintf(cma->name, CMA_MAX_NAME, name);
+	else
+		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
+
 	cma->base_pfn = PFN_DOWN(base);
 	cma->count = size >> PAGE_SHIFT;
 	cma->order_per_bit = order_per_bit;
diff --git a/mm/cma.h b/mm/cma.h
index 33c0b517733c..27d3f0e9f68f 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -2,6 +2,8 @@
 #ifndef __MM_CMA_H__
 #define __MM_CMA_H__
 
+#define CMA_MAX_NAME 64
+
 struct cma {
 	unsigned long   base_pfn;
 	unsigned long   count;
@@ -12,7 +14,7 @@ struct cma {
 	struct hlist_head mem_head;
 	spinlock_t mem_head_lock;
 #endif
-	const char *name;
+	char name[CMA_MAX_NAME];
 };
 
 extern struct cma cma_areas[MAX_CMA_AREAS];
-- 
2.23.0


