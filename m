Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB30E2E06E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgLVHro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLVHro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:47:44 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633A7C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 23:47:03 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x18so7007692pln.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 23:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=/QJ3etTHXwFO0sfMopiRtUfgyd8Q29xDr/I07BPqM8U=;
        b=p1puU9SvCg3tvRbcGQ2hkXUCdUO3WJvuJ0kA0iX8BGOapHSTKYfJry17VM9Ey6lypQ
         4hpG9raA8NszOIlfeBuZHg17/1r2oCx3HttayO4xMbwC+hP1ZgDYaDmD5Fgy+DvK95Rk
         qtWsL8AymLE2e20dA6bB4XcWQmVoPTelQgifD9ndpgoFSdgz8fMvJ9I2WB64wjXumO14
         1bN6WtGrUvh1qRIUWsI3nKlAGZIMMKJZ2U5PbZV/H1RM1Y7Q7D94GIr9e5mcz5LB9RIP
         cnGCyjlLNSO+I63EtbqMrGG5O12bB+pDSLW9Px60C5b/cOIZgxoM8ebM6/Jj2tiR6HRh
         tCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=/QJ3etTHXwFO0sfMopiRtUfgyd8Q29xDr/I07BPqM8U=;
        b=qlkG7HLf8oi5jjQdZof6gzvBTEsIodoOXJhwCx2so/xID370ljodtusOzaFG197rpo
         8j64BRkPZ5FOM72i9fxPskQFCpHADFaH+D8Fz80YcgxRnU4CtCYMmXo+wpzrUwgwIpvi
         rDAT/uARy0S2BA7hPwGZzGwbrC4URaY4A60ire1FCs8S9dD8AecDmg0kU4zKghOFeuNc
         d/thZDLmw4W3Oi2gF1s3Er4SLo3YKgWssgCgPL6WLi9r9ESIiSAI4fIr0EOmtv52WC39
         zvCVzHI5ohaXAJot+MOtF7IWYJ4cw5m8n1s6mD+jzeJ+LJ/DykBmlI0jCV46OgRSQyT3
         LWGg==
X-Gm-Message-State: AOAM531Xr99RD+iYopvyD/T+SuZ1l7/hk1dI67ljbOYHkiXLNHk8B4MV
        fTbAiVQHbp7GztpFm7csPRm+jKItd3M=
X-Google-Smtp-Source: ABdhPJw0yHdBviDxZW6i1d1c62iRZvw98rgXLaZUewI87E4M5nHhPAz65S05jA6v2+0F4gqhWt1Wzw==
X-Received: by 2002:a17:902:7449:b029:dc:bc:65de with SMTP id e9-20020a1709027449b02900dc00bc65demr15697195plt.79.1608623222955;
        Mon, 21 Dec 2020 23:47:02 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id 7sm18884115pfu.2.2020.12.21.23.47.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 23:47:02 -0800 (PST)
From:   Liang Li <liliang.opensource@gmail.com>
X-Google-Original-From: Liang Li <liliangleo@didiglobal.com>
Date:   Tue, 22 Dec 2020 02:46:59 -0500
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liang Li <liliang324@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Subject: [RFC PATCH 1/3] mm: support hugetlb free page reporting
Message-ID: <20201222074656.GA30035@open-light-1.localdomain>
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liang Li <liliang324@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free page reporting only supports buddy pages, it can't report the
free pages reserved for hugetlbfs case. On the other hand, hugetlbfs
is a good choice for a system with a huge amount of RAM, because it
can help to reduce the memory management overhead and improve system
performance.
This patch add the support for reporting hugepages in the free list
of hugetlb, it canbe used by virtio_balloon driver for memory
overcommit and pre zero out free pages for speeding up memory population.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>  
Cc: Michal Hocko <mhocko@suse.com> 
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Liang Li <liliang324@gmail.com>
Signed-off-by: Liang Li <liliangleo@didiglobal.com>
---
 include/linux/hugetlb.h        |   3 +
 include/linux/page_reporting.h |   5 +
 mm/hugetlb.c                   |  29 ++++
 mm/page_reporting.c            | 287 +++++++++++++++++++++++++++++++++
 mm/page_reporting.h            |  34 ++++
 5 files changed, 358 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ebca2ef02212..a72ad25501d3 100644
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
 
+bool isolate_free_huge_page(struct page *page, struct hstate *h, int nid);
+void putback_isolate_huge_page(struct hstate *h, struct page *page);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
 long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
 			 struct page **, struct vm_area_struct **,
diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index 63e1e9fbcaa2..0da3d1a6f0cc 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -7,6 +7,7 @@
 
 /* This value should always be a power of 2, see page_reporting_cycle() */
 #define PAGE_REPORTING_CAPACITY		32
+#define HUGEPAGE_REPORTING_CAPACITY	1
 
 struct page_reporting_dev_info {
 	/* function that alters pages to make them "reported" */
@@ -26,4 +27,8 @@ struct page_reporting_dev_info {
 /* Tear-down and bring-up for page reporting devices */
 void page_reporting_unregister(struct page_reporting_dev_info *prdev);
 int page_reporting_register(struct page_reporting_dev_info *prdev);
+
+/* Tear-down and bring-up for hugepage reporting devices */
+void hugepage_reporting_unregister(struct page_reporting_dev_info *prdev);
+int hugepage_reporting_register(struct page_reporting_dev_info *prdev);
 #endif /*_LINUX_PAGE_REPORTING_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cbf32d2824fd..de6ce147dfe2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -41,6 +41,7 @@
 #include <linux/node.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/page_owner.h>
+#include "page_reporting.h"
 #include "internal.h"
 
 int hugetlb_max_hstate __read_mostly;
@@ -1028,6 +1029,11 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 	list_move(&page->lru, &h->hugepage_freelists[nid]);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
+	if (hugepage_reported(page)) {
+		__ClearPageReported(page);
+		pr_info("%s, free_huge_pages=%ld\n", __func__, h->free_huge_pages);
+	}
+	hugepage_reporting_notify_free(h->order);
 }
 
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
@@ -5531,6 +5537,29 @@ follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int fla
 	return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
 }
 
+bool isolate_free_huge_page(struct page *page, struct hstate *h, int nid)
+{
+	bool ret = true;
+
+	VM_BUG_ON_PAGE(!PageHead(page), page);
+
+	list_move(&page->lru, &h->hugepage_activelist);
+	set_page_refcounted(page);
+	h->free_huge_pages--;
+	h->free_huge_pages_node[nid]--;
+
+	return ret;
+}
+
+void putback_isolate_huge_page(struct hstate *h, struct page *page)
+{
+	int nid = page_to_nid(page);
+	pr_info("%s, free_huge_pages=%ld\n", __func__, h->free_huge_pages);
+	list_move(&page->lru, &h->hugepage_freelists[nid]);
+	h->free_huge_pages++;
+	h->free_huge_pages_node[nid]++;
+}
+
 bool isolate_huge_page(struct page *page, struct list_head *list)
 {
 	bool ret = true;
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 20ec3fb1afc4..15d4b5372df8 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/scatterlist.h>
 #include <linux/sched.h>
+#include <linux/hugetlb.h>
 
 #include "page_reporting.h"
 #include "internal.h"
@@ -16,6 +17,10 @@ static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 int page_report_mini_order = pageblock_order;
 unsigned long page_report_batch_size = 32 * 1024 * 1024;
 
+static struct page_reporting_dev_info __rcu *hgpr_dev_info __read_mostly;
+int hugepage_report_mini_order = pageblock_order;
+unsigned long hugepage_report_batch_size = 64 * 1024 * 1024;
+
 enum {
 	PAGE_REPORTING_IDLE = 0,
 	PAGE_REPORTING_REQUESTED,
@@ -67,6 +72,24 @@ void __page_reporting_notify(void)
 	rcu_read_unlock();
 }
 
+/* notify prdev of free hugepage reporting request */
+void __hugepage_reporting_notify(void)
+{
+	struct page_reporting_dev_info *prdev;
+
+	/*
+	 * We use RCU to protect the pr_dev_info pointer. In almost all
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
@@ -103,6 +126,213 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
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
+	 * free lists/areas. We assume at least one page is populated.
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
+			 struct scatterlist *sgl, unsigned int *offset)
+{
+	struct list_head *list = &h->hugepage_freelists[nid];
+	unsigned int page_len = PAGE_SIZE << h->order;
+	struct page *page, *next;
+	long budget;
+	int ret = 0, scan_cnt = 0;
+
+	/*
+	 * Perform early check, if free area is empty there is
+	 * nothing to process so we can skip this free_list.
+	 */
+	if (list_empty(list))
+		return ret;
+
+	spin_lock_irq(&hugetlb_lock);
+
+	if (huge_page_order(h) > MAX_ORDER)
+		budget = HUGEPAGE_REPORTING_CAPACITY;
+	else
+		budget = HUGEPAGE_REPORTING_CAPACITY * 32;
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
+
+			continue;
+		}
+
+		/*
+		 * Make the first non-processed page in the free list
+		 * the new head of the free list before we release the
+		 * zone lock.
+		 */
+		if (&page->lru != list && !list_is_first(&page->lru, list))
+			list_rotate_to_front(&page->lru, list);
+
+		/* release lock before waiting on report processing */
+		spin_unlock_irq(&hugetlb_lock);
+
+		/* begin processing pages in local list */
+		ret = prdev->report(prdev, sgl, HUGEPAGE_REPORTING_CAPACITY);
+
+		/* reset offset since the full list was reported */
+		*offset = HUGEPAGE_REPORTING_CAPACITY;
+
+		/* update budget to reflect call to report function */
+		budget--;
+
+		/* reacquire zone lock and resume processing */
+		spin_lock_irq(&hugetlb_lock);
+
+		/* flush reported pages from the sg list */
+		hugepage_reporting_drain(prdev, h, sgl,
+					 HUGEPAGE_REPORTING_CAPACITY, !ret);
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
+	spin_unlock_irq(&hugetlb_lock);
+
+	return ret;
+}
+
+static int
+hugepage_reporting_process_hstate(struct page_reporting_dev_info *prdev,
+			    struct scatterlist *sgl, struct hstate *h)
+{
+	unsigned int leftover, offset = HUGEPAGE_REPORTING_CAPACITY;
+	int ret = 0, nid;
+
+	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+		ret = hugepage_reporting_cycle(prdev, h, nid, sgl, &offset);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	/* report the leftover pages before going idle */
+	leftover = HUGEPAGE_REPORTING_CAPACITY - offset;
+	if (leftover) {
+		sgl = &sgl[offset];
+		ret = prdev->report(prdev, sgl, leftover);
+
+		/* flush any remaining pages out from the last report */
+		spin_lock_irq(&hugetlb_lock);
+		hugepage_reporting_drain(prdev, h, sgl, leftover, !ret);
+		spin_unlock_irq(&hugetlb_lock);
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
+	sgl = kmalloc_array(HUGEPAGE_REPORTING_CAPACITY, sizeof(*sgl), GFP_KERNEL);
+	if (!sgl)
+		goto err_out;
+
+	sg_init_table(sgl, HUGEPAGE_REPORTING_CAPACITY);
+
+	for_each_hstate(h) {
+		err = hugepage_reporting_process_hstate(prdev, sgl, h);
+		if (err)
+			break;
+	}
+
+	kfree(sgl);
+err_out:
+	/*
+	 * If the state has reverted back to requested then there may be
+	 * additional pages to be processed. We will defer for 2s to allow
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
@@ -341,6 +571,9 @@ static void page_reporting_process(struct work_struct *work)
 static DEFINE_MUTEX(page_reporting_mutex);
 DEFINE_STATIC_KEY_FALSE(page_reporting_enabled);
 
+static DEFINE_MUTEX(hugepage_reporting_mutex);
+DEFINE_STATIC_KEY_FALSE(hugepage_reporting_enabled);
+
 int page_reporting_register(struct page_reporting_dev_info *prdev)
 {
 	int err = 0;
@@ -395,3 +628,57 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
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
+	if (!static_key_enabled(&hugepage_reporting_enabled)) {
+		static_branch_enable(&hugepage_reporting_enabled);
+		pr_info("Free hugepage reporting enabled\n");
+	}
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
+		/* Disable page reporting notification */
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
index 86ac6ffad970..271c64c3c3cb 100644
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
+	static long batch_size = 0;
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

