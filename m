Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAAD2C5679
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389895AbgKZNwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:52:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:43626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbgKZNwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:52:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D187AD20;
        Thu, 26 Nov 2020 13:52:33 +0000 (UTC)
Subject: Re: [PATCH 7/7] mm,hwpoison: Remove drain_all_pages from shake_page
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-8-osalvador@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4033449e-eb86-e306-81af-d4c6dc823bdf@suse.cz>
Date:   Thu, 26 Nov 2020 14:52:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119105716.5962-8-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 11:57 AM, Oscar Salvador wrote:
> get_hwpoison_page already drains pcplists, previously disabling
> them when trying to grab a refcount.
> We do not need shake_page to take care of it anymore.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/memory-failure.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 512613e9a1bd..ad976e1c3178 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -263,8 +263,8 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
>   }
>   
>   /*
> - * When a unknown page type is encountered drain as many buffers as possible
> - * in the hope to turn the page into a LRU or free page, which we can handle.
> + * Unknown page type encountered. Try to check whether it can turn PageLRU by
> + * lru_add_drain_all, or a free page by reclaiming slabs when possible.
>    */
>   void shake_page(struct page *p, int access)
>   {
> @@ -275,9 +275,6 @@ void shake_page(struct page *p, int access)
>   		lru_add_drain_all();
>   		if (PageLRU(p))
>   			return;
> -		drain_all_pages(page_zone(p));
> -		if (PageLRU(p) || is_free_buddy_page(p))
> -			return;

I wonder if page in the lru pagevec can in fact become free after draining the 
lru - in that case we could keep the is_free_buddy_page() check.

>   	}
>   
>   	/*
> 

