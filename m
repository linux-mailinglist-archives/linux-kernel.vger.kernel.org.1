Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4959D2A9B10
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 18:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgKFRnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 12:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFRnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:43:51 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C78C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 09:43:51 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id v11so942732qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 09:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G13a6E8nEDbkKq8Nf9i9ZmbN0PpTgxyCihonYJzmGe4=;
        b=JkLk1X0pnt2h/91aHRya1FyowgB5EXTK7JNyyeRjp7UTNeEaEYbGBT9jP/8x9nS9Kz
         o0F6gdQ6cG/S90o4YxX93HeqAuEEFWkMCDWbpvd3SlQdpatzzYu4FjWmI9AAarPhLjql
         4A73+UYyuGrXS1lH5ITM9ynAxmw2cTJB6WogE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G13a6E8nEDbkKq8Nf9i9ZmbN0PpTgxyCihonYJzmGe4=;
        b=l3l9KoRHksmRmaHHpTQCtHZN9ZdzDQqn56a8S7HQFqIGR7BAnfygSxggVC+07mi1BT
         6+Vk6oIs/OKAIDzgTlPpqpamVdg2fZfDyLTRSpmNAnf9LGrLlchUVaFpWuhZouNZ6lNo
         swC56nJcR0pF/kfGL+4bpPHBVtAnu+3PZCngxGPWclj7wBbMvMoDvMqQE6usbN9LAK/J
         8rJBX8JT/er5Ba8yaBFEXylo0aLFwwn7oLgrJyDoNtehyF90ljDxjddt7ovStJEtoo29
         uRIrWDxWxB1sUNo0jTdp5braez40VSRAGbyReRls/mXpVcUOBnjPTessQXqfQYSdkZ1C
         MinQ==
X-Gm-Message-State: AOAM530/LtxSy3wfuhlH+CIlLLd6j5Q+acdTAMoJxvcC1/H4KNozS89S
        IUIfoOP68g+BSKbls4vhZ7WLkA==
X-Google-Smtp-Source: ABdhPJzZkjIGFHvjmjyxFd+nk8QXP/1O/ys5n8yDg4qDP9zXnJcP2I2AWYT9Z46YEem8l0cG133DXw==
X-Received: by 2002:ac8:4897:: with SMTP id i23mr2444598qtq.211.1604684630476;
        Fri, 06 Nov 2020 09:43:50 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x4sm984967qtm.48.2020.11.06.09.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 09:43:49 -0800 (PST)
Date:   Fri, 6 Nov 2020 12:43:49 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
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
        benbjiang@tencent.com, James.Bottomley@hansenpartnership.com,
        OWeisse@umich.edu, Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v8 -tip 13/26] kernel/entry: Add support for core-wide
 protection of kernel-mode
Message-ID: <20201106174349.GA2845264@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-14-joel@joelfernandes.org>
 <60cfc619-1521-814d-8894-df9fc61d615c@oracle.com>
 <20201103012002.GA673080@google.com>
 <ceaa7e82-250b-b462-1228-10e1cd22dd46@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceaa7e82-250b-b462-1228-10e1cd22dd46@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 05:57:21PM +0100, Alexandre Chartre wrote:
> 
> 
> On 11/3/20 2:20 AM, Joel Fernandes wrote:
> > Hi Alexandre,
> > 
> > Sorry for late reply as I was working on the snapshotting patch...
> > 
> > On Fri, Oct 30, 2020 at 11:29:26AM +0100, Alexandre Chartre wrote:
> > > 
> > > On 10/20/20 3:43 AM, Joel Fernandes (Google) wrote:
> > > > Core-scheduling prevents hyperthreads in usermode from attacking each
> > > > other, but it does not do anything about one of the hyperthreads
> > > > entering the kernel for any reason. This leaves the door open for MDS
> > > > and L1TF attacks with concurrent execution sequences between
> > > > hyperthreads.
> > > > 
> > > > This patch therefore adds support for protecting all syscall and IRQ
> > > > kernel mode entries. Care is taken to track the outermost usermode exit
> > > > and entry using per-cpu counters. In cases where one of the hyperthreads
> > > > enter the kernel, no additional IPIs are sent. Further, IPIs are avoided
> > > > when not needed - example: idle and non-cookie HTs do not need to be
> > > > forced into kernel mode.
> > > 
> > > Hi Joel,
> > > 
> > > In order to protect syscall/IRQ kernel mode entries, shouldn't we have a
> > > call to sched_core_unsafe_enter() in the syscall/IRQ entry code? I don't
> > > see such a call. Am I missing something?
> > 
> > Yes, this is known bug and fixed in v9 which I'll post soon. Meanwhile
> > updated patch is appended below:
> 
> [..]
> 
> > > > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> > > > index 0a1e20f8d4e8..c8dc6b1b1f40 100644
> > > > --- a/kernel/entry/common.c
> > > > +++ b/kernel/entry/common.c
> > > > @@ -137,6 +137,26 @@ static __always_inline void exit_to_user_mode(void)
> > > >    /* Workaround to allow gradual conversion of architecture code */
> > > >    void __weak arch_do_signal(struct pt_regs *regs) { }
> > > > +unsigned long exit_to_user_get_work(void)
> > > > +{
> > > > +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> > > > +
> > > > +	if (IS_ENABLED(CONFIG_SCHED_CORE) && !sched_core_kernel_protected())
> > > > +		return ti_work;
> > > > +
> > > > +#ifdef CONFIG_SCHED_CORE
> > > > +	ti_work &= EXIT_TO_USER_MODE_WORK;
> > > > +	if ((ti_work & _TIF_UNSAFE_RET) == ti_work) {
> > > > +		sched_core_unsafe_exit();
> > > > +		if (sched_core_wait_till_safe(EXIT_TO_USER_MODE_WORK)) {
> > > 
> > > If we call sched_core_unsafe_exit() before sched_core_wait_till_safe() then we
> > > expose ourself during the entire wait period in sched_core_wait_till_safe(). It
> > > would be better to call sched_core_unsafe_exit() once we know for sure we are
> > > going to exit.
> > 
> > The way the algorithm works right now, it requires the current task to get
> > out of the unsafe state while waiting otherwise it will lockup. Note that we
> > wait with interrupts enabled so new interrupts could come while waiting.
> > 
> > TBH this code is very tricky to get right and it took long time to get it
> > working properly. For now I am content with the way it works. We can improve
> > further incrementally on it in the future.
> > 
> 
> I am concerned this leaves a lot of windows opened (even with the updated patch)
> where the system remains exposed. There are 3 obvious windows:
> 
> - after switching to the kernel page-table and until enter_from_user_mode() is called
> - while waiting for other cpus
> - after leaving exit_to_user_mode_loop() and until switching back to the user page-table
> 
> Also on syscall/interrupt entry, sched_core_unsafe_enter() is called (in the
> updated patch) and this sends an IPI to other CPUs but it doesn't wait for
> other CPUs to effectively switch to the kernel page-table. It also seems like
> the case where the CPU is interrupted by a NMI is not handled.

TBH, we discussed on list before that there may not be much value in closing
the above mentioned windows. We already knew there are a few windows open
like that. Thomas Glexiner told us that the solution does not need to be 100%
as long as it closes most windows and is performant -- the important thing
being to disrupt the attacker than making it 100% attack proof. And keeping
the code simple.

> I know the code is tricky, and I am working on something similar for ASI (ASI
> lockdown) where I am addressing all these cases (this seems to work).

Ok.

> > Let me know if I may add your Reviewed-by tag for this patch, if there are no
> > other comments, and I appreciate it. Appended the updated patch below.
> > 
> 
> I haven't effectively reviewed the code yet. Also I wonder if the work I am doing
> with ASI for synchronizing sibling cpus (i.e. the ASI lockdown) and the integration
> with PTI could provide what you need. Basically each process has an ASI and the
> ASI lockdown ensure that sibling cpus are also running with a trusted ASI. If
> the process/ASI is interrupted (e.g. on interrupt/exception/NMI) then it forces
> sibling cpus to also interrupt ASI. The sibling cpus synchronization occurs when
> switching the page-tables (between user and kernel) so there's no exposure window.

Maybe. But are you doing everything this patch does, when you enter ASI lock
down?
Basically, we want to only send IPIs if needed and we track the "core wide"
entry into the kernel to make sure we do the sligthly higher overhead things
once per "core wide" entry and exit. For some pictures, check these slides
from slide 15:
https://docs.google.com/presentation/d/1VzeQo3AyGTN35DJ3LKoPWBfiZHZJiF8q0NrX9eVYG70/edit#slide=id.g91cff3980b_0_7

As for switching page tables, I am not sure if that is all that's needed to
close the windows you mentioned, because MDS attacks are independent of page
table entries, they leak the uarch buffers. So you really have to isolate
things in the time domain as this patch does.

We discussed with Thomas and Dario in previous list emails that maybe this
patch can be used as a subset of ASI work as a "utility", the implement the
stunning.

> Let me have a closer look.

Sure, thanks.

 - Joel

> alex.
> 
> 
> > ---8<-----------------------
> > 
> >  From b2835a587a28405ffdf8fc801e798129a014a8c8 Mon Sep 17 00:00:00 2001
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Date: Mon, 27 Jul 2020 17:56:14 -0400
> > Subject: [PATCH] kernel/entry: Add support for core-wide protection of
> >   kernel-mode
> > 
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
> > 
> > Cc: Julien Desfossez <jdesfossez@digitalocean.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: Aaron Lu <aaron.lwe@gmail.com>
> > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > Cc: Tim Chen <tim.c.chen@intel.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Co-developed-by: Vineeth Pillai <viremana@linux.microsoft.com>
> > Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> > Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >   .../admin-guide/kernel-parameters.txt         |   9 +
> >   include/linux/entry-common.h                  |   6 +-
> >   include/linux/sched.h                         |  12 +
> >   kernel/entry/common.c                         |  28 ++-
> >   kernel/sched/core.c                           | 230 ++++++++++++++++++
> >   kernel/sched/sched.h                          |   3 +
> >   6 files changed, 285 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 3236427e2215..a338d5d64c3d 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4678,6 +4678,15 @@
> >   	sbni=		[NET] Granch SBNI12 leased line adapter
> > +	sched_core_protect_kernel=
> > +			[SCHED_CORE] Pause SMT siblings of a core running in
> > +			user mode, if at least one of the siblings of the core
> > +			is running in kernel mode. This is to guarantee that
> > +			kernel data is not leaked to tasks which are not trusted
> > +			by the kernel. A value of 0 disables protection, 1
> > +			enables protection. The default is 1. Note that protection
> > +			depends on the arch defining the _TIF_UNSAFE_RET flag.
> > +
> >   	sched_debug	[KNL] Enables verbose scheduler debug messages.
> >   	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
> > diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> > index 474f29638d2c..62278c5b3b5f 100644
> > --- a/include/linux/entry-common.h
> > +++ b/include/linux/entry-common.h
> > @@ -33,6 +33,10 @@
> >   # define _TIF_PATCH_PENDING		(0)
> >   #endif
> > +#ifndef _TIF_UNSAFE_RET
> > +# define _TIF_UNSAFE_RET		(0)
> > +#endif
> > +
> >   #ifndef _TIF_UPROBE
> >   # define _TIF_UPROBE			(0)
> >   #endif
> > @@ -69,7 +73,7 @@
> >   #define EXIT_TO_USER_MODE_WORK						\
> >   	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
> > -	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING |			\
> > +	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_UNSAFE_RET |	\
> >   	 ARCH_EXIT_TO_USER_MODE_WORK)
> >   /**
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index d38e904dd603..fe6f225bfbf9 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2071,4 +2071,16 @@ int sched_trace_rq_nr_running(struct rq *rq);
> >   const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
> > +#ifdef CONFIG_SCHED_CORE
> > +void sched_core_unsafe_enter(void);
> > +void sched_core_unsafe_exit(void);
> > +bool sched_core_wait_till_safe(unsigned long ti_check);
> > +bool sched_core_kernel_protected(void);
> > +#else
> > +#define sched_core_unsafe_enter(ignore) do { } while (0)
> > +#define sched_core_unsafe_exit(ignore) do { } while (0)
> > +#define sched_core_wait_till_safe(ignore) do { } while (0)
> > +#define sched_core_kernel_protected(ignore) do { } while (0)
> > +#endif
> > +
> >   #endif
> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> > index 0a1e20f8d4e8..a18ed60cedea 100644
> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -28,6 +28,8 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
> >   	instrumentation_begin();
> >   	trace_hardirqs_off_finish();
> > +	if (_TIF_UNSAFE_RET) /* Kernel protection depends on arch defining the flag. */
> > +		sched_core_unsafe_enter();
> >   	instrumentation_end();
> >   }
> > @@ -137,6 +139,27 @@ static __always_inline void exit_to_user_mode(void)
> >   /* Workaround to allow gradual conversion of architecture code */
> >   void __weak arch_do_signal(struct pt_regs *regs) { }
> > +unsigned long exit_to_user_get_work(void)
> > +{
> > +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> > +
> > +	if ((IS_ENABLED(CONFIG_SCHED_CORE) && !sched_core_kernel_protected())
> > +	    || !_TIF_UNSAFE_RET)
> > +		return ti_work;
> > +
> > +#ifdef CONFIG_SCHED_CORE
> > +	ti_work &= EXIT_TO_USER_MODE_WORK;
> > +	if ((ti_work & _TIF_UNSAFE_RET) == ti_work) {
> > +		sched_core_unsafe_exit();
> > +		if (sched_core_wait_till_safe(EXIT_TO_USER_MODE_WORK)) {
> > +			sched_core_unsafe_enter(); /* not exiting to user yet. */
> > +		}
> > +	}
> > +
> > +	return READ_ONCE(current_thread_info()->flags);
> > +#endif
> > +}
> > +
> >   static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> >   					    unsigned long ti_work)
> >   {
> > @@ -175,7 +198,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> >   		 * enabled above.
> >   		 */
> >   		local_irq_disable_exit_to_user();
> > -		ti_work = READ_ONCE(current_thread_info()->flags);
> > +		ti_work = exit_to_user_get_work();
> >   	}
> >   	/* Return the latest work state for arch_exit_to_user_mode() */
> > @@ -184,9 +207,10 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> >   static void exit_to_user_mode_prepare(struct pt_regs *regs)
> >   {
> > -	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> > +	unsigned long ti_work;
> >   	lockdep_assert_irqs_disabled();
> > +	ti_work = exit_to_user_get_work();
> >   	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
> >   		ti_work = exit_to_user_mode_loop(regs, ti_work);
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index e05728bdb18c..bd206708fac2 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -76,6 +76,27 @@ __read_mostly int scheduler_running;
> >   #ifdef CONFIG_SCHED_CORE
> > +DEFINE_STATIC_KEY_TRUE(sched_core_protect_kernel);
> > +static int __init set_sched_core_protect_kernel(char *str)
> > +{
> > +	unsigned long val = 0;
> > +
> > +	if (!str)
> > +		return 0;
> > +
> > +	if (!kstrtoul(str, 0, &val) && !val)
> > +		static_branch_disable(&sched_core_protect_kernel);
> > +
> > +	return 1;
> > +}
> > +__setup("sched_core_protect_kernel=", set_sched_core_protect_kernel);
> > +
> > +/* Is the kernel protected by core scheduling? */
> > +bool sched_core_kernel_protected(void)
> > +{
> > +	return static_branch_likely(&sched_core_protect_kernel);
> > +}
> > +
> >   DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
> >   /* kernel prio, less is more */
> > @@ -4596,6 +4617,214 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
> >   	return a->core_cookie == b->core_cookie;
> >   }
> > +/*
> > + * Handler to attempt to enter kernel. It does nothing because the exit to
> > + * usermode or guest mode will do the actual work (of waiting if needed).
> > + */
> > +static void sched_core_irq_work(struct irq_work *work)
> > +{
> > +	return;
> > +}
> > +
> > +static inline void init_sched_core_irq_work(struct rq *rq)
> > +{
> > +	init_irq_work(&rq->core_irq_work, sched_core_irq_work);
> > +}
> > +
> > +/*
> > + * sched_core_wait_till_safe - Pause the caller's hyperthread until the core
> > + * exits the core-wide unsafe state. Obviously the CPU calling this function
> > + * should not be responsible for the core being in the core-wide unsafe state
> > + * otherwise it will deadlock.
> > + *
> > + * @ti_check: We spin here with IRQ enabled and preempt disabled. Break out of
> > + *            the loop if TIF flags are set and notify caller about it.
> > + *
> > + * IRQs should be disabled.
> > + */
> > +bool sched_core_wait_till_safe(unsigned long ti_check)
> > +{
> > +	bool restart = false;
> > +	struct rq *rq;
> > +	int cpu;
> > +
> > +	/* We clear the thread flag only at the end, so need to check for it. */
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
> > +	 * Pair with smp_store_release() in sched_core_unsafe_exit().
> > +	 */
> > +	while (smp_load_acquire(&rq->core->core_unsafe_nest) > 0) {
> > +		cpu_relax();
> > +		if (READ_ONCE(current_thread_info()->flags) & ti_check) {
> > +			restart = true;
> > +			break;
> > +		}
> > +	}
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
> > +
> > +/*
> > + * Enter the core-wide IRQ state. Sibling will be paused if it is running
> > + * 'untrusted' code, until sched_core_unsafe_exit() is called. Every attempt to
> > + * avoid sending useless IPIs is made. Must be called only from hard IRQ
> > + * context.
> > + */
> > +void sched_core_unsafe_enter(void)
> > +{
> > +	const struct cpumask *smt_mask;
> > +	unsigned long flags;
> > +	struct rq *rq;
> > +	int i, cpu;
> > +
> > +	if (!static_branch_likely(&sched_core_protect_kernel))
> > +		return;
> > +
> > +	/* Ensure that on return to user/guest, we check whether to wait. */
> > +	if (current->core_cookie)
> > +		set_tsk_thread_flag(current, TIF_UNSAFE_RET);
> > +
> > +	local_irq_save(flags);
> > +	cpu = smp_processor_id();
> > +	rq = cpu_rq(cpu);
> > +	if (!sched_core_enabled(rq))
> > +		goto ret;
> > +
> > +	/* Count unsafe_enter() calls received without unsafe_exit() on this CPU. */
> > +	rq->core_this_unsafe_nest++;
> > +
> > +	/* Should not nest: enter() should only pair with exit(). */
> > +	if (WARN_ON_ONCE(rq->core_this_unsafe_nest != 1))
> > +		goto ret;
> > +
> > +	raw_spin_lock(rq_lockp(rq));
> > +	smt_mask = cpu_smt_mask(cpu);
> > +
> > +	/* Contribute this CPU's unsafe_enter() to core-wide unsafe_enter() count. */
> > +	WRITE_ONCE(rq->core->core_unsafe_nest, rq->core->core_unsafe_nest + 1);
> > +
> > +	if (WARN_ON_ONCE(rq->core->core_unsafe_nest == UINT_MAX))
> > +		goto unlock;
> > +
> > +	if (irq_work_is_busy(&rq->core_irq_work)) {
> > +		/*
> > +		 * Do nothing more since we are in an IPI sent from another
> > +		 * sibling to enforce safety. That sibling would have sent IPIs
> > +		 * to all of the HTs.
> > +		 */
> > +		goto unlock;
> > +	}
> > +
> > +	/*
> > +	 * If we are not the first ones on the core to enter core-wide unsafe
> > +	 * state, do nothing.
> > +	 */
> > +	if (rq->core->core_unsafe_nest > 1)
> > +		goto unlock;
> > +
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
> > +	}
> > +unlock:
> > +	raw_spin_unlock(rq_lockp(rq));
> > +ret:
> > +	local_irq_restore(flags);
> > +}
> > +
> > +/*
> > + * Process any work need for either exiting the core-wide unsafe state, or for
> > + * waiting on this hyperthread if the core is still in this state.
> > + *
> > + * @idle: Are we called from the idle loop?
> > + */
> > +void sched_core_unsafe_exit(void)
> > +{
> > +	unsigned long flags;
> > +	unsigned int nest;
> > +	struct rq *rq;
> > +	int cpu;
> > +
> > +	if (!static_branch_likely(&sched_core_protect_kernel))
> > +		return;
> > +
> > +	local_irq_save(flags);
> > +	cpu = smp_processor_id();
> > +	rq = cpu_rq(cpu);
> > +
> > +	/* Do nothing if core-sched disabled. */
> > +	if (!sched_core_enabled(rq))
> > +		goto ret;
> > +
> > +	/*
> > +	 * Can happen when a process is forked and the first return to user
> > +	 * mode is a syscall exit. Either way, there's nothing to do.
> > +	 */
> > +	if (rq->core_this_unsafe_nest == 0)
> > +		goto ret;
> > +
> > +	rq->core_this_unsafe_nest--;
> > +
> > +	/* enter() should be paired with exit() only. */
> > +	if (WARN_ON_ONCE(rq->core_this_unsafe_nest != 0))
> > +		goto ret;
> > +
> > +	raw_spin_lock(rq_lockp(rq));
> > +	/*
> > +	 * Core-wide nesting counter can never be 0 because we are
> > +	 * still in it on this CPU.
> > +	 */
> > +	nest = rq->core->core_unsafe_nest;
> > +	WARN_ON_ONCE(!nest);
> > +
> > +	/* Pair with smp_load_acquire() in sched_core_wait_till_safe(). */
> > +	smp_store_release(&rq->core->core_unsafe_nest, nest - 1);
> > +	raw_spin_unlock(rq_lockp(rq));
> > +ret:
> > +	local_irq_restore(flags);
> > +}
> > +
> >   // XXX fairness/fwd progress conditions
> >   /*
> >    * Returns
> > @@ -5019,6 +5248,7 @@ static inline void sched_core_cpu_starting(unsigned int cpu)
> >   			rq = cpu_rq(i);
> >   			if (rq->core && rq->core == rq)
> >   				core_rq = rq;
> > +			init_sched_core_irq_work(rq);
> >   		}
> >   		if (!core_rq)
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index f7e2d8a3be8e..4bcf3b1ddfb3 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1059,12 +1059,15 @@ struct rq {
> >   	unsigned int		core_enabled;
> >   	unsigned int		core_sched_seq;
> >   	struct rb_root		core_tree;
> > +	struct irq_work		core_irq_work; /* To force HT into kernel */
> > +	unsigned int		core_this_unsafe_nest;
> >   	/* shared state */
> >   	unsigned int		core_task_seq;
> >   	unsigned int		core_pick_seq;
> >   	unsigned long		core_cookie;
> >   	unsigned char		core_forceidle;
> > +	unsigned int		core_unsafe_nest;
> >   #endif
> >   };
> > 
