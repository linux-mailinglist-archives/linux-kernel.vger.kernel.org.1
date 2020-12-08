Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231CA2D258B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgLHIPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:15:46 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:35730 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727135AbgLHIPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:15:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UHy7DrU_1607415299;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UHy7DrU_1607415299)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Dec 2020 16:14:59 +0800
Subject: Re: [PATCH 03/11] mm: don't pass "enum lru_list" to lru list addition
 functions
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
 <20201207220949.830352-4-yuzhao@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <444fa3b9-2263-4f0a-3ff3-beaf2472f23f@linux.alibaba.com>
Date:   Tue, 8 Dec 2020 16:14:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201207220949.830352-4-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/12/8 上午6:09, Yu Zhao 写道:
>  
>  		__count_vm_events(PGACTIVATE, nr_pages);
> @@ -543,14 +542,14 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
>  		 * It can make readahead confusing.  But race window
>  		 * is _really_ small and  it's non-critical problem.
>  		 */
> -		add_page_to_lru_list(page, lruvec, lru);
> +		add_page_to_lru_list(page, lruvec);
>  		SetPageReclaim(page);
>  	} else {
>  		/*
>  		 * The page's writeback ends up during pagevec
>  		 * We moves tha page into tail of inactive.
>  		 */
> -		add_page_to_lru_list_tail(page, lruvec, lru);
> +		add_page_to_lru_list_tail(page, lruvec);
>  		__count_vm_events(PGROTATED, nr_pages);
>  	}
>  
> @@ -570,7 +569,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
>  		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
>  		ClearPageActive(page);
>  		ClearPageReferenced(page);
> -		add_page_to_lru_list(page, lruvec, lru);
> +		add_page_to_lru_list(page, lruvec);
>  
>  		__count_vm_events(PGDEACTIVATE, nr_pages);
>  		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,

seems leave the lru = xxx out, could save 2 function calling in lru_deactivate_file_fn(), is this right?
