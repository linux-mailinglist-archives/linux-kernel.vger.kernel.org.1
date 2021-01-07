Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57012ED65A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 19:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbhAGSFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 13:05:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:47258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbhAGSFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 13:05:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63ED1AD19;
        Thu,  7 Jan 2021 18:04:33 +0000 (UTC)
Subject: Re: [PATCH] mm/memcontrol: fix warning in mem_cgroup_page_lruvec()
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hui Su <sh_def@163.com>, Alex Shi <alex.shi@linux.alibaba.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <alpine.LSU.2.11.2101032056260.1093@eggly.anvils>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b52ec93d-9d09-888e-3404-c8c78800c683@suse.cz>
Date:   Thu, 7 Jan 2021 19:04:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2101032056260.1093@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/21 6:03 AM, Hugh Dickins wrote:
> Boot a CONFIG_MEMCG=y kernel with "cgroup_disabled=memory" and you are
> met by a series of warnings from the VM_WARN_ON_ONCE_PAGE(!memcg, page)
> recently added to the inline mem_cgroup_page_lruvec().
> 
> An earlier attempt to place that warning, in mem_cgroup_lruvec(), had
> been careful to do so after weeding out the mem_cgroup_disabled() case;
> but was itself invalid because of the mem_cgroup_lruvec(NULL, pgdat) in
> clear_pgdat_congested() and age_active_anon().
> 
> Warning in mem_cgroup_page_lruvec() was once useful in detecting a KSM
> charge bug, so may be worth keeping: but skip if mem_cgroup_disabled().
> 
> Fixes: 9a1ac2288cf1 ("mm/memcontrol:rewrite mem_cgroup_page_lruvec()")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> 
>  include/linux/memcontrol.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 5.11-rc2/include/linux/memcontrol.h	2020-12-27 20:39:36.751923135 -0800
> +++ linux/include/linux/memcontrol.h	2021-01-03 19:38:24.822978559 -0800
> @@ -665,7 +665,7 @@ static inline struct lruvec *mem_cgroup_
>  {
>  	struct mem_cgroup *memcg = page_memcg(page);
>  
> -	VM_WARN_ON_ONCE_PAGE(!memcg, page);
> +	VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);

Nit: I would reverse the order of conditions as mem_cgroup_disabled() is either
"return true" or a static key. Not that it matters too much on DEBUG_VM configs...

>  	return mem_cgroup_lruvec(memcg, pgdat);
>  }
>  
> 

