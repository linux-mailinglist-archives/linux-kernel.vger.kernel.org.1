Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC50C2A79D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbgKEI5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:57:18 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:46638 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730543AbgKEI4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:56:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0UEJC3Fv_1604566567;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEJC3Fv_1604566567)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Nov 2020 16:56:14 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
Cc:     Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v21 14/19] mm/lru: introduce TestClearPageLRU
Date:   Thu,  5 Nov 2020 16:55:44 +0800
Message-Id: <1604566549-62481-15-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently lru_lock still guards both lru list and page's lru bit, that's
ok. but if we want to use specific lruvec lock on the page, we need to
pin down the page's lruvec/memcg during locking. Just taking lruvec
lock first may be undermined by the page's memcg charge/migration. To
fix this problem, we will clear the lru bit out of locking and use
it as pin down action to block the page isolation in memcg changing.

So now a standard steps of page isolation is following:
	1, get_page(); 	       #pin the page avoid to be free
	2, TestClearPageLRU(); #block other isolation like memcg change
	3, spin_lock on lru_lock; #serialize lru list access
	4, delete page from lru list;

This patch start with the first part: TestClearPageLRU, which combines
PageLRU check and ClearPageLRU into a macro func TestClearPageLRU. This
function will be used as page isolation precondition to prevent other
isolations some where else. Then there are may !PageLRU page on lru
list, need to remove BUG() checking accordingly.

There 2 rules for lru bit now:
1, the lru bit still indicate if a page on lru list, just in some
   temporary moment(isolating), the page may have no lru bit when
   it's on lru list.  but the page still must be on lru list when the
   lru bit set.
2, have to remove lru bit before delete it from lru list.

As Andrew Morton mentioned this change would dirty cacheline for page
isn't on LRU. But the lost would be acceptable in Rong Chen
<rong.a.chen@intel.com> report:
https://lore.kernel.org/lkml/20200304090301.GB5972@shao2-debian/

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Acked-by: Hugh Dickins <hughd@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/page-flags.h |  1 +
 mm/mlock.c                 |  3 +--
 mm/vmscan.c                | 39 +++++++++++++++++++--------------------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 291dc247dc79..6426f2f03611 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -335,6 +335,7 @@ static inline void page_init_poison(struct page *page, size_t size)
 PAGEFLAG(Dirty, dirty, PF_HEAD) TESTSCFLAG(Dirty, dirty, PF_HEAD)
 	__CLEARPAGEFLAG(Dirty, dirty, PF_HEAD)
 PAGEFLAG(LRU, lru, PF_HEAD) __CLEARPAGEFLAG(LRU, lru, PF_HEAD)
+	TESTCLEARFLAG(LRU, lru, PF_HEAD)
 PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
 	TESTCLEARFLAG(Active, active, PF_HEAD)
 PAGEFLAG(Workingset, workingset, PF_HEAD)
diff --git a/mm/mlock.c b/mm/mlock.c
index d487aa864e86..7b0e6334be6f 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -276,10 +276,9 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 			 * We already have pin from follow_page_mask()
 			 * so we can spare the get_page() here.
 			 */
-			if (PageLRU(page)) {
+			if (TestClearPageLRU(page)) {
 				struct lruvec *lruvec;
 
-				ClearPageLRU(page);
 				lruvec = mem_cgroup_page_lruvec(page,
 							page_pgdat(page));
 				del_page_from_lru_list(page, lruvec,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cb2f6256a7d6..ab7a0104d1e1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1542,7 +1542,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
  */
 int __isolate_lru_page(struct page *page, isolate_mode_t mode)
 {
-	int ret = -EINVAL;
+	int ret = -EBUSY;
 
 	/* Only take pages on the LRU. */
 	if (!PageLRU(page))
@@ -1552,8 +1552,6 @@ int __isolate_lru_page(struct page *page, isolate_mode_t mode)
 	if (PageUnevictable(page) && !(mode & ISOLATE_UNEVICTABLE))
 		return ret;
 
-	ret = -EBUSY;
-
 	/*
 	 * To minimise LRU disruption, the caller can indicate that it only
 	 * wants to isolate pages it will be able to operate on without
@@ -1600,8 +1598,10 @@ int __isolate_lru_page(struct page *page, isolate_mode_t mode)
 		 * sure the page is not being freed elsewhere -- the
 		 * page release code relies on it.
 		 */
-		ClearPageLRU(page);
-		ret = 0;
+		if (TestClearPageLRU(page))
+			ret = 0;
+		else
+			put_page(page);
 	}
 
 	return ret;
@@ -1667,8 +1667,6 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		page = lru_to_page(src);
 		prefetchw_prev_lru_page(page, src, flags);
 
-		VM_BUG_ON_PAGE(!PageLRU(page), page);
-
 		nr_pages = compound_nr(page);
 		total_scan += nr_pages;
 
@@ -1765,21 +1763,18 @@ int isolate_lru_page(struct page *page)
 	VM_BUG_ON_PAGE(!page_count(page), page);
 	WARN_RATELIMIT(PageTail(page), "trying to isolate tail page");
 
-	if (PageLRU(page)) {
+	if (TestClearPageLRU(page)) {
 		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
 
-		spin_lock_irq(&pgdat->lru_lock);
+		get_page(page);
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-		if (PageLRU(page)) {
-			int lru = page_lru(page);
-			get_page(page);
-			ClearPageLRU(page);
-			del_page_from_lru_list(page, lruvec, lru);
-			ret = 0;
-		}
+		spin_lock_irq(&pgdat->lru_lock);
+		del_page_from_lru_list(page, lruvec, page_lru(page));
 		spin_unlock_irq(&pgdat->lru_lock);
+		ret = 0;
 	}
+
 	return ret;
 }
 
@@ -4293,6 +4288,10 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		nr_pages = thp_nr_pages(page);
 		pgscanned += nr_pages;
 
+		/* block memcg migration during page moving between lru */
+		if (!TestClearPageLRU(page))
+			continue;
+
 		if (pagepgdat != pgdat) {
 			if (pgdat)
 				spin_unlock_irq(&pgdat->lru_lock);
@@ -4301,10 +4300,7 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		}
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
-		if (!PageLRU(page) || !PageUnevictable(page))
-			continue;
-
-		if (page_evictable(page)) {
+		if (page_evictable(page) && PageUnevictable(page)) {
 			enum lru_list lru = page_lru_base_type(page);
 
 			VM_BUG_ON_PAGE(PageActive(page), page);
@@ -4313,12 +4309,15 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 			add_page_to_lru_list(page, lruvec, lru);
 			pgrescued += nr_pages;
 		}
+		SetPageLRU(page);
 	}
 
 	if (pgdat) {
 		__count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
 		__count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
 		spin_unlock_irq(&pgdat->lru_lock);
+	} else if (pgscanned) {
+		count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
 	}
 }
 EXPORT_SYMBOL_GPL(check_move_unevictable_pages);
-- 
1.8.3.1

