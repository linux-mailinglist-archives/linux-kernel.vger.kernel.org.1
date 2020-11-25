Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AED02C455E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgKYQg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:36:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:37646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730291AbgKYQg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:36:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 151EBACC6;
        Wed, 25 Nov 2020 16:36:26 +0000 (UTC)
Subject: Re: [PATCH v5 3/4] mm,hwpoison: take free pages off the buddy
 freelists for hugetlb
To:     Oscar Salvador <osalvador@suse.de>, n-horiguchi@ah.jp.nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201013144447.6706-1-osalvador@suse.de>
 <20201013144447.6706-4-osalvador@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <440ab1e0-1b69-f2e5-a07a-31861aa2b633@suse.cz>
Date:   Wed, 25 Nov 2020 17:36:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201013144447.6706-4-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/20 4:44 PM, Oscar Salvador wrote:
> Currently, free hugetlb get dissolved, but we also need to make sure
> to take the poisoned subpage off the buddy frelists, so no one stumbles
> upon it (see previous patch for more information).
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>   mm/memory-failure.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 181bed890c16..30aadeca97d2 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -809,7 +809,7 @@ static int me_swapcache_clean(struct page *p, unsigned long pfn)
>    */
>   static int me_huge_page(struct page *p, unsigned long pfn)
>   {
> -	int res = 0;
> +	int res;
>   	struct page *hpage = compound_head(p);
>   	struct address_space *mapping;
>   
> @@ -820,6 +820,7 @@ static int me_huge_page(struct page *p, unsigned long pfn)
>   	if (mapping) {
>   		res = truncate_error_page(hpage, pfn, mapping);
>   	} else {
> +		res = MF_FAILED;
>   		unlock_page(hpage);
>   		/*
>   		 * migration entry prevents later access on error anonymous
> @@ -828,8 +829,10 @@ static int me_huge_page(struct page *p, unsigned long pfn)
>   		 */
>   		if (PageAnon(hpage))
>   			put_page(hpage);
> -		dissolve_free_huge_page(p);
> -		res = MF_RECOVERED;
> +		if (!dissolve_free_huge_page(p) && take_page_off_buddy(p)) {
> +			page_ref_inc(p);
> +			res = MF_RECOVERED;
> +		}
>   		lock_page(hpage);
>   	}
>   
> @@ -1198,9 +1201,13 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>   			}
>   		}
>   		unlock_page(head);
> -		dissolve_free_huge_page(p);
> -		action_result(pfn, MF_MSG_FREE_HUGE, MF_DELAYED);
> -		return 0;
> +		res = MF_FAILED;
> +		if (!dissolve_free_huge_page(p) && take_page_off_buddy(p)) {
> +			page_ref_inc(p);
> +			res = MF_RECOVERED;
> +		}
> +		action_result(pfn, MF_MSG_FREE_HUGE, res);
> +		return res == MF_RECOVERED ? 0 : -EBUSY;
>   	}
>   
>   	lock_page(head);
> 

