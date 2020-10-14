Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C665E28E258
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 16:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgJNOhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 10:37:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:51020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgJNOhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:37:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602686264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fk9g6Vlx0EIA8z+4UQpdX+wgceUcn3bulrSmu9lCrew=;
        b=SBAsSRY5fVHRhruUOZ0YlMZsVltORmGFHIXwOZsXDDadTXfXE14+i/nQNTUMsDNtyRYdsd
        ROeLMNKE+TZADKplklgyUjvYfilfwpJzBKovLGQs9zyrtLzkDnXoucltw+6kHj99P+y5A6
        neAOUHbwiq+uA0Iz+aJr4b/AgoQ9QwY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A5C0AD18;
        Wed, 14 Oct 2020 14:37:44 +0000 (UTC)
Date:   Wed, 14 Oct 2020 16:37:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com
Subject: Re: [PATCH v5 3/4] mm: introduce page memcg flags
Message-ID: <20201014143743.GF4440@dhcp22.suse.cz>
References: <20201002172559.4000748-1-guro@fb.com>
 <20201002172559.4000748-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002172559.4000748-4-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-10-20 10:25:58, Roman Gushchin wrote:
> The lowest bit in page->memcg_data is used to distinguish between
> struct memory_cgroup pointer and a pointer to a objcgs array.
> All checks and modifications of this bit are open-coded.
> 
> Let's formalize it using page memcg flags, defined in enum
> page_memcg_data_flags.
> 
> Additional flags might be added later.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index c7ac0a5b8989..99a4841d658b 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -343,6 +343,15 @@ struct mem_cgroup {
>  
>  extern struct mem_cgroup *root_mem_cgroup;
>  
> +enum page_memcg_data_flags {
> +	/* page->memcg_data is a pointer to an objcgs vector */
> +	MEMCG_DATA_OBJCGS = (1UL << 0),
> +	/* the next bit after the last actual flag */
> +	__NR_MEMCG_DATA_FLAGS  = (1UL << 1),
> +};
> +
> +#define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
> +
>  /*
>   * page_memcg - get the memory cgroup associated with a page
>   * @page: a pointer to the page struct
> @@ -404,13 +413,7 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
>  	 */
>  	unsigned long memcg_data = READ_ONCE(page->memcg_data);
>  
> -	/*
> -	 * The lowest bit set means that memcg isn't a valid
> -	 * memcg pointer, but a obj_cgroups pointer.
> -	 * In this case the page is shared and doesn't belong
> -	 * to any specific memory cgroup.
> -	 */
> -	if (memcg_data & 0x1UL)
> +	if (memcg_data & MEMCG_DATA_OBJCGS)
>  		return NULL;
>  
>  	return (struct mem_cgroup *)memcg_data;
> @@ -429,7 +432,11 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
>   */
>  static inline struct obj_cgroup **page_objcgs(struct page *page)
>  {
> -	return (struct obj_cgroup **)(READ_ONCE(page->memcg_data) & ~0x1UL);
> +	unsigned long memcg_data = READ_ONCE(page->memcg_data);
> +
> +	VM_BUG_ON_PAGE(memcg_data && !(memcg_data & MEMCG_DATA_OBJCGS), page);
> +
> +	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>  
>  /*
> @@ -444,10 +451,10 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
>  {
>  	unsigned long memcg_data = READ_ONCE(page->memcg_data);
>  
> -	if (memcg_data && (memcg_data & 0x1UL))
> -		return (struct obj_cgroup **)(memcg_data & ~0x1UL);
> +	if (!memcg_data || !(memcg_data & MEMCG_DATA_OBJCGS))
> +		return NULL;
>  
> -	return NULL;
> +	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>  
>  /*
> @@ -460,7 +467,8 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
>  static inline bool set_page_objcgs(struct page *page,
>  					struct obj_cgroup **objcgs)
>  {
> -	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs | 0x1UL);
> +	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs |
> +			MEMCG_DATA_OBJCGS);
>  }
>  #else
>  static inline struct obj_cgroup **page_objcgs(struct page *page)
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
