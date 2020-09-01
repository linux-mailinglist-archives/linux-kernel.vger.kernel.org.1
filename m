Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E30E25854D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 03:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgIABrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 21:47:10 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:40048 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726226AbgIABqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:46:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U7Txiaw_1598924804;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7Txiaw_1598924804)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Sep 2020 09:46:44 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v4 4/7] mm/hugetlb: count file_region to be added when regions_needed != NULL
Date:   Tue,  1 Sep 2020 09:46:33 +0800
Message-Id: <20200901014636.29737-5-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200901014636.29737-1-richard.weiyang@linux.alibaba.com>
References: <20200901014636.29737-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only two cases of function add_reservation_in_range()

    * count file_region and return the number in regions_needed
    * do the real list operation without counting

This means it is not necessary to have two parameters to classify these
two cases.

Just use regions_needed to separate them.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a02bf430de6f..441b7f7c623e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -321,16 +321,17 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 	}
 }
 
-/* Must be called with resv->lock held. Calling this with count_only == true
- * will count the number of pages to be added but will not modify the linked
- * list. If regions_needed != NULL and count_only == true, then regions_needed
- * will indicate the number of file_regions needed in the cache to carry out to
- * add the regions for this range.
+/*
+ * Must be called with resv->lock held.
+ *
+ * Calling this with regions_needed != NULL will count the number of pages
+ * to be added but will not modify the linked list. And regions_needed will
+ * indicate the number of file_regions needed in the cache to carry out to add
+ * the regions for this range.
  */
 static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 				     struct hugetlb_cgroup *h_cg,
-				     struct hstate *h, long *regions_needed,
-				     bool count_only)
+				     struct hstate *h, long *regions_needed)
 {
 	long add = 0;
 	struct list_head *head = &resv->regions;
@@ -366,14 +367,14 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 		 */
 		if (rg->from > last_accounted_offset) {
 			add += rg->from - last_accounted_offset;
-			if (!count_only) {
+			if (!regions_needed) {
 				nrg = get_file_region_entry_from_cache(
 					resv, last_accounted_offset, rg->from);
 				record_hugetlb_cgroup_uncharge_info(h_cg, h,
 								    resv, nrg);
 				list_add(&nrg->link, rg->link.prev);
 				coalesce_file_region(resv, nrg);
-			} else if (regions_needed)
+			} else
 				*regions_needed += 1;
 		}
 
@@ -385,13 +386,13 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 	 */
 	if (last_accounted_offset < t) {
 		add += t - last_accounted_offset;
-		if (!count_only) {
+		if (!regions_needed) {
 			nrg = get_file_region_entry_from_cache(
 				resv, last_accounted_offset, t);
 			record_hugetlb_cgroup_uncharge_info(h_cg, h, resv, nrg);
 			list_add(&nrg->link, rg->link.prev);
 			coalesce_file_region(resv, nrg);
-		} else if (regions_needed)
+		} else
 			*regions_needed += 1;
 	}
 
@@ -484,8 +485,8 @@ static long region_add(struct resv_map *resv, long f, long t,
 retry:
 
 	/* Count how many regions are actually needed to execute this add. */
-	add_reservation_in_range(resv, f, t, NULL, NULL, &actual_regions_needed,
-				 true);
+	add_reservation_in_range(resv, f, t, NULL, NULL,
+				 &actual_regions_needed);
 
 	/*
 	 * Check for sufficient descriptors in the cache to accommodate
@@ -513,7 +514,7 @@ static long region_add(struct resv_map *resv, long f, long t,
 		goto retry;
 	}
 
-	add = add_reservation_in_range(resv, f, t, h_cg, h, NULL, false);
+	add = add_reservation_in_range(resv, f, t, h_cg, h, NULL);
 
 	resv->adds_in_progress -= in_regions_needed;
 
@@ -549,9 +550,9 @@ static long region_chg(struct resv_map *resv, long f, long t,
 
 	spin_lock(&resv->lock);
 
-	/* Count how many hugepages in this range are NOT respresented. */
+	/* Count how many hugepages in this range are NOT represented. */
 	chg = add_reservation_in_range(resv, f, t, NULL, NULL,
-				       out_regions_needed, true);
+				       out_regions_needed);
 
 	if (*out_regions_needed == 0)
 		*out_regions_needed = 1;
-- 
2.20.1 (Apple Git-117)

