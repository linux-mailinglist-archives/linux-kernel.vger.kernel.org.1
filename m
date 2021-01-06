Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3C72EB8A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbhAFDuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbhAFDuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:50:05 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B44AC06134D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 19:49:25 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id g15so1307964pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 19:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=lBE80DiAzCuDP+elt7sPeA0KPPaJzTapNwV8hoLlirQ=;
        b=W8Pm970WT8FFS7c4tyriVgv2cemuMNsVjehuv4bTaBQG4EP72fQTKcRS4hC6iCFgGA
         GZPh+sHECl8dvAeT5ziEuwLVbU3PEtw0Zl59MJafVSelkpvsDbvjgaGQDgR5nRc1aVkn
         WdCjXHX/Kmpt+yGin+lPMMJoLmmH79LHt4XrxX600mYx0tRRzFTaBEbgXrqaWdVqy/bD
         7GWGKiKuil+h6Ov9tmxPWhzRmhScMTYz+8EZaztYRn3Z6ceIfvlR3H2Rg4qhC9i+wzpj
         yTNG95NM/FypjtwKs0GqcYwdoUMyyszGPHXLKwVEwqQlSl864GzcvCAQIcpruE1wpwjV
         BlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=lBE80DiAzCuDP+elt7sPeA0KPPaJzTapNwV8hoLlirQ=;
        b=e0xK5rG+Juf5J+7lq52WrHS/YYvXhAHGwKsIKMdI0gG9wDEVA8blYX3xqf8l13VqbF
         6UmI3VpyDrl7/NFCg7LX8EqNoSquyqKhUH0aVKqbSgKeOFqSVpVCHTFU77u00TsOiXLu
         awsEvPUB8Jlwtc4uZc37mD8mTShVEEewp5+8eWkJyvq7WeHpDAT2z/V70jBbPfLeeWXG
         fXXUEu5i032wXtrJMLR507SrtgzzxtHNyYgkVqtCcmXhYBPkKi2wfM0B4ZvkDJuosCyj
         cMmExPa7IddSAjQaukJcomTTsffnXAiPlg/I8kgwYgFdFNFrGk8EG1G2SwwFG+Lc0W/X
         U9OQ==
X-Gm-Message-State: AOAM531YdSP4qq4Kui/7JEjB9nOTYC+bl9p67cPKpH70cu9QH6kZCXNt
        X7Vcf8opfInf5dNiHHQltk0=
X-Google-Smtp-Source: ABdhPJwJ7UdmD8BKDrUkc1RIlVmeVrXZ6wfPFNrq3eR262WncT+CTOqeixq3iU9ed44Jo2b7NrHRSw==
X-Received: by 2002:a63:4426:: with SMTP id r38mr2353171pga.240.1609904964843;
        Tue, 05 Jan 2021 19:49:24 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id g202sm703405pfb.196.2021.01.05.19.49.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 19:49:24 -0800 (PST)
From:   Liang Li <liliang324@gmail.com>
X-Google-Original-From: Liang Li <liliangleo@didiglobal.com>
Date:   Tue, 5 Jan 2021 22:49:21 -0500
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Liang Li <liliang324@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 3/6] hugetlb: add free page reporting support
Message-ID: <20210106034918.GA1154@open-light-1.localdomain>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb manages its page in hstate's free page list, not in buddy
system, this patch try to make it works for hugetlbfs. It canbe
used for memory overcommit in virtualization and hugetlb pre zero
out.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Liang Li <liliang324@gmail.com>
Signed-off-by: Liang Li <liliangleo@didiglobal.com>
---
 include/linux/hugetlb.h        |   3 +
 include/linux/page_reporting.h |   4 +
 mm/Kconfig                     |   1 +
 mm/hugetlb.c                   |  19 +++
 mm/page_reporting.c            | 297 +++++++++++++++++++++++++++++++++
 mm/page_reporting.h            |  34 ++++
 6 files changed, 358 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ebca2ef02212..d55e6a00b3dc 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -11,6 +11,7 @@
 #include <linux/kref.h>
 #include <linux/pgtable.h>
 #include <linux/gfp.h>
+#include <linux/page_reporting.h>
 
 struct ctl_table;
 struct user_struct;
@@ -114,6 +115,8 @@ int hugetlb_treat_movable_handler(struct ctl_table *, int, void *, size_t *,
 int hugetlb_mempolicy_sysctl_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 
+void isolate_free_huge_page(struct page *page, struct hstate *h, int nid);
+void putback_isolate_huge_page(struct hstate *h, struct page *page);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
 long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
 			 struct page **, struct vm_area_struct **,
diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index 63e1e9fbcaa2..884afa2ad70c 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -26,4 +26,8 @@ struct page_reporting_dev_info {
 /* Tear-down and bring-up for page reporting devices */
 void page_reporting_unregister(struct page_reporting_dev_info *prdev);
 int page_reporting_register(struct page_reporting_dev_info *prdev);
+
+/* Tear-down and bring-up for hugepage reporting devices */
+void hugepage_reporting_unregister(struct page_reporting_dev_info *prdev);
+int hugepage_reporting_register(struct page_reporting_dev_info *prdev);
 #endif /*_LINUX_PAGE_REPORTING_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 4275c25b5d8a..630cde982186 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -247,6 +247,7 @@ config COMPACTION
 config PAGE_REPORTING
 	bool "Free page reporting"
 	def_bool n
+	select HUGETLBFS
 	help
 	  Free page reporting allows for the incremental acquisition of
 	  free pages from the buddy allocator for the purpose of reporting
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cbf32d2824fd..eb533995cb49 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -41,6 +41,7 @@
 #include <linux/node.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/page_owner.h>
+#include "page_reporting.h"
 #include "internal.h"
 
 int hugetlb_max_hstate __read_mostly;
@@ -1028,6 +1029,9 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 	list_move(&page->lru, &h->hugepage_freelists[nid]);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
+	if (hugepage_reported(page))
+		__ClearPageReported(page);
+	hugepage_reporting_notify_free(h->order);
 }
 
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
@@ -5531,6 +5535,21 @@ follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int fla
 	return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
 }
 
+void isolate_free_huge_page(struct page *page, struct hstate *h, int nid)
+{
+	VM_BUG_ON_PAGE(!PageHead(page), page);
+
+	list_move(&page->lru, &h->hugepage_activelist);
+	set_page_refcounted(page);
+}
+
+void putback_isolate_huge_page(struct hstate *h, struct page *page)
+{
+	int nid = page_to_nid(page);
+
+	list_move(&page->lru, &h->hugepage_freelists[nid]);
+}
+
 bool isolate_huge_page(struct page *page, struct list_head *list)
 {
 	bool ret = true;
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 39bc6a9d7b73..cc31696225bb 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -6,15 +6,22 @@
 #include <linux/export.h>
 #include <linux/delay.h>
 #include <linux/scatterlist.h>
+#include <linux/hugetlb.h>
 
 #include "page_reporting.h"
 #include "internal.h"
 
 #define PAGE_REPORTING_DELAY	(2 * HZ)
+#define MAX_SCAN_NUM		1024
+
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 unsigned long page_report_batch_size  __read_mostly = 16 * 1024 * 1024UL;
 int page_report_mini_order = pageblock_order;
 
+static struct page_reporting_dev_info __rcu *hgpr_dev_info __read_mostly;
+int hugepage_report_mini_order = pageblock_order;
+unsigned long hugepage_report_batch_size = 16 * 1024 * 1024;
+
 enum {
 	PAGE_REPORTING_IDLE = 0,
 	PAGE_REPORTING_REQUESTED,
@@ -66,6 +73,24 @@ void __page_reporting_notify(void)
 	rcu_read_unlock();
 }
 
+/* notify prdev of free hugepage reporting request */
+void __hugepage_reporting_notify(void)
+{
+	struct page_reporting_dev_info *prdev;
+
+	/*
+	 * We use RCU to protect the hgpr_dev_info pointer. In almost all
+	 * cases this should be present, however in the unlikely case of
+	 * a shutdown this will be NULL and we should exit.
+	 */
+	rcu_read_lock();
+	prdev = rcu_dereference(hgpr_dev_info);
+	if (likely(prdev))
+		__page_reporting_request(prdev);
+
+	rcu_read_unlock();
+}
+
 static void
 page_reporting_drain(struct page_reporting_dev_info *prdev,
 		     struct scatterlist *sgl, unsigned int nents, bool reported)
@@ -102,6 +127,221 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 	sg_init_table(sgl, nents);
 }
 
+static void
+hugepage_reporting_drain(struct page_reporting_dev_info *prdev,
+			 struct hstate *h, struct scatterlist *sgl,
+			 unsigned int nents, bool reported)
+{
+	struct scatterlist *sg = sgl;
+
+	/*
+	 * Drain the now reported pages back into their respective
+	 * free lists. We assume at least one page is populated.
+	 */
+	do {
+		struct page *page = sg_page(sg);
+
+		putback_isolate_huge_page(h, page);
+
+		/* If the pages were not reported due to error skip flagging */
+		if (!reported)
+			continue;
+
+		__SetPageReported(page);
+	} while ((sg = sg_next(sg)));
+
+	/* reinitialize scatterlist now that it is empty */
+	sg_init_table(sgl, nents);
+}
+
+/*
+ * The page reporting cycle consists of 4 stages, fill, report, drain, and
+ * idle. We will cycle through the first 3 stages until we cannot obtain a
+ * full scatterlist of pages, in that case we will switch to idle.
+ */
+static int
+hugepage_reporting_cycle(struct page_reporting_dev_info *prdev,
+			 struct hstate *h, unsigned int nid,
+			 struct scatterlist *sgl, unsigned int *offset,
+			 int max_items)
+{
+	struct list_head *list = &h->hugepage_freelists[nid];
+	unsigned int page_len = PAGE_SIZE << h->order;
+	struct page *page, *next;
+	long budget;
+	int ret = 0, scan_cnt = 0;
+
+	/*
+	 * Perform early check, if free list is empty there is
+	 * nothing to process so we can skip this free list.
+	 */
+	if (list_empty(list))
+		return ret;
+
+	spin_lock(&hugetlb_lock);
+
+	if (huge_page_order(h) > MAX_ORDER - 1)
+		budget = max_items;
+	else
+		budget = DIV_ROUND_UP(h->free_huge_pages_node[nid],
+				      max_items * 16);
+
+	/* loop through free list adding unreported pages to sg list */
+	list_for_each_entry_safe(page, next, list, lru) {
+		/* We are going to skip over the reported pages. */
+		if (PageReported(page)) {
+			if (++scan_cnt >= MAX_SCAN_NUM) {
+				ret = scan_cnt;
+				break;
+			}
+			continue;
+		}
+
+		/*
+		 * If we fully consumed our budget then update our
+		 * state to indicate that we are requesting additional
+		 * processing and exit this list.
+		 */
+		if (budget < 0) {
+			atomic_set(&prdev->state, PAGE_REPORTING_REQUESTED);
+			next = page;
+			break;
+		}
+
+		/* Attempt to pull page from list and place in scatterlist */
+		if (*offset) {
+			isolate_free_huge_page(page, h, nid);
+			/* Add page to scatter list */
+			--(*offset);
+			sg_set_page(&sgl[*offset], page, page_len, 0);
+			continue;
+		}
+
+		/*
+		 * Make the first non-processed page in the free list
+		 * the new head of the free list before we release
+		 * hugetlb lock.
+		 */
+		if (&page->lru != list && !list_is_first(&page->lru, list))
+			list_rotate_to_front(&page->lru, list);
+
+		/* release lock before waiting on report processing */
+		spin_unlock(&hugetlb_lock);
+
+		/* begin processing pages in local list */
+		ret = prdev->report(prdev, sgl, max_items);
+
+		/* reset offset since the full list was reported */
+		*offset = max_items;
+
+		/* update budget to reflect call to report function */
+		budget--;
+
+		/* reacquire hugetlb lock and resume processing */
+		spin_lock(&hugetlb_lock);
+
+		/* flush reported pages from the sg list */
+		hugepage_reporting_drain(prdev, h, sgl, max_items, !ret);
+
+		/*
+		 * Reset next to first entry, the old next isn't valid
+		 * since we dropped the lock to report the pages
+		 */
+		next = list_first_entry(list, struct page, lru);
+
+		/* exit on error */
+		if (ret)
+			break;
+	}
+
+	/* Rotate any leftover pages to the head of the freelist */
+	if (&next->lru != list && !list_is_first(&next->lru, list))
+		list_rotate_to_front(&next->lru, list);
+
+	spin_unlock(&hugetlb_lock);
+
+	return ret;
+}
+
+static int
+hugepage_reporting_process_hstate(struct page_reporting_dev_info *prdev,
+				  struct scatterlist *sgl, int max_items,
+				  struct hstate *h)
+{
+	unsigned int leftover, offset;
+	int ret = 0, nid;
+
+	offset = max_items;
+	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+		ret = hugepage_reporting_cycle(prdev, h, nid, sgl, &offset,
+					       max_items);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	/* report the leftover pages before going idle */
+	leftover = max_items - offset;
+	if (leftover) {
+		sgl = &sgl[offset];
+		ret = prdev->report(prdev, sgl, leftover);
+
+		/* flush any remaining pages out from the last report */
+		spin_lock(&hugetlb_lock);
+		hugepage_reporting_drain(prdev, h, sgl, leftover, !ret);
+		spin_unlock(&hugetlb_lock);
+	}
+
+	return ret;
+}
+
+static void hugepage_reporting_process(struct work_struct *work)
+{
+	struct delayed_work *d_work = to_delayed_work(work);
+	struct page_reporting_dev_info *prdev = container_of(d_work,
+					struct page_reporting_dev_info, work);
+	int err = 0, state = PAGE_REPORTING_ACTIVE;
+	struct scatterlist *sgl;
+	struct hstate *h;
+
+	/*
+	 * Change the state to "Active" so that we can track if there is
+	 * anyone requests page reporting after we complete our pass. If
+	 * the state is not altered by the end of the pass we will switch
+	 * to idle and quit scheduling reporting runs.
+	 */
+	atomic_set(&prdev->state, state);
+
+	/* allocate scatterlist to store pages being reported on */
+	sgl = kmalloc_array(PAGE_REPORTING_CAPACITY, sizeof(*sgl), GFP_KERNEL);
+	if (!sgl)
+		goto err_out;
+
+	for_each_hstate(h) {
+		int max_items;
+
+		if (huge_page_order(h) > MAX_ORDER - 1)
+			max_items = 1;
+		else
+			max_items = PAGE_REPORTING_CAPACITY;
+		sg_init_table(sgl, max_items);
+		err = hugepage_reporting_process_hstate(prdev, sgl, max_items, h);
+		if (err)
+			break;
+	}
+
+	kfree(sgl);
+err_out:
+	/*
+	 * If the state has reverted back to requested then there may be
+	 * additional pages to be processed. We will defer sometime to allow
+	 * more pages to accumulate.
+	 */
+	state = atomic_cmpxchg(&prdev->state, state, PAGE_REPORTING_IDLE);
+	if (state == PAGE_REPORTING_REQUESTED)
+		schedule_delayed_work(&prdev->work, prdev->delay_jiffies);
+}
+
 /*
  * The page reporting cycle consists of 4 stages, fill, report, drain, and
  * idle. We will cycle through the first 3 stages until we cannot obtain a
@@ -314,6 +554,9 @@ static void page_reporting_process(struct work_struct *work)
 static DEFINE_MUTEX(page_reporting_mutex);
 DEFINE_STATIC_KEY_FALSE(page_reporting_enabled);
 
+static DEFINE_MUTEX(hugepage_reporting_mutex);
+DEFINE_STATIC_KEY_FALSE(hugepage_reporting_enabled);
+
 int page_reporting_register(struct page_reporting_dev_info *prdev)
 {
 	int err = 0;
@@ -368,3 +611,57 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
 	mutex_unlock(&page_reporting_mutex);
 }
 EXPORT_SYMBOL_GPL(page_reporting_unregister);
+
+int hugepage_reporting_register(struct page_reporting_dev_info *prdev)
+{
+	int err = 0;
+
+	mutex_lock(&hugepage_reporting_mutex);
+
+	/* nothing to do if already in use */
+	if (rcu_access_pointer(hgpr_dev_info)) {
+		err = -EBUSY;
+		goto err_out;
+	}
+
+	/* initialize state and work structures */
+	atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
+	INIT_DELAYED_WORK(&prdev->work, &hugepage_reporting_process);
+
+	/* Begin initial flush of zones */
+	__page_reporting_request(prdev);
+
+	/* Assign device to allow notifications */
+	rcu_assign_pointer(hgpr_dev_info, prdev);
+
+	hugepage_report_mini_order = prdev->mini_order;
+	hugepage_report_batch_size = prdev->batch_size;
+
+	/* enable hugepage reporting notification */
+	if (!static_key_enabled(&hugepage_reporting_enabled))
+		static_branch_enable(&hugepage_reporting_enabled);
+err_out:
+	mutex_unlock(&hugepage_reporting_mutex);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(hugepage_reporting_register);
+
+void hugepage_reporting_unregister(struct page_reporting_dev_info *prdev)
+{
+	mutex_lock(&hugepage_reporting_mutex);
+
+	if (rcu_access_pointer(hgpr_dev_info) == prdev) {
+		if (static_key_enabled(&hugepage_reporting_enabled))
+			static_branch_disable(&hugepage_reporting_enabled);
+		/* Disable huge page reporting notification */
+		RCU_INIT_POINTER(hgpr_dev_info, NULL);
+		synchronize_rcu();
+
+		/* Flush any existing work, and lock it out */
+		cancel_delayed_work_sync(&prdev->work);
+	}
+
+	mutex_unlock(&hugepage_reporting_mutex);
+}
+EXPORT_SYMBOL_GPL(hugepage_reporting_unregister);
diff --git a/mm/page_reporting.h b/mm/page_reporting.h
index 86ac6ffad970..f0c504b29722 100644
--- a/mm/page_reporting.h
+++ b/mm/page_reporting.h
@@ -18,12 +18,24 @@ extern unsigned long page_report_batch_size;
 DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
 void __page_reporting_notify(void);
 
+extern int hugepage_report_mini_order;
+extern unsigned long hugepage_report_batch_size;
+
+DECLARE_STATIC_KEY_FALSE(hugepage_reporting_enabled);
+void __hugepage_reporting_notify(void);
+
 static inline bool page_reported(struct page *page)
 {
 	return static_branch_unlikely(&page_reporting_enabled) &&
 	       PageReported(page);
 }
 
+static inline bool hugepage_reported(struct page *page)
+{
+	return static_branch_unlikely(&hugepage_reporting_enabled) &&
+	       PageReported(page);
+}
+
 /**
  * page_reporting_notify_free - Free page notification to start page processing
  *
@@ -52,11 +64,33 @@ static inline void page_reporting_notify_free(unsigned int order)
 		__page_reporting_notify();
 	}
 }
+
+static inline void hugepage_reporting_notify_free(unsigned int order)
+{
+	static long batch_size;
+
+	if (!static_branch_unlikely(&hugepage_reporting_enabled))
+		return;
+
+	/* Determine if we have crossed reporting threshold */
+	if (order < hugepage_report_mini_order)
+		return;
+
+	batch_size += (1 << order) << PAGE_SHIFT;
+	if (batch_size >= hugepage_report_batch_size) {
+		batch_size = 0;
+		__hugepage_reporting_notify();
+	}
+}
 #else /* CONFIG_PAGE_REPORTING */
 #define page_reported(_page)	false
 
 static inline void page_reporting_notify_free(unsigned int order)
 {
 }
+
+static inline void hugepage_reporting_notify_free(unsigned int order)
+{
+}
 #endif /* CONFIG_PAGE_REPORTING */
 #endif /*_MM_PAGE_REPORTING_H */
-- 
2.18.2

