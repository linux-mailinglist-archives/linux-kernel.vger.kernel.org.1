Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71DD29C0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1818012AbgJ0RQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:16:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:52474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2899694AbgJ0O6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:58:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603810695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QHfC50u4+qYFKShn9vmVFysfcHnRXhgSobOLpg9p0W8=;
        b=YmmqkqV0zXjnwZ/n/we8egpCPIWoJQ40xIiaz72oAbg1N9ZYj1HNm3osroivK/OGnF/b5Z
        uClP6ikE0YuEZg/hQbgUXTPOFyDo/qVedZdPyp+gs59yeRufDMFViY3kby3riztNmgorP9
        IOhcFQ9z5x8D27pj9l+4X7eFpdFAGnE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1CFFAE7B;
        Tue, 27 Oct 2020 14:58:15 +0000 (UTC)
Date:   Tue, 27 Oct 2020 15:58:14 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hui Su <sh_def@163.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/oom_kill.c: remove the unmatched comments
Message-ID: <20201027145814.GY20500@dhcp22.suse.cz>
References: <20201027144529.GA3558@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027144529.GA3558@rlk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-10-20 22:45:29, Hui Su wrote:
> is_dump_unreclaim_slabs() just check whether nr_unreclaimable
> slabs amount is greater than user memory, not match witch comment.

As I've tried to explain, the comment is not explaining what the
function does but how it should be used. It is not a kerneldoc afterall.
So it is a good match. I can see how that might confuse somebody so I am
not against changing this but the changelog shouldn't really be
confusing on its own. What do you think about the following instead.

"
Comment for is_dump_unreclaim_slabs is not really clear whether it is
meant to instruct how to use the function or whether it is an outdated
information of the past implementation of the function. it doesn't realy
help that is_dump_unreclaim_slabs is hard to grasp on its own.
Rename the helper to should_dump_unreclaim_slabs which should make it
clear what it is meant to do and drop the comment as the purpose should
be pretty evident now.
"

> So delete the comment, and rename it to should_dump_unreclaim_slabs().
> 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  mm/oom_kill.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 8b84661a6410..d181e24d7193 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -170,11 +170,7 @@ static bool oom_unkillable_task(struct task_struct *p)
>  	return false;
>  }
>  
> -/*
> - * Print out unreclaimble slabs info when unreclaimable slabs amount is greater
> - * than all user memory (LRU pages)
> - */
> -static bool is_dump_unreclaim_slabs(void)
> +static bool should_dump_unreclaim_slabs(void)
>  {
>  	unsigned long nr_lru;
>  
> @@ -463,7 +459,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
>  		mem_cgroup_print_oom_meminfo(oc->memcg);
>  	else {
>  		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
> -		if (is_dump_unreclaim_slabs())
> +		if (should_dump_unreclaim_slabs())
>  			dump_unreclaimable_slab();
>  	}
>  	if (sysctl_oom_dump_tasks)
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
