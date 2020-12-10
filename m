Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827502D5724
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbgLJJ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:28:56 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:37324 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbgLJJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:28:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UI810Cr_1607592488;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UI810Cr_1607592488)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Dec 2020 17:28:08 +0800
Subject: Re: [PATCH 00/11] mm: lru related cleanups
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
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <54bdbe42-023a-4e32-9b94-173d0ad2dc16@linux.alibaba.com>
Date:   Thu, 10 Dec 2020 17:28:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201207220949.830352-1-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

btw, after this patchset, to do cacheline alignment on each of lru lists
are possible, so did you try that to see performance changes?

Thanks
Alex

在 2020/12/8 上午6:09, Yu Zhao 写道:
> The cleanups are intended to reduce the verbosity in lru list
> operations and make them less error-prone. A typical example
> would be how the patches change __activate_page():
> 
>  static void __activate_page(struct page *page, struct lruvec *lruvec)
>  {
>  	if (!PageActive(page) && !PageUnevictable(page)) {
> -		int lru = page_lru_base_type(page);
>  		int nr_pages = thp_nr_pages(page);
>  
> -		del_page_from_lru_list(page, lruvec, lru);
> +		del_page_from_lru_list(page, lruvec);
>  		SetPageActive(page);
> -		lru += LRU_ACTIVE;
> -		add_page_to_lru_list(page, lruvec, lru);
> +		add_page_to_lru_list(page, lruvec);
>  		trace_mm_lru_activate(page);
>  
> There are a few more places like __activate_page() and they are
> unnecessarily repetitive in terms of figuring out which list a page
> should be added onto or deleted from. And with the duplicated code
> removed, they are easier to read, IMO.
> 
> Patch 1 to 5 basically cover the above. Patch 6 and 7 make code more
> robust by improving bug reporting. Patch 8, 9 and 10 take care of
> some dangling helpers left in header files. Patch 11 isn't strictly a
> clean-up patch, but it seems still relevant to include it here.
> 
> Yu Zhao (11):
>   mm: use add_page_to_lru_list()
>   mm: shuffle lru list addition and deletion functions
>   mm: don't pass "enum lru_list" to lru list addition functions
>   mm: don't pass "enum lru_list" to trace_mm_lru_insertion()
>   mm: don't pass "enum lru_list" to del_page_from_lru_list()
>   mm: add __clear_page_lru_flags() to replace page_off_lru()
>   mm: VM_BUG_ON lru page flags
>   mm: fold page_lru_base_type() into its sole caller
>   mm: fold __update_lru_size() into its sole caller
>   mm: make lruvec_lru_size() static
>   mm: enlarge the "int nr_pages" parameter of update_lru_size()
> 
>  include/linux/memcontrol.h     |  10 +--
>  include/linux/mm_inline.h      | 115 ++++++++++++++-------------------
>  include/linux/mmzone.h         |   2 -
>  include/linux/vmstat.h         |   6 +-
>  include/trace/events/pagemap.h |  11 ++--
>  mm/compaction.c                |   2 +-
>  mm/memcontrol.c                |  10 +--
>  mm/mlock.c                     |   3 +-
>  mm/swap.c                      |  50 ++++++--------
>  mm/vmscan.c                    |  21 ++----
>  10 files changed, 91 insertions(+), 139 deletions(-)
> 
