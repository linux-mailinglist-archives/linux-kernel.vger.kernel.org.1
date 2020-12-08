Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1D22D2689
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgLHIrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:47:51 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:34226 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728221AbgLHIrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:47:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UHyFcey_1607417219;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UHyFcey_1607417219)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Dec 2020 16:47:00 +0800
Subject: Re: [PATCH 04/11] mm: don't pass "enum lru_list" to
 trace_mm_lru_insertion()
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201207220949.830352-1-yuzhao@google.com>
 <20201207220949.830352-5-yuzhao@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <80656d92-c984-7f24-c2cf-ba6dde4ef90e@linux.alibaba.com>
Date:   Tue, 8 Dec 2020 16:46:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201207220949.830352-5-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

在 2020/12/8 上午6:09, Yu Zhao 写道:
> The parameter is redundant in the sense that it can be extracted
> from the "struct page" parameter by page_lru() correctly.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/trace/events/pagemap.h | 11 ++++-------
>  mm/swap.c                      |  5 +----
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
> index 8fd1babae761..e1735fe7c76a 100644
> --- a/include/trace/events/pagemap.h
> +++ b/include/trace/events/pagemap.h
> @@ -27,24 +27,21 @@
>  
>  TRACE_EVENT(mm_lru_insertion,
>  
> -	TP_PROTO(
> -		struct page *page,
> -		int lru
> -	),
> +	TP_PROTO(struct page *page),
>  
> -	TP_ARGS(page, lru),
> +	TP_ARGS(page),
>  
>  	TP_STRUCT__entry(
>  		__field(struct page *,	page	)
>  		__field(unsigned long,	pfn	)
> -		__field(int,		lru	)
> +		__field(enum lru_list,	lru	)
>  		__field(unsigned long,	flags	)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->page	= page;
>  		__entry->pfn	= page_to_pfn(page);
> -		__entry->lru	= lru;
> +		__entry->lru	= page_lru(page);
>  		__entry->flags	= trace_pagemap_flags(page);
>  	),
>  
> diff --git a/mm/swap.c b/mm/swap.c
> index 136acabbfab5..e053b4db108a 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -957,7 +957,6 @@ EXPORT_SYMBOL(__pagevec_release);
>  
>  static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
>  {
> -	enum lru_list lru;
>  	int was_unevictable = TestClearPageUnevictable(page);
>  	int nr_pages = thp_nr_pages(page);
>  
> @@ -993,11 +992,9 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
>  	smp_mb__after_atomic();
>  
>  	if (page_evictable(page)) {
> -		lru = page_lru(page);
>  		if (was_unevictable)
>  			__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
>  	} else {
> -		lru = LRU_UNEVICTABLE;
>  		ClearPageActive(page);
>  		SetPageUnevictable(page);
>  		if (!was_unevictable)
> @@ -1005,7 +1002,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
>  	}
>  
>  	add_page_to_lru_list(page, lruvec);
> -	trace_mm_lru_insertion(page, lru);
> +	trace_mm_lru_insertion(page);
>  }
>  
>  struct lruvecs {
> 
