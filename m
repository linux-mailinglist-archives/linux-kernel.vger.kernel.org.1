Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CF82D26DB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgLHJDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:03:43 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50281 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728644AbgLHJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:03:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UHydr.H_1607418174;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UHydr.H_1607418174)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Dec 2020 17:02:54 +0800
Subject: Re: [PATCH 08/11] mm: fold page_lru_base_type() into its sole caller
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
 <20201207220949.830352-9-yuzhao@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <fc821a7f-3a16-370e-5ea6-a6fcb8b40cf3@linux.alibaba.com>
Date:   Tue, 8 Dec 2020 17:02:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201207220949.830352-9-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

在 2020/12/8 上午6:09, Yu Zhao 写道:
> We've removed all other references to this function.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/mm_inline.h | 27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 6d907a4dd6ad..7183c7a03f09 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -45,21 +45,6 @@ static __always_inline void update_lru_size(struct lruvec *lruvec,
>  #endif
>  }
>  
> -/**
> - * page_lru_base_type - which LRU list type should a page be on?
> - * @page: the page to test
> - *
> - * Used for LRU list index arithmetic.
> - *
> - * Returns the base LRU type - file or anon - @page should be on.
> - */
> -static inline enum lru_list page_lru_base_type(struct page *page)
> -{
> -	if (page_is_file_lru(page))
> -		return LRU_INACTIVE_FILE;
> -	return LRU_INACTIVE_ANON;
> -}
> -
>  /**
>   * __clear_page_lru_flags - clear page lru flags before releasing a page
>   * @page: the page that was on lru and now has a zero reference
> @@ -92,12 +77,12 @@ static __always_inline enum lru_list page_lru(struct page *page)
>  	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
>  
>  	if (PageUnevictable(page))
> -		lru = LRU_UNEVICTABLE;
> -	else {
> -		lru = page_lru_base_type(page);
> -		if (PageActive(page))
> -			lru += LRU_ACTIVE;
> -	}
> +		return LRU_UNEVICTABLE;
> +
> +	lru = page_is_file_lru(page) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
> +	if (PageActive(page))
> +		lru += LRU_ACTIVE;
> +
>  	return lru;
>  }
>  
> 
