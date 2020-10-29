Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAEE29E6D0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgJ2JEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:04:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:42938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgJ2JEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:04:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603962262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oOcANBdMPXC7B2WLthX/pictznBjPuN497vi+SoY2Xs=;
        b=dhcd+7qqKCXHjOBxV2Cg7MiZML1GKPSWVlBB9FvKKYdgskekurmRpBQNM+RI6MvGVqp+Jy
        rHDoUBCvqVGqB6VmHZ4YrMOJHX2JPN5EgX4efyqaLFx9qsziq9sLEQ92ttTPgewslMFBPo
        vtnWnT1j6OGk084gTe9UcCdgAqlEQRc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16A7EAC65;
        Thu, 29 Oct 2020 09:04:22 +0000 (UTC)
Date:   Thu, 29 Oct 2020 10:04:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH -V2 1/2] mempolicy: Rename MPOL_F_MORON to MPOL_F_MOPRON
Message-ID: <20201029090421.GC17500@dhcp22.suse.cz>
References: <20201028023411.15045-1-ying.huang@intel.com>
 <20201028023411.15045-2-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028023411.15045-2-ying.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-10-20 10:34:10, Huang Ying wrote:
> To follow code-of-conduct better.

This is changing a user visible interface and any userspace which refers
to the existing name will fail to compile unless I am missing something.

Have you checked how many applications would be affected?

Btw I find "follow CoC better" a very weak argument without further
explanation.

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Acked-by: Rafael Aquini <aquini@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Rafael Aquini <aquini@redhat.com>
> ---
>  include/uapi/linux/mempolicy.h | 2 +-
>  kernel/sched/debug.c           | 2 +-
>  mm/mempolicy.c                 | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> index 3354774af61e..3c3666d017e6 100644
> --- a/include/uapi/linux/mempolicy.h
> +++ b/include/uapi/linux/mempolicy.h
> @@ -60,7 +60,7 @@ enum {
>  #define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
>  #define MPOL_F_LOCAL   (1 << 1)	/* preferred local allocation */
>  #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
> -#define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
> +#define MPOL_F_MOPRON	(1 << 4) /* Migrate On Protnone Reference On Node */
>  
>  
>  #endif /* _UAPI_LINUX_MEMPOLICY_H */
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 0655524700d2..8bfb6adb3f31 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -898,7 +898,7 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
>  
>  	task_lock(p);
>  	pol = p->mempolicy;
> -	if (pol && !(pol->flags & MPOL_F_MORON))
> +	if (pol && !(pol->flags & MPOL_F_MOPRON))
>  		pol = NULL;
>  	mpol_get(pol);
>  	task_unlock(p);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 3fde772ef5ef..f6948b659643 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2511,7 +2511,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>  	}
>  
>  	/* Migrate the page towards the node whose CPU is referencing it */
> -	if (pol->flags & MPOL_F_MORON) {
> +	if (pol->flags & MPOL_F_MOPRON) {
>  		polnid = thisnid;
>  
>  		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
> @@ -2802,7 +2802,7 @@ void __init numa_policy_init(void)
>  		preferred_node_policy[nid] = (struct mempolicy) {
>  			.refcnt = ATOMIC_INIT(1),
>  			.mode = MPOL_PREFERRED,
> -			.flags = MPOL_F_MOF | MPOL_F_MORON,
> +			.flags = MPOL_F_MOF | MPOL_F_MOPRON,
>  			.v = { .preferred_node = nid, },
>  		};
>  	}
> @@ -3010,7 +3010,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>  	unsigned short mode = MPOL_DEFAULT;
>  	unsigned short flags = 0;
>  
> -	if (pol && pol != &default_policy && !(pol->flags & MPOL_F_MORON)) {
> +	if (pol && pol != &default_policy && !(pol->flags & MPOL_F_MOPRON)) {
>  		mode = pol->mode;
>  		flags = pol->flags;
>  	}
> -- 
> 2.28.0
> 

-- 
Michal Hocko
SUSE Labs
