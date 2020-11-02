Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474002A252B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgKBH2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:28:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:42832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbgKBH2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:28:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604302118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIeSJu/dxQMs46dPuG/9Z0PrnYcPG7vnkDWSjn2yCPc=;
        b=t3kkl6+BY+//ALDZFl4LH/zzn9lEK17PsBuQJOG4gFXTiEhMJtwEHDKk+6PBTvXUMY4qFF
        aOTAr32BOyEFFBx3huA3vrGlZfq49MNUifeOFqftPzL/YnudR8gNPUEuuEmMOXSTlQDfUd
        A2a6nupcbgZrgV91Fz//CP4kH6/8f/8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4EE79ACF6;
        Mon,  2 Nov 2020 07:28:38 +0000 (UTC)
Date:   Mon, 2 Nov 2020 08:28:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hui Su <sh_def@163.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/oom_kill: change comment and rename
 is_dump_unreclaim_slabs()
Message-ID: <20201102072836.GA22613@dhcp22.suse.cz>
References: <20201027144529.GA3558@rlk>
 <20201027145814.GY20500@dhcp22.suse.cz>
 <20201027151156.GA4336@rlk>
 <20201027192322.GA20500@dhcp22.suse.cz>
 <20201028153141.GB77196@rlk>
 <20201030182704.GA53949@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030182704.GA53949@rlk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 31-10-20 02:27:04, Hui Su wrote:
> Change the comment of is_dump_unreclaim_slabs(), it just check
> whether nr_unreclaimable slabs amount is greater than user
> memory, and explain why we dump unreclaim slabs.
> 
> Rename it to should_dump_unreclaim_slab() maybe better.
> 
> Signed-off-by: Hui Su <sh_def@163.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/oom_kill.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 8b84661a6410..04b19b7b5435 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -170,11 +170,13 @@ static bool oom_unkillable_task(struct task_struct *p)
>  	return false;
>  }
>  
> -/*
> - * Print out unreclaimble slabs info when unreclaimable slabs amount is greater
> - * than all user memory (LRU pages)
> - */
> -static bool is_dump_unreclaim_slabs(void)
> +/**
> + * Check whether unreclaimable slab amount is greater than
> + * all user memory(LRU pages).
> + * dump_unreclaimable_slab() could help in the case that
> + * oom due to too much unreclaimable slab used by kernel.
> +*/
> +static bool should_dump_unreclaim_slab(void)
>  {
>  	unsigned long nr_lru;
>  
> @@ -463,7 +465,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
>  		mem_cgroup_print_oom_meminfo(oc->memcg);
>  	else {
>  		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
> -		if (is_dump_unreclaim_slabs())
> +		if (should_dump_unreclaim_slab())
>  			dump_unreclaimable_slab();
>  	}
>  	if (sysctl_oom_dump_tasks)
> -- 
> 2.29.0
> 
> 

-- 
Michal Hocko
SUSE Labs
