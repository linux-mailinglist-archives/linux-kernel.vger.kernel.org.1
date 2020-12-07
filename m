Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A956D2D1CD7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgLGWKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgLGWKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:10:46 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91049C0617B0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:10:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z3so19807671ybc.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+i7jXjo3RGuU1pORyKs9fhQMrDbu2jqMyaA/zOdPLEU=;
        b=BBB1vpJZAqn3QWvpJ41MwDbQ3WY9GeKfM5yvpEaRsOygyH8QMir+PyA5kyYNIcOcfd
         380wJ853ujXujcGzKi8iZ5IMVosg4cCEvx5M5LO1Gu2za6qb0fw/R0qRaA1Aon3nNasi
         h7sPm4J2mFD9GjVg74/EeEfy2O5L7ztHjAMpJ63qXj8rV5+HY85baWXeZnWVRiaiiSSm
         VVHaZ5tj1TCE9gwI9Q/rmQZD2xOCpZFvgyhD9hWunj8GsBN14DsLsCF/ycPOHlqKqTaF
         GkumoYu8oz2+Mf0w3BY8w/FoLNiHAvgsNgugIuT4SPUaVdtPTCzqtr+stQKTosz7wrO+
         aBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+i7jXjo3RGuU1pORyKs9fhQMrDbu2jqMyaA/zOdPLEU=;
        b=k+fB+ccehhh5ZMy1hj93LtYWVTKBvddxWrEcHGQuWhKeggOR42NfDYBgigZyfUA898
         kNlTM0wlHVnbb/lIgBlDxGie9WFNDs0lIsyJGD7C1EocS9+awvCmZrivUdWibahVbpp5
         tIzErdCa2FoVlo3TQwqO49pqWR7SeJ9ZwIOWyHDBgqzSpMMeTFdGNeibOah10a6pHd+w
         W55lHuBG+pfJZyHY28H1Sq87lLiS3GlYFPt+MBslys7E/20t7rXl9lhH6Ib+9MlmGGgp
         UXY8VB/eoek0hjtmPS2pqFEIywHTaNsqtUfJEZ6AHiwIk6KJFJ2Hw9E4S8LKwDMghpHo
         wL/Q==
X-Gm-Message-State: AOAM532FH0nBJu32qO4Vmm3mykGDgX1VohEWp5qc/dW6XK2L/bfNh0Z5
        VIgL8Prew2W3fwlJh1dlpkm20zxvsa8=
X-Google-Smtp-Source: ABdhPJzeFSY4rrnRDv5UMWqStyUMNed1tMPLl3uYWnIsHoL+6EzxfRunU0xwJOzgTRUeXIfRX6jiYC2oGWA=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a25:15c8:: with SMTP id 191mr26000192ybv.256.1607379005807;
 Mon, 07 Dec 2020 14:10:05 -0800 (PST)
Date:   Mon,  7 Dec 2020 15:09:42 -0700
In-Reply-To: <20201207220949.830352-1-yuzhao@google.com>
Message-Id: <20201207220949.830352-5-yuzhao@google.com>
Mime-Version: 1.0
References: <20201207220949.830352-1-yuzhao@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH 04/11] mm: don't pass "enum lru_list" to trace_mm_lru_insertion()
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

Signed-off-by: Yu Zhao <yuzhao@google.com>
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
index 136acabbfab5..e053b4db108a 100644
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
 
 struct lruvecs {
-- 
2.29.2.576.ga3fc446d84-goog

