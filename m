Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD26300FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbhAVWIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729813AbhAVWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:06:49 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CB2C06178B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:08 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id w5so4585629qts.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Cnppx+CVBWio8kiSnapIqmyvLMG7ttWaX8+dG0VcN8Y=;
        b=npAvqpOHZYHenjgtdugR1VSi14cpzy+ZIkNex0ST5ae5o3EmcZKLBncTqAn37cV9Ha
         7suIKcduY/L+fjLpB6nnt8XblQGuXPWrFssRY2sgQ2xaPX7NFiI5Vn9WRODqIdOd4YBr
         zKdwgpBX0f2M2PAg8q9FwnZUpbcyfeyXx16cvqEjDcbRp9IMPR09K8CJZgk4B5MH+zBD
         HV6OqJTVBhI9mfxd9igc9A5veHUAQ4X2rZLqI/8+JWTSCCjEQyOmbSO7xGUyRi6YCqHt
         uWd+XgAKkb2lbf2PflaT0Rn/g0y2edCLy5BGaN/CHAQBxRCilsuaqZuXLF2Za4UXg6XA
         5ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cnppx+CVBWio8kiSnapIqmyvLMG7ttWaX8+dG0VcN8Y=;
        b=JtFC4mzka5A1wZG1cqozn/aOPfVNtq5jQGX6ErHv2Flzwuc0upOI1PxR9pMLflhKIK
         THTTHA5xUPAcufaDbczwms88EukIQe4yr0VHHE28OASJZKhl45tkkrOyGPZLr3F25WNV
         X2pTZkT47ads9uqczzuaiOUgpajXfIUfL4BpWTWQlJachAdyrVMcV96ur96ia9Fw/rRl
         KNXxL5GM25JL3Xyr1TVFrrlsywGuLXp42NV8Yhm+l7UhinS8CGM07mkumc0MmY9wFMb0
         w8HWDMgXox74iOqhOX589g+lyWDd/WZnUQ1lkf5Y17vFfQQlQr4J1FKfmxZ4ct1+dkm7
         cjHA==
X-Gm-Message-State: AOAM5309yxPfDW5iDnei0JcdVwNXcJS8sYkBX7Q69F89guqBEMjRx9Yg
        CS626ZagbUKPzzDusMG4uWTUkZfkAFg=
X-Google-Smtp-Source: ABdhPJzH2ptmbGlJJ4A0Eip3F7crD9fwrpLPZvwjmm+gGrcj39Bh07beIr4B9mEPXyRX5H/9ms4FexJiycw=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5129:9a91:ef0e:c1a9])
 (user=yuzhao job=sendgmr) by 2002:ad4:4108:: with SMTP id i8mr6324900qvp.49.1611353167796;
 Fri, 22 Jan 2021 14:06:07 -0800 (PST)
Date:   Fri, 22 Jan 2021 15:05:54 -0700
In-Reply-To: <20210122220600.906146-1-yuzhao@google.com>
Message-Id: <20210122220600.906146-5-yuzhao@google.com>
Mime-Version: 1.0
References: <20210122220600.906146-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 04/10] mm: don't pass "enum lru_list" to trace_mm_lru_insertion()
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

The parameter is redundant in the sense that it can be extracted
from the "struct page" parameter by page_lru() correctly.

Link: https://lore.kernel.org/linux-mm/20201207220949.830352-5-yuzhao@google.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
---
 include/trace/events/pagemap.h | 11 ++++-------
 mm/swap.c                      |  5 +----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
index 8fd1babae761..e1735fe7c76a 100644
--- a/include/trace/events/pagemap.h
+++ b/include/trace/events/pagemap.h
@@ -27,24 +27,21 @@
 
 TRACE_EVENT(mm_lru_insertion,
 
-	TP_PROTO(
-		struct page *page,
-		int lru
-	),
+	TP_PROTO(struct page *page),
 
-	TP_ARGS(page, lru),
+	TP_ARGS(page),
 
 	TP_STRUCT__entry(
 		__field(struct page *,	page	)
 		__field(unsigned long,	pfn	)
-		__field(int,		lru	)
+		__field(enum lru_list,	lru	)
 		__field(unsigned long,	flags	)
 	),
 
 	TP_fast_assign(
 		__entry->page	= page;
 		__entry->pfn	= page_to_pfn(page);
-		__entry->lru	= lru;
+		__entry->lru	= page_lru(page);
 		__entry->flags	= trace_pagemap_flags(page);
 	),
 
diff --git a/mm/swap.c b/mm/swap.c
index 4b058ef37add..56682c002db7 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -957,7 +957,6 @@ EXPORT_SYMBOL(__pagevec_release);
 
 static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 {
-	enum lru_list lru;
 	int was_unevictable = TestClearPageUnevictable(page);
 	int nr_pages = thp_nr_pages(page);
 
@@ -993,11 +992,9 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 	smp_mb__after_atomic();
 
 	if (page_evictable(page)) {
-		lru = page_lru(page);
 		if (was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 	} else {
-		lru = LRU_UNEVICTABLE;
 		ClearPageActive(page);
 		SetPageUnevictable(page);
 		if (!was_unevictable)
@@ -1005,7 +1002,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 	}
 
 	add_page_to_lru_list(page, lruvec);
-	trace_mm_lru_insertion(page, lru);
+	trace_mm_lru_insertion(page);
 }
 
 /*
-- 
2.30.0.280.ga3ce27912f-goog

