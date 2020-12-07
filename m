Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031502D1CE0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgLGWLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLGWLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:11:24 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCB3C06138C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:10:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z83so19808513ybz.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=M6CwO9vrk8Jipcr5P78f46dlJFouYfu/sDvlfr5MXC4=;
        b=IziUJR3gadCdwjzue8i4u+Rd/gOqNgrzK/uqFLSsCbKbm04jYATGUJvtOV6u75wGQJ
         g5T63LkvFzj5ao/cGGDQ80HTbrP1SEb71K8NhN06eLeQg/IoYuQxD11Xv9V0u7vxPr2P
         Pgv/4ThBGoO9qMeguGuHLFd/IErzS2Exak9Ql6oyUHPz6+k8t/8JnfhqOVWr5PkM8Onq
         GTHJQEDII6gLHEeEsWth/S+Mdmvp7eV3eFCtmIyvGZ214atwN3Rg9Rgs/kXO9TYO48sW
         M1fiw/hVwF5oS1N7H0fAUOKjNnTY0yvqV6h0w2dk/fFQZqpnyPDo+LIVTHllp6NdCXyg
         /I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M6CwO9vrk8Jipcr5P78f46dlJFouYfu/sDvlfr5MXC4=;
        b=aJDCnBATFb6mq8ko+D7VCKB4Uu/FKnSsCWNltyege9yTaJ5bPhsIvL2T29W6bHUdmM
         u4Vb+SPF19IcRhz2EOywzMumYmBTJBz4KQPCyFkSJMj5xg7OR2PkDCd5UD0FWjhVIZum
         R5a6f5+DfQhmmqLHuFX13r7cYM10IcZgSjvSCZ6uQErbw7G1akUHIJ26l+8UlTx4tMGA
         VYkYGBpqHP8QOmyMGcRFsGrIgKSY5lqlzMgpkjGPj0jnHvJKgzPndLhLXplmg6gsg375
         GVzbA+QDSnaOu3XmsB5Thxpdr0ZWsetiKkcv6E+6pEPE4TMiXoNH9dN4IyBoGwRkUITo
         VxgQ==
X-Gm-Message-State: AOAM531IRFRMEV0HXHPWCbdhxazWkeTDu4PL36NO1lO4Uiceoelqq7pR
        Wp3oE6IbHEtF3y21MEdOn43V/zYHRUA=
X-Google-Smtp-Source: ABdhPJwZb6+nslCcravkBg1ZSHnaWPcfDWbLM4oVGssVoLFmC2KkzoM4YBx2t/HdgizhhzCCOnOSPPtfYvw=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a25:f09:: with SMTP id 9mr26951208ybp.129.1607379007239;
 Mon, 07 Dec 2020 14:10:07 -0800 (PST)
Date:   Mon,  7 Dec 2020 15:09:43 -0700
In-Reply-To: <20201207220949.830352-1-yuzhao@google.com>
Message-Id: <20201207220949.830352-6-yuzhao@google.com>
Mime-Version: 1.0
References: <20201207220949.830352-1-yuzhao@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH 05/11] mm: don't pass "enum lru_list" to del_page_from_lru_list()
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
index 8049d3530812..fd2058330497 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1034,7 +1034,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
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
index e053b4db108a..d55a0c27d804 100644
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
index 8fc8f2c9d7ec..49451899037c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1764,7 +1764,7 @@ int isolate_lru_page(struct page *page)
 
 		get_page(page);
 		lruvec = lock_page_lruvec_irq(page);
-		del_page_from_lru_list(page, lruvec, page_lru(page));
+		del_page_from_lru_list(page, lruvec);
 		unlock_page_lruvec_irq(lruvec);
 		ret = 0;
 	}
@@ -4281,8 +4281,8 @@ void check_move_unevictable_pages(struct pagevec *pvec)
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
2.29.2.576.ga3fc446d84-goog

