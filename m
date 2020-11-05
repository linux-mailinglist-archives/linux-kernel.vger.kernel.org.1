Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBC52A83E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbgKEQrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:47:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:34292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbgKEQrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:47:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E077AB4C;
        Thu,  5 Nov 2020 16:47:07 +0000 (UTC)
To:     bharata@linux.ibm.com, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, cl@linux.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, guro@fb.com,
        shakeelb@google.com, hannes@cmpxchg.org, aneesh.kumar@linux.ibm.com
References: <20201028055030.GA362097@in.ibm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Higher slub memory consumption on 64K page-size systems?
Message-ID: <5150e942-516b-83c8-8e52-e0f294138a71@suse.cz>
Date:   Thu, 5 Nov 2020 17:47:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201028055030.GA362097@in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 6:50 AM, Bharata B Rao wrote:
> slub_max_order
> --------------
> The most promising tunable that shows consistent reduction in slab memory
> is slub_max_order. Here is a table that shows the number of slabs that
> end up with different orders and the total slab consumption at boot
> for different values of slub_max_order:
> -------------------------------------------
> slub_max_order	Order	NrSlabs	Slab memory
> -------------------------------------------
> 		0	276
> 	3	1	16	207488 kB
>      (default)	2	4
> 		3	11
> -------------------------------------------
> 		0	276
> 	2	1	16	166656 kB
> 		2	4
> -------------------------------------------
> 		0	276	144128 kB
> 	1	1	31
> -------------------------------------------
> 
> Though only a few bigger sized caches fall into order-2 or order-3, they
> seem to make a considerable difference to the overall slab consumption.
> If we take task_struct cache as an example, this is how it ends up when
> slub_max_order is varied:
> 
> task_struct, objsize=9856
> --------------------------------------------
> slub_max_order	objperslab	pagesperslab
> --------------------------------------------
> 3		53		8
> 2		26		4
> 1		13		2
> --------------------------------------------
> 
> The slab page-order and hence the number of objects in a slab has a
> bearing on the performance, but I wonder if some caches like task_struct
> above can be auto-tuned to fall into a conservative order and do good
> both wrt both memory and performance?

Hmm ideally this should be based on objperslab so if there's larger page sizes, 
then the calculated order becomes smaller, even 0?

> mm/slub.c:calulate_order() has the logic which determines the the
> page-order for the slab. It starts with min_objects and attempts
> to arrive at the best configuration for the slab. The min_objects
> is starts like this:
> 
> min_objects = 4 * (fls(nr_cpu_ids) + 1);
> 
> Here nr_cpu_ids depends on the maxcpus and hence this can have a
> significant effect on those systems which define maxcpus. Slab numbers
> post-boot for a KVM pseries guest that has 16 boottime CPUs and varying
> number of maxcpus look like this:
> -------------------------------
> maxcpus		Slab memory(kB)
> -------------------------------
> 64		209280
> 256		253824
> 512		293824
> -------------------------------

Yeah IIRC nr_cpu_ids is related to number of possible cpus which is rather 
excessive on some systems, so a relation to actually online cpus would make more 
sense.

> Page-order is a one time setting and obviously can't be tweaked dynamically
> on CPU hotplug, but just wanted to bring out the effect of the same.
> 
> And that constant multiplicative factor of 4 was infact added by the commit
> 9b2cd506e5f2 - "slub: Calculate min_objects based on number of processors."
> 
> Reducing that to say 2, does give some reduction in the slab memory
> and also same hackbench performance with reduced slab memory, but I am not
> sure if that could be assumed to be beneficial for all scenarios.
> 
> MIN_PARTIAL
> -----------
> This determines the number of slabs left on the partial list even if they
> are empty. My initial thought was that the default MIN_PARTIAL value of 5
> is on the higher side and we are accumulating MIN_PARTIAL number of
> empty slabs in all caches without freeing them. However I hardly find
> the case where an empty slab is retained during freeing on account of
> partial slabs being lesser than MIN_PARTIAL.
> 
> However what I find in practice is that we are accumulating a lot of partial
> slabs with just one in-use object in the whole slab. High number of such
> partial slabs is indeed contributing to the increased slab memory consumption.
> 
> For example, after a hackbench run, I find the distribution of objects
> like this for kmalloc-2k cache:
> 
> total_objects		3168
> objects			1611
> Nr partial slabs	54
> Nr parital slabs with
> just 1 inuse object	38
> 
> With 64K page-size, so many partial slabs with just 1 inuse object can
> result in high memory usage. Is there any workaround possible prevent this
> kind of situation?

Probably not, this is just fundamental internal fragmentation problem and that 
we can't predict which objects will have similar lifetime and thus put it 
together. Larger pages make just make the effect more pronounced. It would be 
wrong if we allocated new pages instead of reusing the partial ones, but that's 
not the case, IIUC?

But you are measuring "after a hackbench run", so is that an important data 
point? If the system was in some kind of steady state workload, the pages would 
be better used I'd expect.

> cpu_partial
> -----------
> Here is how the slab consumption post-boot varies when all the slab
> caches are forced with the fixed cpu_partial value:
> ---------------------------
> cpu_partial	Slab Memory
> ---------------------------
> 0		175872 kB
> 2		187136 kB
> 4		191616 kB
> default		204864 kB
> ---------------------------
> 
> It has been suggested earlier that reducing cpu_partial and/or making
> cpu_partial 64K page-size aware will benefit. In set_cpu_partial(),
> for bigger sized slabs (size > PAGE_SIZE), cpu_partial is already set
> to 2. A bit of tweaking there to introduce cpu_partial=1 for certain
> slabs does give some benefit.
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index a28ed9b8fc61..e09eff1199bf 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3626,7 +3626,9 @@ static void set_cpu_partial(struct kmem_cache *s)
>           */
>          if (!kmem_cache_has_cpu_partial(s))
>                  slub_set_cpu_partial(s, 0);
> -       else if (s->size >= PAGE_SIZE)
> +       else if (s->size >= 8192)
> +               slub_set_cpu_partial(s, 1);
> +       else if (s->size >= 4096)
>                  slub_set_cpu_partial(s, 2);
>          else if (s->size >= 1024)
>                  slub_set_cpu_partial(s, 6);
> 
> With the above change, the slab consumption post-boot reduces to 186048 kB.

Yeah, making it agnostic to PAGE_SIZE makes sense.

> Also, here are the hackbench numbers with and w/o the above change:
> 
> Average of 10 runs of 'hackbench -s 1024 -l 200 -g 200 -f 25 -P'
> Slab consumption captured at the end of each run
> --------------------------------------------------------------
> 		Time		Slab memory
> --------------------------------------------------------------
> Default		11.124s		645580 kB
> Patched		11.032s		584352 kB
> --------------------------------------------------------------
> 
> I have mostly looked at reducing the slab memory consumption here.
> But I do understand that default tunable values have been arrived
> at based on some benchmark numbers. Are there ways or possibilities
> to reduce the slub memory consumption with the existing level of
> performance is what I would like to understand and explore.
> 
> Regards,
> Bharata.
> 

