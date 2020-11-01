Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2861D2A213E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 21:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgKAUNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 15:13:02 -0500
Received: from smtprelay0049.hostedemail.com ([216.40.44.49]:34132 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgKAUNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 15:13:01 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2CFA212FB;
        Sun,  1 Nov 2020 20:13:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:4:41:69:355:379:541:800:960:966:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1605:1730:1747:1777:1792:2196:2199:2393:2559:2562:2640:3138:3139:3140:3141:3142:3865:3866:3867:3870:4321:4385:4605:5007:6261:10004:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12683:12895:12986:13894:14110:14394:21080:21324:21433:21451:21611:21627:21990:30054:30056,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: star69_2510d10272aa
X-Filterd-Recvd-Size: 15336
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Nov 2020 20:12:59 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] mm: Use sysfs_emit for struct kobject * uses
Date:   Sun,  1 Nov 2020 12:12:48 -0800
Message-Id: <bdacbb8d04f468436adaccd5c9c9dd330c4bff0c.1604261483.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1604261483.git.joe@perches.com>
References: <cover.1604261483.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the sysfs_emit function instead of the sprintf family.

Done with cocci script as in commit 3c6bff3cf988
("RDMA: Convert sysfs kobject * show functions to use sysfs_emit()")

Signed-off-by: Joe Perches <joe@perches.com>
---
 mm/huge_memory.c | 28 ++++++++++++++++------------
 mm/hugetlb.c     | 13 +++++++------
 mm/khugepaged.c  | 22 +++++++++++-----------
 mm/ksm.c         | 32 ++++++++++++++++----------------
 mm/swap_state.c  |  3 ++-
 5 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 08a183f6c3ab..44826bf3d9ff 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -164,11 +164,11 @@ static ssize_t enabled_show(struct kobject *kobj,
 			    struct kobj_attribute *attr, char *buf)
 {
 	if (test_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags))
-		return sprintf(buf, "[always] madvise never\n");
+		return sysfs_emit(buf, "[always] madvise never\n");
 	else if (test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags))
-		return sprintf(buf, "always [madvise] never\n");
+		return sysfs_emit(buf, "always [madvise] never\n");
 	else
-		return sprintf(buf, "always madvise [never]\n");
+		return sysfs_emit(buf, "always madvise [never]\n");
 }
 
 static ssize_t enabled_store(struct kobject *kobj,
@@ -233,14 +233,18 @@ static ssize_t defrag_show(struct kobject *kobj,
 			   struct kobj_attribute *attr, char *buf)
 {
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
-		return sprintf(buf, "[always] defer defer+madvise madvise never\n");
+		return sysfs_emit(buf,
+				  "[always] defer defer+madvise madvise never\n");
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags))
-		return sprintf(buf, "always [defer] defer+madvise madvise never\n");
+		return sysfs_emit(buf,
+				  "always [defer] defer+madvise madvise never\n");
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags))
-		return sprintf(buf, "always defer [defer+madvise] madvise never\n");
+		return sysfs_emit(buf,
+				  "always defer [defer+madvise] madvise never\n");
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags))
-		return sprintf(buf, "always defer defer+madvise [madvise] never\n");
-	return sprintf(buf, "always defer defer+madvise madvise [never]\n");
+		return sysfs_emit(buf,
+				  "always defer defer+madvise [madvise] never\n");
+	return sysfs_emit(buf, "always defer defer+madvise madvise [never]\n");
 }
 
 static ssize_t defrag_store(struct kobject *kobj,
@@ -281,10 +285,10 @@ static struct kobj_attribute defrag_attr =
 	__ATTR(defrag, 0644, defrag_show, defrag_store);
 
 static ssize_t use_zero_page_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
+				  struct kobj_attribute *attr, char *buf)
 {
 	return single_hugepage_flag_show(kobj, attr, buf,
-				TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
+					 TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
 }
 static ssize_t use_zero_page_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
@@ -296,9 +300,9 @@ static struct kobj_attribute use_zero_page_attr =
 	__ATTR(use_zero_page, 0644, use_zero_page_show, use_zero_page_store);
 
 static ssize_t hpage_pmd_size_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
+				   struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", HPAGE_PMD_SIZE);
+	return sysfs_emit(buf, "%lu\n", HPAGE_PMD_SIZE);
 }
 static struct kobj_attribute hpage_pmd_size_attr =
 	__ATTR_RO(hpage_pmd_size);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f006ad68e2d6..e29c0b6a3349 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2838,7 +2838,7 @@ static ssize_t nr_hugepages_show_common(struct kobject *kobj,
 	else
 		nr_huge_pages = h->nr_huge_pages_node[nid];
 
-	return sprintf(buf, "%lu\n", nr_huge_pages);
+	return sysfs_emit(buf, "%lu\n", nr_huge_pages);
 }
 
 static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
@@ -2911,7 +2911,8 @@ HSTATE_ATTR(nr_hugepages);
  * huge page alloc/free.
  */
 static ssize_t nr_hugepages_mempolicy_show(struct kobject *kobj,
-				       struct kobj_attribute *attr, char *buf)
+					   struct kobj_attribute *attr,
+					   char *buf)
 {
 	return nr_hugepages_show_common(kobj, attr, buf);
 }
@@ -2929,7 +2930,7 @@ static ssize_t nr_overcommit_hugepages_show(struct kobject *kobj,
 					struct kobj_attribute *attr, char *buf)
 {
 	struct hstate *h = kobj_to_hstate(kobj, NULL);
-	return sprintf(buf, "%lu\n", h->nr_overcommit_huge_pages);
+	return sysfs_emit(buf, "%lu\n", h->nr_overcommit_huge_pages);
 }
 
 static ssize_t nr_overcommit_hugepages_store(struct kobject *kobj,
@@ -2967,7 +2968,7 @@ static ssize_t free_hugepages_show(struct kobject *kobj,
 	else
 		free_huge_pages = h->free_huge_pages_node[nid];
 
-	return sprintf(buf, "%lu\n", free_huge_pages);
+	return sysfs_emit(buf, "%lu\n", free_huge_pages);
 }
 HSTATE_ATTR_RO(free_hugepages);
 
@@ -2975,7 +2976,7 @@ static ssize_t resv_hugepages_show(struct kobject *kobj,
 					struct kobj_attribute *attr, char *buf)
 {
 	struct hstate *h = kobj_to_hstate(kobj, NULL);
-	return sprintf(buf, "%lu\n", h->resv_huge_pages);
+	return sysfs_emit(buf, "%lu\n", h->resv_huge_pages);
 }
 HSTATE_ATTR_RO(resv_hugepages);
 
@@ -2992,7 +2993,7 @@ static ssize_t surplus_hugepages_show(struct kobject *kobj,
 	else
 		surplus_huge_pages = h->surplus_huge_pages_node[nid];
 
-	return sprintf(buf, "%lu\n", surplus_huge_pages);
+	return sysfs_emit(buf, "%lu\n", surplus_huge_pages);
 }
 HSTATE_ATTR_RO(surplus_hugepages);
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 757292532767..dddfc554b0f9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -124,7 +124,7 @@ static ssize_t scan_sleep_millisecs_show(struct kobject *kobj,
 					 struct kobj_attribute *attr,
 					 char *buf)
 {
-	return sprintf(buf, "%u\n", khugepaged_scan_sleep_millisecs);
+	return sysfs_emit(buf, "%u\n", khugepaged_scan_sleep_millisecs);
 }
 
 static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
@@ -152,7 +152,7 @@ static ssize_t alloc_sleep_millisecs_show(struct kobject *kobj,
 					  struct kobj_attribute *attr,
 					  char *buf)
 {
-	return sprintf(buf, "%u\n", khugepaged_alloc_sleep_millisecs);
+	return sysfs_emit(buf, "%u\n", khugepaged_alloc_sleep_millisecs);
 }
 
 static ssize_t alloc_sleep_millisecs_store(struct kobject *kobj,
@@ -180,7 +180,7 @@ static ssize_t pages_to_scan_show(struct kobject *kobj,
 				  struct kobj_attribute *attr,
 				  char *buf)
 {
-	return sprintf(buf, "%u\n", khugepaged_pages_to_scan);
+	return sysfs_emit(buf, "%u\n", khugepaged_pages_to_scan);
 }
 static ssize_t pages_to_scan_store(struct kobject *kobj,
 				   struct kobj_attribute *attr,
@@ -205,7 +205,7 @@ static ssize_t pages_collapsed_show(struct kobject *kobj,
 				    struct kobj_attribute *attr,
 				    char *buf)
 {
-	return sprintf(buf, "%u\n", khugepaged_pages_collapsed);
+	return sysfs_emit(buf, "%u\n", khugepaged_pages_collapsed);
 }
 static struct kobj_attribute pages_collapsed_attr =
 	__ATTR_RO(pages_collapsed);
@@ -214,7 +214,7 @@ static ssize_t full_scans_show(struct kobject *kobj,
 			       struct kobj_attribute *attr,
 			       char *buf)
 {
-	return sprintf(buf, "%u\n", khugepaged_full_scans);
+	return sysfs_emit(buf, "%u\n", khugepaged_full_scans);
 }
 static struct kobj_attribute full_scans_attr =
 	__ATTR_RO(full_scans);
@@ -223,7 +223,7 @@ static ssize_t khugepaged_defrag_show(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *buf)
 {
 	return single_hugepage_flag_show(kobj, attr, buf,
-				TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG);
+					 TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG);
 }
 static ssize_t khugepaged_defrag_store(struct kobject *kobj,
 				       struct kobj_attribute *attr,
@@ -248,7 +248,7 @@ static ssize_t khugepaged_max_ptes_none_show(struct kobject *kobj,
 					     struct kobj_attribute *attr,
 					     char *buf)
 {
-	return sprintf(buf, "%u\n", khugepaged_max_ptes_none);
+	return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_none);
 }
 static ssize_t khugepaged_max_ptes_none_store(struct kobject *kobj,
 					      struct kobj_attribute *attr,
@@ -273,7 +273,7 @@ static ssize_t khugepaged_max_ptes_swap_show(struct kobject *kobj,
 					     struct kobj_attribute *attr,
 					     char *buf)
 {
-	return sprintf(buf, "%u\n", khugepaged_max_ptes_swap);
+	return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_swap);
 }
 
 static ssize_t khugepaged_max_ptes_swap_store(struct kobject *kobj,
@@ -297,10 +297,10 @@ static struct kobj_attribute khugepaged_max_ptes_swap_attr =
 	       khugepaged_max_ptes_swap_store);
 
 static ssize_t khugepaged_max_ptes_shared_show(struct kobject *kobj,
-					     struct kobj_attribute *attr,
-					     char *buf)
+					       struct kobj_attribute *attr,
+					       char *buf)
 {
-	return sprintf(buf, "%u\n", khugepaged_max_ptes_shared);
+	return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_shared);
 }
 
 static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
diff --git a/mm/ksm.c b/mm/ksm.c
index 0960750bb316..4f950c70fbcf 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2833,7 +2833,7 @@ static void wait_while_offlining(void)
 static ssize_t sleep_millisecs_show(struct kobject *kobj,
 				    struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", ksm_thread_sleep_millisecs);
+	return sysfs_emit(buf, "%u\n", ksm_thread_sleep_millisecs);
 }
 
 static ssize_t sleep_millisecs_store(struct kobject *kobj,
@@ -2857,7 +2857,7 @@ KSM_ATTR(sleep_millisecs);
 static ssize_t pages_to_scan_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", ksm_thread_pages_to_scan);
+	return sysfs_emit(buf, "%u\n", ksm_thread_pages_to_scan);
 }
 
 static ssize_t pages_to_scan_store(struct kobject *kobj,
@@ -2880,7 +2880,7 @@ KSM_ATTR(pages_to_scan);
 static ssize_t run_show(struct kobject *kobj, struct kobj_attribute *attr,
 			char *buf)
 {
-	return sprintf(buf, "%lu\n", ksm_run);
+	return sysfs_emit(buf, "%lu\n", ksm_run);
 }
 
 static ssize_t run_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -2927,9 +2927,9 @@ KSM_ATTR(run);
 
 #ifdef CONFIG_NUMA
 static ssize_t merge_across_nodes_show(struct kobject *kobj,
-				struct kobj_attribute *attr, char *buf)
+				       struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", ksm_merge_across_nodes);
+	return sysfs_emit(buf, "%u\n", ksm_merge_across_nodes);
 }
 
 static ssize_t merge_across_nodes_store(struct kobject *kobj,
@@ -2984,9 +2984,9 @@ KSM_ATTR(merge_across_nodes);
 #endif
 
 static ssize_t use_zero_pages_show(struct kobject *kobj,
-				struct kobj_attribute *attr, char *buf)
+				   struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", ksm_use_zero_pages);
+	return sysfs_emit(buf, "%u\n", ksm_use_zero_pages);
 }
 static ssize_t use_zero_pages_store(struct kobject *kobj,
 				   struct kobj_attribute *attr,
@@ -3008,7 +3008,7 @@ KSM_ATTR(use_zero_pages);
 static ssize_t max_page_sharing_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", ksm_max_page_sharing);
+	return sysfs_emit(buf, "%u\n", ksm_max_page_sharing);
 }
 
 static ssize_t max_page_sharing_store(struct kobject *kobj,
@@ -3049,21 +3049,21 @@ KSM_ATTR(max_page_sharing);
 static ssize_t pages_shared_show(struct kobject *kobj,
 				 struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", ksm_pages_shared);
+	return sysfs_emit(buf, "%lu\n", ksm_pages_shared);
 }
 KSM_ATTR_RO(pages_shared);
 
 static ssize_t pages_sharing_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", ksm_pages_sharing);
+	return sysfs_emit(buf, "%lu\n", ksm_pages_sharing);
 }
 KSM_ATTR_RO(pages_sharing);
 
 static ssize_t pages_unshared_show(struct kobject *kobj,
 				   struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", ksm_pages_unshared);
+	return sysfs_emit(buf, "%lu\n", ksm_pages_unshared);
 }
 KSM_ATTR_RO(pages_unshared);
 
@@ -3080,21 +3080,21 @@ static ssize_t pages_volatile_show(struct kobject *kobj,
 	 */
 	if (ksm_pages_volatile < 0)
 		ksm_pages_volatile = 0;
-	return sprintf(buf, "%ld\n", ksm_pages_volatile);
+	return sysfs_emit(buf, "%ld\n", ksm_pages_volatile);
 }
 KSM_ATTR_RO(pages_volatile);
 
 static ssize_t stable_node_dups_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", ksm_stable_node_dups);
+	return sysfs_emit(buf, "%lu\n", ksm_stable_node_dups);
 }
 KSM_ATTR_RO(stable_node_dups);
 
 static ssize_t stable_node_chains_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", ksm_stable_node_chains);
+	return sysfs_emit(buf, "%lu\n", ksm_stable_node_chains);
 }
 KSM_ATTR_RO(stable_node_chains);
 
@@ -3103,7 +3103,7 @@ stable_node_chains_prune_millisecs_show(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					char *buf)
 {
-	return sprintf(buf, "%u\n", ksm_stable_node_chains_prune_millisecs);
+	return sysfs_emit(buf, "%u\n", ksm_stable_node_chains_prune_millisecs);
 }
 
 static ssize_t
@@ -3127,7 +3127,7 @@ KSM_ATTR(stable_node_chains_prune_millisecs);
 static ssize_t full_scans_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", ksm_scan.seqnr);
+	return sysfs_emit(buf, "%lu\n", ksm_scan.seqnr);
 }
 KSM_ATTR_RO(full_scans);
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index cf7b322a9abc..751c1ef2fe0e 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -902,7 +902,8 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 static ssize_t vma_ra_enabled_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%s\n", enable_vma_readahead ? "true" : "false");
+	return sysfs_emit(buf, "%s\n",
+			  enable_vma_readahead ? "true" : "false");
 }
 static ssize_t vma_ra_enabled_store(struct kobject *kobj,
 				      struct kobj_attribute *attr,
-- 
2.26.0

