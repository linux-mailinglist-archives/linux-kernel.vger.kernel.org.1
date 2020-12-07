Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FD02D1CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgLGWL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgLGWL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:11:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5C3C061257
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:10:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m203so460335ybf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NPIJCrwWnwAzgQ2Qn9Zjmyj37pTsRc+tAPAwXdBwjQM=;
        b=JkwUTYvRknielhHc5S+DwhqhSrdC1vNFwohjSYPIXJdWfzrFUgg1chCp+rkY8bCcan
         AxGxOZ2Sk6lSPeJsAlcYMdBeQWBJtLI9ZDMIbLNi0j5gT17OrWUJ9EXZ2ENjvDZOmjOx
         aQr9gwgfoZ9OvNocI0K+W26Rr+V/93XvsAWJUoKNbSfhrPVTmH0tRKXAXvpbD2dT3WTB
         /lyQVWAaCN1A+OveyrGUarqC9D48ZmqQ6ubOKuVQTZEOINclgwHL/GIAJC9ZOdSFbHKC
         3yLHjhseb44m19eInYtUvdaXj+IRiTycoM87Xul6XMMEzC8VnFaFwZfsFhslTQSDeTzU
         IxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NPIJCrwWnwAzgQ2Qn9Zjmyj37pTsRc+tAPAwXdBwjQM=;
        b=fH+P1wq6Ig+lPsgQmHOmZmARmHPDI8U5PHvdkyET1L4kpunoJg+uu15SW9BBJTqp0q
         MvfCVKlEVStviMSMcADq0ycPGnSG3aVIDVZJMWK4/3EQxZXzAscTS218LHMab0L3ZamM
         owcQOtTP7gC6LcUYn5EfK6TM3YW3Z6qWpQ6ag6AniVWDmN4fyqMweE0f/1oBDcIO2V3B
         bRLKpFZQ3jL92/PnsFPhvCOKBjXf39uo9L7D5UZc9VyZqOfFS40LiSCrpMtSCoPU0Yej
         MeSY1XP4qT2CepIUguJNovJnyTutlvRGd/OFEyWQa0H7eWlc8sHmvD02beG+OJyTqqwy
         pkAA==
X-Gm-Message-State: AOAM533QzBUyNns2Gin/GNMe6uIsHbW9f4tP1nrT1XsNYrhpXcSLPzi0
        lWxbTns0L2cWCvgFoVDdNnUSxSeNqY8=
X-Google-Smtp-Source: ABdhPJzlYqmdnXQI26Kw5mDt0tCjeHnOs8eVNmrbUZukm+ES7uDZ71CL+xtBFkBA1yiOLpj65GPnWe8zu8w=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a25:8446:: with SMTP id r6mr24209537ybm.442.1607379010197;
 Mon, 07 Dec 2020 14:10:10 -0800 (PST)
Date:   Mon,  7 Dec 2020 15:09:45 -0700
In-Reply-To: <20201207220949.830352-1-yuzhao@google.com>
Message-Id: <20201207220949.830352-8-yuzhao@google.com>
Mime-Version: 1.0
References: <20201207220949.830352-1-yuzhao@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH 07/11] mm: VM_BUG_ON lru page flags
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
index a37c896a32b0..09c4a48e0bcd 100644
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
index e6bdfdfa2da1..95e581c9d9af 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4279,7 +4279,6 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 
 		lruvec = relock_page_lruvec_irq(page, lruvec);
 		if (page_evictable(page) && PageUnevictable(page)) {
-			VM_BUG_ON_PAGE(PageActive(page), page);
 			del_page_from_lru_list(page, lruvec);
 			ClearPageUnevictable(page);
 			add_page_to_lru_list(page, lruvec);
-- 
2.29.2.576.ga3fc446d84-goog

