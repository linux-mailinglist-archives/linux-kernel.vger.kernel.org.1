Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04012743AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgIVN5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:57:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgIVN5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:57:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77CF9AE79;
        Tue, 22 Sep 2020 13:57:46 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     aris@ruivo.org, naoya.horiguchi@nec.com, mhocko@kernel.org,
        tony.luck@intel.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v7 09/14] mm,hwpoison: rework soft offline for in-use pages
Date:   Tue, 22 Sep 2020 15:56:45 +0200
Message-Id: <20200922135650.1634-10-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200922135650.1634-1-osalvador@suse.de>
References: <20200922135650.1634-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the way we set and handle in-use poisoned pages.  Until
now, poisoned pages were released to the buddy allocator, trusting that
the checks that take place at allocation time would act as a safe net
and would skip that page.

This has proved to be wrong, as we got some pfn walkers out there, like
compaction, that all they care is the page to be in a buddy freelist.

Although this might not be the only user, having poisoned pages in the
buddy allocator seems a bad idea as we should only have free pages that
are ready and meant to be used as such.

Before explaining the taken approach, let us break down the kind of pages
we can soft offline.

- Anonymous THP (after the split, they end up being 4K pages)
- Hugetlb
- Order-0 pages (that can be either migrated or invalited)

* Normal pages (order-0 and anon-THP)

  - If they are clean and unmapped page cache pages, we invalidate
    then by means of invalidate_inode_page().
  - If they are mapped/dirty, we do the isolate-and-migrate dance.

Either way, do not call put_page directly from those paths.
Instead, we keep the page and send it to page_handle_poison to perform the
right handling.

page_handle_poison sets the HWPoison flag and does the last put_page.

Down the chain, we placed a check for HWPoison page in
free_pages_prepare, that just skips any poisoned page, so those pages
do not end up in any pcplist/freelist.

After that, we set the refcount on the page to 1 and we increment
the poisoned pages counter.

If we see that the check in free_pages_prepare creates trouble, we can
always do what we do for free pages:

  - wait until the page hits buddy's freelists
  - take it off, and flag it

The downside of the above approach is that we could race with an
allocation, so by the time we  want to take the page off the buddy, the
page has been already allocated so we cannot soft offline it.
But the user could always retry it.

* Hugetlb pages

  - We isolate-and-migrate them

After the migration has been successful, we call dissolve_free_huge_page,
and we set HWPoison on the page if we succeed.
Hugetlb has a slightly different handling though.

While for non-hugetlb pages we cared about closing the race with an
allocation, doing so for hugetlb pages requires quite some additional
and intrusive code (we would need to hook in free_huge_page and some other
places).
So I decided to not make the code overly complicated and just fail
normally if the page we allocated in the meantime.

We can always build on top of this.

As a bonus, because of the way we handle now in-use pages, we no longer
need the put-as-isolation-migratetype dance, that was guarding for poisoned
pages to end up in pcplists.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/page-flags.h |  5 -----
 mm/memory-failure.c        | 43 +++++++++++++-------------------------
 mm/migrate.c               | 11 +++-------
 mm/page_alloc.c            | 39 ++++++++++------------------------
 4 files changed, 28 insertions(+), 70 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d0fdb59794d8..fbbb841a9346 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -428,14 +428,9 @@ PAGEFLAG_FALSE(Uncached)
 PAGEFLAG(HWPoison, hwpoison, PF_ANY)
 TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
 #define __PG_HWPOISON (1UL << PG_hwpoison)
-extern bool set_hwpoison_free_buddy_page(struct page *page);
 extern bool take_page_off_buddy(struct page *page);
 #else
 PAGEFLAG_FALSE(HWPoison)
-static inline bool set_hwpoison_free_buddy_page(struct page *page)
-{
-	return 0;
-}
 #define __PG_HWPOISON 0
 #endif
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index de274356f8c7..cc8757282860 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -65,9 +65,11 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
-static void page_handle_poison(struct page *page)
+static void page_handle_poison(struct page *page, bool release)
 {
 	SetPageHWPoison(page);
+	if (release)
+		put_page(page);
 	page_ref_inc(page);
 	num_poisoned_pages_inc();
 }
@@ -1765,19 +1767,13 @@ static int soft_offline_huge_page(struct page *page, int flags)
 			ret = -EIO;
 	} else {
 		/*
-		 * We set PG_hwpoison only when the migration source hugepage
-		 * was successfully dissolved, because otherwise hwpoisoned
-		 * hugepage remains on free hugepage list, then userspace will
-		 * find it as SIGBUS by allocation failure. That's not expected
-		 * in soft-offlining.
+		 * We set PG_hwpoison only when we were able to take the page
+		 * off the buddy.
 		 */
-		ret = dissolve_free_huge_page(page);
-		if (!ret) {
-			if (set_hwpoison_free_buddy_page(page))
-				num_poisoned_pages_inc();
-			else
-				ret = -EBUSY;
-		}
+		if (!dissolve_free_huge_page(page) && take_page_off_buddy(page))
+			page_handle_poison(page, false);
+		else
+			ret = -EBUSY;
 	}
 	return ret;
 }
@@ -1812,10 +1808,8 @@ static int __soft_offline_page(struct page *page, int flags)
 	 * would need to fix isolation locking first.
 	 */
 	if (ret == 1) {
-		put_page(page);
 		pr_info("soft_offline: %#lx: invalidated\n", pfn);
-		SetPageHWPoison(page);
-		num_poisoned_pages_inc();
+		page_handle_poison(page, true);
 		return 0;
 	}
 
@@ -1846,7 +1840,9 @@ static int __soft_offline_page(struct page *page, int flags)
 		list_add(&page->lru, &pagelist);
 		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
 					MIGRATE_SYNC, MR_MEMORY_FAILURE);
-		if (ret) {
+		if (!ret) {
+			page_handle_poison(page, true);
+		} else {
 			if (!list_empty(&pagelist))
 				putback_movable_pages(&pagelist);
 
@@ -1865,27 +1861,16 @@ static int __soft_offline_page(struct page *page, int flags)
 static int soft_offline_in_use_page(struct page *page, int flags)
 {
 	int ret;
-	int mt;
 	struct page *hpage = compound_head(page);
 
 	if (!PageHuge(page) && PageTransHuge(hpage))
 		if (try_to_split_thp_page(page, "soft offline") < 0)
 			return -EBUSY;
 
-	/*
-	 * Setting MIGRATE_ISOLATE here ensures that the page will be linked
-	 * to free list immediately (not via pcplist) when released after
-	 * successful page migration. Otherwise we can't guarantee that the
-	 * page is really free after put_page() returns, so
-	 * set_hwpoison_free_buddy_page() highly likely fails.
-	 */
-	mt = get_pageblock_migratetype(page);
-	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 	if (PageHuge(page))
 		ret = soft_offline_huge_page(page, flags);
 	else
 		ret = __soft_offline_page(page, flags);
-	set_pageblock_migratetype(page, mt);
 	return ret;
 }
 
@@ -1894,7 +1879,7 @@ static int soft_offline_free_page(struct page *page)
 	int rc = -EBUSY;
 
 	if (!dissolve_free_huge_page(page) && take_page_off_buddy(page)) {
-		page_handle_poison(page);
+		page_handle_poison(page, false);
 		rc = 0;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 7eb82af9f49a..64750ef021c6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1223,16 +1223,11 @@ static int unmap_and_move(new_page_t get_new_page,
 	 * we want to retry.
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
-		put_page(page);
-		if (reason == MR_MEMORY_FAILURE) {
+		if (reason != MR_MEMORY_FAILURE)
 			/*
-			 * Set PG_HWPoison on just freed page
-			 * intentionally. Although it's rather weird,
-			 * it's how HWPoison flag works at the moment.
+			 * We release the page in page_handle_poison.
 			 */
-			if (set_hwpoison_free_buddy_page(page))
-				num_poisoned_pages_inc();
-		}
+			put_page(page);
 	} else {
 		if (rc != -EAGAIN) {
 			if (likely(!__PageMovable(page))) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e02da891d8a9..9a1d1e3cc099 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1173,6 +1173,17 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 	trace_mm_page_free(page, order);
 
+	if (unlikely(PageHWPoison(page)) && !order) {
+		/*
+		 * Do not let hwpoison pages hit pcplists/buddy
+		 * Untie memcg state and reset page's owner
+		 */
+		if (memcg_kmem_enabled() && PageKmemcg(page))
+			__memcg_kmem_uncharge_page(page, order);
+		reset_page_owner(page, order);
+		return false;
+	}
+
 	/*
 	 * Check tail pages before head page information is cleared to
 	 * avoid checking PageCompound for order-0 pages.
@@ -8825,32 +8836,4 @@ bool take_page_off_buddy(struct page *page)
 	spin_unlock_irqrestore(&zone->lock, flags);
 	return ret;
 }
-
-/*
- * Set PG_hwpoison flag if a given page is confirmed to be a free page.  This
- * test is performed under the zone lock to prevent a race against page
- * allocation.
- */
-bool set_hwpoison_free_buddy_page(struct page *page)
-{
-	struct zone *zone = page_zone(page);
-	unsigned long pfn = page_to_pfn(page);
-	unsigned long flags;
-	unsigned int order;
-	bool hwpoisoned = false;
-
-	spin_lock_irqsave(&zone->lock, flags);
-	for (order = 0; order < MAX_ORDER; order++) {
-		struct page *page_head = page - (pfn & ((1 << order) - 1));
-
-		if (PageBuddy(page_head) && page_order(page_head) >= order) {
-			if (!TestSetPageHWPoison(page))
-				hwpoisoned = true;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&zone->lock, flags);
-
-	return hwpoisoned;
-}
 #endif
-- 
2.26.2

