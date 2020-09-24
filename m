Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837E6277593
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgIXPhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:37:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48858 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgIXPhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:37:46 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600961863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IgZX2FYUp1j7kQdIFEegZMZuNCthOoXrf3fIKF0+1e4=;
        b=asFd5z0/dBIC9e7OAE2GaDDGygYqLklwfRV4WbazGM+o3PTbVatECgK9n4lKbggD+cH4iu
        3ifVyq/08EKcruEI7pGbrlGqSxQ30fGvwc1HOeySRzkpcLHHBAGM8cBz31wif0Krxk7E/i
        TnlWwUokFicDyk6MEgXhGtCifH+RVp4WDNkJx/FCgHovzmFzEdbZRlrru2LCRBCdBjw2cC
        SH35BKRBmBBTeEYgv2T+2N3GDpAzvGCCxzoCQE8xzeO5jRnXDjgZeaMD85VVOe6DPicnKf
        gYi7rV6rhz56l/uT4+Lxt8AaDr+M/CML8WUT0tnwJKDDWqWSMyf5TL6IvpFAVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600961863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IgZX2FYUp1j7kQdIFEegZMZuNCthOoXrf3fIKF0+1e4=;
        b=t5AeXNz1HVsbVHb2Mx87wdas5Pzx6ZLISFeipzgB9TmqvLgiHfOVoFK46lapDbqTEO7Qjy
        /A2gkkAERiQVgWBw==
To:     qianjun.kernel@gmail.com, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Cc:     laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com,
        jun qian <qianjun.kernel@gmail.com>
Subject: Re: [PATCH V7 4/4] softirq: Allow early break the softirq processing loop
In-Reply-To: <20200915115609.85106-5-qianjun.kernel@gmail.com>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com> <20200915115609.85106-5-qianjun.kernel@gmail.com>
Date:   Thu, 24 Sep 2020 17:37:42 +0200
Message-ID: <878scz89tl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Sep 15 2020 at 19:56, qianjun kernel wrote:
>  
> +#define SOFTIRQ_PENDING_MASK ((1UL << NR_SOFTIRQS) - 1)
>
> +/*
> + * The pending_next_bit is recorded for the next processing order when
> + * the loop is broken. This per cpu variable is to solve the following
> + * scenarios:
> + * Assume bit 0 and 1 are pending when the processing starts. Now it
> + * breaks out after bit 0 has been handled and stores back bit 1 as
> + * pending. Before ksoftirqd runs bit 0 gets raised again. ksoftirqd
> + * runs and handles bit 0, which takes more than the timeout. As a
> + * result the bit 0 processing can starve all other softirqs.
> + *
> + * so we need the pending_next_bit to record the next process order.
> + */
> +DEFINE_PER_CPU(u32, pending_next_bit);

static if at all.

> +
>  asmlinkage __visible void __softirq_entry __do_softirq(void)
>  {
>  	u64 start = sched_clock();
> @@ -261,8 +277,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  	unsigned int max_restart = MAX_SOFTIRQ_RESTART;
>  	struct softirq_action *h;
>  	unsigned long pending;
> +	unsigned long pending_left, pending_again;
>  	unsigned int vec_nr;
>  	bool in_hardirq;
> +	int next_bit;
> +	unsigned long flags;
>  
>  	/*
>  	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
> @@ -283,25 +302,66 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  
>  	local_irq_enable();
>  
> -	for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS) {
> -		int prev_count;
> -
> -		__clear_bit(vec_nr, &pending);
> -
> -		h = softirq_vec + vec_nr;
> -
> -		prev_count = preempt_count();
> -
> -		kstat_incr_softirqs_this_cpu(vec_nr);
> +	/*
> +	 * pending_left means that the left bits unhandled when the loop is
> +	 * broken without finishing the vectors. These bits will be handled
> +	 * first in the next time. pending_again means that the new bits is
> +	 * generated in the other time. These bits should be handled after
> +	 * the pending_left bits have been handled.
> +	 *
> +	 * For example
> +	 * If the pending bits is 1101010110, and the loop is broken after
> +	 * the bit4 is handled. Then, the pending_next_bit will be 5, and
> +	 * the pending_left is 1101000000, the pending_again is 000000110.
> +	 */

If you need such a comment to explain the meaning of your variables then
you did something fundamentaly wrong.

> +	next_bit = __this_cpu_read(pending_next_bit);
> +	pending_left = pending &
> +		(SOFTIRQ_PENDING_MASK << next_bit);
> +	pending_again = pending &
> +		(SOFTIRQ_PENDING_MASK >> (NR_SOFTIRQS - next_bit));
> +
> +	while (pending_left || pending_again) {
> +		if  (pending_left) {
> +			pending = pending_left;
> +			pending_left = 0;
> +		} else if (pending_again) {
> +			pending = pending_again;
> +			pending_again = 0;
> +		} else
> +			break;

Aside of lacking brackets how is that 'else' patch ever going to be
reached?

But TBH that whole patch is a completely unreviewable maze. 

This can be done without all this pending, pending_left, pending_again,
pending_next_bit, next_bit convolution. It's inconsistent anyway:

__do_softirq()

        pending = 0x25;
        next = 0;

        for (...)
            break after bit 0

        ==> pending == 0x24

        ==> next = 2

now on the next invocation

       pending = 0x35;
       next = 2;

       So the processing order is 2, 4, 5, 0

and there is nothing you can do about that with that approach.

But the whole point is to ensure that the not yet processed bits are
processed first.

Find attached an updated series based on the original one from Peter
with the authorship preserved, intact SOB chains and proper changelogs.

The last one is new and addressing the starvation issue in a readable
way.

All of this is again completely untested.

Thanks,

        tglx


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=peterz-softirq-fix-loop.patch

Subject: softirq: Rewrite softirq processing loop
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Sep 11 17:00:03 CEST 2020

From: Peter Zijlstra <peterz@infradead.org>

Simplify the softirq processing loop by using the bitmap APIs

[ tglx: Make max_restart unsigned int and reduce the variable declaration maze ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/softirq.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -254,13 +254,11 @@ static inline void lockdep_softirq_end(b
 
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
-	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
+	unsigned int vec_nr, max_restart = MAX_SOFTIRQ_RESTART;
 	unsigned long old_flags = current->flags;
-	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
+	unsigned long pending;
 	bool in_hardirq;
-	__u32 pending;
-	int softirq_bit;
 
 	/*
 	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
@@ -281,20 +279,15 @@ asmlinkage __visible void __softirq_entr
 
 	local_irq_enable();
 
-	h = softirq_vec;
-
-	while ((softirq_bit = ffs(pending))) {
-		unsigned int vec_nr;
+	for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS) {
 		int prev_count;
 
-		h += softirq_bit - 1;
-
-		vec_nr = h - softirq_vec;
-		prev_count = preempt_count();
-
+		__clear_bit(vec_nr, &pending);
 		kstat_incr_softirqs_this_cpu(vec_nr);
 
+		prev_count = preempt_count();
 		trace_softirq_entry(vec_nr);
+		h = softirq_vec + vec_nr;
 		h->action(h);
 		trace_softirq_exit(vec_nr);
 		if (unlikely(prev_count != preempt_count())) {
@@ -303,8 +296,6 @@ asmlinkage __visible void __softirq_entr
 			       prev_count, preempt_count());
 			preempt_count_set(prev_count);
 		}
-		h++;
-		pending >>= softirq_bit;
 	}
 
 	if (__this_cpu_read(ksoftirqd) == current)

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=peterz-softirq-timo.patch

Subject: softirq: Use sched_clock() based timeout
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Sep 11 17:30:01 CEST 2020

From: Peter Zijlstra <peterz@infradead.org>

Jiffies based timeouts depend on the HZ value and the resulting granularity
is between 1ms and 10ms. That does not allow to terminate the softirq
processing loop precisely independent of the kernel configuration.

Replace the jiffies based timeout with a sched_clock() based one.

Note, that for systems which lack proper hardware sched_clock() is jiffies
based and the change has no effect on them.

[ tglx: Simplified the timeout condition by calculating the break time once
  	and updated changelog. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/softirq.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -25,6 +25,7 @@
 #include <linux/smpboot.h>
 #include <linux/tick.h>
 #include <linux/irq.h>
+#include <linux/sched/clock.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
@@ -216,8 +217,8 @@ EXPORT_SYMBOL(__local_bh_enable_ip);
  * we want to handle softirqs as soon as possible, but they
  * should not be able to lock up the box.
  */
-#define MAX_SOFTIRQ_TIME  msecs_to_jiffies(2)
-#define MAX_SOFTIRQ_RESTART 10
+#define MAX_SOFTIRQ_TIME	(2 * NSEC_PER_MSEC)
+#define MAX_SOFTIRQ_RESTART	10
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 /*
@@ -255,6 +256,7 @@ static inline void lockdep_softirq_end(b
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
 	unsigned int vec_nr, max_restart = MAX_SOFTIRQ_RESTART;
+	u64 tbreak = sched_clock() + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
 	struct softirq_action *h;
 	unsigned long pending;
@@ -304,8 +306,7 @@ asmlinkage __visible void __softirq_entr
 
 	pending = local_softirq_pending();
 	if (pending) {
-		if (time_before(jiffies, end) && !need_resched() &&
-		    --max_restart)
+		if (sched_clock() < tbreak && !need_resched() && --max_restart)
 			goto restart;
 
 		wakeup_softirqd();

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=peterz-softirq-needs-break.patch

Subject: softirq: Factor loop termination condition
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Sep 11 17:17:20 CEST 2020

From: Peter Zijlstra <peterz@infradead.org>

Invidiual soft interrupts can run longer than the timeout, but the loop
termination conditions (timeout or need_resched()) are only evaluated after
processing all pending bits.

As a preparatory step to allow breaking the loop after each processed
pending bit, factor out the termination condition into helper functions.

[ tglx: Split the function, adopt to previous changes and update change log ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/softirq.c |   40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -204,22 +204,6 @@ void __local_bh_enable_ip(unsigned long
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
-/*
- * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
- * but break the loop if need_resched() is set or after 2 ms.
- * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
- * certain cases, such as stop_machine(), jiffies may cease to
- * increment and so we need the MAX_SOFTIRQ_RESTART limit as
- * well to make sure we eventually return from this method.
- *
- * These limits have been established via experimentation.
- * The two things to balance is latency against fairness -
- * we want to handle softirqs as soon as possible, but they
- * should not be able to lock up the box.
- */
-#define MAX_SOFTIRQ_TIME	(2 * NSEC_PER_MSEC)
-#define MAX_SOFTIRQ_RESTART	10
-
 #ifdef CONFIG_TRACE_IRQFLAGS
 /*
  * When we run softirqs from irq_exit() and thus on the hardirq stack we need
@@ -253,6 +237,28 @@ static inline bool lockdep_softirq_start
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
+/*
+ * We restart softirq processing but break the loop if need_resched() is set or
+ * after 2 ms. The MAX_SOFTIRQ_RESTART guarantees a loop termination if
+ * sched_clock() were ever to stall.
+ *
+ * These limits have been established via experimentation.  The two things to
+ * balance is latency against fairness - we want to handle softirqs as soon as
+ * possible, but they should not be able to lock up the box.
+ */
+#define MAX_SOFTIRQ_TIME	(2 * NSEC_PER_MSEC)
+#define MAX_SOFTIRQ_RESTART	10
+
+static inline bool __softirq_timeout(u64 tbreak)
+{
+	return sched_clock() >= tbreak;
+}
+
+static inline bool __softirq_needs_break(u64 tbreak)
+{
+	return need_resched() || __softirq_timeout(tbreak);
+}
+
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
 	unsigned int vec_nr, max_restart = MAX_SOFTIRQ_RESTART;
@@ -306,7 +312,7 @@ asmlinkage __visible void __softirq_entr
 
 	pending = local_softirq_pending();
 	if (pending) {
-		if (sched_clock() < tbreak && !need_resched() && --max_restart)
+		if (!__softirq_needs_break(tbreak) && --max_restart)
 			goto restart;
 
 		wakeup_softirqd();

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=peterz-softirq-break-more.patch

Subject: softirq: Allow early termination of softirq processing
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Sep 11 17:50:17 CEST 2020

From: Peter Zijlstra <peterz@infradead.org>

Invidiual soft interrupts can run longer than the timeout, but the loop
termination conditions (timeout or need_resched()) are only evaluated after
processing all pending bits.

Check the timeout condition after each processed pending bit and allow
to terminate the loop early. The remaining unprocessed bits are or'ed back
into local_softirq_pending()

need_resched() is not checked after each bit because it's likely to be set
after one of the first bits and way before the timeout condition
happens. While checking need_resched() after each bit is reducing latency
for the particular softirq vector which ended up setting TIF_NEEDRESCHED,
it's counterproductive in terms of batch processing. The main objective of
this change is to keep fairness intact.

Adding need_resched() to the inner termination check needs to be carefully
evaluated and done in a seperate change if at all.

Caveat: Folding back the not yet processed bits without further handling is
bound to cause starvation of the higher numbered softirq vectors when the
lower ones which triggered the timeout are raised again before the
remaining bits have been processed in the next run. This will be handled in
a follow up change.

[ tglx: Adopt to previous changes, use only the timeout condition in the
  	loop and prevent wakeup of ksoftirqd in case there are no new bits
  	pending ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/softirq.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -304,20 +304,26 @@ asmlinkage __visible void __softirq_entr
 			       prev_count, preempt_count());
 			preempt_count_set(prev_count);
 		}
+		if (__softirq_timeout(tbreak))
+			break;
 	}
 
 	if (__this_cpu_read(ksoftirqd) == current)
 		rcu_softirq_qs();
 	local_irq_disable();
 
-	pending = local_softirq_pending();
 	if (pending) {
+		or_softirq_pending(pending);
+	} else {
+		pending = local_softirq_pending();
+		if (!pending)
+			goto out;
 		if (!__softirq_needs_break(tbreak) && --max_restart)
 			goto restart;
-
-		wakeup_softirqd();
 	}
 
+	wakeup_softirqd();
+out:
 	lockdep_softirq_end(in_hardirq);
 	account_irq_exit_time(current);
 	__local_bh_enable(SOFTIRQ_OFFSET);

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=tglx-softirq-prevent-starvation-of-higher-softirq-vectors.patch

Subject: softirq; Prevent starvation of higher softirq vectors
From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 24 Sep 2020 10:40:24 +0200

From: Thomas Gleixner <tglx@linutronix.de>

The early termination of the softirq processing loop can lead to starvation
of the higher numbered soft interrupt vectors because each run starts at
the lowest bit. If the loop terminates then the already processed bits can
be raised again before the next loop starts. If these lower bits run into
the termination again, then a re-raise might starve the higher bits forever.

To prevent this, store the leftovers of the previous run in the upper 16
bit of the local softirq_pending storage and ensure that these are
processed before any newly raised bits are handled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/softirq.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 8 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -259,11 +259,23 @@ static inline bool __softirq_needs_break
 	return need_resched() || __softirq_timeout(tbreak);
 }
 
+/*
+ * local_softirq_pending() is split into two 16 bit words. The low word
+ * contains the bits set by raise_softirq(), the high word contains pending
+ * bits which have not been processed in an early terminated run. This is
+ * required to prevent starvation of the higher numbered softirqs.
+ */
+#define SIRQ_PREV_SHIFT		16
+#define SIRQ_PEND_MASK		((1U << SIRQ_PREV_SHIFT) -1)
+#define SIRQ_PREV_MASK		(SIRQ_PEND_MASK << SIRQ_PREV_SHIFT)
+#define SIRQ_VECTOR_MASK	(SIRQ_PREV_SHIFT - 1)
+
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
 	unsigned int vec_nr, max_restart = MAX_SOFTIRQ_RESTART;
 	u64 tbreak = sched_clock() + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
+	u32 cur_pending, new_pending;
 	struct softirq_action *h;
 	unsigned long pending;
 	bool in_hardirq;
@@ -275,7 +287,7 @@ asmlinkage __visible void __softirq_entr
 	 */
 	current->flags &= ~PF_MEMALLOC;
 
-	pending = local_softirq_pending();
+	cur_pending = local_softirq_pending();
 	account_irq_enter_time(current);
 
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
@@ -287,9 +299,17 @@ asmlinkage __visible void __softirq_entr
 
 	local_irq_enable();
 
+	/*
+	 * Word swap pending to move the not yet handled bits of the previous
+	 * run first and then clear the duplicates in the newly raised ones.
+	 */
+	swahw32s(&cur_pending);
+	pending = cur_pending & ~(cur_pending << SIRQ_PREV_SHIFT);
+
 	for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS) {
 		int prev_count;
 
+		vec_nr &= SIRQ_VECTOR_MASK;
 		__clear_bit(vec_nr, &pending);
 		kstat_incr_softirqs_this_cpu(vec_nr);
 
@@ -312,16 +332,38 @@ asmlinkage __visible void __softirq_entr
 		rcu_softirq_qs();
 	local_irq_disable();
 
-	if (pending) {
-		or_softirq_pending(pending);
-	} else {
-		pending = local_softirq_pending();
-		if (!pending)
-			goto out;
+	/* Check for newly raised softirqs */
+	new_pending = local_softirq_pending();
+
+	/* All processed and no new ones pending? */
+	if (!pending && !new_pending)
+		goto out;
+
+	/* Did the loop process all bits or got it terminated early? */
+	if (!pending) {
+		/* Give the new onces precedence in case of terminatation */
+		cur_pending = new_pending  <<= SIRQ_PREV_SHIFT;
+		/* Restart possible? */
 		if (!__softirq_needs_break(tbreak) && --max_restart)
 			goto restart;
-	}
+	} else {
+		/*
+		 * Retain the unprocessed bits and swap @cur_pending back
+		 * into normal ordering
+		 */
+		cur_pending = (u32)pending;
+		swahw32s(&cur_pending);
+		/*
+		 * If the previous bits are done move the low word of
+		 * @pending into the high word so it's processed first.
+		 */
+		if (!(cur_pending & SIRQ_PREV_MASK))
+			cur_pending <<= SIRQ_PREV_SHIFT;
 
+		/* Merge the newly pending ones into the low word */
+		cur_pending |= new_pending;
+	}
+	set_softirq_pending(cur_pending);
 	wakeup_softirqd();
 out:
 	lockdep_softirq_end(in_hardirq);

--=-=-=--
