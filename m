Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B505C2B7CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgKRLZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:25:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:44804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgKRLZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:25:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 890D8ADAA;
        Wed, 18 Nov 2020 11:25:39 +0000 (UTC)
To:     Bharata B Rao <bharata@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, cl@linux.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, guro@fb.com,
        shakeelb@google.com, hannes@cmpxchg.org, aneesh.kumar@linux.ibm.com
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <9e1a2e2b-1b3c-9587-9b74-8ed8300fcb98@suse.cz>
Date:   Wed, 18 Nov 2020 12:25:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201118082759.1413056-1-bharata@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/20 9:27 AM, Bharata B Rao wrote:
> The page order of the slab that gets chosen for a given slab
> cache depends on the number of objects that can be fit in the
> slab while meeting other requirements. We start with a value
> of minimum objects based on nr_cpu_ids that is driven by
> possible number of CPUs and hence could be higher than the
> actual number of CPUs present in the system. This leads to
> calculate_order() chosing a page order that is on the higher
> side leading to increased slab memory consumption on systems
> that have bigger page sizes.
> 
> Hence rely on the number of online CPUs when determining the
> mininum objects, thereby increasing the chances of chosing
> a lower conservative page order for the slab.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Ideally, we would react to hotplug events and update existing caches 
accordingly. But for that, recalculation of order for existing caches 
would have to be made safe, while not affecting hot paths. We have 
removed the sysfs interface with 32a6f409b693 ("mm, slub: remove runtime 
allocation order changes") as it didn't seem easy and worth the trouble.

In case somebody wants to start with a large order right from the boot 
because they know they will hotplug lots of cpus later, they can use 
slub_min_objects= boot param to override this heuristic. So in case this 
change regresses somebody's performance, there's a way around it and 
thus the risk is low IMHO.

> ---
> This is a generic change and I am unsure how it would affect
> other archs, but as a start, here are some numbers from
> PowerPC pseries KVM guest with and without this patch:
> 
> This table shows how this change has affected some of the slab
> caches.
> ===================================================================
> 		Current				Patched
> Cache	<objperslab> <pagesperslab>	<objperslab> <pagesperslab>
> ===================================================================
> TCPv6		53    2			26    1
> net_namespace	53    4			26    2
> dtl		32    2			16    1
> names_cache	32    2			16    1
> task_struct	53    8			13    2
> thread_stack	32    8			8     2
> pgtable-2^11	16    8			8     4
> pgtable-2^8	32    2			16    1
> kmalloc-32k	16    8			8     4
> kmalloc-16k	32    8			8     2
> kmalloc-8k	32    4			8     1
> kmalloc-4k	32    2			16    1
> ===================================================================
> 
> Slab memory (kB) consumption comparision
> ==================================================================
> 			Current		Patched
> ==================================================================
> After-boot		205760		156096
> During-hackbench	629145		506752 (Avg of 5 runs)
> After-hackbench		474176		331840 (after drop_caches)
> ==================================================================
> 
> Hackbench Time (Avg of 5 runs)
> (hackbench -s 1024 -l 200 -g 200 -f 25 -P)
> ==========================================
> Current		Patched
> ==========================================
> 10.990		11.010
> ==========================================
> 
> Measuring the effect due to CPU hotplug
> ----------------------------------------
> Since the patch doesn't consider all the possible CPUs for page
> order calcluation, let's see how affects the case when CPUs are
> hotplugged. Here I compare a system that is booted with 64CPUs
> with a system that is booted with 16CPUs but hotplugged with
> 48CPUs after boot. These numbers are with the patch applied.
> 
> Slab memory (kB) consumption comparision
> ===================================================================
> 			64bootCPUs	16bootCPUs+48HotPluggedCPUs
> ===================================================================
> After-boot		390272		159744
> After-hotplug		-		251328
> During-hackbench	1001267		941926 (Avg of 5 runs)
> After-hackbench		913600		827200 (after drop_caches)
> ===================================================================
> 
> Hackbench Time (Avg of 5 runs)
> (hackbench -s 1024 -l 200 -g 200 -f 25 -P)
> ===========================================
> 64bootCPUs	16bootCPUs+48HotPluggedCPUs
> ===========================================
> 12.554		12.589
> ===========================================
>   mm/slub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 34dcc09e2ec9..8342c0a167b2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3433,7 +3433,7 @@ static inline int calculate_order(unsigned int size)
>   	 */
>   	min_objects = slub_min_objects;
>   	if (!min_objects)
> -		min_objects = 4 * (fls(nr_cpu_ids) + 1);
> +		min_objects = 4 * (fls(num_online_cpus()) + 1);
>   	max_objects = order_objects(slub_max_order, size);
>   	min_objects = min(min_objects, max_objects);
>   
> 

