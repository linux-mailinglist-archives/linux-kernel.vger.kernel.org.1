Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3080D2B1909
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgKMK2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgKMK2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:28:00 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFB0C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d/KlS2pzfp8sOne97UF0Zm10zOHX7PS1VzOMej7apbY=; b=OzOcddnySIP6GHq4GAmp22N1jM
        NxdbA1ix2l/H6Vhjsvmh5GKS/UxInVEUtH4MdnKDhIEdz5OLO6MKDvKKp3cBbCragW++/iee3Eefk
        eHrlmarf7mgpKQ6RYZYyGtiX4L8XzWAub6Yg/uCqRiKE60RsXET3ms3DSWQmLG72+woIFjxnPbfkh
        RWv1TJCejM5my7d0WiNQtLj3NrK99qCNAzL24IeCbcqYkO08ncmUdwKwKnCSpUgnlxP6YatiyfYIH
        ltH/LupG9dLf/DjTUUAX5wN66Ehsi5VeQm5j7WBMdVkmg/idozsRjpjJXf05iPhOhlaMHXhJiyk0Q
        BdTmRzlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdWIs-0001vI-D1; Fri, 13 Nov 2020 10:27:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4B783003E1;
        Fri, 13 Nov 2020 11:27:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D12CB2BCDBFCC; Fri, 13 Nov 2020 11:27:34 +0100 (CET)
Date:   Fri, 13 Nov 2020 11:27:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Qian Cai <cai@redhat.com>, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: Re: [PATCH v4 10/19] sched: Fix migrate_disable() vs
 set_cpus_allowed_ptr()
Message-ID: <20201113102734.GE2628@hirez.programming.kicks-ass.net>
References: <20201023101158.088940906@infradead.org>
 <20201023102346.921768277@infradead.org>
 <8b62fd1ad1b18def27f18e2ee2df3ff5b36d0762.camel@redhat.com>
 <jhjd00ixz9z.mognet@arm.com>
 <13786aa5a5fc958708ef1182c885d1a574449d99.camel@redhat.com>
 <jhja6vmxthb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhja6vmxthb.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 07:31:12PM +0000, Valentin Schneider wrote:

> I think what is happening here is:
> 
>   affine_move_task()
>       // task_running() case
>       stop_one_cpu()
>       wait_for_completion(&pending->done);
> 
> and this is !PREEMPT, so the stopper can very well hit:
> 
>   migration_cpu_stop()
>     // Task moved between unlocks and scheduling the stopper
>     task_rq(p) != rq &&
>     // task_running() case
>     dest_cpu >= 0
> 
>     => no complete_all(), ever :(

Damn...

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 02076e6d3792..fad0a8e62aca 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1923,7 +1923,7 @@ static int migration_cpu_stop(void *data)
>  		else
>  			p->wake_cpu = dest_cpu;
>  
> -	} else if (dest_cpu < 0) {
> +	} else if (dest_cpu < 0 || pending) {
>  		/*
>  		 * This happens when we get migrated between migrate_enable()'s
>  		 * preempt_enable() and scheduling the stopper task. At that
> @@ -1933,6 +1933,17 @@ static int migration_cpu_stop(void *data)
>  		 * more likely.
>  		 */
>  
> +		/*
> +		 * The task moved before the stopper got to run. We're holding
> +		 * ->pi_lock, so the allowed mask is stable - if it got
> +		 * somewhere allowed, we're done.
> +		 */
> +		if (pending && cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
> +			p->migration_pending = NULL;
> +			complete = true;
> +			goto out;
> +		}
> +
>  		/*
>  		 * When this was migrate_enable() but we no longer have an
>  		 * @pending, a concurrent SCA 'fixed' things and we should be

Agreed, this is very clearly a missing case and the proposed solution
seems straight forward enough; but I'm struggling to convince my sleep
deprived brain we're actually complete now.

I'll continue staring at it a little more. Could you make it into a
proper patch?
