Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF2D2405F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHJMeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 08:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:32988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgHJMeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:34:20 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14BBD2078D;
        Mon, 10 Aug 2020 12:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597062859;
        bh=7q658YYiM8sfTsaYHIM5HAWIKjH/ScMVjJoBtH2g4/g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DndfMPaBLunsSFNO/ZtSya7epqU9l/t7j75mKQEdGfAPCfx9th2gRkCcRLWDiA8ti
         bdCHlh4/6FoPItugUYWyRE49myqVoV87+YpgT60Mo+KabxbdHvBhqeSEXtDf+aYfwF
         7VPR8dBaAvviUZ3OaFZ7x9MxnKuNljNYBxSnTJjs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DC4F435228C7; Mon, 10 Aug 2020 05:34:18 -0700 (PDT)
Date:   Mon, 10 Aug 2020 05:34:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>
Subject: Re: [PATCH] kcsan: Treat runtime as NMI-like with interrupt tracing
Message-ID: <20200810123418.GH4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200807090031.3506555-1-elver@google.com>
 <20200807170618.GW4295@paulmck-ThinkPad-P72>
 <CANpmjNPqEeQvg53wJ5EsyfssSqyOqCsPG+YTV6ytj6wsc+5BPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPqEeQvg53wJ5EsyfssSqyOqCsPG+YTV6ytj6wsc+5BPQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:07:44AM +0200, Marco Elver wrote:
> On Fri, 7 Aug 2020 at 19:06, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Fri, Aug 07, 2020 at 11:00:31AM +0200, Marco Elver wrote:
> > > Since KCSAN instrumentation is everywhere, we need to treat the hooks
> > > NMI-like for interrupt tracing. In order to present an as 'normal' as
> > > possible context to the code called by KCSAN when reporting errors, we
> > > need to update the IRQ-tracing state.
> > >
> > > Tested: Several runs through kcsan-test with different configuration
> > > (PROVE_LOCKING on/off), as well as hours of syzbot testing with the
> > > original config that caught the problem (without CONFIG_PARAVIRT=y,
> > > which appears to cause IRQ state tracking inconsistencies even when
> > > KCSAN remains off, see Link).
> > >
> > > Link: https://lkml.kernel.org/r/0000000000007d3b2d05ac1c303e@google.com
> > > Fixes: 248591f5d257 ("kcsan: Make KCSAN compatible with new IRQ state tracking")
> > > Reported-by: syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com
> > > Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Peter, if you're fine with it, I think we'll require your
> Signed-off-by (since Co-developed-by).
> 
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > > Patch Note: This patch applies to latest mainline. While current
> > > mainline suffers from the above problem, the configs required to hit the
> > > issue are likely not enabled too often (of course with PROVE_LOCKING on;
> > > we hit it on syzbot though). It'll probably be wise to queue this as
> > > normal on -rcu, just in case something is still off, given the
> > > non-trivial nature of the issue. (If it should instead go to mainline
> > > right now as a fix, I'd like some more test time on syzbot.)
> >
> > The usual, please let me know when/if you would like me to apply
> > to -rcu.  And have a great weekend!
> 
> I think we need to wait until you have rebased -rcu to 5.9-rc1 some
> time next week. I will send a reminder after, and if it doesn't apply
> cleanly, I'll send a rebased patch.

Sounds good, thank you!

							Thanx, Paul

> Thank you!
> 
> -- Marco
> 
> >                                                 Thanx, Paul
> >
> > > ---
> > >  kernel/kcsan/core.c  | 79 ++++++++++++++++++++++++++++++++++----------
> > >  kernel/kcsan/kcsan.h |  3 +-
> > >  2 files changed, 62 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > > index 9147ff6a12e5..6202a645f1e2 100644
> > > --- a/kernel/kcsan/core.c
> > > +++ b/kernel/kcsan/core.c
> > > @@ -291,13 +291,28 @@ static inline unsigned int get_delay(void)
> > >                               0);
> > >  }
> > >
> > > -void kcsan_save_irqtrace(struct task_struct *task)
> > > -{
> > > +/*
> > > + * KCSAN instrumentation is everywhere, which means we must treat the hooks
> > > + * NMI-like for interrupt tracing. In order to present a 'normal' as possible
> > > + * context to the code called by KCSAN when reporting errors we need to update
> > > + * the IRQ-tracing state.
> > > + *
> > > + * Save and restore the IRQ state trace touched by KCSAN, since KCSAN's
> > > + * runtime is entered for every memory access, and potentially useful
> > > + * information is lost if dirtied by KCSAN.
> > > + */
> > > +
> > > +struct kcsan_irq_state {
> > > +     unsigned long           flags;
> > >  #ifdef CONFIG_TRACE_IRQFLAGS
> > > -     task->kcsan_save_irqtrace = task->irqtrace;
> > > +     int                     hardirqs_enabled;
> > >  #endif
> > > -}
> > > +};
> > >
> > > +/*
> > > + * This is also called by the reporting task for the other task, to generate the
> > > + * right report with CONFIG_KCSAN_VERBOSE. No harm in restoring more than once.
> > > + */
> > >  void kcsan_restore_irqtrace(struct task_struct *task)
> > >  {
> > >  #ifdef CONFIG_TRACE_IRQFLAGS
> > > @@ -305,6 +320,41 @@ void kcsan_restore_irqtrace(struct task_struct *task)
> > >  #endif
> > >  }
> > >
> > > +/*
> > > + * Saves/restores IRQ state (see comment above). Need noinline to work around
> > > + * unfortunate code-gen upon inlining, resulting in objtool getting confused as
> > > + * well as losing stack trace information.
> > > + */
> > > +static noinline void kcsan_irq_save(struct kcsan_irq_state *irq_state)
> > > +{
> > > +#ifdef CONFIG_TRACE_IRQFLAGS
> > > +     current->kcsan_save_irqtrace = current->irqtrace;
> > > +     irq_state->hardirqs_enabled = lockdep_hardirqs_enabled();
> > > +#endif
> > > +     if (!kcsan_interrupt_watcher) {
> > > +             kcsan_disable_current(); /* Lockdep might WARN, etc. */
> > > +             raw_local_irq_save(irq_state->flags);
> > > +             lockdep_hardirqs_off(_RET_IP_);
> > > +             kcsan_enable_current();
> > > +     }
> > > +}
> > > +
> > > +static noinline void kcsan_irq_restore(struct kcsan_irq_state *irq_state)
> > > +{
> > > +     if (!kcsan_interrupt_watcher) {
> > > +             kcsan_disable_current(); /* Lockdep might WARN, etc. */
> > > +#ifdef CONFIG_TRACE_IRQFLAGS
> > > +             if (irq_state->hardirqs_enabled) {
> > > +                     lockdep_hardirqs_on_prepare(_RET_IP_);
> > > +                     lockdep_hardirqs_on(_RET_IP_);
> > > +             }
> > > +#endif
> > > +             raw_local_irq_restore(irq_state->flags);
> > > +             kcsan_enable_current();
> > > +     }
> > > +     kcsan_restore_irqtrace(current);
> > > +}
> > > +
> > >  /*
> > >   * Pull everything together: check_access() below contains the performance
> > >   * critical operations; the fast-path (including check_access) functions should
> > > @@ -350,11 +400,13 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
> > >       flags = user_access_save();
> > >
> > >       if (consumed) {
> > > -             kcsan_save_irqtrace(current);
> > > +             struct kcsan_irq_state irqstate;
> > > +
> > > +             kcsan_irq_save(&irqstate);
> > >               kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_MAYBE,
> > >                            KCSAN_REPORT_CONSUMED_WATCHPOINT,
> > >                            watchpoint - watchpoints);
> > > -             kcsan_restore_irqtrace(current);
> > > +             kcsan_irq_restore(&irqstate);
> > >       } else {
> > >               /*
> > >                * The other thread may not print any diagnostics, as it has
> > > @@ -387,7 +439,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
> > >       unsigned long access_mask;
> > >       enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
> > >       unsigned long ua_flags = user_access_save();
> > > -     unsigned long irq_flags = 0;
> > > +     struct kcsan_irq_state irqstate;
> > >
> > >       /*
> > >        * Always reset kcsan_skip counter in slow-path to avoid underflow; see
> > > @@ -412,14 +464,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
> > >               goto out;
> > >       }
> > >
> > > -     /*
> > > -      * Save and restore the IRQ state trace touched by KCSAN, since KCSAN's
> > > -      * runtime is entered for every memory access, and potentially useful
> > > -      * information is lost if dirtied by KCSAN.
> > > -      */
> > > -     kcsan_save_irqtrace(current);
> > > -     if (!kcsan_interrupt_watcher)
> > > -             local_irq_save(irq_flags);
> > > +     kcsan_irq_save(&irqstate);
> > >
> > >       watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
> > >       if (watchpoint == NULL) {
> > > @@ -559,9 +604,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
> > >       remove_watchpoint(watchpoint);
> > >       kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
> > >  out_unlock:
> > > -     if (!kcsan_interrupt_watcher)
> > > -             local_irq_restore(irq_flags);
> > > -     kcsan_restore_irqtrace(current);
> > > +     kcsan_irq_restore(&irqstate);
> > >  out:
> > >       user_access_restore(ua_flags);
> > >  }
> > > diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
> > > index 29480010dc30..6eb35a9514d8 100644
> > > --- a/kernel/kcsan/kcsan.h
> > > +++ b/kernel/kcsan/kcsan.h
> > > @@ -24,9 +24,8 @@ extern unsigned int kcsan_udelay_interrupt;
> > >  extern bool kcsan_enabled;
> > >
> > >  /*
> > > - * Save/restore IRQ flags state trace dirtied by KCSAN.
> > > + * Restore IRQ flags state trace dirtied by KCSAN.
> > >   */
> > > -void kcsan_save_irqtrace(struct task_struct *task);
> > >  void kcsan_restore_irqtrace(struct task_struct *task);
> > >
> > >  /*
> > > --
> > > 2.28.0.236.gb10cc79966-goog
> > >
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200807170618.GW4295%40paulmck-ThinkPad-P72.
