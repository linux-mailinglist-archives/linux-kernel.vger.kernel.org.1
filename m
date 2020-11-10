Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386C52AE385
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbgKJWml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbgKJWmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:42:40 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF5FC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:42:38 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id m65so9865456qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NDBouXbWfB+Lo7mB10/ImmIuWBAzTDWWj7YHNhQTLU8=;
        b=YWEAUkk6QPX2H6FPqZZUzKO8BZ6Hz0eUOqnr8+htF45pEayGfGTNXtcH/5btoClKGq
         Do3SAYDHmM7PLmBZb7wualzLN3HogPVKavlhNmp2G3Yx/VM570NlmWgWLcHd7XoUeBfo
         xDOrWKU7eHGUZk2URO3xoKGSNj/olIEpCPnAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NDBouXbWfB+Lo7mB10/ImmIuWBAzTDWWj7YHNhQTLU8=;
        b=k3uyGLn6JZlCKNS79XDtT7CwIRHFhNEdGvbSr5a53+h2dr5cXiCCDZpmAsezvN/Jli
         q/3cjcI8iTAsBDdMn1tgaSqlnfaXcfnGhs/lUnvhM1uLV/ZfF3Ms7Vbbo83eYRZokv9v
         A8SYIVaohCJlPZIYLm41GL5tgBM6wR2WdOfbwnnUQ5GRUZpZztkR5ZvUs8kuvqn5TrJP
         JDXKsBPuVwhwmVOsMmPFvisRhWNMA3gQmpvu2UhS2WwpIF8mcUOpCg26tbB54DxY1X16
         T4fLooxGhBLhBPdmVT3Bt/7QFiGFrGkUFVIbNimRYmJ6bOPpV9hl9NfrJIJlJZKwZln/
         Jh0g==
X-Gm-Message-State: AOAM530E83BkcSeQjZcw1a1VSakk9S0bjcRTxuD8vOAoHnBRv0KvSMH+
        yUliqv7WC/EsGvH6TXp8syx78w==
X-Google-Smtp-Source: ABdhPJwVI7NxVk/H+ve+UUIrc2LQxtAwAoR+FwhUvtE/6ic6RoCJav8G9LhiI131D8IAsKAV07wsbg==
X-Received: by 2002:aed:3ae5:: with SMTP id o92mr20236679qte.265.1605048157959;
        Tue, 10 Nov 2020 14:42:37 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id h129sm250628qkd.35.2020.11.10.14.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 14:42:37 -0800 (PST)
Date:   Tue, 10 Nov 2020 17:42:36 -0500
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
Message-ID: <20201110224236.GA696041@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-14-joel@joelfernandes.org>
 <60cfc619-1521-814d-8894-df9fc61d615c@oracle.com>
 <20201103012002.GA673080@google.com>
 <e830757c-96ce-c927-9b94-f1af3b71e6ba@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e830757c-96ce-c927-9b94-f1af3b71e6ba@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:35:17AM +0100, Alexandre Chartre wrote:
[..] 
> > ---8<-----------------------
> > 
> >  From b2835a587a28405ffdf8fc801e798129a014a8c8 Mon Sep 17 00:00:00 2001
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Date: Mon, 27 Jul 2020 17:56:14 -0400
> > Subject: [PATCH] kernel/entry: Add support for core-wide protection of
> >   kernel-mode
[..]
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
> 
> Function should be static.

Fixed.

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
> 
> What happen if the task is scheduled out in exit_to_user_mode_loop? (e.g. if it has
> _TIF_NEED_RESCHED set). It will have call sched_core_unsafe_enter() and force siblings
> to wait for it. So shouldn't sched_core_unsafe_exit() be called when the task is
> scheduled out? (because it won't run anymore) And sched_core_unsafe_enter() when
> the task is scheduled back in?

No, when the task is scheduled out, it will in kernel mode on the task being
scheduled in. That task (being scheduled-in) would have already done a
sched_core_unsafe_enter(). When that task returns to user made, it will do a
sched_core_unsafe_exit(). When all tasks goto sleep, the last task that
enters the idle loop will do a sched_core_unsafe_exit(). Just to note: the
"unsafe kernel context" is per-CPU and not per-task. Does that answer your
question?

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
> 
> Do you mean "no need to check for it" ?

Fixed.

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
> 
> Should we clear TIF_UNSAFE_RET if (!sched_core_enabled(rq))? This would avoid calling
> sched_core_wait_till_safe().

Ok, or what I'll do is move the set_tsk_thread_flag to after the check for
sched_core_enabled().

> > +
> > +	/* Count unsafe_enter() calls received without unsafe_exit() on this CPU. */
> > +	rq->core_this_unsafe_nest++;
> > +
> > +	/* Should not nest: enter() should only pair with exit(). */
> > +	if (WARN_ON_ONCE(rq->core_this_unsafe_nest != 1))
> > +		goto ret;
> 
> I would be more precise about the nesting comment: we don't nest not only because each
> enter() is paired with an exit() but because each enter()/exit() is for a user context.
> We can have nested interrupts but they will be for a kernel context so they won't enter/exit.
> 
> So I would say something like:
> 
>         /*
>          * Should not nest: each enter() is paired with an exit(), and enter()/exit()
>          * are done when coming from userspace. We can have nested interrupts between
>          * enter()/exit() but they will originate from the kernel so they won't enter()
>          * nor exit().
>          */

Changed it to following, hope its ok with you:
        /*
         * Should not nest: enter() should only pair with exit(). Both are done
         * during the first entry into kernel and the last exit from kernel.
         * Nested kernel entries (such as nested interrupts) will only trigger
         * enter() and exit() on the outer most kernel entry and exit.
         */

> > +
> > +	raw_spin_lock(rq_lockp(rq));
> > +	smt_mask = cpu_smt_mask(cpu);
> > +
> > +	/* Contribute this CPU's unsafe_enter() to core-wide unsafe_enter() count. */
> > +	WRITE_ONCE(rq->core->core_unsafe_nest, rq->core->core_unsafe_nest + 1);
> 
> We are protected by the rq_lockp(rq) spinlock, but we still need to use WRITE_ONCE()
> because sched_core_wait_till_safe() checks core_unsafe_next without taking rq_lockp(rq),
> right?

Yes.

> Shouldn't we be using smp_store_release() like sched_core_unsafe_exit() does?
> 
> In any case, it is worth having a comment why WRITE_ONCE() or smp_store_release() is
> used.

The smp_store_release() in exit() ensures that the write to the nesting
counter happens *after* all prior reads and write accesses done by this CPU
are seen by the spinning CPU doing the smp_load_acquire() before that
spinning CPU returns. I did put a comment there.

But, I think I don't need smp_store_release() at all here. The spin_unlock
that follows already has the required release semantics. I will demote it to
a WRITE_ONCE() in enter() as well, and add appropriate comments.

> > +
> > +	if (WARN_ON_ONCE(rq->core->core_unsafe_nest == UINT_MAX))
> > +		goto unlock;
> 
> It might be better checking if (rq->core->core_unsafe_nest >= cpumask_weight(smt_mask))
> because we shouldn't exceed the number of siblings.

I am a bit concerned with the time complexity of cpumask_weight(). It may be
better not to add overhead. I am not fully sure how it works but there is a
loop in bitmask weight that goes through the bits of the bitmap, what is your
opinion on that?

Can I add your Reviewed-by tag to below updated patch? Thanks for review!

 - Joel

---8<---

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bd1a5b87a5e2..a36f08d74e09 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4678,6 +4678,15 @@
 
 	sbni=		[NET] Granch SBNI12 leased line adapter
 
+	sched_core_protect_kernel=
+			[SCHED_CORE] Pause SMT siblings of a core running in
+			user mode, if at least one of the siblings of the core
+			is running in kernel mode. This is to guarantee that
+			kernel data is not leaked to tasks which are not trusted
+			by the kernel. A value of 0 disables protection, 1
+			enables protection. The default is 1. Note that protection
+			depends on the arch defining the _TIF_UNSAFE_RET flag.
+
 	sched_debug	[KNL] Enables verbose scheduler debug messages.
 
 	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 474f29638d2c..62278c5b3b5f 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -33,6 +33,10 @@
 # define _TIF_PATCH_PENDING		(0)
 #endif
 
+#ifndef _TIF_UNSAFE_RET
+# define _TIF_UNSAFE_RET		(0)
+#endif
+
 #ifndef _TIF_UPROBE
 # define _TIF_UPROBE			(0)
 #endif
@@ -69,7 +73,7 @@
 
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
-	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING |			\
+	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_UNSAFE_RET |	\
 	 ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d38e904dd603..fe6f225bfbf9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2071,4 +2071,16 @@ int sched_trace_rq_nr_running(struct rq *rq);
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 
+#ifdef CONFIG_SCHED_CORE
+void sched_core_unsafe_enter(void);
+void sched_core_unsafe_exit(void);
+bool sched_core_wait_till_safe(unsigned long ti_check);
+bool sched_core_kernel_protected(void);
+#else
+#define sched_core_unsafe_enter(ignore) do { } while (0)
+#define sched_core_unsafe_exit(ignore) do { } while (0)
+#define sched_core_wait_till_safe(ignore) do { } while (0)
+#define sched_core_kernel_protected(ignore) do { } while (0)
+#endif
+
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 2b8366693d5c..d5d88e735d55 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -28,6 +28,8 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
+	if (_TIF_UNSAFE_RET) /* Kernel protection depends on arch defining the flag. */
+		sched_core_unsafe_enter();
 	instrumentation_end();
 }
 
@@ -137,6 +139,27 @@ static __always_inline void exit_to_user_mode(void)
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal(struct pt_regs *regs) { }
 
+static unsigned long exit_to_user_get_work(void)
+{
+	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+
+	if ((IS_ENABLED(CONFIG_SCHED_CORE) && !sched_core_kernel_protected())
+	    || !_TIF_UNSAFE_RET)
+		return ti_work;
+
+#ifdef CONFIG_SCHED_CORE
+	ti_work &= EXIT_TO_USER_MODE_WORK;
+	if ((ti_work & _TIF_UNSAFE_RET) == ti_work) {
+		sched_core_unsafe_exit();
+		if (sched_core_wait_till_safe(EXIT_TO_USER_MODE_WORK)) {
+			sched_core_unsafe_enter(); /* not exiting to user yet. */
+		}
+	}
+
+	return READ_ONCE(current_thread_info()->flags);
+#endif
+}
+
 static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 					    unsigned long ti_work)
 {
@@ -174,7 +197,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		 * enabled above.
 		 */
 		local_irq_disable_exit_to_user();
-		ti_work = READ_ONCE(current_thread_info()->flags);
+		ti_work = exit_to_user_get_work();
 	}
 
 	/* Return the latest work state for arch_exit_to_user_mode() */
@@ -183,9 +206,10 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 static void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
-	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+	unsigned long ti_work;
 
 	lockdep_assert_irqs_disabled();
+	ti_work = exit_to_user_get_work();
 
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
 		ti_work = exit_to_user_mode_loop(regs, ti_work);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fa68941998e3..429f9b8ca38e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -76,6 +76,27 @@ __read_mostly int scheduler_running;
 
 #ifdef CONFIG_SCHED_CORE
 
+DEFINE_STATIC_KEY_TRUE(sched_core_protect_kernel);
+static int __init set_sched_core_protect_kernel(char *str)
+{
+	unsigned long val = 0;
+
+	if (!str)
+		return 0;
+
+	if (!kstrtoul(str, 0, &val) && !val)
+		static_branch_disable(&sched_core_protect_kernel);
+
+	return 1;
+}
+__setup("sched_core_protect_kernel=", set_sched_core_protect_kernel);
+
+/* Is the kernel protected by core scheduling? */
+bool sched_core_kernel_protected(void)
+{
+	return static_branch_likely(&sched_core_protect_kernel);
+}
+
 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
 
 /* kernel prio, less is more */
@@ -4596,6 +4617,226 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 	return a->core_cookie == b->core_cookie;
 }
 
+/*
+ * Handler to attempt to enter kernel. It does nothing because the exit to
+ * usermode or guest mode will do the actual work (of waiting if needed).
+ */
+static void sched_core_irq_work(struct irq_work *work)
+{
+	return;
+}
+
+static inline void init_sched_core_irq_work(struct rq *rq)
+{
+	init_irq_work(&rq->core_irq_work, sched_core_irq_work);
+}
+
+/*
+ * sched_core_wait_till_safe - Pause the caller's hyperthread until the core
+ * exits the core-wide unsafe state. Obviously the CPU calling this function
+ * should not be responsible for the core being in the core-wide unsafe state
+ * otherwise it will deadlock.
+ *
+ * @ti_check: We spin here with IRQ enabled and preempt disabled. Break out of
+ *            the loop if TIF flags are set and notify caller about it.
+ *
+ * IRQs should be disabled.
+ */
+bool sched_core_wait_till_safe(unsigned long ti_check)
+{
+	bool restart = false;
+	struct rq *rq;
+	int cpu;
+
+	/* We clear the thread flag only at the end, so no need to check for it. */
+	ti_check &= ~_TIF_UNSAFE_RET;
+
+	cpu = smp_processor_id();
+	rq = cpu_rq(cpu);
+
+	if (!sched_core_enabled(rq))
+		goto ret;
+
+	/* Down grade to allow interrupts to prevent stop_machine lockups.. */
+	preempt_disable();
+	local_irq_enable();
+
+	/*
+	 * Wait till the core of this HT is not in an unsafe state.
+	 *
+	 * Pair with smp_store_release() in sched_core_unsafe_exit().
+	 */
+	while (smp_load_acquire(&rq->core->core_unsafe_nest) > 0) {
+		cpu_relax();
+		if (READ_ONCE(current_thread_info()->flags) & ti_check) {
+			restart = true;
+			break;
+		}
+	}
+
+	/* Upgrade it back to the expectations of entry code. */
+	local_irq_disable();
+	preempt_enable();
+
+ret:
+	if (!restart)
+		clear_tsk_thread_flag(current, TIF_UNSAFE_RET);
+
+	return restart;
+}
+
+/*
+ * Enter the core-wide IRQ state. Sibling will be paused if it is running
+ * 'untrusted' code, until sched_core_unsafe_exit() is called. Every attempt to
+ * avoid sending useless IPIs is made. Must be called only from hard IRQ
+ * context.
+ */
+void sched_core_unsafe_enter(void)
+{
+	const struct cpumask *smt_mask;
+	unsigned long flags;
+	struct rq *rq;
+	int i, cpu;
+
+	if (!static_branch_likely(&sched_core_protect_kernel))
+		return;
+
+	local_irq_save(flags);
+	cpu = smp_processor_id();
+	rq = cpu_rq(cpu);
+	if (!sched_core_enabled(rq))
+		goto ret;
+
+	/* Ensure that on return to user/guest, we check whether to wait. */
+	if (current->core_cookie)
+		set_tsk_thread_flag(current, TIF_UNSAFE_RET);
+
+	/* Count unsafe_enter() calls received without unsafe_exit() on this CPU. */
+	rq->core_this_unsafe_nest++;
+
+	/*
+	 * Should not nest: enter() should only pair with exit(). Both are done
+	 * during the first entry into kernel and the last exit from kernel.
+	 * Nested kernel entries (such as nested interrupts) will only trigger
+	 * enter() and exit() on the outer most kernel entry and exit.
+	 */
+	if (WARN_ON_ONCE(rq->core_this_unsafe_nest != 1))
+		goto ret;
+
+	raw_spin_lock(rq_lockp(rq));
+	smt_mask = cpu_smt_mask(cpu);
+
+	/*
+	 * Contribute this CPU's unsafe_enter() to the core-wide unsafe_enter()
+	 * count.  The raw_spin_unlock() release semantics pairs with the nest
+	 * counter's smp_load_acquire() in sched_core_wait_till_safe().
+	 */
+	WRITE_ONCE(rq->core->core_unsafe_nest, rq->core->core_unsafe_nest + 1);
+
+	if (WARN_ON_ONCE(rq->core->core_unsafe_nest == UINT_MAX))
+		goto unlock;
+
+	if (irq_work_is_busy(&rq->core_irq_work)) {
+		/*
+		 * Do nothing more since we are in an IPI sent from another
+		 * sibling to enforce safety. That sibling would have sent IPIs
+		 * to all of the HTs.
+		 */
+		goto unlock;
+	}
+
+	/*
+	 * If we are not the first ones on the core to enter core-wide unsafe
+	 * state, do nothing.
+	 */
+	if (rq->core->core_unsafe_nest > 1)
+		goto unlock;
+
+	/* Do nothing more if the core is not tagged. */
+	if (!rq->core->core_cookie)
+		goto unlock;
+
+	for_each_cpu(i, smt_mask) {
+		struct rq *srq = cpu_rq(i);
+
+		if (i == cpu || cpu_is_offline(i))
+			continue;
+
+		if (!srq->curr->mm || is_task_rq_idle(srq->curr))
+			continue;
+
+		/* Skip if HT is not running a tagged task. */
+		if (!srq->curr->core_cookie && !srq->core_pick)
+			continue;
+
+		/*
+		 * Force sibling into the kernel by IPI. If work was already
+		 * pending, no new IPIs are sent. This is Ok since the receiver
+		 * would already be in the kernel, or on its way to it.
+		 */
+		irq_work_queue_on(&srq->core_irq_work, i);
+	}
+unlock:
+	raw_spin_unlock(rq_lockp(rq));
+ret:
+	local_irq_restore(flags);
+}
+
+/*
+ * Process any work need for either exiting the core-wide unsafe state, or for
+ * waiting on this hyperthread if the core is still in this state.
+ *
+ * @idle: Are we called from the idle loop?
+ */
+void sched_core_unsafe_exit(void)
+{
+	unsigned long flags;
+	unsigned int nest;
+	struct rq *rq;
+	int cpu;
+
+	if (!static_branch_likely(&sched_core_protect_kernel))
+		return;
+
+	local_irq_save(flags);
+	cpu = smp_processor_id();
+	rq = cpu_rq(cpu);
+
+	/* Do nothing if core-sched disabled. */
+	if (!sched_core_enabled(rq))
+		goto ret;
+
+	/*
+	 * Can happen when a process is forked and the first return to user
+	 * mode is a syscall exit. Either way, there's nothing to do.
+	 */
+	if (rq->core_this_unsafe_nest == 0)
+		goto ret;
+
+	rq->core_this_unsafe_nest--;
+
+	/* enter() should be paired with exit() only. */
+	if (WARN_ON_ONCE(rq->core_this_unsafe_nest != 0))
+		goto ret;
+
+	raw_spin_lock(rq_lockp(rq));
+	/*
+	 * Core-wide nesting counter can never be 0 because we are
+	 * still in it on this CPU.
+	 */
+	nest = rq->core->core_unsafe_nest;
+	WARN_ON_ONCE(!nest);
+
+	WRITE_ONCE(rq->core->core_unsafe_nest, nest - 1);
+	/*
+	 * The raw_spin_unlock release semantics pairs with the nest counter's
+	 * smp_load_acquire() in sched_core_wait_till_safe().
+	 */
+	raw_spin_unlock(rq_lockp(rq));
+ret:
+	local_irq_restore(flags);
+}
+
 // XXX fairness/fwd progress conditions
 /*
  * Returns
@@ -4991,6 +5232,7 @@ static inline void sched_core_cpu_starting(unsigned int cpu)
 			rq = cpu_rq(i);
 			if (rq->core && rq->core == rq)
 				core_rq = rq;
+			init_sched_core_irq_work(rq);
 		}
 
 		if (!core_rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 001382bc67f9..20937a5b6272 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1061,6 +1061,8 @@ struct rq {
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
+	struct irq_work		core_irq_work; /* To force HT into kernel */
+	unsigned int		core_this_unsafe_nest;
 
 	/* shared state */
 	unsigned int		core_task_seq;
@@ -1068,6 +1070,7 @@ struct rq {
 	unsigned long		core_cookie;
 	unsigned char		core_forceidle;
 	unsigned int		core_forceidle_seq;
+	unsigned int		core_unsafe_nest;
 #endif
 };
 
