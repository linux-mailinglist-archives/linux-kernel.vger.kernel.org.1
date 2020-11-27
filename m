Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1754E2C60B5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgK0IGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgK0IGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:06:12 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE707208CA;
        Fri, 27 Nov 2020 08:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606464371;
        bh=GGTofRdm/Erp0GIGGwK5gTXImKW1NVGj6YOURY+3mus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FgwgKCuRDdAxuxKqZUo0IDf1Tn5z3zrUktz9jKaP797N7JINdQ9nWKhDwrn9N6SbU
         nXgqukBK33w7drRoemVv5lqjebhhkEQyzHWqsDepkbXRYmfT6efKdYoEkQ1KbTaiYT
         jsaqMKYtNkgJ/GHPOUeAuVs0wMMEGGv+CJ10VUDs=
Date:   Fri, 27 Nov 2020 10:06:05 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Haitao Shi <shihaitao1@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangle6@huawei.com
Subject: Re: [PATCH] mm: fix some spelling mistakes in comments
Message-ID: <20201127080605.GA557259@kernel.org>
References: <20201127011747.86005-1-shihaitao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127011747.86005-1-shihaitao1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 09:17:47AM +0800, Haitao Shi wrote:
> Fix some spelling mistakes in comments:
> 	udpate ==> update
> 	succesful ==> successful
> 	exmaple ==> example
> 	unneccessary ==> unnecessary
> 	stoping ==> stopping
> 	uknown ==> unknown
> 
> Signed-off-by: Haitao Shi <shihaitao1@huawei.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/filemap.c     | 2 +-
>  mm/huge_memory.c | 2 +-
>  mm/khugepaged.c  | 2 +-
>  mm/memblock.c    | 2 +-
>  mm/migrate.c     | 2 +-
>  mm/page_ext.c    | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 3ebbe64..8826c48 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1359,7 +1359,7 @@ static int __wait_on_page_locked_async(struct page *page,
>  	else
>  		ret = PageLocked(page);
>  	/*
> -	 * If we were succesful now, we know we're still on the
> +	 * If we were successful now, we know we're still on the
>  	 * waitqueue as we're still under the lock. This means it's
>  	 * safe to remove and return success, we know the callback
>  	 * isn't going to trigger.
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ec2bb93..0fea0c2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2356,7 +2356,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
>  	 * Clone page flags before unfreezing refcount.
>  	 *
>  	 * After successful get_page_unless_zero() might follow flags change,
> -	 * for exmaple lock_page() which set PG_waiters.
> +	 * for example lock_page() which set PG_waiters.
>  	 */
>  	page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
>  	page_tail->flags |= (head->flags &
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4e3dff1..d6f7ede 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1273,7 +1273,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>  			 * PTEs are armed with uffd write protection.
>  			 * Here we can also mark the new huge pmd as
>  			 * write protected if any of the small ones is
> -			 * marked but that could bring uknown
> +			 * marked but that could bring unknown
>  			 * userfault messages that falls outside of
>  			 * the registered range.  So, just be simple.
>  			 */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index b68ee86..086662a 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -871,7 +871,7 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
>   * @base: base address of the region
>   * @size: size of the region
>   * @set: set or clear the flag
> - * @flag: the flag to udpate
> + * @flag: the flag to update
>   *
>   * This function isolates region [@base, @base + @size), and sets/clears flag
>   *
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5795cb8..8a3580c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2548,7 +2548,7 @@ static bool migrate_vma_check_page(struct page *page)
>  		 * will bump the page reference count. Sadly there is no way to
>  		 * differentiate a regular pin from migration wait. Hence to
>  		 * avoid 2 racing thread trying to migrate back to CPU to enter
> -		 * infinite loop (one stoping migration because the other is
> +		 * infinite loop (one stopping migration because the other is
>  		 * waiting on pte migration entry). We always return true here.
>  		 *
>  		 * FIXME proper solution is to rework migration_entry_wait() so
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index a3616f7..cf931eb 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -34,7 +34,7 @@
>   *
>   * The need callback is used to decide whether extended memory allocation is
>   * needed or not. Sometimes users want to deactivate some features in this
> - * boot and extra memory would be unneccessary. In this case, to avoid
> + * boot and extra memory would be unnecessary. In this case, to avoid
>   * allocating huge chunk of memory, each clients represent their need of
>   * extra memory through the need callback. If one of the need callbacks
>   * returns true, it means that someone needs extra memory so that
> -- 
> 2.10.1
> 

-- 
Sincerely yours,
Mike.
