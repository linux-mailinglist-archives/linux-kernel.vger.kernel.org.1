Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B3D273B79
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgIVHLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:11:31 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15818 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbgIVHLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:11:30 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f69a3740001>; Tue, 22 Sep 2020 00:10:44 -0700
Received: from [10.2.52.174] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 07:11:30 +0000
Subject: Re: [PATCH 3/5] mm: Rework return value for copy_one_pte()
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Jann Horn" <jannh@google.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-4-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6eb46d4d-8267-4e10-0157-e2ce2be2850d@nvidia.com>
Date:   Tue, 22 Sep 2020 00:11:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921211744.24758-4-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600758644; bh=8J71hRtGdhJ0Jg8YwjuNNAFNeiVmfi98qQdLTq8Xlvc=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=fd9UV+iK4layuQDHkfCQ0DfdIT0PjMADSSkh0YkG8MJXBIPzOodb/mgiW9vQGHQBi
         rQ/2VftVeE/Dp6XoRpkgndJKAXocZAZb44nTXMVdcjO1mSlXbXLw+Vu+kgB12PlaJP
         1GMip8RM86OZQUiZ2QUw92xRf929bxNx1UYc1eobvtyt7AitupF54FwjJQ1D4YuHt6
         WyZs6WglqEciB/S8MXi2BCH8Vs9cRrpsdRtzvyY917NrN2qs2HBEGBdL4mDkTgt64u
         mYzm6asnaANurCWu77r/dSbYG/xuyPbDuBpT+5TJzE2vlrlsDle1VMRp+Da5xu/dvH
         z+6/jh35EVZgQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/20 2:17 PM, Peter Xu wrote:
> There's one special path for copy_one_pte() with swap entries, in which
> add_swap_count_continuation(GFP_ATOMIC) might fail.  In that case we'll return

I might be looking at the wrong place, but the existing code seems to call
add_swap_count_continuation(GFP_KERNEL), not with GFP_ATOMIC?

> the swp_entry_t so that the caller will release the locks and redo the same
> thing with GFP_KERNEL.
> 
> It's confusing when copy_one_pte() must return a swp_entry_t (even if all the
> ptes are non-swap entries).  More importantly, we face other requirement to
> extend this "we need to do something else, but without the locks held" case.
> 
> Rework the return value into something easier to understand, as defined in enum
> copy_mm_ret.  We'll pass the swp_entry_t back using the newly introduced union

I like the documentation here, but it doesn't match what you did in the patch.
Actually, the documentation had the right idea (enum, rather than #define, for
COPY_MM_* items). Below...

> copy_mm_data parameter.
> 
> Another trivial change is to move the reset of the "progress" counter into the
> retry path, so that we'll reset it for other reasons too.
> 
> This should prepare us with adding new return codes, very soon.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/memory.c | 42 +++++++++++++++++++++++++++++-------------
>   1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 7525147908c4..1530bb1070f4 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -689,16 +689,24 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>   }
>   #endif
>   
> +#define  COPY_MM_DONE               0
> +#define  COPY_MM_SWAP_CONT          1

Those should be enums, so as to get a little type safety and other goodness from
using non-macro items.

...
> @@ -866,13 +877,18 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>   	pte_unmap_unlock(orig_dst_pte, dst_ptl);
>   	cond_resched();
>   
> -	if (entry.val) {
> -		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0)
> +	switch (copy_ret) {
> +	case COPY_MM_SWAP_CONT:
> +		if (add_swap_count_continuation(data.entry, GFP_KERNEL) < 0)
>   			return -ENOMEM;
> -		progress = 0;

Yes. Definitely a little cleaner to reset this above, instead of here.

> +		break;
> +	default:
> +		break;

I assume this no-op noise is to placate the compiler and/or static checkers. :)

I'm unable to find any actual problems with the diffs, aside from the nit about
using an enum.

thanks,
-- 
John Hubbard
NVIDIA
