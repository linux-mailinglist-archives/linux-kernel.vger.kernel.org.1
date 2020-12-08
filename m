Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4CF2D218A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 04:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgLHDmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 22:42:06 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:64042 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgLHDmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 22:42:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UHwrZ-V_1607398881;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UHwrZ-V_1607398881)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Dec 2020 11:41:22 +0800
Subject: Re: [PATCH 01/11] mm: use add_page_to_lru_list()
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
 <20201207220949.830352-2-yuzhao@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <cf290655-5353-1fd3-e57f-452b7662b458@linux.alibaba.com>
Date:   Tue, 8 Dec 2020 11:41:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201207220949.830352-2-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

在 2020/12/8 上午6:09, Yu Zhao 写道:
> There is add_page_to_lru_list(), and move_pages_to_lru() should reuse
> it, not duplicate it.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  mm/vmscan.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 469016222cdb..a174594e40f8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1821,7 +1821,6 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  	int nr_pages, nr_moved = 0;
>  	LIST_HEAD(pages_to_free);
>  	struct page *page;
> -	enum lru_list lru;
>  
>  	while (!list_empty(list)) {
>  		page = lru_to_page(list);
> @@ -1866,11 +1865,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		 * inhibits memcg migration).
>  		 */
>  		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
> -		lru = page_lru(page);
> +		add_page_to_lru_list(page, lruvec, page_lru(page));
>  		nr_pages = thp_nr_pages(page);
> -
> -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> -		list_add(&page->lru, &lruvec->lists[lru]);
>  		nr_moved += nr_pages;
>  		if (PageActive(page))
>  			workingset_age_nonresident(lruvec, nr_pages);
> 
