Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F612D1CDA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgLGWKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgLGWKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:10:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BF0C06179C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:10:05 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b9so14103969ybi.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=McdTDI5gTaApfzVRyszFJfKAeo/sD2oxQxdyTUnmuTU=;
        b=VzV//rAr/11+bo+kkpF9/SgtAirJwiN/16IJGMJ4kZgcqXPR4rjxNm3l0i/CFnpPWV
         prr2VVg2jq+5MgYTFREBfWcqJZK1u6FGROt0dbv4qUZTIfdEm/hXDl0Lqr8v8obWPHEN
         UKYfk63VEX8+nrl1ezkYi+kmdkOFkezxmiUEkdKhGNeeQXwzZAawfICznHKsjMwe80MK
         JY630hcH3BppRLj0Rtz9g1BG1WfkMCprb5n4DRa+H6K0PxwEYao9qiHdpuUmyx/ZM0Of
         pxZU8gp97DuhsaocR9jrXW0cHxJJYXzarPOnRxPYWX+tPtbd6cvpnp02yntBmzgsNL8n
         WCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=McdTDI5gTaApfzVRyszFJfKAeo/sD2oxQxdyTUnmuTU=;
        b=blP1tMT1FK8mCKL63ojJQ3HEX4FyG0eL5cKfJlAw/3KGdI4KJ29V1kSx02Jq0Ms/tr
         ZduQpbRSB+40+8hYCrleFl2M6yRs1qoIMs4S5nc+KX+Mcn3vQFLs1Xu09pXey3pBamDE
         kLO5X/xBh5TCU/b0XwjJIp1w6VDNEepBguhZguwDRi5EW5QZNISS49n+MDgaiKVPqSEj
         3y+LYJrban95NXbvoZD8kej14FkHBvvttYusE48REquaGZNm9mVjdnpuD6j8bgfi4cph
         CowKcC//0GDJ/pSHItPM1xWHNBeMsI6Nbac+hC7HNmfJwmK9a7aIGYnSebuTtjbQm9AO
         xgrQ==
X-Gm-Message-State: AOAM532dU9+QyyCZNoj9TUuCnOOuakF/3DJvZDaZZIpA3pqZQxUMmgiC
        OGA6JH2vy8Y0NOqbHc/8wo3iHF21u8U=
X-Google-Smtp-Source: ABdhPJzdJEGVZ8rnGEwlN3OE6e/qoWUD8uaxm9qmkp6j49pGWZQRiP6bBqDLeanyLkseC2KSGOiXA91BGhI=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a25:d2c5:: with SMTP id j188mr26647887ybg.485.1607379004333;
 Mon, 07 Dec 2020 14:10:04 -0800 (PST)
Date:   Mon,  7 Dec 2020 15:09:41 -0700
In-Reply-To: <20201207220949.830352-1-yuzhao@google.com>
Message-Id: <20201207220949.830352-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20201207220949.830352-1-yuzhao@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH 03/11] mm: don't pass "enum lru_list" to lru list addition functions
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

The "enum lru_list" parameter to add_page_to_lru_list() and
add_page_to_lru_list_tail() is redundant in the sense that it can
be extracted from the "struct page" parameter by page_lru().

A caveat is that we need to make sure PageActive() or
PageUnevictable() is correctly set or cleared before calling
these two functions. And they are indeed.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h |  8 ++++++--
 mm/swap.c                 | 15 +++++++--------
 mm/vmscan.c               |  6 ++----
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 2889741f450a..130ba3201d3f 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -106,15 +106,19 @@ static __always_inline enum lru_list page_lru(struct page *page)
 }
 
 static __always_inline void add_page_to_lru_list(struct page *page,
-				struct lruvec *lruvec, enum lru_list lru)
+				struct lruvec *lruvec)
 {
+	enum lru_list lru = page_lru(page);
+
 	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
 	list_add(&page->lru, &lruvec->lists[lru]);
 }
 
 static __always_inline void add_page_to_lru_list_tail(struct page *page,
-				struct lruvec *lruvec, enum lru_list lru)
+				struct lruvec *lruvec)
 {
+	enum lru_list lru = page_lru(page);
+
 	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
 	list_add_tail(&page->lru, &lruvec->lists[lru]);
 }
diff --git a/mm/swap.c b/mm/swap.c
index 5022dfe388ad..136acabbfab5 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -231,7 +231,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
 	if (!PageUnevictable(page)) {
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		ClearPageActive(page);
-		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
+		add_page_to_lru_list_tail(page, lruvec);
 		__count_vm_events(PGROTATED, thp_nr_pages(page));
 	}
 }
@@ -313,8 +313,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec)
 
 		del_page_from_lru_list(page, lruvec, lru);
 		SetPageActive(page);
-		lru += LRU_ACTIVE;
-		add_page_to_lru_list(page, lruvec, lru);
+		add_page_to_lru_list(page, lruvec);
 		trace_mm_lru_activate(page);
 
 		__count_vm_events(PGACTIVATE, nr_pages);
@@ -543,14 +542,14 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 		 * It can make readahead confusing.  But race window
 		 * is _really_ small and  it's non-critical problem.
 		 */
-		add_page_to_lru_list(page, lruvec, lru);
+		add_page_to_lru_list(page, lruvec);
 		SetPageReclaim(page);
 	} else {
 		/*
 		 * The page's writeback ends up during pagevec
 		 * We moves tha page into tail of inactive.
 		 */
-		add_page_to_lru_list_tail(page, lruvec, lru);
+		add_page_to_lru_list_tail(page, lruvec);
 		__count_vm_events(PGROTATED, nr_pages);
 	}
 
@@ -570,7 +569,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
 		ClearPageActive(page);
 		ClearPageReferenced(page);
-		add_page_to_lru_list(page, lruvec, lru);
+		add_page_to_lru_list(page, lruvec);
 
 		__count_vm_events(PGDEACTIVATE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
@@ -595,7 +594,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
 		 * anonymous pages
 		 */
 		ClearPageSwapBacked(page);
-		add_page_to_lru_list(page, lruvec, LRU_INACTIVE_FILE);
+		add_page_to_lru_list(page, lruvec);
 
 		__count_vm_events(PGLAZYFREE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE,
@@ -1005,7 +1004,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 			__count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
 	}
 
-	add_page_to_lru_list(page, lruvec, lru);
+	add_page_to_lru_list(page, lruvec);
 	trace_mm_lru_insertion(page, lru);
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a174594e40f8..8fc8f2c9d7ec 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1865,7 +1865,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		 * inhibits memcg migration).
 		 */
 		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
-		add_page_to_lru_list(page, lruvec, page_lru(page));
+		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
 		if (PageActive(page))
@@ -4280,12 +4280,10 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 
 		lruvec = relock_page_lruvec_irq(page, lruvec);
 		if (page_evictable(page) && PageUnevictable(page)) {
-			enum lru_list lru = page_lru_base_type(page);
-
 			VM_BUG_ON_PAGE(PageActive(page), page);
 			ClearPageUnevictable(page);
 			del_page_from_lru_list(page, lruvec, LRU_UNEVICTABLE);
-			add_page_to_lru_list(page, lruvec, lru);
+			add_page_to_lru_list(page, lruvec);
 			pgrescued += nr_pages;
 		}
 		SetPageLRU(page);
-- 
2.29.2.576.ga3fc446d84-goog

