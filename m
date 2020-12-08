Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735D82D272E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgLHJIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:08:43 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:19840 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728587AbgLHJIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:08:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UHyFft1_1607418468;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UHyFft1_1607418468)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Dec 2020 17:07:49 +0800
Subject: Re: [PATCH 09/11] mm: fold __update_lru_size() into its sole caller
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
 <20201207220949.830352-10-yuzhao@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <a5b583d4-1c1f-5b86-33f5-eaa0b130b17c@linux.alibaba.com>
Date:   Tue, 8 Dec 2020 17:07:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201207220949.830352-10-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

在 2020/12/8 上午6:09, Yu Zhao 写道:
> All other references to the function were removed after
> commit a892cb6b977f ("mm/vmscan.c: use update_lru_size() in update_lru_sizes()")
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/mm_inline.h | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 7183c7a03f09..355ea1ee32bd 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -24,7 +24,7 @@ static inline int page_is_file_lru(struct page *page)
>  	return !PageSwapBacked(page);
>  }
>  
> -static __always_inline void __update_lru_size(struct lruvec *lruvec,
> +static __always_inline void update_lru_size(struct lruvec *lruvec,
>  				enum lru_list lru, enum zone_type zid,
>  				int nr_pages)
>  {
> @@ -33,13 +33,6 @@ static __always_inline void __update_lru_size(struct lruvec *lruvec,
>  	__mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
>  	__mod_zone_page_state(&pgdat->node_zones[zid],
>  				NR_ZONE_LRU_BASE + lru, nr_pages);
> -}
> -
> -static __always_inline void update_lru_size(struct lruvec *lruvec,
> -				enum lru_list lru, enum zone_type zid,
> -				int nr_pages)
> -{
> -	__update_lru_size(lruvec, lru, zid, nr_pages);
>  #ifdef CONFIG_MEMCG
>  	mem_cgroup_update_lru_size(lruvec, lru, zid, nr_pages);
>  #endif
> 
