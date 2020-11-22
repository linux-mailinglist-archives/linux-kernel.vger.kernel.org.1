Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6C12BC51C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 11:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgKVKfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 05:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgKVKfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 05:35:36 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4857C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 02:35:36 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id w4so11476926pgg.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 02:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nvsN7En8UwCGyI/kzbsgXIx2QOfcFYqyG9OlXKCe5M8=;
        b=p6Rn983BQh4c+m1LDrdDK/+ecNpPqBKzEsBxgiuD/ph5R3m5YaTiCdZ+RfySgmqX6R
         CQ1kRVZp1jhWFU1wA3sVdfxjmVZxx3PbuSDr/uHckNtZb5BsStJypJL4jPNfwPC9P9Yq
         eY9djoeEF0UIuixj2Jl5azz5bqG2E2nDpxZdYMDZKHAaMNQemQnsceQbCEWsQEXw0mmt
         Y1gm6HZ0BaH+4RLs6OnaEWveoJnkOYLGioLSBpTCR4vGy0ScAH2gYDqVX2pj3lXhGueu
         FeCDBY/jiLQmUTopVOM6DGsRnRQfq2XihVvHPkJ2eTQ0PigRLu2iBS3lOBBaF5fP2pON
         mYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nvsN7En8UwCGyI/kzbsgXIx2QOfcFYqyG9OlXKCe5M8=;
        b=h70NQf7b2Nv05QFxb5elXjvywjRSVtFCHNkYZEOps6QeP8Q2xyEd73OzDUWtYjcCSz
         XoRx8NOiNf4xWPy+1zCkibaA9DjU/YcQkB664qaahrP/FqFnP4b48Cp1X+GbxKpF6YKR
         oW31vaUU1oqTj5P51cdJj+d0+0fu/nTfVkYl4jYsWa2Kxv5rhbyM7rrZCM16m2UViM7G
         cljKPZpE4n2vt5ywsXVGt7x+9UN7TNt6zVhsA7MNWxGScBFYPwnh87+nC0Cdahrp5xxl
         OikkkDl6Sw0lkEkfDdSqUewYpN4Ho6lE89h9ckbzv2Km2rGhZowvoYAJeV/c0voS+SQC
         6PnQ==
X-Gm-Message-State: AOAM531PlBoBu6QNiO52Lj2XqcGj3RiDfeD4ksLO9E/IDj2e5qw1kVXV
        t8ainwuSL1zeYvKN1DE5gFw=
X-Google-Smtp-Source: ABdhPJyz2hTh7IN+EJVPsZbyRlVglu4hyb45W0aAVe4CbEnrlIxiEIUp71+lYGCo1yR0Dzyodlt/DA==
X-Received: by 2002:a17:90a:4295:: with SMTP id p21mr19905667pjg.217.1606041335384;
        Sun, 22 Nov 2020 02:35:35 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id d2sm9797254pjj.37.2020.11.22.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 02:35:33 -0800 (PST)
Date:   Sun, 22 Nov 2020 21:35:29 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 08/32] sched/fair: Fix forced idle sibling
 starvation corner case
Message-ID: <20201122103529.GC110669@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-9-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-9-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:38PM -0500, Joel Fernandes (Google) wrote:
> From: Vineeth Pillai <viremana@linux.microsoft.com>
> 
> If there is only one long running local task and the sibling is
> forced idle, it  might not get a chance to run until a schedule
> event happens on any cpu in the core.
> 
> So we check for this condition during a tick to see if a sibling
> is starved and then give it a chance to schedule.
> 
> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/core.c  | 15 ++++++++-------
>  kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h |  2 +-
>  3 files changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1bd0b0bbb040..52d0e83072a4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5206,16 +5206,15 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  
>  	/* reset state */
>  	rq->core->core_cookie = 0UL;
> +	if (rq->core->core_forceidle) {
> +		need_sync = true;
> +		rq->core->core_forceidle = false;
> +	}
>  	for_each_cpu(i, smt_mask) {
>  		struct rq *rq_i = cpu_rq(i);
>  
>  		rq_i->core_pick = NULL;
>  
> -		if (rq_i->core_forceidle) {
> -			need_sync = true;
> -			rq_i->core_forceidle = false;
> -		}
> -
>  		if (i != cpu)
>  			update_rq_clock(rq_i);
>  	}
> @@ -5335,8 +5334,10 @@ next_class:;
>  		if (!rq_i->core_pick)
>  			continue;
>  
> -		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running)
> -			rq_i->core_forceidle = true;
> +		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running &&
> +		    !rq_i->core->core_forceidle) {
> +			rq_i->core->core_forceidle = true;
> +		}
>  
>  		if (i == cpu) {
>  			rq_i->core_pick = NULL;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f53681cd263e..42965c4fd71f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10692,6 +10692,44 @@ static void rq_offline_fair(struct rq *rq)
>  
>  #endif /* CONFIG_SMP */
>  
> +#ifdef CONFIG_SCHED_CORE
> +static inline bool
> +__entity_slice_used(struct sched_entity *se, int min_nr_tasks)
> +{
> +	u64 slice = sched_slice(cfs_rq_of(se), se);

I wonder if the definition of sched_slice() should be revisited for core
scheduling?

Should we use sched_slice = sched_slice / cpumask_weight(smt_mask)?
Would that resolve the issue your seeing? Effectively we need to answer
if two sched core siblings should be treated as executing one large
slice?

Balbir Singh.


