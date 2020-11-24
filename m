Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0C22C2C63
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390162AbgKXQKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgKXQKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:10:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CC4C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6fQQBJMyU7rQN8STcobWFnRbpaAgVHAouxn6yUHDYi0=; b=LIG6ysINJ18Q2FPQ0q16mDexVV
        guBsMK0qDtf8Us1FenqjkX7906rVSoVBa6jd5PMfhnEW1jX+whnQfgoctrAuTM/Ma1F3/+LW1pwcz
        crqlwTletQnZI1kz6tarYbDCHx/iUUKUowkt6OSv5qns9e4PCqxJ74RA6QyeKabSWMXcgez6JkDZN
        jCfGmmGahmpjgO4URVHMnksj+s9kMrWVZMO/igsub+gU2Ul4lYXenT6VD4YS7FnyJbxJRXuGND8vi
        SWWsp54O1MwmVJ+S3u7QH9gu9bXwcmitsDmNi4mkI98qac43MdwreRrnsFK9gC+KUDvDTcCL42i9V
        mFEkDLrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khasQ-0001OF-52; Tue, 24 Nov 2020 16:09:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B50D53062EA;
        Tue, 24 Nov 2020 17:09:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 975F5200D4F00; Tue, 24 Nov 2020 17:09:06 +0100 (CET)
Date:   Tue, 24 Nov 2020 17:09:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
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
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH -tip 18/32] kernel/entry: Add support for core-wide
 protection of kernel-mode
Message-ID: <20201124160906.GA3021@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-19-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-19-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:48PM -0500, Joel Fernandes (Google) wrote:
> Core-scheduling prevents hyperthreads in usermode from attacking each
> other, but it does not do anything about one of the hyperthreads
> entering the kernel for any reason. This leaves the door open for MDS
> and L1TF attacks with concurrent execution sequences between
> hyperthreads.
> 
> This patch therefore adds support for protecting all syscall and IRQ
> kernel mode entries. Care is taken to track the outermost usermode exit
> and entry using per-cpu counters. In cases where one of the hyperthreads
> enter the kernel, no additional IPIs are sent. Further, IPIs are avoided
> when not needed - example: idle and non-cookie HTs do not need to be
> forced into kernel mode.
> 
> More information about attacks:
> For MDS, it is possible for syscalls, IRQ and softirq handlers to leak
> data to either host or guest attackers. For L1TF, it is possible to leak
> to guest attackers. There is no possible mitigation involving flushing
> of buffers to avoid this since the execution of attacker and victims
> happen concurrently on 2 or more HTs.

Oh gawd; this is horrible...


> +bool sched_core_wait_till_safe(unsigned long ti_check)
> +{
> +	bool restart = false;
> +	struct rq *rq;
> +	int cpu;
> +
> +	/* We clear the thread flag only at the end, so no need to check for it. */
> +	ti_check &= ~_TIF_UNSAFE_RET;
> +
> +	cpu = smp_processor_id();
> +	rq = cpu_rq(cpu);
> +
> +	if (!sched_core_enabled(rq))
> +		goto ret;
> +
> +	/* Down grade to allow interrupts to prevent stop_machine lockups.. */
> +	preempt_disable();
> +	local_irq_enable();
> +
> +	/*
> +	 * Wait till the core of this HT is not in an unsafe state.
> +	 *
> +	 * Pair with raw_spin_lock/unlock() in sched_core_unsafe_enter/exit().
> +	 */
> +	while (smp_load_acquire(&rq->core->core_unsafe_nest) > 0) {
> +		cpu_relax();
> +		if (READ_ONCE(current_thread_info()->flags) & ti_check) {
> +			restart = true;
> +			break;
> +		}
> +	}

What's that ACQUIRE for?

> +
> +	/* Upgrade it back to the expectations of entry code. */
> +	local_irq_disable();
> +	preempt_enable();
> +
> +ret:
> +	if (!restart)
> +		clear_tsk_thread_flag(current, TIF_UNSAFE_RET);
> +
> +	return restart;
> +}

So if TIF_NEED_RESCHED gets set, we'll break out and reschedule, cute.

> +void sched_core_unsafe_enter(void)
> +{
> +	const struct cpumask *smt_mask;
> +	unsigned long flags;
> +	struct rq *rq;
> +	int i, cpu;
> +
> +	if (!static_branch_likely(&sched_core_protect_kernel))
> +		return;
> +
> +	local_irq_save(flags);
> +	cpu = smp_processor_id();
> +	rq = cpu_rq(cpu);
> +	if (!sched_core_enabled(rq))
> +		goto ret;
> +
> +	/* Ensure that on return to user/guest, we check whether to wait. */
> +	if (current->core_cookie)
> +		set_tsk_thread_flag(current, TIF_UNSAFE_RET);
> +
> +	/* Count unsafe_enter() calls received without unsafe_exit() on this CPU. */
> +	rq->core_this_unsafe_nest++;
> +
> +	/*
> +	 * Should not nest: enter() should only pair with exit(). Both are done
> +	 * during the first entry into kernel and the last exit from kernel.
> +	 * Nested kernel entries (such as nested interrupts) will only trigger
> +	 * enter() and exit() on the outer most kernel entry and exit.
> +	 */
> +	if (WARN_ON_ONCE(rq->core_this_unsafe_nest != 1))
> +		goto ret;
> +
> +	raw_spin_lock(rq_lockp(rq));
> +	smt_mask = cpu_smt_mask(cpu);
> +
> +	/*
> +	 * Contribute this CPU's unsafe_enter() to the core-wide unsafe_enter()
> +	 * count.  The raw_spin_unlock() release semantics pairs with the nest
> +	 * counter's smp_load_acquire() in sched_core_wait_till_safe().
> +	 */
> +	WRITE_ONCE(rq->core->core_unsafe_nest, rq->core->core_unsafe_nest + 1);
> +
> +	if (WARN_ON_ONCE(rq->core->core_unsafe_nest == UINT_MAX))
> +		goto unlock;
> +
> +	if (irq_work_is_busy(&rq->core_irq_work)) {
> +		/*
> +		 * Do nothing more since we are in an IPI sent from another
> +		 * sibling to enforce safety. That sibling would have sent IPIs
> +		 * to all of the HTs.
> +		 */
> +		goto unlock;
> +	}
> +
> +	/*
> +	 * If we are not the first ones on the core to enter core-wide unsafe
> +	 * state, do nothing.
> +	 */
> +	if (rq->core->core_unsafe_nest > 1)
> +		goto unlock;
> +
> +	/* Do nothing more if the core is not tagged. */
> +	if (!rq->core->core_cookie)
> +		goto unlock;
> +
> +	for_each_cpu(i, smt_mask) {
> +		struct rq *srq = cpu_rq(i);
> +
> +		if (i == cpu || cpu_is_offline(i))
> +			continue;
> +
> +		if (!srq->curr->mm || is_task_rq_idle(srq->curr))
> +			continue;
> +
> +		/* Skip if HT is not running a tagged task. */
> +		if (!srq->curr->core_cookie && !srq->core_pick)
> +			continue;
> +
> +		/*
> +		 * Force sibling into the kernel by IPI. If work was already
> +		 * pending, no new IPIs are sent. This is Ok since the receiver
> +		 * would already be in the kernel, or on its way to it.
> +		 */
> +		irq_work_queue_on(&srq->core_irq_work, i);

Why irq_work though? Why not smp_send_reschedule(i)?

> +	}
> +unlock:
> +	raw_spin_unlock(rq_lockp(rq));
> +ret:
> +	local_irq_restore(flags);
> +}
