Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68492CD134
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbgLCIXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:23:18 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5307 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388299AbgLCIXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:23:18 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc8a04d0001>; Thu, 03 Dec 2020 00:22:37 -0800
Received: from [10.2.53.244] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 08:22:28 +0000
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <david@redhat.com>, <osalvador@suse.de>,
        <dan.j.williams@intel.com>, <sashal@kernel.org>,
        <tyhicks@linux.microsoft.com>, <iamjoonsoo.kim@lge.com>,
        <mike.kravetz@oracle.com>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <jgg@ziepe.ca>, <peterz@infradead.org>,
        <mgorman@suse.de>, <willy@infradead.org>, <rientjes@google.com>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b44584e0-bee8-3f3b-f9e7-c1cbd981296e@nvidia.com>
Date:   Thu, 3 Dec 2020 00:22:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201202052330.474592-7-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606983757; bh=h6m0/TACyhVMYRHvzofk9LBZe+WjcX4xP/tCct9mk0I=;
        h=Subject:To:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=BKbVodsieUTArR1wIi/sxEyh3UryMc7a5YGKj/3dhaS/zHwufv7C37LYUZloA2EmN
         Z1wXd+pCQMm9JywrbgNJcUw8Ua1s/wXDpHM5I76IMdGJ0irYSksQtTvaZW8ORk3Py3
         /jPX/D1UZUJuPn1ajN1KeJ8JO2Ra/2rMVIRAcZ/1yIO68QBUHA7xgZk3pKyWDbieyO
         jsZ3souG/o/72dLQ9GhlZqaG+ZkKvyaM1FVviZBPegKvbJ1wwa9lJtWi0rBjBqIyF2
         2tJwuyTWL6Q6tkppl/q+H/i5JO5LSNK5D/9FLO0Bomi868jVvRla6aD3KVkm2xxoL1
         wM8TnV/MteYPw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 9:23 PM, Pavel Tatashin wrote:
> We do not allocate pin pages in ZONE_MOVABLE, but if pages were already
> allocated before pinning they need to migrated to a different zone.
> Currently, we migrate movable CMA pages only. Generalize the function
> that migrates CMA pages to migrate all movable pages.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>   include/linux/migrate.h        |  1 +
>   include/trace/events/migrate.h |  3 +-
>   mm/gup.c                       | 56 +++++++++++++---------------------
>   3 files changed, 24 insertions(+), 36 deletions(-)
> 

I like the cleanup so far, even at this point it's a relief to finally
see the nested ifdefs get removed.

One naming nit/idea below, but this looks fine as is, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 0f8d1583fa8e..00bab23d1ee5 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -27,6 +27,7 @@ enum migrate_reason {
>   	MR_MEMPOLICY_MBIND,
>   	MR_NUMA_MISPLACED,
>   	MR_CONTIG_RANGE,
> +	MR_LONGTERM_PIN,
>   	MR_TYPES
>   };
>   
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> index 4d434398d64d..363b54ce104c 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -20,7 +20,8 @@
>   	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
>   	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
>   	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
> -	EMe(MR_CONTIG_RANGE,	"contig_range")
> +	EM( MR_CONTIG_RANGE,	"contig_range")			\
> +	EMe(MR_LONGTERM_PIN,	"longterm_pin")
>   
>   /*
>    * First define the enums in the above macros to be exported to userspace
> diff --git a/mm/gup.c b/mm/gup.c
> index 724d8a65e1df..1d511f65f8a7 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1593,19 +1593,18 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>   }
>   #endif
>   
> -#ifdef CONFIG_CMA
> -static long check_and_migrate_cma_pages(struct mm_struct *mm,
> -					unsigned long start,
> -					unsigned long nr_pages,
> -					struct page **pages,
> -					struct vm_area_struct **vmas,
> -					unsigned int gup_flags)
> +static long check_and_migrate_movable_pages(struct mm_struct *mm,
> +					    unsigned long start,
> +					    unsigned long nr_pages,
> +					    struct page **pages,
> +					    struct vm_area_struct **vmas,
> +					    unsigned int gup_flags)
>   {
>   	unsigned long i;
>   	unsigned long step;
>   	bool drain_allow = true;
>   	bool migrate_allow = true;
> -	LIST_HEAD(cma_page_list);
> +	LIST_HEAD(page_list);


Maybe naming it "movable_page_list", would be a nice touch.


thanks,
-- 
John Hubbard
NVIDIA

>   	long ret = nr_pages;
>   	struct migration_target_control mtc = {
>   		.nid = NUMA_NO_NODE,
> @@ -1623,13 +1622,12 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>   		 */
>   		step = compound_nr(head) - (pages[i] - head);
>   		/*
> -		 * If we get a page from the CMA zone, since we are going to
> -		 * be pinning these entries, we might as well move them out
> -		 * of the CMA zone if possible.
> +		 * If we get a movable page, since we are going to be pinning
> +		 * these entries, try to move them out if possible.
>   		 */
> -		if (is_migrate_cma_page(head)) {
> +		if (is_migrate_movable(get_pageblock_migratetype(head))) {
>   			if (PageHuge(head))
> -				isolate_huge_page(head, &cma_page_list);
> +				isolate_huge_page(head, &page_list);
>   			else {
>   				if (!PageLRU(head) && drain_allow) {
>   					lru_add_drain_all();
> @@ -1637,7 +1635,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>   				}
>   
>   				if (!isolate_lru_page(head)) {
> -					list_add_tail(&head->lru, &cma_page_list);
> +					list_add_tail(&head->lru, &page_list);
>   					mod_node_page_state(page_pgdat(head),
>   							    NR_ISOLATED_ANON +
>   							    page_is_file_lru(head),
> @@ -1649,7 +1647,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>   		i += step;
>   	}
>   
> -	if (!list_empty(&cma_page_list)) {
> +	if (!list_empty(&page_list)) {
>   		/*
>   		 * drop the above get_user_pages reference.
>   		 */
> @@ -1659,7 +1657,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>   			for (i = 0; i < nr_pages; i++)
>   				put_page(pages[i]);
>   
> -		if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
> +		if (migrate_pages(&page_list, alloc_migration_target, NULL,
>   			(unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
>   			/*
>   			 * some of the pages failed migration. Do get_user_pages
> @@ -1667,17 +1665,16 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>   			 */
>   			migrate_allow = false;
>   
> -			if (!list_empty(&cma_page_list))
> -				putback_movable_pages(&cma_page_list);
> +			if (!list_empty(&page_list))
> +				putback_movable_pages(&page_list);
>   		}
>   		/*
>   		 * We did migrate all the pages, Try to get the page references
> -		 * again migrating any new CMA pages which we failed to isolate
> -		 * earlier.
> +		 * again migrating any pages which we failed to isolate earlier.
>   		 */
>   		ret = __get_user_pages_locked(mm, start, nr_pages,
> -						   pages, vmas, NULL,
> -						   gup_flags);
> +					      pages, vmas, NULL,
> +					      gup_flags);
>   
>   		if ((ret > 0) && migrate_allow) {
>   			nr_pages = ret;
> @@ -1688,17 +1685,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>   
>   	return ret;
>   }
> -#else
> -static long check_and_migrate_cma_pages(struct mm_struct *mm,
> -					unsigned long start,
> -					unsigned long nr_pages,
> -					struct page **pages,
> -					struct vm_area_struct **vmas,
> -					unsigned int gup_flags)
> -{
> -	return nr_pages;
> -}
> -#endif /* CONFIG_CMA */
>   
>   /*
>    * __gup_longterm_locked() is a wrapper for __get_user_pages_locked which
> @@ -1746,8 +1732,8 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>   			goto out;
>   		}
>   
> -		rc = check_and_migrate_cma_pages(mm, start, rc, pages,
> -						 vmas_tmp, gup_flags);
> +		rc = check_and_migrate_movable_pages(mm, start, rc, pages,
> +						     vmas_tmp, gup_flags);
>   out:
>   		memalloc_nomovable_restore(flags);
>   	}
> 

