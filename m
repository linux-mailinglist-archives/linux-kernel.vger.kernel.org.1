Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5560280F6E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 11:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbgJBJEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 05:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgJBJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:04:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C806BC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 02:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UPgkKpf2KLW7NTadJ/ufBcqqYUd7cQ/xFgIflBKKIFg=; b=wO/cDRi1qiwZMSEqpqkz48lIcw
        gWI0SvjOUcGCGSSN2ZmimtQvdGtkLVCViFavpTH1mBNf9P4B0I7BxadoziFMwHWixvbIGqquJolSO
        zoiy5VwGWWJU6qGsUaxmRdNjq4atC+S2d/0qOAhdtXitCqzkiNAGzOQPPGMirWpQxYaXczGUHWu+8
        RFoUZsZtwdxYj38vgatrxGZ6I5vovII04Fp0uCsNMK6eIxLowqTjQqf5uX9Ax/liJ7uUd5lk62Kcf
        tI7pMKKhEMrRDuvKV7LrEEVLSUPd0pSW8AMTJ6k4T/LG9jEdeMyA6mCZlOyUhqg1SiahBIw92MIXa
        qPciWvUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOGzI-00077l-G8; Fri, 02 Oct 2020 09:04:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC051304B92;
        Fri,  2 Oct 2020 11:04:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91E5B2011674A; Fri,  2 Oct 2020 11:04:21 +0200 (CEST)
Date:   Fri, 2 Oct 2020 11:04:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [WARNING] kernel/rcu/tree.c:1058 rcu_irq_enter+0x15/0x20
Message-ID: <20201002090421.GT2628@hirez.programming.kicks-ass.net>
References: <20200917131647.2b55ebb1@gandalf.local.home>
 <20200930181323.GF2628@hirez.programming.kicks-ass.net>
 <20200930151026.4a87ab79@gandalf.local.home>
 <20200930192242.GM2611@hirez.programming.kicks-ass.net>
 <20200930155222.6754ce6c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930155222.6754ce6c@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:52:22PM -0400, Steven Rostedt wrote:
> On Wed, 30 Sep 2020 21:22:42 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Sep 30, 2020 at 03:10:26PM -0400, Steven Rostedt wrote:
> > > On Wed, 30 Sep 2020 20:13:23 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > >   
> > > >  diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h  
> > > > > index 6a584b3e5c74..3e5bc1dd71c6 100644
> > > > > --- a/include/linux/lockdep.h
> > > > > +++ b/include/linux/lockdep.h
> > > > > @@ -550,7 +550,8 @@ do {									\
> > > > >  
> > > > >  #define lockdep_assert_irqs_disabled()					\
> > > > >  do {									\
> > > > > -	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled));	\
> > > > > +	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled) &&	\
> > > > > +           likely(!(current->lockdep_recursion & LOCKDEP_RECURSION_MASK)));\
> > > > >  } while (0)    
> > > > 
> > > > Blergh, IIRC there's header hell that way. The sane fix is killing off
> > > > that trace_*_rcuidle() disease.  
> > > 
> > > Really?
> > > 
> > > I could run this through all my other tests to see if that is the case.
> > > That is, to see if it stumbles across header hell.  
> > 
> > I went through a lot of pain to make that per-cpu to avoid using
> > current. But that might've been driven by
> > lockdep_assert_preemption_disabled(), which is used in seqlock.h which
> > in turn is included all over the place.
> > 
> > That said, there's at least two things we can do:
> > 
> >  - make lockdep_recursion per-cpu too, IIRC we only ever set that when
> >    we have IRQs disabled anyway.
> > 
> > OR
> > 
> >  - inspired by the above, as can save/clear - restore hardirqs_enabled
> >    when we frob lockdep_recursion.
> > 
> > Admittedly, the second is somewhat gross :-)
> 
> I think making lockdep_recursion percpu sounds like the best approach.
> 
> -- Steve

Bugger, we use current->lockdep_recursion also for lockdep_off(); I
always forget about that thing.

Anyway, something like so then.

---
 include/linux/lockdep.h  |  13 +++---
 kernel/locking/lockdep.c | 101 ++++++++++++++++++++++++++++-------------------
 2 files changed, 68 insertions(+), 46 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 57d642d378c7..1cc982536640 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -559,6 +559,7 @@ do {									\
 
 DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
+DECLARE_PER_CPU(unsigned int, lockdep_recursion);
 
 /*
  * The below lockdep_assert_*() macros use raw_cpu_read() to access the above
@@ -568,25 +569,27 @@ DECLARE_PER_CPU(int, hardirq_context);
  * read the value from our previous CPU.
  */
 
+#define __lockdep_enabled	(debug_locks && !raw_cpu_read(lockdep_recursion))
+
 #define lockdep_assert_irqs_enabled()					\
 do {									\
-	WARN_ON_ONCE(debug_locks && !raw_cpu_read(hardirqs_enabled));	\
+	WARN_ON_ONCE(__lockdep_enabled && !raw_cpu_read(hardirqs_enabled)); \
 } while (0)
 
 #define lockdep_assert_irqs_disabled()					\
 do {									\
-	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled));	\
+	WARN_ON_ONCE(__lockdep_enabled && raw_cpu_read(hardirqs_enabled)); \
 } while (0)
 
 #define lockdep_assert_in_irq()						\
 do {									\
-	WARN_ON_ONCE(debug_locks && !raw_cpu_read(hardirq_context));	\
+	WARN_ON_ONCE(__lockdep_enabled && !raw_cpu_read(hardirq_context)); \
 } while (0)
 
 #define lockdep_assert_preemption_enabled()				\
 do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     debug_locks			&&		\
+		     __lockdep_enabled			&&		\
 		     (preempt_count() != 0		||		\
 		      !raw_cpu_read(hardirqs_enabled)));		\
 } while (0)
@@ -594,7 +597,7 @@ do {									\
 #define lockdep_assert_preemption_disabled()				\
 do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     debug_locks			&&		\
+		     __lockdep_enabled			&&		\
 		     (preempt_count() == 0		&&		\
 		      raw_cpu_read(hardirqs_enabled)));			\
 } while (0)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 454355c033d2..47942557b4fb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -76,6 +76,22 @@ module_param(lock_stat, int, 0644);
 #define lock_stat 0
 #endif
 
+DEFINE_PER_CPU(unsigned int, lockdep_recursion);
+
+static inline bool lockdep_enabled(void)
+{
+	if (!debug_locks)
+		return false;
+
+	if (__this_cpu_read(lockdep_recursion))
+		return false;
+
+	if (current->lockdep_recursion)
+		return false;
+
+	return true;
+}
+
 /*
  * lockdep_lock: protects the lockdep graph, the hashes and the
  *               class/list/hash allocators.
@@ -93,7 +109,7 @@ static inline void lockdep_lock(void)
 
 	arch_spin_lock(&__lock);
 	__owner = current;
-	current->lockdep_recursion++;
+	__this_cpu_inc(lockdep_recursion);
 }
 
 static inline void lockdep_unlock(void)
@@ -101,7 +117,7 @@ static inline void lockdep_unlock(void)
 	if (debug_locks && DEBUG_LOCKS_WARN_ON(__owner != current))
 		return;
 
-	current->lockdep_recursion--;
+	__this_cpu_dec(lockdep_recursion);
 	__owner = NULL;
 	arch_spin_unlock(&__lock);
 }
@@ -408,10 +424,15 @@ void lockdep_init_task(struct task_struct *task)
 	task->lockdep_recursion = 0;
 }
 
+static __always_inline void lockdep_recursion_inc(void)
+{
+	__this_cpu_inc(lockdep_recursion);
+}
+
 static __always_inline void lockdep_recursion_finish(void)
 {
-	if (WARN_ON_ONCE((--current->lockdep_recursion) & LOCKDEP_RECURSION_MASK))
-		current->lockdep_recursion = 0;
+	if (WARN_ON_ONCE(__this_cpu_dec_return(lockdep_recursion)))
+		__this_cpu_write(lockdep_recursion, 0);
 }
 
 void lockdep_set_selftest_task(struct task_struct *task)
@@ -4012,7 +4033,7 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 	if (unlikely(in_nmi()))
 		return;
 
-	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
+	if (unlikely(__this_cpu_read(lockdep_recursion)))
 		return;
 
 	if (unlikely(lockdep_hardirqs_enabled())) {
@@ -4048,7 +4069,7 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 
 	current->hardirq_chain_key = current->curr_chain_key;
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	__trace_hardirqs_on_caller();
 	lockdep_recursion_finish();
 }
@@ -4081,7 +4102,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 		goto skip_checks;
 	}
 
-	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
+	if (unlikely(__this_cpu_read(lockdep_recursion)))
 		return;
 
 	if (lockdep_hardirqs_enabled()) {
@@ -4134,7 +4155,7 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 	if (in_nmi()) {
 		if (!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_NMI))
 			return;
-	} else if (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)
+	} else if (__this_cpu_read(lockdep_recursion))
 		return;
 
 	/*
@@ -4167,7 +4188,7 @@ void lockdep_softirqs_on(unsigned long ip)
 {
 	struct irqtrace_events *trace = &current->irqtrace;
 
-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	/*
@@ -4182,7 +4203,7 @@ void lockdep_softirqs_on(unsigned long ip)
 		return;
 	}
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	/*
 	 * We'll do an OFF -> ON transition:
 	 */
@@ -4205,7 +4226,7 @@ void lockdep_softirqs_on(unsigned long ip)
  */
 void lockdep_softirqs_off(unsigned long ip)
 {
-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	/*
@@ -4590,11 +4611,11 @@ void lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
 	if (subclass) {
 		unsigned long flags;
 
-		if (DEBUG_LOCKS_WARN_ON(current->lockdep_recursion))
+		if (DEBUG_LOCKS_WARN_ON(!lockdep_enabled()))
 			return;
 
 		raw_local_irq_save(flags);
-		current->lockdep_recursion++;
+		lockdep_recursion_inc();
 		register_lock_class(lock, subclass, 1);
 		lockdep_recursion_finish();
 		raw_local_irq_restore(flags);
@@ -5277,11 +5298,11 @@ void lock_set_class(struct lockdep_map *lock, const char *name,
 {
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	check_flags(flags);
 	if (__lock_set_class(lock, name, key, subclass, ip))
 		check_chain_key(current);
@@ -5294,11 +5315,11 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	check_flags(flags);
 	if (__lock_downgrade(lock, ip))
 		check_chain_key(current);
@@ -5336,7 +5357,7 @@ static void verify_lock_unused(struct lockdep_map *lock, struct held_lock *hlock
 
 static bool lockdep_nmi(void)
 {
-	if (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)
+	if (__this_cpu_read(lockdep_recursion))
 		return false;
 
 	if (!in_nmi())
@@ -5371,7 +5392,11 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
 
-	if (unlikely(current->lockdep_recursion)) {
+	if (!debug_locks)
+		return;
+
+	raw_local_irq_save(flags);
+	if (unlikely(!lockdep_enabled())) {
 		/* XXX allow trylock from NMI ?!? */
 		if (lockdep_nmi() && !trylock) {
 			struct held_lock hlock;
@@ -5388,13 +5413,13 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 			verify_lock_unused(lock, &hlock, subclass);
 		}
+		raw_local_irq_restore(flags);
 		return;
 	}
 
-	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
 	lockdep_recursion_finish();
@@ -5408,13 +5433,13 @@ void lock_release(struct lockdep_map *lock, unsigned long ip)
 
 	trace_lock_release(lock, ip);
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	if (__lock_release(lock, ip))
 		check_chain_key(current);
 	lockdep_recursion_finish();
@@ -5427,13 +5452,13 @@ noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
 	unsigned long flags;
 	int ret = 0;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return 1; /* avoid false negative lockdep_assert_held() */
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	ret = __lock_is_held(lock, read);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5448,13 +5473,13 @@ struct pin_cookie lock_pin_lock(struct lockdep_map *lock)
 	struct pin_cookie cookie = NIL_COOKIE;
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return cookie;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	cookie = __lock_pin_lock(lock);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5467,13 +5492,13 @@ void lock_repin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 {
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	__lock_repin_lock(lock, cookie);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5484,13 +5509,13 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 {
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	__lock_unpin_lock(lock, cookie);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5620,15 +5645,12 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 
 	trace_lock_acquired(lock, ip);
 
-	if (unlikely(!lock_stat || !debug_locks))
-		return;
-
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lock_stat || !lockdep_enabled()))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	__lock_contended(lock, ip);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5641,15 +5663,12 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 
 	trace_lock_contended(lock, ip);
 
-	if (unlikely(!lock_stat || !debug_locks))
-		return;
-
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lock_stat || !lockdep_enabled()))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	__lock_acquired(lock, ip);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
