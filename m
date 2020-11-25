Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941C52C477A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbgKYSUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:20:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:38138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729688AbgKYSUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:20:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F25CAAC1F;
        Wed, 25 Nov 2020 18:20:35 +0000 (UTC)
Subject: Re: [PATCH 3/7] mm,madvise: call soft_offline_page() without
 MF_COUNT_INCREASED
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-4-osalvador@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2aa4bf71-443b-9b9b-b761-12761263dfec@suse.cz>
Date:   Wed, 25 Nov 2020 19:20:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119105716.5962-4-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 11:57 AM, Oscar Salvador wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> The call to get_user_pages_fast is only to get the pointer to a struct
> page of a given address, pinning it is memory-poisoning handler's job,
> so drop the refcount grabbed by get_user_pages_fast().
> 
> Note that the target page is still pinned after this put_page() because
> the current process should have refcount from mapping.

Well, but can't it go away due to reclaim, migration or whatever?

> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/madvise.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index c6b5524add58..7a0f64b93635 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -900,20 +900,23 @@ static int madvise_inject_error(int behavior,
>   		 */
>   		size = page_size(compound_head(page));
>   
> +		/*
> +		 * The get_user_pages_fast() is just to get the pfn of the
> +		 * given address, and the refcount has nothing to do with
> +		 * what we try to test, so it should be released immediately.
> +		 * This is racy but it's intended because the real hardware
> +		 * errors could happen at any moment and memory error handlers
> +		 * must properly handle the race.

Sure they have to. We might just be unexpectedly messing with other process' 
memory. Or does anything else prevent that?

> +		 */
> +		put_page(page);
> +
>   		if (behavior == MADV_SOFT_OFFLINE) {
>   			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
>   				 pfn, start);
> -			ret = soft_offline_page(pfn, MF_COUNT_INCREASED);
> +			ret = soft_offline_page(pfn, 0);
>   		} else {
>   			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
>   				 pfn, start);
> -			/*
> -			 * Drop the page reference taken by get_user_pages_fast(). In
> -			 * the absence of MF_COUNT_INCREASED the memory_failure()
> -			 * routine is responsible for pinning the page to prevent it
> -			 * from being released back to the page allocator.
> -			 */
> -			put_page(page);
>   			ret = memory_failure(pfn, 0);
>   		}
>   
> 

