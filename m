Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37BB1B9813
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 09:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgD0HEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 03:04:24 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38761 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbgD0HEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:04:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0TwlGirx_1587971020;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwlGirx_1587971020)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Apr 2020 15:03:40 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jann Horn <jannh@google.com>
Subject: [PATCH v10 15/15] mm/lru: revise the comments of lru_lock
Date:   Mon, 27 Apr 2020 15:03:05 +0800
Message-Id: <1587970985-21629-17-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587970985-21629-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1587970985-21629-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hughd@google.com>

Since we changed the pgdat->lru_lock to lruvec->lru_lock, it's time to
fix the incorrect comments in code. Also fixed some zone->lru_lock comment
error from ancient time. etc.

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Jann Horn <jannh@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 Documentation/admin-guide/cgroup-v1/memcg_test.rst | 15 +++------------
 Documentation/admin-guide/cgroup-v1/memory.rst     |  8 ++++----
 Documentation/trace/events-kmem.rst                |  2 +-
 Documentation/vm/unevictable-lru.rst               | 22 ++++++++--------------
 include/linux/mm_types.h                           |  2 +-
 include/linux/mmzone.h                             |  2 +-
 mm/filemap.c                                       |  4 ++--
 mm/memcontrol.c                                    |  2 +-
 mm/rmap.c                                          |  2 +-
 mm/vmscan.c                                        | 12 ++++++++----
 10 files changed, 30 insertions(+), 41 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memcg_test.rst b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
index 3f7115e07b5d..0b9f91589d3d 100644
--- a/Documentation/admin-guide/cgroup-v1/memcg_test.rst
+++ b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
@@ -133,18 +133,9 @@ Under below explanation, we assume CONFIG_MEM_RES_CTRL_SWAP=y.
 
 8. LRU
 ======
-        Each memcg has its own private LRU. Now, its handling is under global
-	VM's control (means that it's handled under global pgdat->lru_lock).
-	Almost all routines around memcg's LRU is called by global LRU's
-	list management functions under pgdat->lru_lock.
-
-	A special function is mem_cgroup_isolate_pages(). This scans
-	memcg's private LRU and call __isolate_lru_page() to extract a page
-	from LRU.
-
-	(By __isolate_lru_page(), the page is removed from both of global and
-	private LRU.)
-
+	Each memcg has its own vector of LRUs (inactive anon, active anon,
+	inactive file, active file, unevictable) of pages from each node,
+	each LRU handled under a single lru_lock for that memcg and node.
 
 9. Typical Tests.
 =================
diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 0ae4f564c2d6..5a68ecfdb835 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -297,13 +297,13 @@ When oom event notifier is registered, event will be delivered.
 
    PG_locked.
      mm->page_table_lock
-         pgdat->lru_lock
-	   lock_page_cgroup.
+       lruvec->lru_lock
+	 lock_page_cgroup.
 
   In many cases, just lock_page_cgroup() is called.
 
-  per-zone-per-cgroup LRU (cgroup's private LRU) is just guarded by
-  pgdat->lru_lock, it has no lock of its own.
+  per-node-per-cgroup LRU (cgroup's private LRU) is just guarded by
+  lruvec->lru_lock, it has no lock of its own.
 
 2.7 Kernel Memory Extension (CONFIG_MEMCG_KMEM)
 -----------------------------------------------
diff --git a/Documentation/trace/events-kmem.rst b/Documentation/trace/events-kmem.rst
index 555484110e36..68fa75247488 100644
--- a/Documentation/trace/events-kmem.rst
+++ b/Documentation/trace/events-kmem.rst
@@ -69,7 +69,7 @@ When pages are freed in batch, the also mm_page_free_batched is triggered.
 Broadly speaking, pages are taken off the LRU lock in bulk and
 freed in batch with a page list. Significant amounts of activity here could
 indicate that the system is under memory pressure and can also indicate
-contention on the zone->lru_lock.
+contention on the lruvec->lru_lock.
 
 4. Per-CPU Allocator Activity
 =============================
diff --git a/Documentation/vm/unevictable-lru.rst b/Documentation/vm/unevictable-lru.rst
index 17d0861b0f1d..0e1490524f53 100644
--- a/Documentation/vm/unevictable-lru.rst
+++ b/Documentation/vm/unevictable-lru.rst
@@ -33,7 +33,7 @@ reclaim in Linux.  The problems have been observed at customer sites on large
 memory x86_64 systems.
 
 To illustrate this with an example, a non-NUMA x86_64 platform with 128GB of
-main memory will have over 32 million 4k pages in a single zone.  When a large
+main memory will have over 32 million 4k pages in a single node.  When a large
 fraction of these pages are not evictable for any reason [see below], vmscan
 will spend a lot of time scanning the LRU lists looking for the small fraction
 of pages that are evictable.  This can result in a situation where all CPUs are
@@ -55,7 +55,7 @@ unevictable, either by definition or by circumstance, in the future.
 The Unevictable Page List
 -------------------------
 
-The Unevictable LRU infrastructure consists of an additional, per-zone, LRU list
+The Unevictable LRU infrastructure consists of an additional, per-node, LRU list
 called the "unevictable" list and an associated page flag, PG_unevictable, to
 indicate that the page is being managed on the unevictable list.
 
@@ -84,15 +84,9 @@ The unevictable list does not differentiate between file-backed and anonymous,
 swap-backed pages.  This differentiation is only important while the pages are,
 in fact, evictable.
 
-The unevictable list benefits from the "arrayification" of the per-zone LRU
+The unevictable list benefits from the "arrayification" of the per-node LRU
 lists and statistics originally proposed and posted by Christoph Lameter.
 
-The unevictable list does not use the LRU pagevec mechanism. Rather,
-unevictable pages are placed directly on the page's zone's unevictable list
-under the zone lru_lock.  This allows us to prevent the stranding of pages on
-the unevictable list when one task has the page isolated from the LRU and other
-tasks are changing the "evictability" state of the page.
-
 
 Memory Control Group Interaction
 --------------------------------
@@ -101,8 +95,8 @@ The unevictable LRU facility interacts with the memory control group [aka
 memory controller; see Documentation/admin-guide/cgroup-v1/memory.rst] by extending the
 lru_list enum.
 
-The memory controller data structure automatically gets a per-zone unevictable
-list as a result of the "arrayification" of the per-zone LRU lists (one per
+The memory controller data structure automatically gets a per-node unevictable
+list as a result of the "arrayification" of the per-node LRU lists (one per
 lru_list enum element).  The memory controller tracks the movement of pages to
 and from the unevictable list.
 
@@ -196,7 +190,7 @@ for the sake of expediency, to leave a unevictable page on one of the regular
 active/inactive LRU lists for vmscan to deal with.  vmscan checks for such
 pages in all of the shrink_{active|inactive|page}_list() functions and will
 "cull" such pages that it encounters: that is, it diverts those pages to the
-unevictable list for the zone being scanned.
+unevictable list for the node being scanned.
 
 There may be situations where a page is mapped into a VM_LOCKED VMA, but the
 page is not marked as PG_mlocked.  Such pages will make it all the way to
@@ -328,7 +322,7 @@ If the page was NOT already mlocked, mlock_vma_page() attempts to isolate the
 page from the LRU, as it is likely on the appropriate active or inactive list
 at that time.  If the isolate_lru_page() succeeds, mlock_vma_page() will put
 back the page - by calling putback_lru_page() - which will notice that the page
-is now mlocked and divert the page to the zone's unevictable list.  If
+is now mlocked and divert the page to the node's unevictable list.  If
 mlock_vma_page() is unable to isolate the page from the LRU, vmscan will handle
 it later if and when it attempts to reclaim the page.
 
@@ -603,7 +597,7 @@ Some examples of these unevictable pages on the LRU lists are:
      unevictable list in mlock_vma_page().
 
 shrink_inactive_list() also diverts any unevictable pages that it finds on the
-inactive lists to the appropriate zone's unevictable list.
+inactive lists to the appropriate node's unevictable list.
 
 shrink_inactive_list() should only see SHM_LOCK'd pages that became SHM_LOCK'd
 after shrink_active_list() had moved them to the inactive list, or pages mapped
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4aba6c0c2ba8..fd5c04413fc6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -78,7 +78,7 @@ struct page {
 		struct {	/* Page cache and anonymous pages */
 			/**
 			 * @lru: Pageout list, eg. active_list protected by
-			 * pgdat->lru_lock.  Sometimes used as a generic list
+			 * lruvec->lru_lock.  Sometimes used as a generic list
 			 * by the page owner.
 			 */
 			struct list_head lru;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 21bebe8d40dd..85f79757f1e6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -115,7 +115,7 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
 struct pglist_data;
 
 /*
- * zone->lock and the zone lru_lock are two of the hottest locks in the kernel.
+ * zone->lock and the lru_lock are two of the hottest locks in the kernel.
  * So add a wild amount of padding here to ensure that they fall into separate
  * cachelines.  There are very few zone structures in the machine, so space
  * consumption is not a concern here.
diff --git a/mm/filemap.c b/mm/filemap.c
index f73b221314df..93872ce6ebbe 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -101,8 +101,8 @@
  *    ->swap_lock		(try_to_unmap_one)
  *    ->private_lock		(try_to_unmap_one)
  *    ->i_pages lock		(try_to_unmap_one)
- *    ->pgdat->lru_lock		(follow_page->mark_page_accessed)
- *    ->pgdat->lru_lock		(check_pte_range->isolate_lru_page)
+ *    ->lruvec->lru_lock	(follow_page->mark_page_accessed)
+ *    ->lruvec->lru_lock	(check_pte_range->isolate_lru_page)
  *    ->private_lock		(page_remove_rmap->set_page_dirty)
  *    ->i_pages lock		(page_remove_rmap->set_page_dirty)
  *    bdi.wb->list_lock		(page_remove_rmap->set_page_dirty)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cd3dc512b16d..62de650ef48b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3012,7 +3012,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
 /*
- * Because tail pages are not marked as "used", set it. We're under
+ * Because tail pages are not marked as "used", set it. Don't need
  * lruvec->lru_lock and migration entries setup in all page mappings.
  */
 void mem_cgroup_split_huge_fixup(struct page *head)
diff --git a/mm/rmap.c b/mm/rmap.c
index ad4a0fdcc94c..d3717d21c992 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -28,7 +28,7 @@
  *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
  *           anon_vma->rwsem
  *             mm->page_table_lock or pte_lock
- *               pgdat->lru_lock (in mark_page_accessed, isolate_lru_page)
+ *               lruvec->lru_lock (in mark_page_accessed, isolate_lru_page)
  *               swap_lock (in swap_duplicate, swap_info_get)
  *                 mmlist_lock (in mmput, drain_mmlist and others)
  *                 mapping->private_lock (in __set_page_dirty_buffers)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 52d8a35fdf6a..0487a2cb5b3b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1600,14 +1600,16 @@ static __always_inline void update_lru_sizes(struct lruvec *lruvec,
 }
 
 /**
- * pgdat->lru_lock is heavily contended.  Some of the functions that
+ * Isolating page from the lruvec to fill in @dst list by nr_to_scan times.
+ *
+ * lruvec->lru_lock is heavily contended.  Some of the functions that
  * shrink the lists perform better by taking out a batch of pages
  * and working on them outside the LRU lock.
  *
  * For pagecache intensive workloads, this function is the hottest
  * spot in the kernel (apart from copy_*_user functions).
  *
- * Appropriate locks must be held before calling this function.
+ * Lru_lock must be held before calling this function.
  *
  * @nr_to_scan:	The number of eligible pages to look through on the list.
  * @lruvec:	The LRU vector to pull pages from.
@@ -1808,14 +1810,16 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
 
 /*
  * This moves pages from @list to corresponding LRU list.
+ * The pages from @list is out of any lruvec, and in the end list reuses as
+ * pages_to_free list.
  *
  * We move them the other way if the page is referenced by one or more
  * processes, from rmap.
  *
  * If the pages are mostly unmapped, the processing is fast and it is
- * appropriate to hold zone_lru_lock across the whole operation.  But if
+ * appropriate to hold lru_lock across the whole operation.  But if
  * the pages are mapped, the processing is slow (page_referenced()) so we
- * should drop zone_lru_lock around each page.  It's impossible to balance
+ * should drop lru_lock around each page.  It's impossible to balance
  * this, so instead we remove the pages from the LRU while processing them.
  * It is safe to rely on PG_active against the non-LRU pages in here because
  * nobody will play with that bit on a non-LRU page.
-- 
1.8.3.1

