Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A772C27F11D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgI3SNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3SNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:13:31 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F132AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vZ/HnKuRT5tR6nLrBTHMSvstDBgty5tBlA0QQylooBI=; b=ilY+O4JNer6Fyanb+axFt8u35a
        r+8BV4/fpcwz9xokjkpq7eRJVzBmkJbcUDOayeyirLhVzlDcqsidtekUkf3ueGaoPU/qH7S1ZYzWz
        /hwJrWkN37ZdBaa4Co8YsAgS1Qd+sGLwGpSzutF6xGu6QMySqZlCqjvWfJyJmllyXFk/QhkipwMQg
        2+doOPeRTI+hMpekJYzkZHRu3yhAKw3BneDQj3Vvzp2HldJBZ8KVqbgfBLOgw4IaAHTaj8sHc1fue
        k+wMYpccLPqCnEFJL9zyeTXQkr9QXCen2gAJns+RhRaB1B+hnBxfIVA/amgnC0fBhzGIJFqjpxxHb
        ZK1JvMPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNgbW-0001IS-5f; Wed, 30 Sep 2020 18:13:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F1D7B302753;
        Wed, 30 Sep 2020 20:13:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE55820115B0E; Wed, 30 Sep 2020 20:13:23 +0200 (CEST)
Date:   Wed, 30 Sep 2020 20:13:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [WARNING] kernel/rcu/tree.c:1058 rcu_irq_enter+0x15/0x20
Message-ID: <20200930181323.GF2628@hirez.programming.kicks-ass.net>
References: <20200917131647.2b55ebb1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917131647.2b55ebb1@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 01:16:46PM -0400, Steven Rostedt wrote:
> Hi Peter,
> 
> I ran my tests on a series of patches on top of 5.9-rc4, and hit the
> following splat:
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 2557 at kernel/rcu/tree.c:1058 rcu_irq_enter+0x15/0x20
>  RIP: 0010:rcu_irq_enter+0x15/0x20

>  Call Trace:
>   rcu_irq_enter_irqson+0x21/0x40
>   trace_preempt_off+0x6e/0xd0
>   unwind_next_frame+0x41/0x560
>   __unwind_start+0x153/0x1e0
>   arch_stack_walk+0x76/0x100
>   stack_trace_save+0x4b/0x70
>   save_trace+0x42/0x350
>   __lock_acquire+0x1858/0x2460
>   lock_acquire+0xdc/0x3b0
>   cpuset_read_lock+0x26/0xc0

> What looks to have happened was:
> 
>   cpuset_read_lock()
>      lockdep called
>        save stack trace
>           preempt_disable()
>              trace_preempt_disable();
>                 rcu_irq_enter_irqson();
>                    local_irq_save() (ignored by lockdep due to recursion set)
>                       rcu_irq_enter();
>                          lockdep_assert_irqs_disabled() (no, because it was ignored by recursion being set)
> 
>                           BOOM!
> 
> 
> Thoughts?

> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 6a584b3e5c74..3e5bc1dd71c6 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -550,7 +550,8 @@ do {									\
>  
>  #define lockdep_assert_irqs_disabled()					\
>  do {									\
> -	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled));	\
> +	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled) &&	\
> +           likely(!(current->lockdep_recursion & LOCKDEP_RECURSION_MASK)));\
>  } while (0)

Blergh, IIRC there's header hell that way. The sane fix is killing off
that trace_*_rcuidle() disease.

But I think this will also cure it.

---
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 6a339ce328e0..4f90293d170b 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -432,7 +432,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		return false;
 
 	/* Don't let modules unload while we're reading their ORC data. */
-	preempt_disable();
+	preempt_disable_notrace();
 
 	/* End-of-stack check for user tasks: */
 	if (state->regs && user_mode(state->regs))
@@ -612,14 +612,14 @@ bool unwind_next_frame(struct unwind_state *state)
 		goto err;
 	}
 
-	preempt_enable();
+	preempt_enable_notrace();
 	return true;
 
 err:
 	state->error = true;
 
 the_end:
-	preempt_enable();
+	preempt_enable_notrace();
 	state->stack_info.type = STACK_TYPE_UNKNOWN;
 	return false;
 }
