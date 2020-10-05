Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D4E2833BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgJEKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJEKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:00:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB72C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BL9qfT/NSdfFJcSF1d1oFJL7/9iZjoCO0TgcUMANNRY=; b=QKdNo8GUWKAZlDsn8zITkCMZjo
        ePXgAJ0Xjg+/Wrpz9mV160HNIMjP6AuygYrxAVvMNtzMKLdD+4pNIi3ZjRk4RCp0JcJ7FlfJEJaqQ
        qxEJG2MJ75KRw1ZLNVR+0IWsd0eC5Wd6pkAxHdAXRASd/7XmwdToXcoLMX6Ckw0atXKG7CPBYKMRQ
        LiJspLRshThe9lu8V7BvXPc94IGCyT2I4Fxb9KhDmQmdc1SJyAGkh4sfyAlphjF7MWj1MyQyQ3DiM
        lugFFfkTs5KYmVo6jIBQpCzTkJm+2Axd8r/5qMZSOpk8je0OpmEQEXKdEOU7FmdUx5P9NbGNSKk1J
        IG84EgIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPNHm-0007Zk-Gq; Mon, 05 Oct 2020 10:00:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA71A3011C6;
        Mon,  5 Oct 2020 11:59:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BF9629E88427; Mon,  5 Oct 2020 11:59:58 +0200 (CEST)
Date:   Mon, 5 Oct 2020 11:59:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, svens@linux.ibm.com
Subject: [PATCH] lockdep: Revert "lockdep: Use raw_cpu_*() for per-cpu
 variables"
Message-ID: <20201005095958.GJ2651@hirez.programming.kicks-ass.net>
References: <20200917131647.2b55ebb1@gandalf.local.home>
 <20200930181323.GF2628@hirez.programming.kicks-ass.net>
 <20201002135644.7903d0e5@gandalf.local.home>
 <20201002181313.GM29142@worktop.programming.kicks-ass.net>
 <20201005075206.GI2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005075206.GI2651@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 09:52:06AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 02, 2020 at 08:13:13PM +0200, Peter Zijlstra wrote:
> > > checks within the irq disabling to get rid of the using cpu pointers within
> > > preemptable code warnings
> > 
> > Ah, I think I lost a s/__this_cpu_read/raw_cpu_read/ somewhere. The
> > thing is, if we're preemptible/migratable it will be 0 on both CPUs and
> > it doesn't matter which 0 we read. If it is !0, IRQs will be disabled
> > and we can't get migrated.
> 
> Aargh, this isn't in fact correct, and that means I have to revert:
> 
>   fddf9055a60d ("lockdep: Use raw_cpu_*() for per-cpu variables")
> 
> The trouble is that on a bunch of architectures we can read the other
> CPUs variable from the new CPU, long after the old CPU has continued
> executing things.
> 
> So this really needs to be this_cpu_read(). Luckily Sven has already
> fixed s390, but let me go audit all the other archs.

---
Subject: lockdep: Revert "lockdep: Use raw_cpu_*() for per-cpu variables"
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Oct 5 09:56:57 CEST 2020

The thinking in commit:

  fddf9055a60d ("lockdep: Use raw_cpu_*() for per-cpu variables")

is flawed. While it is true that when we're migratable both CPUs will
have a 0 value, it doesn't hold that when we do get migrated in the
middle of a raw_cpu_op(), the old CPU will still have 0 by the time we
get around to reading it on the new CPU.

Luckily, the reason for that commit (s390 using preempt_disable()
instead of preempt_disable_notrace() in their percpu code), has since
been fixed by commit:

  1196f12a2c96 ("s390: don't trace preemption in percpu macros")

An audit of arch/*/include/asm/percpu*.h shows there are no other
architectures affected by this particular issue.

Fixes: fddf9055a60d ("lockdep: Use raw_cpu_*() for per-cpu variables")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/lockdep.h |   26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -537,19 +537,19 @@ do {									\
 #define lock_map_release(l)			lock_release(l, _THIS_IP_)
 
 #ifdef CONFIG_PROVE_LOCKING
-# define might_lock(lock) 						\
+# define might_lock(lock)						\
 do {									\
 	typecheck(struct lockdep_map *, &(lock)->dep_map);		\
 	lock_acquire(&(lock)->dep_map, 0, 0, 0, 1, NULL, _THIS_IP_);	\
 	lock_release(&(lock)->dep_map, _THIS_IP_);			\
 } while (0)
-# define might_lock_read(lock) 						\
+# define might_lock_read(lock)						\
 do {									\
 	typecheck(struct lockdep_map *, &(lock)->dep_map);		\
 	lock_acquire(&(lock)->dep_map, 0, 0, 1, 1, NULL, _THIS_IP_);	\
 	lock_release(&(lock)->dep_map, _THIS_IP_);			\
 } while (0)
-# define might_lock_nested(lock, subclass) 				\
+# define might_lock_nested(lock, subclass)				\
 do {									\
 	typecheck(struct lockdep_map *, &(lock)->dep_map);		\
 	lock_acquire(&(lock)->dep_map, subclass, 0, 1, 1, NULL,		\
@@ -561,29 +561,21 @@ DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
 DECLARE_PER_CPU(unsigned int, lockdep_recursion);
 
-/*
- * The below lockdep_assert_*() macros use raw_cpu_read() to access the above
- * per-cpu variables. This is required because this_cpu_read() will potentially
- * call into preempt/irq-disable and that obviously isn't right. This is also
- * correct because when IRQs are enabled, it doesn't matter if we accidentally
- * read the value from our previous CPU.
- */
-
-#define __lockdep_enabled	(debug_locks && !raw_cpu_read(lockdep_recursion))
+#define __lockdep_enabled	(debug_locks && !this_cpu_read(lockdep_recursion))
 
 #define lockdep_assert_irqs_enabled()					\
 do {									\
-	WARN_ON_ONCE(__lockdep_enabled && !raw_cpu_read(hardirqs_enabled)); \
+	WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirqs_enabled)); \
 } while (0)
 
 #define lockdep_assert_irqs_disabled()					\
 do {									\
-	WARN_ON_ONCE(__lockdep_enabled && raw_cpu_read(hardirqs_enabled)); \
+	WARN_ON_ONCE(__lockdep_enabled && this_cpu_read(hardirqs_enabled)); \
 } while (0)
 
 #define lockdep_assert_in_irq()						\
 do {									\
-	WARN_ON_ONCE(__lockdep_enabled && !raw_cpu_read(hardirq_context)); \
+	WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirq_context)); \
 } while (0)
 
 #define lockdep_assert_preemption_enabled()				\
@@ -591,7 +583,7 @@ do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
 		     __lockdep_enabled			&&		\
 		     (preempt_count() != 0		||		\
-		      !raw_cpu_read(hardirqs_enabled)));		\
+		      !this_cpu_read(hardirqs_enabled)));		\
 } while (0)
 
 #define lockdep_assert_preemption_disabled()				\
@@ -599,7 +591,7 @@ do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
 		     __lockdep_enabled			&&		\
 		     (preempt_count() == 0		&&		\
-		      raw_cpu_read(hardirqs_enabled)));			\
+		      this_cpu_read(hardirqs_enabled)));		\
 } while (0)
 
 #else
