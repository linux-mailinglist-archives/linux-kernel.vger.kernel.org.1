Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E1921C15B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 02:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGKA7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 20:59:21 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:47009 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727061AbgGKA7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 20:59:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U2KGAZr_1594429139;
Received: from alexshi-test.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2KGAZr_1594429139)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Jul 2020 08:59:06 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name
Subject: [PATCH v16 15/22] mm/compaction: do page isolation first in compaction
Date:   Sat, 11 Jul 2020 08:58:49 +0800
Message-Id: <1594429136-20002-16-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner has suggested:
"So here is a crazy idea that may be worth exploring:

Right now, pgdat->lru_lock protects both PageLRU *and* the lruvec's
linked list.

Can we make PageLRU atomic and use it to stabilize the lru_lock
instead, and then use the lru_lock only serialize list operations?
..."

Yes, this patch is doing so on  __isolate_lru_page which is the core
page isolation func in compaction and shrinking path.
With this patch, the compaction will only deal the PageLRU set and now
isolated pages to skip the just alloced page which no LRU bit. And the
isolation could exclusive the other isolations in memcg move_account,
page migrations and thp split_huge_page.

As a side effect, PageLRU may be cleared during shrink_inactive_list
path for isolation reason. If so, we can skip that page.

Hugh Dickins <hughd@google.com> fixed following bugs in this patch's
early version:

Fix lots of crashes under compaction load: isolate_migratepages_block()
must clean up appropriately when rejecting a page, setting PageLRU again
if it had been cleared; and a put_page() after get_page_unless_zero()
cannot safely be done while holding locked_lruvec - it may turn out to
be the final put_page(), which will take an lruvec lock when PageLRU.
And move __isolate_lru_page_prepare back after get_page_unless_zero to
make trylock_page() safe:
trylock_page() is not safe to use at this time: its setting PG_locked
can race with the page being freed or allocated ("Bad page"), and can
also erase flags being set by one of those "sole owners" of a freshly
allocated page who use non-atomic __SetPageFlag().

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/swap.h |  2 +-
 mm/compaction.c      | 42 +++++++++++++++++++++++++++++++++---------
 mm/vmscan.c          | 38 ++++++++++++++++++++++----------------
 3 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2c29399b29a0..6d23d3beeff7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -358,7 +358,7 @@ extern void lru_cache_add_active_or_unevictable(struct page *page,
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
 extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 					gfp_t gfp_mask, nodemask_t *mask);
-extern int __isolate_lru_page(struct page *page, isolate_mode_t mode);
+extern int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode);
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
diff --git a/mm/compaction.c b/mm/compaction.c
index f14780fc296a..2da2933fe56b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -869,6 +869,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		if (!valid_page && IS_ALIGNED(low_pfn, pageblock_nr_pages)) {
 			if (!cc->ignore_skip_hint && get_pageblock_skip(page)) {
 				low_pfn = end_pfn;
+				page = NULL;
 				goto isolate_abort;
 			}
 			valid_page = page;
@@ -950,6 +951,21 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
 			goto isolate_fail;
 
+		/*
+		 * Be careful not to clear PageLRU until after we're
+		 * sure the page is not being freed elsewhere -- the
+		 * page release code relies on it.
+		 */
+		if (unlikely(!get_page_unless_zero(page)))
+			goto isolate_fail;
+
+		if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
+			goto isolate_fail_put;
+
+		/* Try isolate the page */
+		if (!TestClearPageLRU(page))
+			goto isolate_fail_put;
+
 		/* If we already hold the lock, we can skip some rechecking */
 		if (!locked) {
 			locked = compact_lock_irqsave(&pgdat->lru_lock,
@@ -962,10 +978,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
 					goto isolate_abort;
 			}
 
-			/* Recheck PageLRU and PageCompound under lock */
-			if (!PageLRU(page))
-				goto isolate_fail;
-
 			/*
 			 * Page become compound since the non-locked check,
 			 * and it's on LRU. It can only be a THP so the order
@@ -973,16 +985,13 @@ static bool too_many_isolated(pg_data_t *pgdat)
 			 */
 			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
 				low_pfn += compound_nr(page) - 1;
-				goto isolate_fail;
+				SetPageLRU(page);
+				goto isolate_fail_put;
 			}
 		}
 
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
-		/* Try isolate the page */
-		if (__isolate_lru_page(page, isolate_mode) != 0)
-			goto isolate_fail;
-
 		/* The whole page is taken off the LRU; skip the tail pages. */
 		if (PageCompound(page))
 			low_pfn += compound_nr(page) - 1;
@@ -1011,6 +1020,15 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		}
 
 		continue;
+
+isolate_fail_put:
+		/* Avoid potential deadlock in freeing page under lru_lock */
+		if (locked) {
+			spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+			locked = false;
+		}
+		put_page(page);
+
 isolate_fail:
 		if (!skip_on_failure)
 			continue;
@@ -1047,9 +1065,15 @@ static bool too_many_isolated(pg_data_t *pgdat)
 	if (unlikely(low_pfn > end_pfn))
 		low_pfn = end_pfn;
 
+	page = NULL;
+
 isolate_abort:
 	if (locked)
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+	if (page) {
+		SetPageLRU(page);
+		put_page(page);
+	}
 
 	/*
 	 * Updated the cached scanner pfn once the pageblock has been scanned
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 18986fefd49b..f77748adc340 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1544,7 +1544,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
  *
  * returns 0 on success, -ve errno on failure.
  */
-int __isolate_lru_page(struct page *page, isolate_mode_t mode)
+int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
 {
 	int ret = -EINVAL;
 
@@ -1598,20 +1598,9 @@ int __isolate_lru_page(struct page *page, isolate_mode_t mode)
 	if ((mode & ISOLATE_UNMAPPED) && page_mapped(page))
 		return ret;
 
-	if (likely(get_page_unless_zero(page))) {
-		/*
-		 * Be careful not to clear PageLRU until after we're
-		 * sure the page is not being freed elsewhere -- the
-		 * page release code relies on it.
-		 */
-		ClearPageLRU(page);
-		ret = 0;
-	}
-
-	return ret;
+	return 0;
 }
 
-
 /*
  * Update LRU sizes after isolating pages. The LRU size updates must
  * be complete before mem_cgroup_update_lru_size due to a sanity check.
@@ -1691,17 +1680,34 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		 * only when the page is being freed somewhere else.
 		 */
 		scan += nr_pages;
-		switch (__isolate_lru_page(page, mode)) {
+		switch (__isolate_lru_page_prepare(page, mode)) {
 		case 0:
+			/*
+			 * Be careful not to clear PageLRU until after we're
+			 * sure the page is not being freed elsewhere -- the
+			 * page release code relies on it.
+			 */
+			if (unlikely(!get_page_unless_zero(page)))
+				goto busy;
+
+			if (!TestClearPageLRU(page)) {
+				/*
+				 * This page may in other isolation path,
+				 * but we still hold lru_lock.
+				 */
+				put_page(page);
+				goto busy;
+			}
+
 			nr_taken += nr_pages;
 			nr_zone_taken[page_zonenum(page)] += nr_pages;
 			list_move(&page->lru, dst);
 			break;
-
+busy:
 		case -EBUSY:
 			/* else it is being freed elsewhere */
 			list_move(&page->lru, src);
-			continue;
+			break;
 
 		default:
 			BUG();
-- 
1.8.3.1

