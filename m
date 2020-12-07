Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FE22D1CE1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgLGWLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgLGWLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:11:24 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C860C061285
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:10:09 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id a22so12368809qtx.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oqyquPDsQv/losMm6vmwKnq7puKQvoB7JepY3I4Ctjo=;
        b=IutVZCqQJIGWGjR8da5I9BZEA6qbm1LSKTSIyeEi88bwC+1t7hNQss/U7D5Xp/xBbN
         tnjL4W1QYVO2quExQoj8aWLsrfAhoeeHUFeAPRGm8ZuDOgql1XgHWniiBdKVMVLG6+Ds
         mAoGc9OBJLechfDWZdFWog6v8Rrt/lEzdqVEkg5ANBHZioqRPfL+zaSeHd52enkDXQoh
         JfUu/SBRZr29zpkWKhrBtjyIFaQn7aIZncsiVraupsxAgwtVGG7Xs4W1bOmVvrssYiWw
         T8wJcDgkrAzV+BXYH7DsPN2qZ24y0Xz6WIyTjmLK8zG6+Dm0rhLsW0zy8CcTd95Kfe9D
         3ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oqyquPDsQv/losMm6vmwKnq7puKQvoB7JepY3I4Ctjo=;
        b=iXPSXukIs33AfD7qwkoKNyBb4C6gXw/yjcHPg6sVVkdz9YZtngBmkvD+8Pvg1fpjTp
         nPSQcqY47GSvZxtX2Yr0QbE8G7KLL/1FzWLHXHOmF9F5BNNFo81fMH9BRamNcGIPIFEi
         Gzbmd1Hv+zOQDlyvgmcqtEG+8Yq7fY74p0cgQOz4mRYVrKtRG7wwvYmdg3JFptXGPq5P
         XUGN3dydcx65CP3VufbYbwhDcfKG/2aUD5DO59Mreljpq025bE1iY6HcCHRmO9jt07+I
         We1E9Ig2oy/sbbyAyYUDC5ev69p/6OEDPVOt/f7s5jTLuP64qGQHXcE2jfxkyPzigqvH
         UGxQ==
X-Gm-Message-State: AOAM533hJWo5VwZNdSlTg821KTMh5tDLyZ8uS4XVTjcr8uCF/mHEQ8Dw
        zxWen9LoTeGa6/Z3OoYh8Qhc1r5MCP0=
X-Google-Smtp-Source: ABdhPJyFcXvBQlIF2WWyp7++Nj9btU9SvkMYtKHuKytdDJ36qrAREMDYQIhMtnFTsibh5fPPfemlfI+ErzY=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a0c:bf44:: with SMTP id b4mr23909200qvj.30.1607379008664;
 Mon, 07 Dec 2020 14:10:08 -0800 (PST)
Date:   Mon,  7 Dec 2020 15:09:44 -0700
In-Reply-To: <20201207220949.830352-1-yuzhao@google.com>
Message-Id: <20201207220949.830352-7-yuzhao@google.com>
Mime-Version: 1.0
References: <20201207220949.830352-1-yuzhao@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH 06/11] mm: add __clear_page_lru_flags() to replace page_off_lru()
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
index d55a0c27d804..a37c896a32b0 100644
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
index 49451899037c..e6bdfdfa2da1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1847,8 +1847,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		SetPageLRU(page);
 
 		if (unlikely(put_page_testzero(page))) {
-			__ClearPageLRU(page);
-			__ClearPageActive(page);
+			__clear_page_lru_flags(page);
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&lruvec->lru_lock);
-- 
2.29.2.576.ga3fc446d84-goog

