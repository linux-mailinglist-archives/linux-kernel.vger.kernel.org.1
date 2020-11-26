Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7EB2C4CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 02:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbgKZBe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 20:34:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730045AbgKZBe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 20:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606354465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3vsGtrbKChhjEDghyXYrOSAStA3F1s3kUVkgs5kgY6I=;
        b=W5SjtYzMUFDXKYWxoNsO69lSZeXjHvOGbnChbplDfhqQ3wl0Qf/ets98qxajzP+ybtg6e0
        Fy2ddOS2SGWaReSm8qmLICEOpCQ0uIYy80xo57UGBSKr5VnqIzo0ONxubJGxXDCaMGDIYV
        5hlx0GA3HXiMUz8CW847UeFUwr6tMFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-5deCA3koODi5-KQ1NU43Sw-1; Wed, 25 Nov 2020 20:34:21 -0500
X-MC-Unique: 5deCA3koODi5-KQ1NU43Sw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1353100C602;
        Thu, 26 Nov 2020 01:34:18 +0000 (UTC)
Received: from llong.remote.csb (ovpn-113-107.rdu2.redhat.com [10.10.113.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 573B560636;
        Thu, 26 Nov 2020 01:34:16 +0000 (UTC)
Subject: Re: [LKP] Re: [mm/memcg] bd0b230fe1: will-it-scale.per_process_ops
 -22.7% regression
To:     Feng Tang <feng.tang@intel.com>, Michal Hocko <mhocko@suse.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@intel.com, ying.huang@intel.com,
        andi.kleen@intel.com
References: <20201102091543.GM31092@shao2-debian>
 <20201102092754.GD22613@dhcp22.suse.cz>
 <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com>
 <20201102100247.GF22613@dhcp22.suse.cz>
 <bd87e8bd-c918-3f41-0cc5-e2927d91625f@linux.intel.com>
 <20201104081546.GB10052@dhcp22.suse.cz>
 <20201112122844.GA11000@shbuild999.sh.intel.com>
 <20201112141654.GC12240@dhcp22.suse.cz>
 <20201113073436.GA113119@shbuild999.sh.intel.com>
 <20201120114424.GA103521@shbuild999.sh.intel.com>
 <20201125062445.GA51005@shbuild999.sh.intel.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <cd827aad-a30d-854e-2c55-782be8effec3@redhat.com>
Date:   Wed, 25 Nov 2020 20:34:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201125062445.GA51005@shbuild999.sh.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/20 1:24 AM, Feng Tang wrote:
> On Fri, Nov 20, 2020 at 07:44:24PM +0800, Feng Tang wrote:
>> On Fri, Nov 13, 2020 at 03:34:36PM +0800, Feng Tang wrote:
>>>> I would rather focus on a more effective mem_cgroup layout. It is very
>>>> likely that we are just stumbling over two counters here.
>>>>
>>>> Could you try to add cache alignment of counters after memory and see
>>>> which one makes the difference? I do not expect memsw to be the one
>>>> because that one is used together with the main counter. But who knows
>>>> maybe the way it crosses the cache line has the exact effect. Hard to
>>>> tell without other numbers.
>>> I added some alignments change around the 'memsw', but neither of them can
>>> restore the -22.7%. Following are some log showing how the alignments
>>> are:
>>>
>>> tl: memcg=0x7cd1000 memory=0x7cd10d0 memsw=0x7cd1140 kmem=0x7cd11b0 tcpmem=0x7cd1220
>>> t2: memcg=0x7cd0000 memory=0x7cd00d0 memsw=0x7cd0140 kmem=0x7cd01c0 tcpmem=0x7cd0230
>>>
>>> So both of the 'memsw' are aligned, but t2's 'kmem' is aligned while
>>> t1's is not.
>>>
>>> I will check more on the perf data about detailed hotspots.
>> Some more check updates about it:
>>
>> Waiman's patch is effectively removing one 'struct page_counter' between
>> 'memory' and "memsw'. And the mem_cgroup is:
>>
>> struct mem_cgroup {
>>
>> 	...
>>
>> 	struct page_counter memory;		/* Both v1 & v2 */
>>
>> 	union {
>> 		struct page_counter swap;	/* v2 only */
>> 		struct page_counter memsw;	/* v1 only */
>> 	};
>>
>> 	/* Legacy consumer-oriented counters */
>> 	struct page_counter kmem;		/* v1 only */
>> 	struct page_counter tcpmem;		/* v1 only */
>>
>> 	...
>> 	...
>>
>> 	MEMCG_PADDING(_pad1_);
>>
>> 	atomic_t		moving_account;
>> 	struct task_struct	*move_lock_task;
>> 	
>> 	...
>> };
>>
>>
>> I do experiments by inserting a 'page_counter' between 'memory'
>> and the 'MEMCG_PADDING(_pad1_)', no matter where I put it, the
>> benchmark result can be recovered from 145K to 185K, which is
>> really confusing, as adding a 'page_counter' right before the
>> '_pad1_' doesn't change cache alignment of any members.
> I think we finally found the trick :), further debugging shows it
> is not related to the alignment inside one cacheline, but the
> adjacency of 2 adjacent cacheliens (2N and 2N+1, one pair of 128 bytes).
>
> For structure mem_cgroup, member 'vmstats_local', 'vmstats_percpu'
> sit in one cacheline, while 'vmstats[]' sits in the next cacheline,
> and when 'adjacent cacheline prefetch" is enabled, if these 2 lines
> sit in one pair (128 btyes), say 2N and 2N+1, then there seems to
> be some kind of false sharing, and if they sit in 2 pairs, say
> 2N-1 and 2N then it's fine.
>
> And with the following patch to relayout these members, the regression
> is restored and event better. while reducing 64 bytes of sizeof
> 'struct mem_cgroup'
>
> 	parent_commit	Waiman's_commit		+relayout patch
>
> result	187K		145K			200K
>
> Also, if we disable the hw prefetch feature, the Waiman's commit
> and its parent commit will have no performance difference.
>
> Thanks,
> Feng

Finally, misery solved? Well done.

Your patch looks good. It reduces structure size and improves performance.

Acked-by: Waiman Long <longman@redhat.com>

>  From 2e63af34fa4853b2dd9669867c37a3cf07f7a505 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Wed, 25 Nov 2020 13:22:21 +0800
> Subject: [PATCH] mm: memcg: relayout structure mem_cgroup to avoid cache
>   interfereing
>
> 0day reported one -22.7% regression for will-it-scale page_fault2
> case [1] on a 4 sockets 144 CPU platform, and bisected to it to be
> caused by Waiman's optimization (commit bd0b230fe1) of saving one
> 'struct page_counter' space for 'struct mem_cgroup'.
>
> Initially we thought it was due to the cache alignment change introduced
> by the patch, but further debug shows that it is due to some hot data
> members ('vmstats_local', 'vmstats_percpu', 'vmstats') sit in 2 adjacent
> cacheline (2N and 2N+1 cacheline), and when adjacent cache line prefetch
> is enabled, it triggers an "extended level" of cache false sharing for
> 2 adjacent cache lines.
>
> So exchange the 2 member blocks, while keeping mostly the original
> cache alignment, which can restore and even enhance the performance,
> and save 64 bytes of space for 'struct mem_cgroup' (from 2880 to 2816,
> with 0day's default RHEL-8.3 kernel config)
>
> [1]. https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
>
> Fixes: bd0b230fe145 ("mm/memcg: unify swap and memsw page counters")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>   include/linux/memcontrol.h | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e391e3c..a2d50b0 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -282,20 +282,6 @@ struct mem_cgroup {
>   
>   	MEMCG_PADDING(_pad1_);
>   
> -	/*
> -	 * set > 0 if pages under this cgroup are moving to other cgroup.
> -	 */
> -	atomic_t		moving_account;
> -	struct task_struct	*move_lock_task;
> -
> -	/* Legacy local VM stats and events */
> -	struct memcg_vmstats_percpu __percpu *vmstats_local;
> -
> -	/* Subtree VM stats and events (batched updates) */
> -	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
> -
> -	MEMCG_PADDING(_pad2_);
> -
>   	atomic_long_t		vmstats[MEMCG_NR_STAT];
>   	atomic_long_t		vmevents[NR_VM_EVENT_ITEMS];
>   
> @@ -317,6 +303,20 @@ struct mem_cgroup {
>   	struct list_head objcg_list; /* list of inherited objcgs */
>   #endif
>   
> +	MEMCG_PADDING(_pad2_);
> +
> +	/*
> +	 * set > 0 if pages under this cgroup are moving to other cgroup.
> +	 */
> +	atomic_t		moving_account;
> +	struct task_struct	*move_lock_task;
> +
> +	/* Legacy local VM stats and events */
> +	struct memcg_vmstats_percpu __percpu *vmstats_local;
> +
> +	/* Subtree VM stats and events (batched updates) */
> +	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
> +
>   #ifdef CONFIG_CGROUP_WRITEBACK
>   	struct list_head cgwb_list;
>   	struct wb_domain cgwb_domain;


