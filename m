Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45675300FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbhAVWK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730658AbhAVWHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:07:31 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95CBC061797
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i82so6811237yba.18
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fAuiFEZ8FCk1cyn9mPE9ipM3xtIpXox+XMx0+fOv6K0=;
        b=Tj3WeTBV23IF4aMWa4+0shsXAgeLKrQYNXoF2rnMDFzObm0V3stFevul6MDDuv0Vjy
         Uveak3xihcbz4I0qEFCBUG9x+WRhUSOYvOYJddiGvbmvnYZVRCJEwlN4LSfIwJtsMeMj
         WYTw2yQ36r6EHIJVvUKyK1o1e8rBlvI8xIi1PdDD61BzAbjGfvrK4hTjit/ZUPj8hBAx
         AeWHuF3krzcIQD5JGpwgGxNrwXjLtM7re+126AiQbRwzc7qMNaw4EdvwjTXfXUgnJ2e6
         NHP6clrqZtkZBATC9zU9jT/XBZqoUQr7+GJXkqYkGh5vo7ahJe1CSzFdfRGGK+he8pus
         vqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fAuiFEZ8FCk1cyn9mPE9ipM3xtIpXox+XMx0+fOv6K0=;
        b=mcTOLR90I0C731Vg8O6w3ramBxACcChJ4/rQ0mqNOQ+y0b1msSly5z0occWBOqpleK
         syZ8W2SVAfgHaEc7T4eypnaA5FR+yArRd9gXlsWNyhPlwTRQyrvvOPD6KPSJVwQ4773q
         HUpOp75r9ZnsrpehUmrW/jdi61XIBxbwNffKPpNijEeKQCh/LzloViJxwrmRU6aJnNbh
         tltrq6ewmTLk3IStdAbX9EiqMZO34GdYCpGoSMj9GXRukgpFOElmS5DTVhqjxEjB8swO
         PnEeJ+JqiORcyd7eRRRigCZRVn6GTk/n6bBYwS2m9UU2P7RTGn3NlnDsQUe1D9ono5Nz
         7wCg==
X-Gm-Message-State: AOAM531TYNXQhSHLT7EN9nizPIGyvoTwa7jzTeqNNWlS+lGPSIVe2BLF
        TTMC49E0hrmf5OH9v2NZmMk7WPf9FWI=
X-Google-Smtp-Source: ABdhPJzNQu1VwToQATIslnVn1F+DC21pIfxNwXyzzKXRWXw7PukDCkvFCwvjuDiotly+Vtus46FsaQy6rPw=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5129:9a91:ef0e:c1a9])
 (user=yuzhao job=sendgmr) by 2002:a25:2505:: with SMTP id l5mr9365754ybl.292.1611353172069;
 Fri, 22 Jan 2021 14:06:12 -0800 (PST)
Date:   Fri, 22 Jan 2021 15:05:57 -0700
In-Reply-To: <20210122220600.906146-1-yuzhao@google.com>
Message-Id: <20210122220600.906146-8-yuzhao@google.com>
Mime-Version: 1.0
References: <20210122220600.906146-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 07/10] mm: VM_BUG_ON lru page flags
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

Move scattered VM_BUG_ONs to two essential places that cover all
lru list additions and deletions.

Link: https://lore.kernel.org/linux-mm/20201207220949.830352-8-yuzhao@google.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h | 4 ++++
 mm/swap.c                 | 2 --
 mm/vmscan.c               | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index ef3fd79222e5..6d907a4dd6ad 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -66,6 +66,8 @@ static inline enum lru_list page_lru_base_type(struct page *page)
  */
 static __always_inline void __clear_page_lru_flags(struct page *page)
 {
+	VM_BUG_ON_PAGE(!PageLRU(page), page);
+
 	__ClearPageLRU(page);
 
 	/* this shouldn't happen, so leave the flags to bad_page() */
@@ -87,6 +89,8 @@ static __always_inline enum lru_list page_lru(struct page *page)
 {
 	enum lru_list lru;
 
+	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
+
 	if (PageUnevictable(page))
 		lru = LRU_UNEVICTABLE;
 	else {
diff --git a/mm/swap.c b/mm/swap.c
index 38900d672051..31b844d4ed94 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -83,7 +83,6 @@ static void __page_cache_release(struct page *page)
 		unsigned long flags;
 
 		lruvec = lock_page_lruvec_irqsave(page, &flags);
-		VM_BUG_ON_PAGE(!PageLRU(page), page);
 		del_page_from_lru_list(page, lruvec);
 		__clear_page_lru_flags(page);
 		unlock_page_lruvec_irqrestore(lruvec, flags);
@@ -909,7 +908,6 @@ void release_pages(struct page **pages, int nr)
 			if (prev_lruvec != lruvec)
 				lock_batch = 0;
 
-			VM_BUG_ON_PAGE(!PageLRU(page), page);
 			del_page_from_lru_list(page, lruvec);
 			__clear_page_lru_flags(page);
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 452dd3818aa3..348a90096550 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4281,7 +4281,6 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 
 		lruvec = relock_page_lruvec_irq(page, lruvec);
 		if (page_evictable(page) && PageUnevictable(page)) {
-			VM_BUG_ON_PAGE(PageActive(page), page);
 			del_page_from_lru_list(page, lruvec);
 			ClearPageUnevictable(page);
 			add_page_to_lru_list(page, lruvec);
-- 
2.30.0.280.ga3ce27912f-goog

