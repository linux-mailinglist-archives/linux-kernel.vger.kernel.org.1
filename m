Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5215A2C2F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404199AbgKXRwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404192AbgKXRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:52:44 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0430DC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:52:44 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q22so21590123qkq.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fVbCOtcfm0yidH7c72tQnMGxgzTTUDg2VURqxrKu36k=;
        b=CeUHYw3snSnDwqzXiT8zeaqWGMR7lnmj1Y8wDNmpmxQoiMKBp6hXY/pxiRSUMK6wDN
         4HZ+xtPcZNGwxGGJH9Y6LeTEBEmlWZ0FabR/hseHgXW3fOQNFmS2MJFPv+DJO9Zq114q
         rf/23ZNL+9pQocwvBQnWjgc+foBqH2trLf8HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fVbCOtcfm0yidH7c72tQnMGxgzTTUDg2VURqxrKu36k=;
        b=IaZZ9SUx6SBYXd/Im/VSjdvbz2q9DWccBc+b5mZ5PSCBgnnGcTAdhT+FnrfH5UH83Z
         M8ZorSf5aNFtyV9iAQ6guVPzsR6LOLpIosuqehFvuEUV9s+6g4yxLFOov5wT/By7wiIt
         laVpxGCHdh6XAvWP6L2VDRlrPJzCXU+i+XFp42Qr98cbC65lKFS9O3WfT5SkJnMp3EOc
         BIweA33AqgS5B6tVayHKeIcPZy1Ki/62IMcK8mn+dxrs9BjpwfKMFGVZMkZ+i9sJlBlC
         01nWKPvcpJFsXP2hVyq6iIR3O47cgnDQvvBHohsy8irpZeak22QqMx8XL5kUky0v0xgY
         FwOw==
X-Gm-Message-State: AOAM532V84+l+6LI34spz6RQaUYYkaTfIusvMRdXT6NPyFP9y6X5gMvZ
        vGz9TVnMe0otADsDoR8KEUZv6w==
X-Google-Smtp-Source: ABdhPJxYThXnhs3sd++m8gDRN/ByXzPPMPMwpYoxJ3lNgSqGqxxrY4lEj3JZ3ftl+0NprbPZd46AMw==
X-Received: by 2002:a37:cd1:: with SMTP id 200mr5945180qkm.55.1606240363114;
        Tue, 24 Nov 2020 09:52:43 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id s7sm13221508qkm.124.2020.11.24.09.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:52:42 -0800 (PST)
Date:   Tue, 24 Nov 2020 12:52:42 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20201124175242.GE1021337@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-19-joel@joelfernandes.org>
 <20201124160906.GA3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124160906.GA3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Nov 24, 2020 at 05:09:06PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 06:19:48PM -0500, Joel Fernandes (Google) wrote:
> > Core-scheduling prevents hyperthreads in usermode from attacking each
> > other, but it does not do anything about one of the hyperthreads
> > entering the kernel for any reason. This leaves the door open for MDS
> > and L1TF attacks with concurrent execution sequences between
> > hyperthreads.
> > 
> > This patch therefore adds support for protecting all syscall and IRQ
> > kernel mode entries. Care is taken to track the outermost usermode exit
> > and entry using per-cpu counters. In cases where one of the hyperthreads
> > enter the kernel, no additional IPIs are sent. Further, IPIs are avoided
> > when not needed - example: idle and non-cookie HTs do not need to be
> > forced into kernel mode.
> > 
> > More information about attacks:
> > For MDS, it is possible for syscalls, IRQ and softirq handlers to leak
> > data to either host or guest attackers. For L1TF, it is possible to leak
> > to guest attackers. There is no possible mitigation involving flushing
> > of buffers to avoid this since the execution of attacker and victims
> > happen concurrently on 2 or more HTs.
> 
> Oh gawd; this is horrible...

Yeah, its the same issue we discussed earlier this year :)

> > +bool sched_core_wait_till_safe(unsigned long ti_check)
> > +{
> > +	bool restart = false;
> > +	struct rq *rq;
> > +	int cpu;
> > +
> > +	/* We clear the thread flag only at the end, so no need to check for it. */
> > +	ti_check &= ~_TIF_UNSAFE_RET;
> > +
> > +	cpu = smp_processor_id();
> > +	rq = cpu_rq(cpu);
> > +
> > +	if (!sched_core_enabled(rq))
> > +		goto ret;
> > +
> > +	/* Down grade to allow interrupts to prevent stop_machine lockups.. */
> > +	preempt_disable();
> > +	local_irq_enable();
> > +
> > +	/*
> > +	 * Wait till the core of this HT is not in an unsafe state.
> > +	 *
> > +	 * Pair with raw_spin_lock/unlock() in sched_core_unsafe_enter/exit().
> > +	 */
> > +	while (smp_load_acquire(&rq->core->core_unsafe_nest) > 0) {
> > +		cpu_relax();
> > +		if (READ_ONCE(current_thread_info()->flags) & ti_check) {
> > +			restart = true;
> > +			break;
> > +		}
> > +	}
> 
> What's that ACQUIRE for?

I was concerned about something like below for weakly-ordered arch:

Kernel				Attacker
------                          --------
write unsafe=1

kernel code does stores		while (unsafe == 1); (ACQUIRE)
   ^                             ^
   | needs to be ordered	 | needs to be ordered
   v                             v
write unsafe=0 (RELEASE)        Attacker code.


Here, I want the access made by kernel code to be ordered WRT the write to
the unsafe nesting counter variable, so that the attacker code does not see
those accesses later.

It could be argued its a theoretical concern, but I wanted to play it safe. In
particular, the existing uarch buffer flushing before entering the Attacker
code might make it sufficiently impossible for Attacker to do anything bad
even without the additional memory barriers.

> > +
> > +	/* Upgrade it back to the expectations of entry code. */
> > +	local_irq_disable();
> > +	preempt_enable();
> > +
> > +ret:
> > +	if (!restart)
> > +		clear_tsk_thread_flag(current, TIF_UNSAFE_RET);
> > +
> > +	return restart;
> > +}
> 
> So if TIF_NEED_RESCHED gets set, we'll break out and reschedule, cute.

Thanks.

> > +	/* Do nothing more if the core is not tagged. */
> > +	if (!rq->core->core_cookie)
> > +		goto unlock;
> > +
> > +	for_each_cpu(i, smt_mask) {
> > +		struct rq *srq = cpu_rq(i);
> > +
> > +		if (i == cpu || cpu_is_offline(i))
> > +			continue;
> > +
> > +		if (!srq->curr->mm || is_task_rq_idle(srq->curr))
> > +			continue;
> > +
> > +		/* Skip if HT is not running a tagged task. */
> > +		if (!srq->curr->core_cookie && !srq->core_pick)
> > +			continue;
> > +
> > +		/*
> > +		 * Force sibling into the kernel by IPI. If work was already
> > +		 * pending, no new IPIs are sent. This is Ok since the receiver
> > +		 * would already be in the kernel, or on its way to it.
> > +		 */
> > +		irq_work_queue_on(&srq->core_irq_work, i);
> 
> Why irq_work though? Why not smp_send_reschedule(i)?

I tried this approach. The main issue is sending IPIs if a previous IPI was
already sent. I needed some mechanism (shared variables to detect this)
so that an IPI would not be sent if one was just sent.

With irq_work, I get the irq_work_is_busy() which helps with exactly that.
With other approaches I tried, I ran into issues with CSD locking and it
seems irq_work implements the CSD locking the way I wanted to. So to avoid
reinventing the wheel, I stuck to irq_work and it worked well.

thanks,

 - Joel

