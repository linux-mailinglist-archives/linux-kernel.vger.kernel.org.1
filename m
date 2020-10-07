Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECD8286550
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgJGQzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgJGQzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:55:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B8CC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sxbkS3NRMl6rIsLLVu2DdPxndxYXSPWPV6laeejVFsU=; b=hHCdo69g1ERO0IyETSWyJVT5Gn
        BLeZEqM1CGzKvDiaGp273w5dx+Abx7FxWkr2A1qq6zGnEZCNr2FIBXZUxDbX3UrnXT0RzltPzr/D6
        9Z8zo+4bDSJ9oeOaizYam7gbczI0WF0Dd/N4GZSs3mHTj4vSmFYpRuV56M+WZmx4Eb6SJuvwL7kul
        X9Xfn7mUj0Z8U30JBcyaVd+PLOZSQcCVJb5pf73KafT0byRiYj8dx51haG1ytZA/0DgX1GA7tA72b
        HPQqgvdK2qNxUaG/x4PWhRiCTA0ZphN2ZwjTpiqZwcxuxfoVWEQ8EWyBcVCXJkFteS4EWk8RVNZQI
        y3tf9o4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQCj1-0004Ix-Gi; Wed, 07 Oct 2020 16:55:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 997B83019CE;
        Wed,  7 Oct 2020 18:55:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 815322B067BD9; Wed,  7 Oct 2020 18:55:33 +0200 (CEST)
Date:   Wed, 7 Oct 2020 18:55:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, valentin.schneider@arm.com,
        raistlin@linux.it
Subject: Re: [PATCH v5 1/2] sched/deadline: optimize
 sched_dl_global_validate()
Message-ID: <20201007165533.GL2628@hirez.programming.kicks-ass.net>
References: <cover.1601993091.git.iwtbavbm@gmail.com>
 <9ad8eff54a3dd6f7f0da50e827047e4d3c4bb00a.1601993091.git.iwtbavbm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ad8eff54a3dd6f7f0da50e827047e4d3c4bb00a.1601993091.git.iwtbavbm@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:12:29PM +0800, Peng Liu wrote:
> +/* Used for dl_bw check and update. */
> +static u32 dl_generation;

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 28709f6b0975..53477e8b26b0 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -798,6 +798,13 @@ struct root_domain {
>  	 */
>  	cpumask_var_t		dlo_mask;
>  	atomic_t		dlo_count;
> +
> +	/*
> +	 * Indicate whether a root_domain's dl_bw has been checked or
> +	 * updated. It's monotonously increasing, then wrap around.
> +	 */
> +	u32 visit_gen;
> +
>  	struct dl_bw		dl_bw;
>  	struct cpudl		cpudl;
>  
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index dd7770226086..90f3e5558fa2 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -516,6 +516,7 @@ static int init_rootdomain(struct root_domain *rd)
>  	init_irq_work(&rd->rto_push_work, rto_push_irq_work_func);
>  #endif
>  
> +	rd->visit_gen = 0;
>  	init_dl_bw(&rd->dl_bw);
>  	if (cpudl_init(&rd->cpudl) != 0)
>  		goto free_rto_mask;

I'm fairly sure I made the generation a u64, the above is susceptible to
a false positive due to wrap-around.

Increase the generation to -1, create a new root domain, then the next
generation is 0 and we'll skip the new domain, even though it should be
updated.
