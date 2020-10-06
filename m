Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2039D284FD0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJFQ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:28:24 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:32786 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725902AbgJFQ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:28:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id BE0C3180A7FE6;
        Tue,  6 Oct 2020 16:28:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:327:355:379:800:960:966:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:2194:2196:2198:2199:2200:2201:2393:2559:2562:2731:2828:3138:3139:3140:3141:3142:3165:3865:3866:3867:3868:3871:4321:4385:4605:5007:7550:7875:7904:8603:9121:9592:10004:10848:11026:11232:11473:11658:11914:12043:12291:12296:12297:12438:12555:12679:12683:12760:12986:13439:14394:14659:21080:21324:21433:21450:21451:21627:21990:30004:30025:30029:30054:30056:30075,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: value80_1013f92271c8
X-Filterd-Recvd-Size: 30504
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Oct 2020 16:28:18 +0000 (UTC)
Message-ID: <8a0d4fc9a4e372b125249b186689f247312d4387.camel@perches.com>
Subject: [PATCH -next] mm: Use sysfs_emit functions not sprintf
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>
Date:   Tue, 06 Oct 2020 09:28:17 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the various uses of sprintf/snprintf/scnprintf to
format sysfs output to sysfs_emit and sysfs_emit_at to make
clear the output is sysfs related and to avoid any possible
buffer overrun of the PAGE_SIZE buffer.

Done with cocci scripts and some typing.

Miscellanea:

o dmapool: Renamed show_pools to pools_show to use DEVICE_ATTR_RO
o hugemem: Convert multiple if (foo) return to cascaded if/else if
           with a single return sysfs_emit
o slub: Convert a couple uses like
	if (foo)
		len += sprintf(buf, len, "%d/%d/%d", a, b, c);
	else
		len += sprintf(buf, len, "%d", a);
  to
	len += sysfs_emit_at(buf, len, "%d", a);
	if (foo)
		len += sysfs_emit_at(buf, len, "/%d/%d", b, c);
o whitespace neatening around these changes

Signed-off-by: Joe Perches <joe@perches.com>
---
Depends on next-20201006
commit 2efc459d06f1 ("sysfs: Add sysfs_emit and sysfs_emit_at to format sysfs output")

 mm/backing-dev.c |   8 ++--
 mm/dmapool.c     |  27 ++++-------
 mm/huge_memory.c |  56 ++++++++++++++---------
 mm/hugetlb.c     |  14 +++---
 mm/khugepaged.c  |  22 ++++-----
 mm/ksm.c         |  32 ++++++-------
 mm/slub.c        | 133 ++++++++++++++++++++++++++-----------------------------
 mm/swap_state.c  |   3 +-
 8 files changed, 148 insertions(+), 147 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 408d5051d05b..faa4baf1931d 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -154,7 +154,7 @@ static ssize_t name##_show(struct device *dev,				\
 {									\
 	struct backing_dev_info *bdi = dev_get_drvdata(dev);		\
 									\
-	return snprintf(page, PAGE_SIZE-1, "%lld\n", (long long)expr);	\
+	return sysfs_emit(page, "%lld\n", (long long)expr);		\
 }									\
 static DEVICE_ATTR_RW(name);
 
@@ -200,11 +200,11 @@ BDI_SHOW(max_ratio, bdi->max_ratio)
 
 static ssize_t stable_pages_required_show(struct device *dev,
 					  struct device_attribute *attr,
-					  char *page)
+					  char *buf)
 {
 	dev_warn_once(dev,
-		"the stable_pages_required attribute has been removed. Use the stable_writes queue attribute instead.\n");
-	return snprintf(page, PAGE_SIZE-1, "%d\n", 0);
+		      "the stable_pages_required attribute has been removed. Use the stable_writes queue attribute instead.\n");
+	return sysfs_emit(buf, "%d\n", 0);
 }
 static DEVICE_ATTR_RO(stable_pages_required);
 
diff --git a/mm/dmapool.c b/mm/dmapool.c
index a97c97232337..c0082c8f8399 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -62,20 +62,13 @@ static DEFINE_MUTEX(pools_lock);
 static DEFINE_MUTEX(pools_reg_lock);
 
 static ssize_t
-show_pools(struct device *dev, struct device_attribute *attr, char *buf)
+pools_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	unsigned temp;
-	unsigned size;
-	char *next;
 	struct dma_page *page;
 	struct dma_pool *pool;
+	int len;
 
-	next = buf;
-	size = PAGE_SIZE;
-
-	temp = scnprintf(next, size, "poolinfo - 0.1\n");
-	size -= temp;
-	next += temp;
+	len = sysfs_emit(buf, "poolinfo - 0.1\n");
 
 	mutex_lock(&pools_lock);
 	list_for_each_entry(pool, &dev->dma_pools, pools) {
@@ -90,19 +83,17 @@ show_pools(struct device *dev, struct device_attribute *attr, char *buf)
 		spin_unlock_irq(&pool->lock);
 
 		/* per-pool info, no real statistics yet */
-		temp = scnprintf(next, size, "%-16s %4u %4zu %4zu %2u\n",
-				 pool->name, blocks,
-				 pages * (pool->allocation / pool->size),
-				 pool->size, pages);
-		size -= temp;
-		next += temp;
+		len += sysfs_emit_at(buf, len, "%-16s %4u %4zu %4zu %2u\n",
+				     pool->name, blocks,
+				     pages * (pool->allocation / pool->size),
+				     pool->size, pages);
 	}
 	mutex_unlock(&pools_lock);
 
-	return PAGE_SIZE - size;
+	return len;
 }
 
-static DEVICE_ATTR(pools, 0444, show_pools, NULL);
+static DEVICE_ATTR_RO(pools);
 
 /**
  * dma_pool_create - Creates a pool of consistent memory blocks, for dma.
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cba3812a5c3e..02412cb27168 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -163,12 +163,17 @@ static struct shrinker huge_zero_page_shrinker = {
 static ssize_t enabled_show(struct kobject *kobj,
 			    struct kobj_attribute *attr, char *buf)
 {
+	const char *output;
+
 	if (test_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags))
-		return sprintf(buf, "[always] madvise never\n");
-	else if (test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags))
-		return sprintf(buf, "always [madvise] never\n");
+		output = "[always] madvise never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
+			  &transparent_hugepage_flags))
+		output = "always [madvise] never";
 	else
-		return sprintf(buf, "always madvise [never]\n");
+		output = "always madvise [never]";
+
+	return sysfs_emit(buf, "%s\n", output);
 }
 
 static ssize_t enabled_store(struct kobject *kobj,
@@ -200,11 +205,11 @@ static struct kobj_attribute enabled_attr =
 	__ATTR(enabled, 0644, enabled_show, enabled_store);
 
 ssize_t single_hugepage_flag_show(struct kobject *kobj,
-				struct kobj_attribute *attr, char *buf,
-				enum transparent_hugepage_flag flag)
+				  struct kobj_attribute *attr, char *buf,
+				  enum transparent_hugepage_flag flag)
 {
-	return sprintf(buf, "%d\n",
-		       !!test_bit(flag, &transparent_hugepage_flags));
+	return sysfs_emit(buf, "%d\n",
+			  !!test_bit(flag, &transparent_hugepage_flags));
 }
 
 ssize_t single_hugepage_flag_store(struct kobject *kobj,
@@ -232,15 +237,24 @@ ssize_t single_hugepage_flag_store(struct kobject *kobj,
 static ssize_t defrag_show(struct kobject *kobj,
 			   struct kobj_attribute *attr, char *buf)
 {
-	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
-		return sprintf(buf, "[always] defer defer+madvise madvise never\n");
-	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags))
-		return sprintf(buf, "always [defer] defer+madvise madvise never\n");
-	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags))
-		return sprintf(buf, "always defer [defer+madvise] madvise never\n");
-	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags))
-		return sprintf(buf, "always defer defer+madvise [madvise] never\n");
-	return sprintf(buf, "always defer defer+madvise madvise [never]\n");
+	const char *output;
+
+	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
+		     &transparent_hugepage_flags))
+		output = "[always] defer defer+madvise madvise never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
+			  &transparent_hugepage_flags))
+		output = "always [defer] defer+madvise madvise never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG,
+			  &transparent_hugepage_flags))
+		output = "always defer [defer+madvise] madvise never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
+			  &transparent_hugepage_flags))
+		output = "always defer defer+madvise [madvise] never";
+	else
+		output = "always defer defer+madvise madvise [never]";
+
+	return sysfs_emit(buf, "%s\n", output);
 }
 
 static ssize_t defrag_store(struct kobject *kobj,
@@ -281,10 +295,10 @@ static struct kobj_attribute defrag_attr =
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
@@ -296,9 +310,9 @@ static struct kobj_attribute use_zero_page_attr =
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
index fe76f8fd5a73..d919542ff6e5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2837,7 +2837,7 @@ static ssize_t nr_hugepages_show_common(struct kobject *kobj,
 	else
 		nr_huge_pages = h->nr_huge_pages_node[nid];
 
-	return sprintf(buf, "%lu\n", nr_huge_pages);
+	return sysfs_emit(buf, "%lu\n", nr_huge_pages);
 }
 
 static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
@@ -2910,7 +2910,8 @@ HSTATE_ATTR(nr_hugepages);
  * huge page alloc/free.
  */
 static ssize_t nr_hugepages_mempolicy_show(struct kobject *kobj,
-				       struct kobj_attribute *attr, char *buf)
+					   struct kobj_attribute *attr,
+					   char *buf)
 {
 	return nr_hugepages_show_common(kobj, attr, buf);
 }
@@ -2928,7 +2929,7 @@ static ssize_t nr_overcommit_hugepages_show(struct kobject *kobj,
 					struct kobj_attribute *attr, char *buf)
 {
 	struct hstate *h = kobj_to_hstate(kobj, NULL);
-	return sprintf(buf, "%lu\n", h->nr_overcommit_huge_pages);
+	return sysfs_emit(buf, "%lu\n", h->nr_overcommit_huge_pages);
 }
 
 static ssize_t nr_overcommit_hugepages_store(struct kobject *kobj,
@@ -2966,7 +2967,7 @@ static ssize_t free_hugepages_show(struct kobject *kobj,
 	else
 		free_huge_pages = h->free_huge_pages_node[nid];
 
-	return sprintf(buf, "%lu\n", free_huge_pages);
+	return sysfs_emit(buf, "%lu\n", free_huge_pages);
 }
 HSTATE_ATTR_RO(free_hugepages);
 
@@ -2974,7 +2975,8 @@ static ssize_t resv_hugepages_show(struct kobject *kobj,
 					struct kobj_attribute *attr, char *buf)
 {
 	struct hstate *h = kobj_to_hstate(kobj, NULL);
-	return sprintf(buf, "%lu\n", h->resv_huge_pages);
+
+	return sysfs_emit(buf, "%lu\n", h->resv_huge_pages);
 }
 HSTATE_ATTR_RO(resv_hugepages);
 
@@ -2991,7 +2993,7 @@ static ssize_t surplus_hugepages_show(struct kobject *kobj,
 	else
 		surplus_huge_pages = h->surplus_huge_pages_node[nid];
 
-	return sprintf(buf, "%lu\n", surplus_huge_pages);
+	return sysfs_emit(buf, "%lu\n", surplus_huge_pages);
 }
 HSTATE_ATTR_RO(surplus_hugepages);
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f1d5f6dde47c..28dcaca63f2b 100644
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
index 9afccc36dbd2..3c7f7a1101c5 100644
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
 
diff --git a/mm/slub.c b/mm/slub.c
index 8f66de8a5ab3..7ae323bd77ac 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4735,7 +4735,7 @@ static int list_locations(struct kmem_cache *s, char *buf,
 
 	if (!alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
 			     GFP_KERNEL)) {
-		return sprintf(buf, "Out of memory\n");
+		return sysfs_emit(buf, "Out of memory\n");
 	}
 	/* Push back cpu slabs */
 	flush_all(s);
@@ -4758,50 +4758,41 @@ static int list_locations(struct kmem_cache *s, char *buf,
 	for (i = 0; i < t.count; i++) {
 		struct location *l = &t.loc[i];
 
-		if (len > PAGE_SIZE - KSYM_SYMBOL_LEN - 100)
-			break;
-		len += sprintf(buf + len, "%7ld ", l->count);
+		len += sysfs_emit_at(buf, len, "%7ld ", l->count);
 
 		if (l->addr)
-			len += sprintf(buf + len, "%pS", (void *)l->addr);
+			len += sysfs_emit_at(buf, len, "%pS", (void *)l->addr);
 		else
-			len += sprintf(buf + len, "<not-available>");
+			len += sysfs_emit_at(buf, len, "<not-available>");
 
-		if (l->sum_time != l->min_time) {
-			len += sprintf(buf + len, " age=%ld/%ld/%ld",
-				l->min_time,
-				(long)div_u64(l->sum_time, l->count),
-				l->max_time);
-		} else
-			len += sprintf(buf + len, " age=%ld",
-				l->min_time);
+		len += sysfs_emit_at(buf, len, " age=%ld", l->min_time);
+		if (l->sum_time != l->min_time)
+			len += sysfs_emit_at(buf, len, "%ld/%ld",
+					     (long)div_u64(l->sum_time,
+							   l->count),
+					     l->max_time);
 
+		len += sysfs_emit_at(buf, len, " pid=%ld", l->min_pid);
 		if (l->min_pid != l->max_pid)
-			len += sprintf(buf + len, " pid=%ld-%ld",
-				l->min_pid, l->max_pid);
-		else
-			len += sprintf(buf + len, " pid=%ld",
-				l->min_pid);
+			len += sysfs_emit_at(buf, len, "-%ld", l->max_pid);
 
 		if (num_online_cpus() > 1 &&
-				!cpumask_empty(to_cpumask(l->cpus)) &&
-				len < PAGE_SIZE - 60)
-			len += scnprintf(buf + len, PAGE_SIZE - len - 50,
-					 " cpus=%*pbl",
-					 cpumask_pr_args(to_cpumask(l->cpus)));
-
-		if (nr_online_nodes > 1 && !nodes_empty(l->nodes) &&
-				len < PAGE_SIZE - 60)
-			len += scnprintf(buf + len, PAGE_SIZE - len - 50,
-					 " nodes=%*pbl",
-					 nodemask_pr_args(&l->nodes));
-
-		len += sprintf(buf + len, "\n");
+		    !cpumask_empty(to_cpumask(l->cpus)))
+			len += sysfs_emit_at(buf, len, " cpus=%*pbl",
+					     cpumask_pr_args(to_cpumask(l->cpus)));
+
+		if (nr_online_nodes > 1 && !nodes_empty(l->nodes))
+			len += sysfs_emit_at(buf, len, " nodes=%*pbl",
+					     nodemask_pr_args(&l->nodes));
+
+		len += sysfs_emit_at(buf, len, "\n");
 	}
 
 	free_loc_track(&t);
+
 	if (!t.count)
-		len += sprintf(buf, "No data\n");
+		len += sysfs_emit_at(buf, len, "No data\n");
+
 	return len;
 }
 #endif	/* CONFIG_SLUB_DEBUG */
@@ -4903,6 +4894,7 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 	unsigned long total = 0;
 	int node;
 	int x;
+	int len;
 	unsigned long *nodes;
 
 	nodes = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
@@ -4992,15 +4984,17 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 			nodes[node] += x;
 		}
 	}
-	x = sprintf(buf, "%lu", total);
+
+	len = sysfs_emit(buf, "%lu", total);
 #ifdef CONFIG_NUMA
 	for (node = 0; node < nr_node_ids; node++)
 		if (nodes[node])
-			x += sprintf(buf + x, " N%d=%lu",
-					node, nodes[node]);
+			len += sysfs_emit_at(buf, len, " N%d=%lu",
+					     node, nodes[node]);
 #endif
 	kfree(nodes);
-	return x + sprintf(buf + x, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
+	return len;
 }
 
 #define to_slab_attr(n) container_of(n, struct slab_attribute, attr)
@@ -5022,37 +5016,37 @@ struct slab_attribute {
 
 static ssize_t slab_size_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", s->size);
+	return sysfs_emit(buf, "%u\n", s->size);
 }
 SLAB_ATTR_RO(slab_size);
 
 static ssize_t align_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", s->align);
+	return sysfs_emit(buf, "%u\n", s->align);
 }
 SLAB_ATTR_RO(align);
 
 static ssize_t object_size_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", s->object_size);
+	return sysfs_emit(buf, "%u\n", s->object_size);
 }
 SLAB_ATTR_RO(object_size);
 
 static ssize_t objs_per_slab_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", oo_objects(s->oo));
+	return sysfs_emit(buf, "%u\n", oo_objects(s->oo));
 }
 SLAB_ATTR_RO(objs_per_slab);
 
 static ssize_t order_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", oo_order(s->oo));
+	return sysfs_emit(buf, "%u\n", oo_order(s->oo));
 }
 SLAB_ATTR_RO(order);
 
 static ssize_t min_partial_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%lu\n", s->min_partial);
+	return sysfs_emit(buf, "%lu\n", s->min_partial);
 }
 
 static ssize_t min_partial_store(struct kmem_cache *s, const char *buf,
@@ -5072,7 +5066,7 @@ SLAB_ATTR(min_partial);
 
 static ssize_t cpu_partial_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", slub_cpu_partial(s));
+	return sysfs_emit(buf, "%u\n", slub_cpu_partial(s));
 }
 
 static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
@@ -5097,13 +5091,13 @@ static ssize_t ctor_show(struct kmem_cache *s, char *buf)
 {
 	if (!s->ctor)
 		return 0;
-	return sprintf(buf, "%pS\n", s->ctor);
+	return sysfs_emit(buf, "%pS\n", s->ctor);
 }
 SLAB_ATTR_RO(ctor);
 
 static ssize_t aliases_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", s->refcount < 0 ? 0 : s->refcount - 1);
+	return sysfs_emit(buf, "%d\n", s->refcount < 0 ? 0 : s->refcount - 1);
 }
 SLAB_ATTR_RO(aliases);
 
@@ -5149,20 +5143,19 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 		}
 	}
 
-	len = sprintf(buf, "%d(%d)", objects, pages);
+	len = sysfs_emit(buf, "%d(%d)", objects, pages);
 
 #ifdef CONFIG_SMP
 	for_each_online_cpu(cpu) {
 		struct page *page;
 
 		page = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
-
-		if (page && len < PAGE_SIZE - 20)
-			len += sprintf(buf + len, " C%d=%d(%d)", cpu,
-				page->pobjects, page->pages);
+		len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
+				     cpu, page->pobjects, page->pages);
 	}
 #endif
-	return len + sprintf(buf + len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
+	return len;
 }
 SLAB_ATTR_RO(slabs_cpu_partial);
 
@@ -5174,27 +5167,27 @@ SLAB_ATTR_RO(reclaim_account);
 
 static ssize_t hwcache_align_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_HWCACHE_ALIGN));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_HWCACHE_ALIGN));
 }
 SLAB_ATTR_RO(hwcache_align);
 
 #ifdef CONFIG_ZONE_DMA
 static ssize_t cache_dma_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_CACHE_DMA));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_CACHE_DMA));
 }
 SLAB_ATTR_RO(cache_dma);
 #endif
 
 static ssize_t usersize_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", s->usersize);
+	return sysfs_emit(buf, "%u\n", s->usersize);
 }
 SLAB_ATTR_RO(usersize);
 
 static ssize_t destroy_by_rcu_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_TYPESAFE_BY_RCU));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_TYPESAFE_BY_RCU));
 }
 SLAB_ATTR_RO(destroy_by_rcu);
 
@@ -5213,33 +5206,33 @@ SLAB_ATTR_RO(total_objects);
 
 static ssize_t sanity_checks_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_CONSISTENCY_CHECKS));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_CONSISTENCY_CHECKS));
 }
 SLAB_ATTR_RO(sanity_checks);
 
 static ssize_t trace_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_TRACE));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_TRACE));
 }
 SLAB_ATTR_RO(trace);
 
 static ssize_t red_zone_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_RED_ZONE));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_RED_ZONE));
 }
 
 SLAB_ATTR_RO(red_zone);
 
 static ssize_t poison_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_POISON));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_POISON));
 }
 
 SLAB_ATTR_RO(poison);
 
 static ssize_t store_user_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_STORE_USER));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_STORE_USER));
 }
 
 SLAB_ATTR_RO(store_user);
@@ -5283,7 +5276,7 @@ SLAB_ATTR_RO(free_calls);
 #ifdef CONFIG_FAILSLAB
 static ssize_t failslab_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_FAILSLAB));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_FAILSLAB));
 }
 SLAB_ATTR_RO(failslab);
 #endif
@@ -5307,7 +5300,7 @@ SLAB_ATTR(shrink);
 #ifdef CONFIG_NUMA
 static ssize_t remote_node_defrag_ratio_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", s->remote_node_defrag_ratio / 10);
+	return sysfs_emit(buf, "%u\n", s->remote_node_defrag_ratio / 10);
 }
 
 static ssize_t remote_node_defrag_ratio_store(struct kmem_cache *s,
@@ -5332,7 +5325,7 @@ SLAB_ATTR(remote_node_defrag_ratio);
 #ifdef CONFIG_SLUB_STATS
 static int show_stat(struct kmem_cache *s, char *buf, enum stat_item si)
 {
-	unsigned long sum  = 0;
+	unsigned long sum = 0;
 	int cpu;
 	int len;
 	int *data = kmalloc_array(nr_cpu_ids, sizeof(int), GFP_KERNEL);
@@ -5347,16 +5340,16 @@ static int show_stat(struct kmem_cache *s, char *buf, enum stat_item si)
 		sum += x;
 	}
 
-	len = sprintf(buf, "%lu", sum);
+	len = sysfs_emit(buf, "%lu", sum);
 
 #ifdef CONFIG_SMP
-	for_each_online_cpu(cpu) {
-		if (data[cpu] && len < PAGE_SIZE - 20)
-			len += sprintf(buf + len, " C%d=%u", cpu, data[cpu]);
-	}
+	for_each_online_cpu(cpu)
+		len += sysfs_emit_at(buf, len, " C%d=%u", cpu, data[cpu]);
 #endif
 	kfree(data);
-	return len + sprintf(buf + len, "\n");
+
+	len += sysfs_emit_at(buf, len, "\n");
+	return len;
 }
 
 static void clear_stat(struct kmem_cache *s, enum stat_item si)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ee465827420e..aeb5bc4d64ec 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -900,7 +900,8 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 static ssize_t vma_ra_enabled_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%s\n", enable_vma_readahead ? "true" : "false");
+	return sysfs_emit(buf, "%s\n",
+			  enable_vma_readahead ? "true" : "false");
 }
 static ssize_t vma_ra_enabled_store(struct kobject *kobj,
 				      struct kobj_attribute *attr,


