Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C27E300FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbhAVWIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbhAVWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:06:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCEEC061788
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 67so6853061ybh.22
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6tYKFJlOjUi4v7dxUtU008EVEUsjebXj9aGlyhOOTRY=;
        b=Lin1fBDfs49ToqHhinKJo5WCabg8cHvmzRGU+MHB8noS3TO/7kdhKHSq4B21/HSvv7
         AL3T4lUw2JOJCYvpE92NGm0M0I5R7+C+XMUcp2i9Ia3OcbPr58HmNRIw33WaeqX4l996
         Z6nwLSRZoA4C2+vuIjXmlbPEmOMoHPu+6X8tKncG7cYSbBp+6RrJp7G7gbD9q0K4lrKi
         +KWa02wUceBS0I2sIrqe2K2isxVB3q+0P/pyp2lG3iu3BCAczy673wh46XDlhlp5QSdO
         f5iaCtkS1oPH3+Zy6OuYpmHfZcy7KY15IqaKYuRxg77zbBANht275o4xt6yws4Fic98w
         JP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6tYKFJlOjUi4v7dxUtU008EVEUsjebXj9aGlyhOOTRY=;
        b=ojEiA62Ph6jFW8bvcCxKuV0oUTWXGXgcWsqGVWVaKn+2GcY/UlsbsSeSQsUtc8NcjV
         l61LKupEumpssk4rKl6+AUq/zXSL+MRjlPiX9YquuFZWsV0mOMHwWckJu6k2RIlRj206
         1qUMBgNKTofgSboMa85ol41T8VtpRIvj/xwS1vMRdesvqvv8NjiSXujZVQp4tc28r8cB
         MN29cyzlm2BBBqML6VZogqM90Kk8N5RCGKiVFaC28m6VZ9cGya0+FtPfgigtiDp5sNhP
         Zlbv4q/MiOPiIWhgnQLhkbUNaPZLuFXll+iiauoWJD1xLU+74fhGnr9KBuJvN44Fu+Dg
         qVHg==
X-Gm-Message-State: AOAM53130shX2nBdL8UPa75rh4QEKSEzAsFdhzaPRGPAbctUhQBRqT0r
        jpoGOQW2oIeKTAaWN/+M0O166E4KLZA=
X-Google-Smtp-Source: ABdhPJz2EAXiGRuqsYtX77btAm5YE4nGxkhkS/RBacGhOf2nSumfuEHnFAm6QB5hWkYOUqSstiSFAt0a2R0=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5129:9a91:ef0e:c1a9])
 (user=yuzhao job=sendgmr) by 2002:a25:9b45:: with SMTP id u5mr9202755ybo.331.1611353166601;
 Fri, 22 Jan 2021 14:06:06 -0800 (PST)
Date:   Fri, 22 Jan 2021 15:05:53 -0700
In-Reply-To: <20210122220600.906146-1-yuzhao@google.com>
Message-Id: <20210122220600.906146-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20210122220600.906146-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 03/10] mm: don't pass "enum lru_list" to lru list addition functions
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

Link: https://lore.kernel.org/linux-mm/20201207220949.830352-4-yuzhao@google.com/
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
index 490553f3f9ef..4b058ef37add 100644
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
index 19875660e8f8..09e4f97488c9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1867,7 +1867,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		 * inhibits memcg migration).
 		 */
 		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
-		add_page_to_lru_list(page, lruvec, page_lru(page));
+		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
 		if (PageActive(page))
@@ -4282,12 +4282,10 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 
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
2.30.0.280.ga3ce27912f-goog

