Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4966A25BD45
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 10:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgICI2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 04:28:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:40582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgICI2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:28:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 32A4BAD1A;
        Thu,  3 Sep 2020 08:28:34 +0000 (UTC)
Date:   Thu, 3 Sep 2020 10:28:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: use
 add_page_to_lru_list()/page_lru()/page_off_lru()
Message-ID: <20200903082832.GR4617@dhcp22.suse.cz>
References: <20200831175042.3527153-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831175042.3527153-1-yuzhao@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 31-08-20 11:50:41, Yu Zhao wrote:
[...]
> @@ -1860,16 +1859,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  
>  		SetPageLRU(page);
> -		lru = page_lru(page);
> -
> -		nr_pages = thp_nr_pages(page);
> -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> -		list_move(&page->lru, &lruvec->lists[lru]);
> +		add_page_to_lru_list(page, lruvec, page_lru(page));
>  
>  		if (put_page_testzero(page)) {
>  			__ClearPageLRU(page);
> -			__ClearPageActive(page);

This should go into its own patch. The rest is a mechanical and clear.
This one needs some head scratching. E.g. Is it correct for all compound
pages. I believe it should be but few words on why would be better.

> -			del_page_from_lru_list(page, lruvec, lru);
> +			del_page_from_lru_list(page, lruvec, page_off_lru(page));
>  
>  			if (unlikely(PageCompound(page))) {
>  				spin_unlock_irq(&pgdat->lru_lock);
> @@ -1878,6 +1872,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  			} else
>  				list_add(&page->lru, &pages_to_free);
>  		} else {
> +			nr_pages = thp_nr_pages(page);
>  			nr_moved += nr_pages;
>  			if (PageActive(page))
>  				workingset_age_nonresident(lruvec, nr_pages);
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 

-- 
Michal Hocko
SUSE Labs
