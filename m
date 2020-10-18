Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B392917D7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 16:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgJROSs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 18 Oct 2020 10:18:48 -0400
Received: from smtp.h3c.com ([60.191.123.50]:32440 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgJROSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 10:18:48 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 09IEIZDq084122
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 18 Oct 2020 22:18:36 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 18 Oct 2020 22:18:37 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.2106.002; Sun, 18 Oct 2020 22:18:37 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Subject: RE: [PATCH] mm: Make allocator take care of memoryless numa node
Thread-Topic: [PATCH] mm: Make allocator take care of memoryless numa node
Thread-Index: AQHWoHLpCFmBht8fWEyQ1LSKDhVJgamTi1oAgAnlFDA=
Date:   Sun, 18 Oct 2020 14:18:37 +0000
Message-ID: <10ae851702e346369db44e1ec9c830fb@h3c.com>
References: <20201012082739.15661-1-tian.xianting@h3c.com>
 <20201012150554.GE29725@dhcp22.suse.cz>
In-Reply-To: <20201012150554.GE29725@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 09IEIZDq084122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments
I found in current code, there are two places to call local_memory_node(node) before calling kzalloc_node(), I think we can remove them?

-----Original Message-----
From: Michal Hocko [mailto:mhocko@suse.com] 
Sent: Monday, October 12, 2020 11:06 PM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: cl@linux.com; penberg@kernel.org; rientjes@google.com; iamjoonsoo.kim@lge.com; akpm@linux-foundation.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org; kuba@kernel.org; alexei.starovoitov@gmail.com
Subject: Re: [PATCH] mm: Make allocator take care of memoryless numa node

On Mon 12-10-20 16:27:39, Xianting Tian wrote:
> In architecture like powerpc, we can have cpus without any local 
> memory attached to it. In such cases the node does not have real memory.

Yes, this is normal (unfortunately).

> In many places of current kernel code, it doesn't judge whether the 
> node is memoryless numa node before calling allocator interface.

And that is correct. It shouldn't make any assumption on the memory on a given node because that memory might be depleted (similar to no memory) or it can disappear at any moment because of the memory offlining.

> This patch is to use local_memory_node(), which is guaranteed to have 
> memory, in allocator interface. local_memory_node() is a noop in other 
> architectures that don't support memoryless nodes.
> 
> As the call path:
> 	alloc_pages_node
> 	    __alloc_pages_node
> 	        __alloc_pages_nodemask
> and __alloc_pages_node,__alloc_pages_nodemask may be called directly, 
> so only add local_memory_node() in __alloc_pages_nodemask.

Page allocator should deal with memory less nodes just fine. It has zonelists constructed for each possible nodes. And it will automatically fall back into a node with is closest to the requested node.
local_memory_node might be incorrect choice from the topology POV.

What kind of problem are you trying to fix?

> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  include/linux/slab.h |  3 +++
>  mm/page_alloc.c      |  1 +
>  mm/slab.c            |  6 +++++-
>  mm/slob.c            |  1 +
>  mm/slub.c            | 10 ++++++++--
>  5 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h index 
> 24df2393e..527e811e0 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -574,6 +574,7 @@ static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
>  						flags, node, size);
>  	}
>  #endif
> +	node = local_memory_node(node);
>  	return __kmalloc_node(size, flags, node);  }
>  
> @@ -626,6 +627,8 @@ static inline void *kmalloc_array_node(size_t n, size_t size, gfp_t flags,
>  		return NULL;
>  	if (__builtin_constant_p(n) && __builtin_constant_p(size))
>  		return kmalloc_node(bytes, flags, node);
> +
> +	node = local_memory_node(node);
>  	return __kmalloc_node(bytes, flags, node);  }
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c index 
> 6866533de..be63c62c2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4878,6 +4878,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  		return NULL;
>  	}
>  
> +	preferred_nid = local_memory_node(preferred_nid);
>  	gfp_mask &= gfp_allowed_mask;
>  	alloc_mask = gfp_mask;
>  	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, 
> &ac, &alloc_mask, &alloc_flags)) diff --git a/mm/slab.c b/mm/slab.c 
> index f658e86ec..263c2f2e1 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3575,7 +3575,10 @@ EXPORT_SYMBOL(kmem_cache_alloc_trace);
>   */
>  void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, 
> int nodeid)  {
> -	void *ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
> +	void *ret;
> +
> +	nodeid = local_memory_node(nodeid);
> +	ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
>  
>  	trace_kmem_cache_alloc_node(_RET_IP_, ret,
>  				    cachep->object_size, cachep->size, @@ -3593,6 +3596,7 @@ void 
> *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,  {
>  	void *ret;
>  
> +	nodeid = local_memory_node(nodeid);
>  	ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
>  
>  	ret = kasan_kmalloc(cachep, ret, size, flags); diff --git 
> a/mm/slob.c b/mm/slob.c index 7cc9805c8..1f1c25e06 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -636,6 +636,7 @@ EXPORT_SYMBOL(__kmalloc_node);
>  
>  void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t gfp, int 
> node)  {
> +	node = local_memory_node(node);
>  	return slob_alloc_node(cachep, gfp, node);  }  
> EXPORT_SYMBOL(kmem_cache_alloc_node);
> diff --git a/mm/slub.c b/mm/slub.c
> index 6d3574013..6e5e12b04 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2921,7 +2921,10 @@ EXPORT_SYMBOL(kmem_cache_alloc_trace);
>  #ifdef CONFIG_NUMA
>  void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int 
> node)  {
> -	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_);
> +	void *ret;
> +
> +	node = local_memory_node(node);
> +	ret = slab_alloc_node(s, gfpflags, node, _RET_IP_);
>  
>  	trace_kmem_cache_alloc_node(_RET_IP_, ret,
>  				    s->object_size, s->size, gfpflags, node); @@ -2935,7 +2938,10 
> @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
>  				    gfp_t gfpflags,
>  				    int node, size_t size)
>  {
> -	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_);
> +	void *ret;
> +
> +	node = local_memory_node(node);
> +	ret = slab_alloc_node(s, gfpflags, node, _RET_IP_);
>  
>  	trace_kmalloc_node(_RET_IP_, ret,
>  			   size, s->size, gfpflags, node);
> --
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
