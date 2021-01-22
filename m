Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1469F300FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbhAVWJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbhAVWH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:07:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6191EC061794
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l3so6875053ybl.17
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PuLjvynrg4RueR9MnPtl/IKEUZzMuvZcczIQVkHLPxA=;
        b=is0zDnNnmJbohTyX0ICyl2GWebWoGZO3LYZYq5StpLjdztxZxQ1x6D4pDVi2482Wcv
         PFiQPq9Z2rZsA1VViLZtfi5aqmmNjb8NfcWwbdbfPOzR6r3ufyMTfhi//kRU8PpSgReq
         D8YOCZyVonQdyZjCBXQOHqkt4Hfb2a6uj8o/M49WOfP68LB9wKtRqZU4hmV/GBAoiJY2
         anDaAB3i+hlhzjqJ1wqYSVewzAfw9Z6/KOBuxmDLh8AdH9EIVPFfDPA1s5N1k/Ibw6Lj
         wnF5TB35lr9GtfGP3xAPhXb4UMlp9t+ZyEEf95Lgyon4Um8ohy1XJjFFRUSgR2IWRjeu
         Z9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PuLjvynrg4RueR9MnPtl/IKEUZzMuvZcczIQVkHLPxA=;
        b=hJfkQixhkY5ASImn+n4arVeTdHhs+HAP1nML9G5N5cWd7+mG+QxiqsWg37OQyTxsrx
         vQsjdtTpHzIyDnFGpC4ElHHvfyw8MIcjMLimcQI2hOs4+w9TFVL5vuR+SqHj5CBQoOsU
         ZLu2WkGnGnytrfURnTWYhki3eWKR4X/M/0crWciMIbbV6uwhTbHgNbAMnuoLs6Ou0/7q
         5A/dSs2RpEutwmkNr/hpSgSvbhLC0pA5lGfCTafTStp/OylQYBrMCRmSJySWQRe199OY
         rR82InrAsezmlA4qb5hU46MOVLCXExc+dIWWpRIQ5jkdqy2Vjo51vd3B4X2c/4JKsfyz
         egjA==
X-Gm-Message-State: AOAM532XVPr3JN2qHKHwhLy/G9g7z/YkR4XX/4Q2boBMG98OrOYAWZb8
        4ug89/gyhAP5FW2fT+63MOtRPTcOOSY=
X-Google-Smtp-Source: ABdhPJyRTcSRQhsSHaqqODslMrw0qd1Ys4U9WBeBKQcEiersSME0lIFIEZYEZdLFapETlRej2mLSzFfviX0=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5129:9a91:ef0e:c1a9])
 (user=yuzhao job=sendgmr) by 2002:a25:4296:: with SMTP id p144mr9927779yba.428.1611353170659;
 Fri, 22 Jan 2021 14:06:10 -0800 (PST)
Date:   Fri, 22 Jan 2021 15:05:56 -0700
In-Reply-To: <20210122220600.906146-1-yuzhao@google.com>
Message-Id: <20210122220600.906146-7-yuzhao@google.com>
Mime-Version: 1.0
References: <20210122220600.906146-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 06/10] mm: add __clear_page_lru_flags() to replace page_off_lru()
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

Similar to page_off_lru(), the new function does non-atomic clearing
of PageLRU() in addition to PageActive() and PageUnevictable(), on a
page that has no references left.

If PageActive() and PageUnevictable() are both set, refuse to clear
either and leave them to bad_page(). This is a behavior change that
is meant to help debug.

Link: https://lore.kernel.org/linux-mm/20201207220949.830352-7-yuzhao@google.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h | 28 ++++++++++------------------
 mm/swap.c                 |  6 ++----
 mm/vmscan.c               |  3 +--
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index ffacc6273678..ef3fd79222e5 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -61,27 +61,19 @@ static inline enum lru_list page_lru_base_type(struct page *page)
 }
 
 /**
- * page_off_lru - which LRU list was page on? clearing its lru flags.
- * @page: the page to test
- *
- * Returns the LRU list a page was on, as an index into the array of LRU
- * lists; and clears its Unevictable or Active flags, ready for freeing.
+ * __clear_page_lru_flags - clear page lru flags before releasing a page
+ * @page: the page that was on lru and now has a zero reference
  */
-static __always_inline enum lru_list page_off_lru(struct page *page)
+static __always_inline void __clear_page_lru_flags(struct page *page)
 {
-	enum lru_list lru;
+	__ClearPageLRU(page);
 
-	if (PageUnevictable(page)) {
-		__ClearPageUnevictable(page);
-		lru = LRU_UNEVICTABLE;
-	} else {
-		lru = page_lru_base_type(page);
-		if (PageActive(page)) {
-			__ClearPageActive(page);
-			lru += LRU_ACTIVE;
-		}
-	}
-	return lru;
+	/* this shouldn't happen, so leave the flags to bad_page() */
+	if (PageActive(page) && PageUnevictable(page))
+		return;
+
+	__ClearPageActive(page);
+	__ClearPageUnevictable(page);
 }
 
 /**
diff --git a/mm/swap.c b/mm/swap.c
index 94532799ed82..38900d672051 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -84,9 +84,8 @@ static void __page_cache_release(struct page *page)
 
 		lruvec = lock_page_lruvec_irqsave(page, &flags);
 		VM_BUG_ON_PAGE(!PageLRU(page), page);
-		__ClearPageLRU(page);
 		del_page_from_lru_list(page, lruvec);
-		page_off_lru(page);
+		__clear_page_lru_flags(page);
 		unlock_page_lruvec_irqrestore(lruvec, flags);
 	}
 	__ClearPageWaiters(page);
@@ -911,9 +910,8 @@ void release_pages(struct page **pages, int nr)
 				lock_batch = 0;
 
 			VM_BUG_ON_PAGE(!PageLRU(page), page);
-			__ClearPageLRU(page);
 			del_page_from_lru_list(page, lruvec);
-			page_off_lru(page);
+			__clear_page_lru_flags(page);
 		}
 
 		__ClearPageWaiters(page);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7c65d47e6612..452dd3818aa3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1849,8 +1849,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		SetPageLRU(page);
 
 		if (unlikely(put_page_testzero(page))) {
-			__ClearPageLRU(page);
-			__ClearPageActive(page);
+			__clear_page_lru_flags(page);
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&lruvec->lru_lock);
-- 
2.30.0.280.ga3ce27912f-goog

