Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985B52A7169
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbgKDXTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732650AbgKDXTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:19:38 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96A2C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:19:38 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a24so254550pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=hjRBqBGf8x5Qs+jA3dkL4OK4h5TdyZ7tlkBRl04gbfY=;
        b=BXWnLrRRDqhkMGkluTxks0XVzkwBWMv5YQsrYCOz4b3YDAZ31scxR/LrT518JEznri
         WI9Ly5zGl0hwPE6s0haEhzwzq3Hg6YQIz3xtKu1aWCllzZu77Lqs52YJf862HXRgyCS/
         HZ1RF+C+uxOaivzDp3XthWuYNxcANPBpySrGiehhyqUm3jp5aJLzSlgPfyjpNwl6g6e/
         wupZfWC2BPi3u7IDnW6LuPeUUZSGxPmhQztF6zlxsuLdPeaTSe4NpPBFaSOle/z3BHTA
         K34IRfusy/VAS/4t8sKcsRoJHl4YvXS9pHsofy6iSrNrspKt1C6Jdsotk0BSDxtcz+N4
         4CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=hjRBqBGf8x5Qs+jA3dkL4OK4h5TdyZ7tlkBRl04gbfY=;
        b=ABD6ZcgihSYV87nsqKPUinQaO+exzAQCuxEXC8t55jtjQPpU9RcLcn0RDXX0MDY3Ve
         A1jwOG47FP2UoBWqKXxHZJuqLnblWTqb/55KnQKwJwTnAroONT4t3L4TIMB2yJU0M0XX
         JrIXUuGvu0/gaYitmV8x2ASnA4RWMy0IxAXtmcxsoUt/70KSoSSxUcfBxxxqmS+v36SY
         xSMKRE0J+qXzemEL0kjz+RWqD7HDXvIxoi5afkMgNjSvZQdPadfbJltZEJd9rKlytKcc
         gvjwfS+V8D6Yu1kkTdL3/Fw+9mpwjV4Hq/5/kDsFzFgMVaOq4BIZU0jSQLhYg1CO/wtE
         e2/w==
X-Gm-Message-State: AOAM5325PyGYSCZsJclVU8ohFA4hlZ/WdzbvFt5pVYjkWwtSMbT/Oj+s
        9n/tYTBztpaNCXdMwPrJP7YaUa2UZvBOGA==
X-Google-Smtp-Source: ABdhPJxxRN7YByv4qt7VLaU3yPQNFBlA3Gm6vSkahlVMzv9Ykw3Du0DrHnfrkuhXtxyyz2MHKN0GA8kEhj04FA==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee8:36f0])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:4684:: with SMTP id
 z4mr219067pjf.97.1604531978117; Wed, 04 Nov 2020 15:19:38 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:19:28 -0800
Message-Id: <20201104231928.1494083-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] mm/rmap: always do TTU_IGNORE_ACCESS
From:   Shakeel Butt <shakeelb@google.com>
To:     Hugh Dickins <hughd@google.com>, Jerome Glisse <jglisse@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 369ea8242c0f ("mm/rmap: update to new mmu_notifier
semantic v2"), the code to check the secondary MMU's page table access
bit is broken for !(TTU_IGNORE_ACCESS) because the page is unmapped from
the secondary MMU's page table before the check. More specifically for
those secondary MMUs which unmap the memory in
mmu_notifier_invalidate_range_start() like kvm.

However memory reclaim is the only user of !(TTU_IGNORE_ACCESS) or the
absence of TTU_IGNORE_ACCESS and it explicitly performs the page table
access check before trying to unmap the page. So, at worst the reclaim
will miss accesses in a very short window if we remove page table access
check in unmapping code.

There is an unintented consequence of !(TTU_IGNORE_ACCESS) for the memcg
reclaim. From memcg reclaim the page_referenced() only account the
accesses from the processes which are in the same memcg of the target
page but the unmapping code is considering accesses from all the
processes, so, decreasing the effectiveness of memcg reclaim.

The simplest solution is to always assume TTU_IGNORE_ACCESS in unmapping
code.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/rmap.h |  1 -
 mm/huge_memory.c     |  2 +-
 mm/memory-failure.c  |  2 +-
 mm/memory_hotplug.c  |  2 +-
 mm/migrate.c         |  8 +++-----
 mm/rmap.c            |  9 ---------
 mm/vmscan.c          | 14 +++++---------
 7 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 3a6adfa70fb0..70085ca1a3fc 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -91,7 +91,6 @@ enum ttu_flags {
 
 	TTU_SPLIT_HUGE_PMD	= 0x4,	/* split huge PMD if any */
 	TTU_IGNORE_MLOCK	= 0x8,	/* ignore mlock */
-	TTU_IGNORE_ACCESS	= 0x10,	/* don't age */
 	TTU_IGNORE_HWPOISON	= 0x20,	/* corrupted page is recoverable */
 	TTU_BATCH_FLUSH		= 0x40,	/* Batch TLB flushes where possible
 					 * and caller guarantees they will
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 08a183f6c3ab..8b235b4abf73 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2324,7 +2324,7 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 
 static void unmap_page(struct page *page)
 {
-	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS |
+	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
 		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
 	bool unmap_success;
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c0bb186bba62..b6d6d5cdb435 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -989,7 +989,7 @@ static int get_hwpoison_page(struct page *page)
 static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 				  int flags, struct page **hpagep)
 {
-	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS;
+	enum ttu_flags ttu = TTU_IGNORE_MLOCK;
 	struct address_space *mapping;
 	LIST_HEAD(tokill);
 	bool unmap_success = true;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8c1b7182bb08..968e6916d297 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1303,7 +1303,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			if (WARN_ON(PageLRU(page)))
 				isolate_lru_page(page);
 			if (page_mapped(page))
-				try_to_unmap(page, TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS);
+				try_to_unmap(page, TTU_IGNORE_MLOCK);
 			continue;
 		}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index c1585ec29827..e434d49fd428 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1122,8 +1122,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		/* Establish migration ptes */
 		VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
 				page);
-		try_to_unmap(page,
-			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
+		try_to_unmap(page, TTU_MIGRATION|TTU_IGNORE_MLOCK);
 		page_was_mapped = 1;
 	}
 
@@ -1339,8 +1338,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 			goto unlock_put_anon;
 
 		try_to_unmap(hpage,
-			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS|
-			TTU_RMAP_LOCKED);
+			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_RMAP_LOCKED);
 		page_was_mapped = 1;
 		/*
 		 * Leave mapping locked until after subsequent call to
@@ -2684,7 +2682,7 @@ static void migrate_vma_prepare(struct migrate_vma *migrate)
  */
 static void migrate_vma_unmap(struct migrate_vma *migrate)
 {
-	int flags = TTU_MIGRATION | TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS;
+	int flags = TTU_MIGRATION | TTU_IGNORE_MLOCK;
 	const unsigned long npages = migrate->npages;
 	const unsigned long start = migrate->start;
 	unsigned long addr, i, restore = 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index 1b84945d655c..6cd9d4512117 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1536,15 +1536,6 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			goto discard;
 		}
 
-		if (!(flags & TTU_IGNORE_ACCESS)) {
-			if (ptep_clear_flush_young_notify(vma, address,
-						pvmw.pte)) {
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
-			}
-		}
-
 		/* Nuke the page table entry. */
 		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
 		if (should_defer_flush(mm, flags)) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a8611dce7a95..e71b563cda7b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1072,7 +1072,6 @@ static void page_check_dirty_writeback(struct page *page,
 static unsigned int shrink_page_list(struct list_head *page_list,
 				     struct pglist_data *pgdat,
 				     struct scan_control *sc,
-				     enum ttu_flags ttu_flags,
 				     struct reclaim_stat *stat,
 				     bool ignore_references)
 {
@@ -1297,7 +1296,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		 * processes. Try to unmap it here.
 		 */
 		if (page_mapped(page)) {
-			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
+			enum ttu_flags flags = TTU_BATCH_FLUSH;
 			bool was_swapbacked = PageSwapBacked(page);
 
 			if (unlikely(PageTransHuge(page)))
@@ -1514,7 +1513,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 	}
 
 	nr_reclaimed = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
-			TTU_IGNORE_ACCESS, &stat, true);
+					&stat, true);
 	list_splice(&clean_pages, page_list);
 	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE,
 			    -(long)nr_reclaimed);
@@ -1958,8 +1957,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	if (nr_taken == 0)
 		return 0;
 
-	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, 0,
-				&stat, false);
+	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, &stat, false);
 
 	spin_lock_irq(&pgdat->lru_lock);
 
@@ -2131,8 +2129,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
 
 		nr_reclaimed += shrink_page_list(&node_page_list,
 						NODE_DATA(nid),
-						&sc, 0,
-						&dummy_stat, false);
+						&sc, &dummy_stat, false);
 		while (!list_empty(&node_page_list)) {
 			page = lru_to_page(&node_page_list);
 			list_del(&page->lru);
@@ -2145,8 +2142,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
 	if (!list_empty(&node_page_list)) {
 		nr_reclaimed += shrink_page_list(&node_page_list,
 						NODE_DATA(nid),
-						&sc, 0,
-						&dummy_stat, false);
+						&sc, &dummy_stat, false);
 		while (!list_empty(&node_page_list)) {
 			page = lru_to_page(&node_page_list);
 			list_del(&page->lru);
-- 
2.29.1.341.ge80a0c044ae-goog

