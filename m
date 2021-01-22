Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1B5300FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbhAVWKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730616AbhAVWH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:07:27 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB530C061793
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:09 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id i11so5096790qkn.21
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=dY2ZUp0PF6rLon2iFmQEtt29TVjYa1d8HYIO3og6VGs=;
        b=XSKdRG2I+FkXq7NpjZTTTTrJiyL4WMljgJGfpCpMX4dS+I+uUBI4P213WwG7nHFXkk
         OqKzFCKwT90hKLnRZ5tj1XMWqOVag8ojh7gjXo4mZBNxRRFJiK9Z8p2fZOJIjm0dCCag
         FeR87Dzi8czafYpSk1Ph/iRWZgmCGDSZy4d7LWqOP7wD2GSgCmJpvrrcX7ttXeCkKMs/
         6psZtcO5t36E75MEiffG+kh+9CXlSuhcorY+03WMRchIZaitrvcKuh5LDlAkIMPmwSMh
         Iw/JyMUb0D2OV1wp0BM+RNphNNYbKleBQzrG5mlR9AL2/Y4NhBXA6bgP9IjmggdKjW3A
         GVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dY2ZUp0PF6rLon2iFmQEtt29TVjYa1d8HYIO3og6VGs=;
        b=SMmclGpqM40ZE/DZsv7DyZoeeZ2vnooJwAfJs4hkpTE+fPHPAlirzJCEKYrnPqW8I+
         qDyVl6HOVx/Av4p/jcpm/QDEQLX7W4ioQhus+YD5lQ8d/dMsJ8++ulra0Yttg/zvmYUG
         50cyhw7RupSgzoeagIXW8zSA9BysNoR3eRo9TLoC83HnD510jBzPX/49SdQXg9pxwYlh
         SaipgeMNSmf1ROV8M++u7M+aqtVH4VoQ6Sf4j9L3Z6sq017Xx4/+rQh8/OZBUDHklyLa
         LZiaaznZWImi2tlc3hjAVq0oXU55/IMeQ9FZw9c0SOLx6FeEmmnf5zugUfxlUZ9f5zPI
         1Afg==
X-Gm-Message-State: AOAM530tmY5z/z06TMk0zbPjgOTN687YeGlD/gjZEcqAFXyK1Yhy7Nyp
        Smj1ENCtlBmdHpmo/zDz5SHzGovHXGQ=
X-Google-Smtp-Source: ABdhPJxFPaXdnBEP2moUANWUz9QxU291FJpi9b9+T2aZQPfn6M4adT85YHD5opPYDdFiI93hCOOhDWzlpng=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5129:9a91:ef0e:c1a9])
 (user=yuzhao job=sendgmr) by 2002:a0c:8c87:: with SMTP id p7mr796493qvb.46.1611353169058;
 Fri, 22 Jan 2021 14:06:09 -0800 (PST)
Date:   Fri, 22 Jan 2021 15:05:55 -0700
In-Reply-To: <20210122220600.906146-1-yuzhao@google.com>
Message-Id: <20210122220600.906146-6-yuzhao@google.com>
Mime-Version: 1.0
References: <20210122220600.906146-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 05/10] mm: don't pass "enum lru_list" to del_page_from_lru_list()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter is redundant in the sense that it can be potentially
extracted from the "struct page" parameter by page_lru(). We need to
make sure that existing PageActive() or PageUnevictable() remains
until the function returns. A few places don't conform, and simple
reordering fixes them.

This patch may have left page_off_lru() seemingly odd, and we'll take
care of it in the next patch.

Link: https://lore.kernel.org/linux-mm/20201207220949.830352-6-yuzhao@google.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h |  5 +++--
 mm/compaction.c           |  2 +-
 mm/mlock.c                |  3 +--
 mm/swap.c                 | 26 ++++++++++----------------
 mm/vmscan.c               |  4 ++--
 5 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 130ba3201d3f..ffacc6273678 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -124,9 +124,10 @@ static __always_inline void add_page_to_lru_list_tail(struct page *page,
 }
 
 static __always_inline void del_page_from_lru_list(struct page *page,
-				struct lruvec *lruvec, enum lru_list lru)
+				struct lruvec *lruvec)
 {
 	list_del(&page->lru);
-	update_lru_size(lruvec, lru, page_zonenum(page), -thp_nr_pages(page));
+	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
+			-thp_nr_pages(page));
 }
 #endif
diff --git a/mm/compaction.c b/mm/compaction.c
index 6e21db7f51b3..71fab3f5938c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1030,7 +1030,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			low_pfn += compound_nr(page) - 1;
 
 		/* Successfully isolated */
-		del_page_from_lru_list(page, lruvec, page_lru(page));
+		del_page_from_lru_list(page, lruvec);
 		mod_node_page_state(page_pgdat(page),
 				NR_ISOLATED_ANON + page_is_file_lru(page),
 				thp_nr_pages(page));
diff --git a/mm/mlock.c b/mm/mlock.c
index 55b3b3672977..73960bb3464d 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -278,8 +278,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 			 */
 			if (TestClearPageLRU(page)) {
 				lruvec = relock_page_lruvec_irq(page, lruvec);
-				del_page_from_lru_list(page, lruvec,
-							page_lru(page));
+				del_page_from_lru_list(page, lruvec);
 				continue;
 			} else
 				__munlock_isolation_failed(page);
diff --git a/mm/swap.c b/mm/swap.c
index 56682c002db7..94532799ed82 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -85,7 +85,8 @@ static void __page_cache_release(struct page *page)
 		lruvec = lock_page_lruvec_irqsave(page, &flags);
 		VM_BUG_ON_PAGE(!PageLRU(page), page);
 		__ClearPageLRU(page);
-		del_page_from_lru_list(page, lruvec, page_off_lru(page));
+		del_page_from_lru_list(page, lruvec);
+		page_off_lru(page);
 		unlock_page_lruvec_irqrestore(lruvec, flags);
 	}
 	__ClearPageWaiters(page);
@@ -229,7 +230,7 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
 {
 	if (!PageUnevictable(page)) {
-		del_page_from_lru_list(page, lruvec, page_lru(page));
+		del_page_from_lru_list(page, lruvec);
 		ClearPageActive(page);
 		add_page_to_lru_list_tail(page, lruvec);
 		__count_vm_events(PGROTATED, thp_nr_pages(page));
@@ -308,10 +309,9 @@ void lru_note_cost_page(struct page *page)
 static void __activate_page(struct page *page, struct lruvec *lruvec)
 {
 	if (!PageActive(page) && !PageUnevictable(page)) {
-		int lru = page_lru_base_type(page);
 		int nr_pages = thp_nr_pages(page);
 
-		del_page_from_lru_list(page, lruvec, lru);
+		del_page_from_lru_list(page, lruvec);
 		SetPageActive(page);
 		add_page_to_lru_list(page, lruvec);
 		trace_mm_lru_activate(page);
@@ -518,8 +518,7 @@ void lru_cache_add_inactive_or_unevictable(struct page *page,
  */
 static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 {
-	int lru;
-	bool active;
+	bool active = PageActive(page);
 	int nr_pages = thp_nr_pages(page);
 
 	if (PageUnevictable(page))
@@ -529,10 +528,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 	if (page_mapped(page))
 		return;
 
-	active = PageActive(page);
-	lru = page_lru_base_type(page);
-
-	del_page_from_lru_list(page, lruvec, lru + active);
+	del_page_from_lru_list(page, lruvec);
 	ClearPageActive(page);
 	ClearPageReferenced(page);
 
@@ -563,10 +559,9 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 {
 	if (PageActive(page) && !PageUnevictable(page)) {
-		int lru = page_lru_base_type(page);
 		int nr_pages = thp_nr_pages(page);
 
-		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
+		del_page_from_lru_list(page, lruvec);
 		ClearPageActive(page);
 		ClearPageReferenced(page);
 		add_page_to_lru_list(page, lruvec);
@@ -581,11 +576,9 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
 {
 	if (PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
-		bool active = PageActive(page);
 		int nr_pages = thp_nr_pages(page);
 
-		del_page_from_lru_list(page, lruvec,
-				       LRU_INACTIVE_ANON + active);
+		del_page_from_lru_list(page, lruvec);
 		ClearPageActive(page);
 		ClearPageReferenced(page);
 		/*
@@ -919,7 +912,8 @@ void release_pages(struct page **pages, int nr)
 
 			VM_BUG_ON_PAGE(!PageLRU(page), page);
 			__ClearPageLRU(page);
-			del_page_from_lru_list(page, lruvec, page_off_lru(page));
+			del_page_from_lru_list(page, lruvec);
+			page_off_lru(page);
 		}
 
 		__ClearPageWaiters(page);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 09e4f97488c9..7c65d47e6612 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1766,7 +1766,7 @@ int isolate_lru_page(struct page *page)
 
 		get_page(page);
 		lruvec = lock_page_lruvec_irq(page);
-		del_page_from_lru_list(page, lruvec, page_lru(page));
+		del_page_from_lru_list(page, lruvec);
 		unlock_page_lruvec_irq(lruvec);
 		ret = 0;
 	}
@@ -4283,8 +4283,8 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		lruvec = relock_page_lruvec_irq(page, lruvec);
 		if (page_evictable(page) && PageUnevictable(page)) {
 			VM_BUG_ON_PAGE(PageActive(page), page);
+			del_page_from_lru_list(page, lruvec);
 			ClearPageUnevictable(page);
-			del_page_from_lru_list(page, lruvec, LRU_UNEVICTABLE);
 			add_page_to_lru_list(page, lruvec);
 			pgrescued += nr_pages;
 		}
-- 
2.30.0.280.ga3ce27912f-goog

