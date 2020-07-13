Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36AA21C030
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 00:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgGJW6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 18:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgGJW6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:58:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5677B206E2;
        Fri, 10 Jul 2020 22:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594421929;
        bh=F0C0FCYkG4GFGjrGyJwgX3mb+jTXolMHkoMuPb4jasQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uelBMiiatZ0zwHdQN80fqAhUmJD9sCa0FSa/isbcmhw/8aYrKJhFya7pw27k3MaqA
         O9I+Xf+PqKhMyxxd+7FJw1dzT1NxJmsXVauzJcndM3aiqIpzRrw3ERjyevki8zy9xN
         EU4blqfZ5xhkka/H2qzb6SQFu+6aumd1GqxNp5xA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3C269352262E; Fri, 10 Jul 2020 15:58:49 -0700 (PDT)
Date:   Fri, 10 Jul 2020 15:58:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, frederic@kernel.org
Subject: Re: [PATCH smp 2/2] kernel/smp: Provide CSD lock timeout diagnostics
Message-ID: <20200710225849.GA6004@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200709235436.GA20922@paulmck-ThinkPad-P72>
 <20200709235557.21080-2-paulmck@kernel.org>
 <20200710103227.GD4800@hirez.programming.kicks-ass.net>
 <20200710212834.GL9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200710212834.GL9247@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 02:28:34PM -0700, Paul E. McKenney wrote:
> On Fri, Jul 10, 2020 at 12:32:27PM +0200, Peter Zijlstra wrote:
> > On Thu, Jul 09, 2020 at 04:55:57PM -0700, paulmck@kernel.org wrote:
> > 
> > So the biggest problem I have with this patch is that while it adds a
> > Kconfig debug knob, it doesn't seem to actually use it.
> 
> It certainly does not use it as much as it could.  I have make
> changes based on your suggestions.
> 
> And thank you for looking this over!
> 
> > Stuff like:
> > 
> > > +/* Record current CSD work for current CPU, NULL to erase. */
> > > +static void csd_lock_record(call_single_data_t *csd)
> > > +{
> > > +	if (!csd) {
> > > +		smp_mb(); // NULL cur_csd after unlock.
> > > +		__this_cpu_write(cur_csd, NULL);
> > > +		return;
> > > +	}
> > > +	__this_cpu_write(cur_csd, csd);
> > > +	__this_cpu_write(cur_csd_func, csd->func);
> > > +	__this_cpu_write(cur_csd_info, csd->info);
> > > +	smp_mb(); // Update cur_csd before function call.
> > > +		  // Or before unlock, as the case may be.
> > > +}
> > > +
> > > +static __always_inline int csd_lock_wait_getcpu(call_single_data_t *csd)
> > > +{
> > > +	unsigned int csd_type;
> > > +
> > > +	csd_type = CSD_TYPE(csd);
> > > +#ifdef CONFIG_64BIT
> > > +	if (csd_type == CSD_TYPE_ASYNC || csd_type == CSD_TYPE_SYNC)
> > > +		return csd->dst; // Other CSD_TYPE_ values might not have ->dst.
> > > +#endif
> > > +	return -1;
> > > +}
> > 
> > is unconditional, and thus adds unconditional fulll barriers :-(
> 
> I now #ifdef them out, as you suggest below.
> 
> > > +/*
> > > + * Complain if too much time spent waiting.  Note that only
> > > + * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
> > > + * so waiting on other types gets much less information.
> > > + */
> > > +static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
> > > +{
> > > +	int cpu = -1;
> > > +	call_single_data_t *cpu_cur_csd;
> > > +	bool firsttime;
> > > +	unsigned int flags = READ_ONCE(csd->flags);
> > > +	u64 quo;
> > > +	u32 rem;
> > > +	u64 ts2, ts_delta;
> > > +
> > > +	if (!(flags & CSD_FLAG_LOCK)) {
> > > +		if (!unlikely(*bug_id))
> > > +			return true;
> > > +		cpu = csd_lock_wait_getcpu(csd);
> > > +		if (cpu >= 0)
> > > +			pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock after all. Phew!\n", *bug_id, raw_smp_processor_id(), cpu);
> > > +		else
> > > +			pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, the lock was released after all. Phew!\n", *bug_id, raw_smp_processor_id());
> > > +		return true;
> > > +	}
> > > +
> > > +	ts2 = div_u64_rem(sched_clock(), 1000 * 1000, &rem);
> > > +	ts_delta = ts2 - *ts1;
> > > +	if (likely(ts_delta <= CSD_LOCK_TIMEOUT)) {
> > > +		cpu_relax();
> > > +		return false;
> > > +	}
> > > +
> > > +	firsttime = !*bug_id;
> > > +	if (firsttime)
> > > +		*bug_id = atomic_inc_return(&csd_bug_count);
> > > +	cpu = csd_lock_wait_getcpu(csd);
> > > +	smp_mb(); // No stale cur_csd values!
> > > +	if (WARN_ONCE(cpu < 0 || cpu >= nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
> > > +		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, 0));
> > > +	else
> > > +		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, cpu));
> > > +	smp_mb(); // No refetching cur_csd values!
> > > +	quo = div_u64_rem(ts2 - ts0, 1000, &rem);
> > > +#define CSD_FORMAT_PREFIX "csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu.%03u secs for CPU#%02d %pS(%ps), currently"
> > > +#define CSD_ARGS_PREFIX firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), \
> > > +	quo, rem, cpu, csd->func, csd->info
> > > +	if (cpu_cur_csd && csd != cpu_cur_csd)
> > > +		pr_alert(CSD_FORMAT_PREFIX " handling prior %pS(%ps) request.\n",
> > > +			 CSD_ARGS_PREFIX, cpu_cur_csd->func, cpu_cur_csd->info);
> > > +	else
> > > +		pr_alert(CSD_FORMAT_PREFIX " %s.\n", CSD_ARGS_PREFIX,
> > > +			 !cpu_cur_csd ? "unresponsive" : "handling this request");
> > > +#undef CSD_FORMAT_PREFIX
> > > +#undef CSD_ARGS_PREFIX
> > > +	if (cpu >= 0) {
> > > +		if (!trigger_single_cpu_backtrace(cpu))
> > > +			dump_cpu_task(cpu);
> > > +		if (!cpu_cur_csd) {
> > > +			pr_alert("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", *bug_id, raw_smp_processor_id(), cpu);
> > > +			arch_send_call_function_single_ipi(cpu);
> > > +		}
> > > +	}
> > > +	dump_stack();
> > > +	*ts1 = ts2;
> > > +	cpu_relax();
> > > +
> > > +	return false;
> > > +}
> > 
> > 
> > This thing is just unreadable. Did it want to be something like:
> > 	
> > 	bool warn = false;
> > 
> > 	for (;;) {
> > 		while (sched_clock() - t1 < NSEC_PER_MSEC * CSD_TIMO) {
> > 			if (!(READ_ONCE(csd->flags) & CSD_FLAG_LOCK))
> > 				goto out;
> > 		}
> > 
> > 		t1 += NSEC_PER_MSEC * CSD_TIMO;
> > 
> > 		pr_alert("csd: stuck on %d, waiting on %d\n", csd->src, csd->dst);
> 
> I agree that this code is more compact, but the additional information
> in the original is useful:
> 
> o	->func and ->info: If the destination CPU is unresponsive to
> 	NMIs, which happens sometimes, these help locate where the
> 	problem might be.
> 
> o	It is useful to know whether the destination CPU is stuck in
> 	the currently waited-on request, some other request, or is not
> 	seeing requests at all.
> 
> o	There can be multiple reports for a given incident, and sometimes
> 	there are overlapping incidents in production, so the bug_id is
> 	necessary to work out which reports go together.
> 
> Instead of the macros, I could sprintf() the varying stuff into a buffer
> and then print the buffer out.  My concern with that approach was the
> very long function names that are present in some parts of the kernel.
> 
> Another approach is to use pr_cont(), but that produced very ugly results
> when torture testing.  But in real life, these things normally occur in
> isolation, so pr_cont() might be OK for non-torture use.
> 
> Yet another approach would be to just do multiple pr_alert() calls,
> repeating the bug_id in each pr_alert() so that the output can be
> correlated.  Left to myself, I would take this approach.
> 
> Thoughts?
> 
> > 		if (!warn) {
> > 			warn = true;
> > 			WARN_ON(1);
> > 		}
> > 
> > 		arch_send_call_function_single_ipi(csd->dst);
> > 	}
> > out:
> > 	smp_acquire__after_ctrl_dep();
> > 
> > 	if (warn)
> > 		pr_alert("csd: got unstuck..\n");
> > 
> > 
> > > +
> > >  /*
> > >   * csd_lock/csd_unlock used to serialize access to per-cpu csd resources
> > >   *
> > > @@ -105,7 +212,19 @@ void __init call_function_init(void)
> > >   */
> > >  static __always_inline void csd_lock_wait(call_single_data_t *csd)
> > >  {
> > > -	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
> > > +	int bug_id = 0;
> > > +	u32 rem;
> > > +	u64 ts0, ts1;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_CSD_LOCK_WAIT_DEBUG)) {
> > > +		smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
> > > +		return;
> > > +	}
> > > +	ts1 = ts0 = div_u64_rem(sched_clock(), 1000 * 1000, &rem);
> > > +	for (;;)
> > > +		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
> > > +			break;
> > > +	smp_acquire__after_ctrl_dep();
> > >  }
> > 
> > This makes a trainwreck from what was a very simple small function.
> > 
> > I'm thinking you can get rid of that division and simply multiply things
> > by a 1e6 to get a timeout in ns, that'll be _waaaaay_ faster on
> > everything that doesn't have an oversized divider.
> 
> Easy enough to compare and print in nanoseconds, done.
> 
> > Anyway, what's wrong with the age old way of:
> > 
> > #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> > 
> > static inline void csd_lock_record(call_single_data_t *csd)
> > {
> > 	/* extra barriers go here */
> > }
> > 
> > static void csd_lock_wait(call_single_data *csd)
> > {
> > 	/* giant monster goes here */
> > }
> > 
> > #else
> > 
> > static __always_inline void csd_lock_record(call_single_data_t *csd)
> > {
> > }
> > 
> > static __always_inline void csd_lock_wait(call_single_data_t *csd)
> > {
> > 	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
> > }
> > 
> > #endif /* CONFIG_CSD_LOCK_WAIT_DEBUG */
> 
> Fair enough!
> 
> I took this approach, also applied #ifdef to the data and definitions.
> 
> > > @@ -375,7 +500,10 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
> > >  
> > >  	csd->func = func;
> > >  	csd->info = info;
> > > +#ifdef CONFIG_64BIT
> > > +	csd->src = smp_processor_id();
> > >  	csd->dst = cpu;
> > > +#endif
> > >  
> > >  	err = generic_exec_single(cpu, csd);
> > >  
> > > @@ -541,7 +669,10 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
> > >  			csd->flags |= CSD_TYPE_SYNC;
> > >  		csd->func = func;
> > >  		csd->info = info;
> > > +#ifdef CONFIG_64BIT
> > > +		csd->src = smp_processor_id();
> > >  		csd->dst = cpu;
> > > +#endif
> > >  		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
> > >  			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
> > >  	}
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index 669f4d3..22443fa3 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -1332,6 +1332,16 @@ config SCF_TORTURE_TEST
> > >  	  module may be built after the fact on the running kernel to
> > >  	  be tested, if desired.
> > >  
> > > +config CSD_LOCK_WAIT_DEBUG
> > > +	bool "Debugging for csd_lock_wait(), called from smp_call_function*()"
> > > +	depends on DEBUG_KERNEL
> > 
> > Would it make sense to put the src,dst members under this config
> > variable too and make this whole thing
> > 
> > 	depends on CONFIG_64BIT
> > 
> > ?
> 
> I believe so.  Making that change as well.

Sadly, the code creating the 32-bit VDSO became unhappy:

------------------------------------------------------------------------

In file included from ././include/linux/compiler_types.h:59:0,
                 from <command-line>:0:
./include/linux/smp.h:40:26: error: requested alignment is not a positive power of 2
  __aligned(sizeof(struct __call_single_data));
                          ^
./include/linux/compiler_attributes.h:57:68: note: in definition of macro ‘__aligned’
 #define __aligned(x)                    __attribute__((__aligned__(x)))
                                                                    ^
scripts/Makefile.build:280: recipe for target 'arch/x86/entry/vdso/vdso32/vclock_gettime.o' failed
make[3]: *** [arch/x86/entry/vdso/vdso32/vclock_gettime.o] Error 1

------------------------------------------------------------------------

So I left the CONFIG_64BIT for the "u16 src, dst" fields, but did move
the rest to CONFIG_CSD_LOCK_WAIT_DEBUG.

Updated patch (with pr_alert()s as yet unchanged) below.  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit aba04e2ce05fbc6bb90e6fa238c22e491f6b95e3
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jun 30 13:22:54 2020 -0700

    kernel/smp: Provide CSD lock timeout diagnostics
    
    This commit causes csd_lock_wait() to emit diagnostics when a CPU
    fails to respond quickly enough to one of the smp_call_function()
    family of function calls.  These diagnostics are enabled by a new
    CSD_LOCK_WAIT_DEBUG Kconfig option that depends on DEBUG_KERNEL.
    
    This commit was inspired by an earlier patch by Josef Bacik.
    
    [ paulmck: Fix for syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com ]
    [ paulmck: Fix KASAN use-after-free issue reported by Qian Cai. ]
    [ paulmck: Fix botched nr_cpu_ids comparison per Dan Carpenter. ]
    [ paulmck: More #ifdef per Peter Zijlstra. ]
    [ paulmck: Print delays in ns rather than ms per Peter Zijlstra. ]
    [ paulmck: Use more CONFIG_CSD_LOCK_WAIT_DEBUG per Peter Zijlstra. ]
    Link: https://lore.kernel.org/lkml/00000000000042f21905a991ecea@google.com
    Link: https://lore.kernel.org/lkml/0000000000002ef21705a9933cf3@google.com
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/smp.c b/kernel/smp.c
index 148d991..e1d8e52 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -20,6 +20,9 @@
 #include <linux/sched.h>
 #include <linux/sched/idle.h>
 #include <linux/hypervisor.h>
+#include <linux/sched/clock.h>
+#include <linux/nmi.h>
+#include <linux/sched/debug.h>
 
 #include "smpboot.h"
 #include "sched/smp.h"
@@ -34,6 +37,12 @@ struct call_function_data {
 
 static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
 
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
+static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
+static DEFINE_PER_CPU(void *, cur_csd_info);
+#endif
+
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
 
 static void flush_smp_call_function_queue(bool warn_cpu_offline);
@@ -96,6 +105,103 @@ void __init call_function_init(void)
 	smpcfd_prepare_cpu(smp_processor_id());
 }
 
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+
+#define CSD_LOCK_TIMEOUT (5 * 1000ULL * 1000ULL * 1000ULL) /* Nanoseconds. */
+atomic_t csd_bug_count = ATOMIC_INIT(0);
+
+/* Record current CSD work for current CPU, NULL to erase. */
+static void csd_lock_record(call_single_data_t *csd)
+{
+	if (!csd) {
+		smp_mb(); // NULL cur_csd after unlock.
+		__this_cpu_write(cur_csd, NULL);
+		return;
+	}
+	__this_cpu_write(cur_csd, csd);
+	__this_cpu_write(cur_csd_func, csd->func);
+	__this_cpu_write(cur_csd_info, csd->info);
+	smp_mb(); // Update cur_csd before function call.
+		  // Or before unlock, as the case may be.
+}
+
+static __always_inline int csd_lock_wait_getcpu(call_single_data_t *csd)
+{
+	unsigned int csd_type;
+
+	csd_type = CSD_TYPE(csd);
+	if (csd_type == CSD_TYPE_ASYNC || csd_type == CSD_TYPE_SYNC)
+		return csd->dst; // Other CSD_TYPE_ values might not have ->dst.
+	return -1;
+}
+
+/*
+ * Complain if too much time spent waiting.  Note that only
+ * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
+ * so waiting on other types gets much less information.
+ */
+static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
+{
+	int cpu = -1;
+	call_single_data_t *cpu_cur_csd;
+	bool firsttime;
+	unsigned int flags = READ_ONCE(csd->flags);
+	u64 ts2, ts_delta;
+
+	if (!(flags & CSD_FLAG_LOCK)) {
+		if (!unlikely(*bug_id))
+			return true;
+		cpu = csd_lock_wait_getcpu(csd);
+		if (cpu >= 0)
+			pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock after all. Phew!\n", *bug_id, raw_smp_processor_id(), cpu);
+		else
+			pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, the lock was released after all. Phew!\n", *bug_id, raw_smp_processor_id());
+		return true;
+	}
+
+	ts2 = sched_clock();
+	ts_delta = ts2 - *ts1;
+	if (likely(ts_delta <= CSD_LOCK_TIMEOUT)) {
+		cpu_relax();
+		return false;
+	}
+
+	firsttime = !*bug_id;
+	if (firsttime)
+		*bug_id = atomic_inc_return(&csd_bug_count);
+	cpu = csd_lock_wait_getcpu(csd);
+	smp_mb(); // No stale cur_csd values!
+	if (WARN_ONCE(cpu < 0 || cpu >= nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
+		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, 0));
+	else
+		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, cpu));
+	smp_mb(); // No refetching cur_csd values!
+#define CSD_FORMAT_PREFIX "csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps), currently"
+#define CSD_ARGS_PREFIX firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), \
+	ts2 - ts0, cpu, csd->func, csd->info
+	if (cpu_cur_csd && csd != cpu_cur_csd)
+		pr_alert(CSD_FORMAT_PREFIX " handling prior %pS(%ps) request.\n",
+			 CSD_ARGS_PREFIX, cpu_cur_csd->func, cpu_cur_csd->info);
+	else
+		pr_alert(CSD_FORMAT_PREFIX " %s.\n", CSD_ARGS_PREFIX,
+			 !cpu_cur_csd ? "unresponsive" : "handling this request");
+#undef CSD_FORMAT_PREFIX
+#undef CSD_ARGS_PREFIX
+	if (cpu >= 0) {
+		if (!trigger_single_cpu_backtrace(cpu))
+			dump_cpu_task(cpu);
+		if (!cpu_cur_csd) {
+			pr_alert("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", *bug_id, raw_smp_processor_id(), cpu);
+			arch_send_call_function_single_ipi(cpu);
+		}
+	}
+	dump_stack();
+	*ts1 = ts2;
+	cpu_relax();
+
+	return false;
+}
+
 /*
  * csd_lock/csd_unlock used to serialize access to per-cpu csd resources
  *
@@ -105,8 +211,26 @@ void __init call_function_init(void)
  */
 static __always_inline void csd_lock_wait(call_single_data_t *csd)
 {
+	int bug_id = 0;
+	u64 ts0, ts1;
+
+	ts1 = ts0 = sched_clock();
+	for (;;)
+		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
+			break;
+	smp_acquire__after_ctrl_dep();
+}
+
+#else
+static void csd_lock_record(call_single_data_t *csd)
+{
+}
+
+static __always_inline void csd_lock_wait(call_single_data_t *csd)
+{
 	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
 }
+#endif
 
 static __always_inline void csd_lock(call_single_data_t *csd)
 {
@@ -166,9 +290,11 @@ static int generic_exec_single(int cpu, call_single_data_t *csd)
 		 * We can unlock early even for the synchronous on-stack case,
 		 * since we're doing this from the same CPU..
 		 */
+		csd_lock_record(csd);
 		csd_unlock(csd);
 		local_irq_save(flags);
 		func(info);
+		csd_lock_record(NULL);
 		local_irq_restore(flags);
 		return 0;
 	}
@@ -268,8 +394,10 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 				entry = &csd_next->llist;
 			}
 
+			csd_lock_record(csd);
 			func(info);
 			csd_unlock(csd);
+			csd_lock_record(NULL);
 		} else {
 			prev = &csd->llist;
 		}
@@ -296,8 +424,10 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 				smp_call_func_t func = csd->func;
 				void *info = csd->info;
 
+				csd_lock_record(csd);
 				csd_unlock(csd);
 				func(info);
+				csd_lock_record(NULL);
 			} else if (type == CSD_TYPE_IRQ_WORK) {
 				irq_work_single(csd);
 			}
@@ -375,7 +505,10 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 
 	csd->func = func;
 	csd->info = info;
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+	csd->src = smp_processor_id();
 	csd->dst = cpu;
+#endif
 
 	err = generic_exec_single(cpu, csd);
 
@@ -541,7 +674,10 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			csd->flags |= CSD_TYPE_SYNC;
 		csd->func = func;
 		csd->info = info;
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+		csd->src = smp_processor_id();
 		csd->dst = cpu;
+#endif
 		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 	}
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 669f4d3..5cd8deb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1332,6 +1332,17 @@ config SCF_TORTURE_TEST
 	  module may be built after the fact on the running kernel to
 	  be tested, if desired.
 
+config CSD_LOCK_WAIT_DEBUG
+	bool "Debugging for csd_lock_wait(), called from smp_call_function*()"
+	depends on DEBUG_KERNEL
+	depends on 64BIT
+	default n
+	help
+	  This option enables debug prints when CPUs are slow to respond
+	  to the smp_call_function*() IPI wrappers.  These debug prints
+	  include the IPI handler function currently executing (if any)
+	  and relevant stack traces.
+
 endmenu # lock debugging
 
 config TRACE_IRQFLAGS
