Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F4F2873F3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgJHMXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgJHMXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:23:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAD2C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 05:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ec6MzPHCDPznfeukNQTZmPPb/KNmSc4YPZZIPYevzu8=; b=AYgWWGSafxpmDe5C2LIZfAWh57
        9vbftV0Gfx8+RekIQZFOBkBOYvsyZEjDdLrOMoU36WEG+vMrGzGtxN00L9zgS8YhVIXmkm3zifKp3
        LLf0wJ9RPIIbbAziDU2No9l/KYHd5rmdWUm50Ah+Xh6p6P62Pv2Z2TBC5t0V96x2kKLctLTaxKf2W
        rbRqom6MG1kYHIC4Vxb3uDMBTyParLrPrqj9nBqjSbCaMSD4Br83X5l4/yw6c8QshoHoeKEzDGdHM
        EdTudQNMpzO4j7UdaGyb0ehiwtnUzrLSLZAvG09uTZxcpnShscqCUSd9rS1IMgtbtkCdw6GFh4mAq
        4nM4xZWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQUwm-0004sh-Ra; Thu, 08 Oct 2020 12:23:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B8E19301A42;
        Thu,  8 Oct 2020 14:22:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A54912B262238; Thu,  8 Oct 2020 14:22:56 +0200 (CEST)
Date:   Thu, 8 Oct 2020 14:22:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201008122256.GW2628@hirez.programming.kicks-ass.net>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007180229.724302019@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 03:01:52PM -0300, Marcelo Tosatti wrote:
> When adding a tick dependency to a task, its necessary to
> wakeup the CPU where the task resides to reevaluate tick
> dependencies on that CPU.
> 
> However the current code wakes up all nohz_full CPUs, which 
> is unnecessary.
> 
> Switch to waking up a single CPU, by using ordering of writes
> to task->cpu and task->tick_dep_mask.
> 
> From: Frederic Weisbecker <frederic@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> Index: linux-2.6/kernel/time/tick-sched.c
> ===================================================================
> --- linux-2.6.orig/kernel/time/tick-sched.c
> +++ linux-2.6/kernel/time/tick-sched.c
> @@ -274,6 +274,31 @@ void tick_nohz_full_kick_cpu(int cpu)
>  	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
>  }
>  
> +static void tick_nohz_kick_task(struct task_struct *tsk)
> +{
> +	int cpu = task_cpu(tsk);
> +
> +	/*
> +	 * If the task concurrently migrates to another cpu,
> +	 * we guarantee it sees the new tick dependency upon
> +	 * schedule.
> +	 *
> +	 *
> +	 * set_task_cpu(p, cpu);
> +	 *   STORE p->cpu = @cpu
> +	 * __schedule() (switch to task 'p')
> +	 *   LOCK rq->lock
> +	 *   smp_mb__after_spin_lock()          STORE p->tick_dep_mask
> +	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
> +	 *      LOAD p->tick_dep_mask           LOAD p->cpu
> +	 */
> +
> +	preempt_disable();
> +	if (cpu_online(cpu))
> +		tick_nohz_full_kick_cpu(cpu);
> +	preempt_enable();
> +}

So we need to kick the CPU unconditionally, or only when the task is
actually running? AFAICT we only care about current->tick_dep_mask.
