Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7206E301431
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 10:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbhAWJcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 04:32:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11134 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbhAWJcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 04:32:12 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DN9pM11FVz15ws4;
        Sat, 23 Jan 2021 17:30:19 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Sat, 23 Jan 2021
 17:31:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <almasrymina@google.com>, <rientjes@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH RFC] hugetlb_cgroup: fix unbalanced css_put for shared mappings
Date:   Sat, 23 Jan 2021 04:31:11 -0500
Message-ID: <20210123093111.60785-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of hugetlb_cgroup for shared mappings could have
different behavior. Consider the following two scenarios:

1.Assume initial css reference count of hugetlb_cgroup is 1:
  1.1 Call hugetlb_reserve_pages with from = 1, to = 2. So css reference
count is 2 associated with 1 file_region.
  1.2 Call hugetlb_reserve_pages with from = 2, to = 3. So css reference
count is 3 associated with 2 file_region.
  1.3 coalesce_file_region will coalesce these two file_regions into one.
So css reference count is 3 associated with 1 file_region now.

2.Assume initial css reference count of hugetlb_cgroup is 1 again:
  2.1 Call hugetlb_reserve_pages with from = 1, to = 3. So css reference
count is 2 associated with 1 file_region.

Therefore, we might have one file_region while holding one or more css
reference counts. This inconsistency could lead to unbalanced css_put().
If we do css_put one by one (i.g. hole punch case), scenario 2 would put
one more css reference. If we do css_put all together (i.g. truncate case),
scenario 1 will leak one css reference.

In order to fix this, we have to make sure that one file_region may hold
and must hold one css reference. So in coalesce_file_region case, we should
release one css reference before coalescence. Also only put css reference
when the entire file_region is removed.

Fixes: 075a61d07a8e ("hugetlb_cgroup: add accounting for shared mappings")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@kernel.org
---
 include/linux/hugetlb_cgroup.h |  6 ++++--
 mm/hugetlb.c                   | 18 ++++++++++++++----
 mm/hugetlb_cgroup.c            | 10 ++++++++--
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 2ad6e92f124a..7610efcd96bd 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -138,7 +138,8 @@ extern void hugetlb_cgroup_uncharge_counter(struct resv_map *resv,
 
 extern void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
 						struct file_region *rg,
-						unsigned long nr_pages);
+						unsigned long nr_pages,
+						bool region_del);
 
 extern void hugetlb_cgroup_file_init(void) __init;
 extern void hugetlb_cgroup_migrate(struct page *oldhpage,
@@ -147,7 +148,8 @@ extern void hugetlb_cgroup_migrate(struct page *oldhpage,
 #else
 static inline void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
 						       struct file_region *rg,
-						       unsigned long nr_pages)
+						       unsigned long nr_pages,
+						       bool region_del)
 {
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a6bad1f686c5..777bc0e45bf3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -298,6 +298,14 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
 #endif
 }
 
+static void put_uncharge_info(struct file_region *rg)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+	if (rg->css)
+		css_put(rg->css);
+#endif
+}
+
 static bool has_same_uncharge_info(struct file_region *rg,
 				   struct file_region *org)
 {
@@ -321,6 +329,7 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 		prg->to = rg->to;
 
 		list_del(&rg->link);
+		put_uncharge_info(rg);
 		kfree(rg);
 
 		rg = prg;
@@ -332,6 +341,7 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 		nrg->from = rg->from;
 
 		list_del(&rg->link);
+		put_uncharge_info(rg);
 		kfree(rg);
 	}
 }
@@ -664,7 +674,7 @@ static long region_del(struct resv_map *resv, long f, long t)
 
 			del += t - f;
 			hugetlb_cgroup_uncharge_file_region(
-				resv, rg, t - f);
+				resv, rg, t - f, false);
 
 			/* New entry for end of split region */
 			nrg->from = t;
@@ -685,7 +695,7 @@ static long region_del(struct resv_map *resv, long f, long t)
 		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
 			del += rg->to - rg->from;
 			hugetlb_cgroup_uncharge_file_region(resv, rg,
-							    rg->to - rg->from);
+							    rg->to - rg->from, true);
 			list_del(&rg->link);
 			kfree(rg);
 			continue;
@@ -693,13 +703,13 @@ static long region_del(struct resv_map *resv, long f, long t)
 
 		if (f <= rg->from) {	/* Trim beginning of region */
 			hugetlb_cgroup_uncharge_file_region(resv, rg,
-							    t - rg->from);
+							    t - rg->from, false);
 
 			del += t - rg->from;
 			rg->from = t;
 		} else {		/* Trim end of region */
 			hugetlb_cgroup_uncharge_file_region(resv, rg,
-							    rg->to - f);
+							    rg->to - f, false);
 
 			del += rg->to - f;
 			rg->to = f;
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 9182848dda3e..8909e075d441 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -391,7 +391,8 @@ void hugetlb_cgroup_uncharge_counter(struct resv_map *resv, unsigned long start,
 
 void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
 					 struct file_region *rg,
-					 unsigned long nr_pages)
+					 unsigned long nr_pages,
+					 bool region_del)
 {
 	if (hugetlb_cgroup_disabled() || !resv || !rg || !nr_pages)
 		return;
@@ -400,7 +401,12 @@ void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
 	    !resv->reservation_counter) {
 		page_counter_uncharge(rg->reservation_counter,
 				      nr_pages * resv->pages_per_hpage);
-		css_put(rg->css);
+		/*
+		 * Only do css_put(rg->css) when we delete the entire region
+		 * because one file_region only holds one rg->css reference.
+		 */
+		if (region_del)
+			css_put(rg->css);
 	}
 }
 
-- 
2.19.1

