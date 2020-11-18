Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0892B7455
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 03:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgKRCsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 21:48:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:30872 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgKRCsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 21:48:54 -0500
IronPort-SDR: WmtD+OyE2aYI4plakhgj7BpBsjHUSK0gE9fd1qTjlPS91+WReccZwmJqWpOEF/EoJJk5raPNe6
 Sks00Ioj8scw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150901809"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150901809"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 18:48:53 -0800
IronPort-SDR: BnhggAbXjQpNlzRVqvTPEYZqIFSboQRkXAQiPmukInDtEPafAE+f2psumAZy9h5ulGY0vsZgDY
 wxXtoUvkcnyA==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544308278"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 18:48:49 -0800
Subject: Re: [LKP] Re: [mm] be5d0a74c6: will-it-scale.per_thread_ops -9.1%
 regression
To:     Johannes Weiner <hannes@cmpxchg.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Balbir Singh <bsingharora@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@intel.com
References: <20201115095543.GC32502@xsang-OptiPlex-9020>
 <20201116161936.GB924708@cmpxchg.org>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <8bd51faa-31ad-5608-6be3-352bc234ddf2@linux.intel.com>
Date:   Wed, 18 Nov 2020 10:48:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201116161936.GB924708@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2020 12:19 AM, Johannes Weiner wrote:
> On Sun, Nov 15, 2020 at 05:55:44PM +0800, kernel test robot wrote:
>>
>> Greeting,
>>
>> FYI, we noticed a -9.1% regression of will-it-scale.per_thread_ops due to commit:
>>
>>
>> commit: be5d0a74c62d8da43f9526a5b08cdd18e2bbc37a ("mm: memcontrol: switch to native NR_ANON_MAPPED counter")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>>
>> in testcase: will-it-scale
>> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
>> with following parameters:
>>
>> 	nr_task: 50%
>> 	mode: thread
>> 	test: page_fault2
>> 	cpufreq_governor: performance
>> 	ucode: 0x5002f01
> 
> I suspect it's the lock_page_memcg() in page_remove_rmap(). We already
> needed it for shared mappings, and this patch added it to private path
> as well, which this test exercises.
> 
> The slowpath for this lock is extremely cold - most of the time it's
> just an rcu_read_lock(). But we're still doing the function call.
> 
> Could you try if this patch helps, please?

I apply the patch to Linux mainline v5.10-rc4, Linux-next next-20201117, 
and "be5d0a74c6", they are all failed. What's your codebase for
the patch? I appreciate it if you can rebase the patch to "be5d0a74c6".
 From "be5d0a74c6" to v5.10-rc4 or next-20201117, there are a lot of 
commits, they will affect the test result. Thanks.

> 
>  From f6e8e56b369109d1362de2c27ea6601d5c411b2e Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 16 Nov 2020 10:48:06 -0500
> Subject: [PATCH] lockpagememcg
> 
> ---
>   include/linux/memcontrol.h | 61 ++++++++++++++++++++++++++--
>   mm/memcontrol.c            | 82 +++++++-------------------------------
>   2 files changed, 73 insertions(+), 70 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 20108e426f84..b4b73e375948 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -842,9 +842,64 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
>   extern bool cgroup_memory_noswap;
>   #endif
>   
> -struct mem_cgroup *lock_page_memcg(struct page *page);
> -void __unlock_page_memcg(struct mem_cgroup *memcg);
> -void unlock_page_memcg(struct page *page);
> +struct mem_cgroup *lock_page_memcg_slowpath(struct page *page,
> +					    struct mem_cgroup *memcg);
> +void unlock_page_memcg_slowpath(struct mem_cgroup *memcg);
> +
> +/**
> + * lock_page_memcg - lock a page and memcg binding
> + * @page: the page
> + *
> + * This function protects unlocked LRU pages from being moved to
> + * another cgroup.
> + *
> + * It ensures lifetime of the memcg -- the caller is responsible for
> + * the lifetime of the page; __unlock_page_memcg() is available when
> + * @page might get freed inside the locked section.
> + */
> +static inline struct mem_cgroup *lock_page_memcg(struct page *page)
> +{
> +	struct page *head = compound_head(page); /* rmap on tail pages */
> +	struct mem_cgroup *memcg;
> +
> +	/*
> +	 * The RCU lock is held throughout the transaction.  The fast
> +	 * path can get away without acquiring the memcg->move_lock
> +	 * because page moving starts with an RCU grace period.
> +	 *
> +	 * The RCU lock also protects the memcg from being freed when
> +	 * the page state that is going to change is the only thing
> +	 * preventing the page itself from being freed. E.g. writeback
> +	 * doesn't hold a page reference and relies on PG_writeback to
> +	 * keep off truncation, migration and so forth.
> +         */
> +	rcu_read_lock();
> +
> +	if (mem_cgroup_disabled())
> +		return NULL;
> +
> +	memcg = page_memcg(head);
> +	if (unlikely(!memcg))
> +		return NULL;
> +
> +	if (likely(!atomic_read(&memcg->moving_account)))
> +		return memcg;
> +
> +	return lock_page_memcg_slowpath(head, memcg);
> +}
> +
> +static inline void __unlock_page_memcg(struct mem_cgroup *memcg)
> +{
> +	if (unlikely(memcg && memcg->move_lock_task == current))
> +		unlock_page_memcg_slowpath(memcg);
> +
> +	rcu_read_unlock();
> +}
> +
> +static inline void unlock_page_memcg(struct page *page)
> +{
> +	__unlock_page_memcg(page_memcg(compound_head(page)));
> +}
>   
>   /*
>    * idx can be of type enum memcg_stat_item or node_stat_item.
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 69a2893a6455..9acc42388b86 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2084,49 +2084,19 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
>   	pr_cont(" are going to be killed due to memory.oom.group set\n");
>   }
>   
> -/**
> - * lock_page_memcg - lock a page and memcg binding
> - * @page: the page
> - *
> - * This function protects unlocked LRU pages from being moved to
> - * another cgroup.
> - *
> - * It ensures lifetime of the returned memcg. Caller is responsible
> - * for the lifetime of the page; __unlock_page_memcg() is available
> - * when @page might get freed inside the locked section.
> - */
> -struct mem_cgroup *lock_page_memcg(struct page *page)
> +struct mem_cgroup *lock_page_memcg_slowpath(struct page *page,
> +					    struct mem_cgroup *memcg)
>   {
> -	struct page *head = compound_head(page); /* rmap on tail pages */
> -	struct mem_cgroup *memcg;
>   	unsigned long flags;
> -
> -	/*
> -	 * The RCU lock is held throughout the transaction.  The fast
> -	 * path can get away without acquiring the memcg->move_lock
> -	 * because page moving starts with an RCU grace period.
> -	 *
> -	 * The RCU lock also protects the memcg from being freed when
> -	 * the page state that is going to change is the only thing
> -	 * preventing the page itself from being freed. E.g. writeback
> -	 * doesn't hold a page reference and relies on PG_writeback to
> -	 * keep off truncation, migration and so forth.
> -         */
> -	rcu_read_lock();
> -
> -	if (mem_cgroup_disabled())
> -		return NULL;
>   again:
> -	memcg = page_memcg(head);
> -	if (unlikely(!memcg))
> -		return NULL;
> -
> -	if (atomic_read(&memcg->moving_account) <= 0)
> -		return memcg;
> -
>   	spin_lock_irqsave(&memcg->move_lock, flags);
> -	if (memcg != page_memcg(head)) {
> +	if (memcg != page_memcg(page)) {
>   		spin_unlock_irqrestore(&memcg->move_lock, flags);
> +		memcg = page_memcg(page);
> +		if (unlikely(!memcg))
> +			return NULL;
> +		if (!atomic_read(&memcg->moving_account))
> +			return memcg;
>   		goto again;
>   	}
>   
> @@ -2140,39 +2110,17 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
>   
>   	return memcg;
>   }
> -EXPORT_SYMBOL(lock_page_memcg);
> -
> -/**
> - * __unlock_page_memcg - unlock and unpin a memcg
> - * @memcg: the memcg
> - *
> - * Unlock and unpin a memcg returned by lock_page_memcg().
> - */
> -void __unlock_page_memcg(struct mem_cgroup *memcg)
> -{
> -	if (memcg && memcg->move_lock_task == current) {
> -		unsigned long flags = memcg->move_lock_flags;
> -
> -		memcg->move_lock_task = NULL;
> -		memcg->move_lock_flags = 0;
> -
> -		spin_unlock_irqrestore(&memcg->move_lock, flags);
> -	}
> -
> -	rcu_read_unlock();
> -}
> +EXPORT_SYMBOL(lock_page_memcg_slowpath);
>   
> -/**
> - * unlock_page_memcg - unlock a page and memcg binding
> - * @page: the page
> - */
> -void unlock_page_memcg(struct page *page)
> +void unlock_page_memcg_slowpath(struct mem_cgroup *memcg)
>   {
> -	struct page *head = compound_head(page);
> +	unsigned long flags = memcg->move_lock_flags;
>   
> -	__unlock_page_memcg(page_memcg(head));
> +	memcg->move_lock_task = NULL;
> +	memcg->move_lock_flags = 0;
> +	spin_unlock_irqrestore(&memcg->move_lock, flags);
>   }
> -EXPORT_SYMBOL(unlock_page_memcg);
> +EXPORT_SYMBOL(unlock_page_memcg_slowpath);
>   
>   struct memcg_stock_pcp {
>   	struct mem_cgroup *cached; /* this never be root cgroup */
> 

-- 
Zhengjun Xing
