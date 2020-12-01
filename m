Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D572C9EF7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgLAKRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgLAKRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:17:37 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A4DC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 02:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XiOaRNcHFimAGdExnmO9Yv/eufez+zgifw/UuLZdECo=; b=QHAhKLWGjyuaBhEMoYVPP6HkR6
        581vee6lz31W+HhXDI3f2std8vtMAnnYtm0nSlu6NKt8S/fO8RU6B1iXouvf/INsQz8Ebl2/RNuD/
        BQxtB4FUP0f68kq2umauPK7H4ajtS8+0w5dHMlBxZ2ItwznEvFuTOi5yqC4txLg++ukSrKBebiwvk
        2wLwEb8vHrLVSsIUYE6bY1zVOJGC0LVAoWvaWrRiTWA4qYWuBpW+0/SCHusTUxFhwztjh78DujVJf
        /HFRVuhSkQUZVJctgIvJ3wIpEa0AkYgebFYQxRSTLR+U0pQj4lxNXGKsG2U0bnG+I7rdY57bJqArR
        7SQxsi8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk2i7-0000Cf-4O; Tue, 01 Dec 2020 10:16:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A023C305815;
        Tue,  1 Dec 2020 11:16:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E32A20298C8D; Tue,  1 Dec 2020 11:16:37 +0100 (CET)
Date:   Tue, 1 Dec 2020 11:16:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 3/3] membarrier: Propagate SYNC_CORE and RSEQ actions
 more carefully
Message-ID: <20201201101637.GU2414@hirez.programming.kicks-ass.net>
References: <cover.1606758530.git.luto@kernel.org>
 <5495e4c344dc09011ff57756c7e0a1330830eafc.1606758530.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5495e4c344dc09011ff57756c7e0a1330830eafc.1606758530.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 09:50:35AM -0800, Andy Lutomirski wrote:
> membarrier() carefully propagates SYNC_CORE and RSEQ actions to all
> other CPUs, but there are two issues.
> 
>  - membarrier() does not sync_core() or rseq_preempt() the calling
>    CPU.  Aside from the logic being mind-bending, this also means
>    that it may not be safe to modify user code through an alias,
>    call membarrier(), and then jump to a different executable alias
>    of the same code.

I always understood this to be on purpose. The calling CPU can fix up
itself just fine. The pain point is fixing up the other CPUs, and that's
where membarrier() helps.

That said, I don't mind including self, these aren't fast calls by any
means.

>  - membarrier() does not explicitly sync_core() remote CPUs either;
>    instead, it relies on the assumption that an IPI will result in a
>    core sync.  On x86, I think this may be true in practice, but
>    it's not architecturally reliable.  In particular, the SDM and
>    APM do not appear to guarantee that interrupt delivery is
>    serializing.

Right, I don't think we rely on that, we do rely on interrupt delivery
providing order though -- as per the previous email.

>    On a preemptible kernel, IPI return can schedule,
>    thereby switching to another task in the same mm that was
>    sleeping in a syscall.  The new task could then SYSRET back to
>    usermode without ever executing IRET.

This; I think we all overlooked this scenario.

> This patch simplifies the code to treat the calling CPU just like
> all other CPUs, and explicitly sync_core() on all target CPUs.  This
> eliminates the need for the smp_mb() at the end of the function
> except in the special case of a targeted remote membarrier().  This
> patch updates that code and the comments accordingly.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

> @@ -228,25 +258,33 @@ static int membarrier_private_expedited(int flags, int cpu_id)
>  		rcu_read_unlock();
>  	}
>  
> -	preempt_disable();
> -	if (cpu_id >= 0)
> -		smp_call_function_single(cpu_id, ipi_func, NULL, 1);
> -	else
> -		smp_call_function_many(tmpmask, ipi_func, NULL, 1);
> -	preempt_enable();
> +	if (cpu_id >= 0) {
> +		int cpu = get_cpu();
> +
> +		if (cpu_id == cpu) {
> +			ipi_func(NULL);
> +		} else {
> +			smp_call_function_single(cpu_id, ipi_func, NULL, 1);
> +			/*
> +			 * This is analogous to the smp_mb() at the beginning
> +			 * of the function -- exit from a system call is not a
> +			 * barrier.  We only need this if we're targeting a
> +			 * specific remote CPU, though -- otherwise ipi_func()
> +			 * would serves the same purpose.
> +			 */
> +			smp_mb();

smp_call_function_single(.wait=1) already orders against completion of
the IPI. Do we really need more?

> +		}
> +
> +		put_cpu();
> +	} else {
> +		on_each_cpu_mask(tmpmask, ipi_func, NULL, true);
> +	}
>  
>  out:
>  	if (cpu_id < 0)
>  		free_cpumask_var(tmpmask);
>  	cpus_read_unlock();
>  
> -	/*
> -	 * Memory barrier on the caller thread _after_ we finished
> -	 * waiting for the last IPI. Matches memory barriers around
> -	 * rq->curr modification in scheduler.
> -	 */
> -	smp_mb();	/* exit from system call is not a mb */
> -
>  	return 0;
>  }
>  
> -- 
> 2.28.0
> 
