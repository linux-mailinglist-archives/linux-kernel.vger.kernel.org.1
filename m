Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F82280DBD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 08:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgJBG5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 02:57:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:36400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJBG5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 02:57:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601621867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LlwEz4B/S7P9H5p6PBWotxH8LpYCx1zo/m0p5+ZNd+c=;
        b=YSKDYRVuK21DNVTgp1G5vaYqO/K1DwlshqB5b2Yp0q4/tJEUWUhhASK84nZPtiaMBEZRVv
        nqapw0mcKancESEDJ6qMAVpiNoCXxBVU7yHcH0lf00fcrH3PFlCrkunxpPDPadOjb/uD8d
        ZSXrZlZVLOKZAwVVk1CquSGfmFuyR+c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B026AF68;
        Fri,  2 Oct 2020 06:57:47 +0000 (UTC)
Date:   Fri, 2 Oct 2020 08:57:46 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 14/15] rcu/tree: Allocate a page when caller
 is preemptible
Message-ID: <20201002065746.GA20872@dhcp22.suse.cz>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
 <20200928233102.24265-14-paulmck@kernel.org>
 <20200929120756.GC2277@dhcp22.suse.cz>
 <20200930015327.GX29330@paulmck-ThinkPad-P72>
 <20200930084139.GN2277@dhcp22.suse.cz>
 <20200930232154.GA29330@paulmck-ThinkPad-P72>
 <20201001090220.GA22560@dhcp22.suse.cz>
 <20201001162709.GD29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001162709.GD29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-10-20 09:27:09, Paul E. McKenney wrote:
[...]
> commit ea5c19d21233b5e8d3d06c0d4ecd6be9f2829dc3
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Oct 1 09:24:40 2020 -0700
> 
>     kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument kvfree_rcu()
>     
>     This commit applies the __GFP_NOMEMALLOC gfp flag to memory allocations
>     carried out by the single-argument variant of kvfree_rcu(), thus avoiding
>     this can-sleep code path from dipping into the emergency reserves.
>     
>     Suggested-by: Michal Hocko <mhocko@suse.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

LGTM. At least for this one I feel competent to give you
Acked-by: Michal Hocko <mhocko@suse.com>

> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 242f0f0..6132452 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3364,7 +3364,8 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  {
>  	struct kvfree_rcu_bulk_data *bnode;
>  	bool can_alloc_page = preemptible();
> -	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL : GFP_ATOMIC) | __GFP_NOWARN;
> +	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC
> +			       : GFP_ATOMIC) | __GFP_NOWARN;
>  	int idx;
>  
>  	*krcp = krc_this_cpu_lock(flags);

-- 
Michal Hocko
SUSE Labs
