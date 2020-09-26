Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D37B279AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgIZQ3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49930 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729898AbgIZQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:29:46 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601137785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/KIvQSIHpzjNKm1095ZlQDJ4pMedwPDesb5k1nHeYM=;
        b=O7znlYUB4jo1ani7HSvOHX0DdNRwDTbo3RHKjeImXQWag8Z9GyA5hL3DR1HSsAHzlsi/vB
        ggC/w5ZclgqEb+yvEYX3bPUoVQBOaGrlQCNpQxsffKzAQu7UvROxZ4IRdomop/9Hk+T7yJ
        MJi/pJuYt53rsRnOVOWfIsjhJ+Hiitc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-m_ahbw38NmOnb5XjBVT7qQ-1; Sat, 26 Sep 2020 12:29:42 -0400
X-MC-Unique: m_ahbw38NmOnb5XjBVT7qQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E76FC801A9D;
        Sat, 26 Sep 2020 16:29:40 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B82D31001901;
        Sat, 26 Sep 2020 16:29:37 +0000 (UTC)
Date:   Sat, 26 Sep 2020 12:29:34 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/2] mempolicy: Rename MPOL_F_MORON to MPOL_F_MOPRON
Message-ID: <20200926162854.GB1325930@optiplex-lnx>
References: <20200924082509.445336-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924082509.445336-1-ying.huang@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 04:25:08PM +0800, Huang Ying wrote:
> To follow code-of-conduct better.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Rientjes <rientjes@google.com>
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
> index 36c54265bb2b..26495a344d8d 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -844,7 +844,7 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
>  
>  	task_lock(p);
>  	pol = p->mempolicy;
> -	if (pol && !(pol->flags & MPOL_F_MORON))
> +	if (pol && !(pol->flags & MPOL_F_MOPRON))
>  		pol = NULL;
>  	mpol_get(pol);
>  	task_unlock(p);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index eddbe4e56c73..62cd159aa46d 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2515,7 +2515,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>  	}
>  
>  	/* Migrate the page towards the node whose CPU is referencing it */
> -	if (pol->flags & MPOL_F_MORON) {
> +	if (pol->flags & MPOL_F_MOPRON) {
>  		polnid = thisnid;
>  
>  		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
> @@ -2806,7 +2806,7 @@ void __init numa_policy_init(void)
>  		preferred_node_policy[nid] = (struct mempolicy) {
>  			.refcnt = ATOMIC_INIT(1),
>  			.mode = MPOL_PREFERRED,
> -			.flags = MPOL_F_MOF | MPOL_F_MORON,
> +			.flags = MPOL_F_MOF | MPOL_F_MOPRON,
>  			.v = { .preferred_node = nid, },
>  		};
>  	}
> @@ -3014,7 +3014,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
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
> 
Acked-by: Rafael Aquini <aquini@redhat.com>

