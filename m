Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AD92F8DD4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbhAPRKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbhAPRKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:22 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD79EC0617BD
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 06:45:15 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y19so23995904iov.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 06:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EHihIcKDoV0+JHPY4VGxSXXMUYFdCoryZeO5QPeUbJc=;
        b=GnaGfjbkXKtzD9cX08SDfUJtODWmWyYUR89tTrLQgOD1I5QxSiHgjQMO/m8swKC3sN
         h7LVVYetoA/fYq+IkgN+Mf2t5mARxHNvhMCTFwAxuEvtbrwIlhUfXqDQ0n4pSJqbXJl/
         cAb0OBHLuLB4qEZ07mNIMgroKOHO7L20gfJ5NN3RBBt10D1hxW2Z5bKa0t7Wp4pAMqgR
         KbKZPoq4IpZGK2PF7QIx+dVs0GzExH4THCt+WnltChaT73PRi7GXa9RejQI6b08j3qng
         2BLcL3zFCFWibRL4K4PCe8zJW+Fvk20zx+egLzNccgJQh7eVUYG56EGgIoOqzfwIXmWt
         aJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHihIcKDoV0+JHPY4VGxSXXMUYFdCoryZeO5QPeUbJc=;
        b=b4cKX2NbnNadvS6tF36M1jnaGYYmUa/yy7dhvinsSntrsULqsH8ICNVk3ohUcLIIBb
         Rr43Xxb9KndM2glYnO0hZguoQmFBbteA3UvU8a+huKP3rLnIHRGe92RgtWvaL65ytxFo
         7UBk6QobBfW8cClCFdeb1Fly3iPrDu90fBRN2OR5tTswXxFgT2kmo+aEs8lZl+o6oQxW
         G7LMZr3uKaNGvE6KdZQWdmbYs43kGZ2oq6qYly8+vDLqo2UioUkyNlZ+erE6xUzDqIDV
         wbaJZY41e/CILZQFl2SjZGZG8u04waClMyBoDv2O+Vle/bSfSfoo10VHBOoZ9B9BTm7p
         6NCQ==
X-Gm-Message-State: AOAM533FKdc6B2W2UZePdNJkQuNPCNlnONAKjoJmUJitfQA35jaQBx7o
        3kTzBo3NBGutKC4p3JLoxvmUm+cMsb5K303Rtik=
X-Google-Smtp-Source: ABdhPJw6eRSI1V+vyLoF3FgZnrQIknsQXZyGjEmAtVMeI5M2g92vnTxIkF8bY4HVhiFXlEgph4zZyGmp02wdxjDFvI0=
X-Received: by 2002:a5d:8c85:: with SMTP id g5mr12002223ion.154.1610808315233;
 Sat, 16 Jan 2021 06:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20210112144344.850850975@infradead.org> <20210112144843.849135905@infradead.org>
 <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
 <YABDI6Qkp5PNslUS@hirez.programming.kicks-ass.net> <jhjlfcvhcx5.mognet@arm.com>
 <YABknAqDe4h35+GY@hirez.programming.kicks-ass.net> <CAJhGHyBazDix9tLTV0HnobeSzneUK8Y9GKf6AgXspf=c9O5dhQ@mail.gmail.com>
 <YALf4xDwTKCERPbf@hirez.programming.kicks-ass.net>
In-Reply-To: <YALf4xDwTKCERPbf@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sat, 16 Jan 2021 22:45:04 +0800
Message-ID: <CAJhGHyDT2FWsn15-_DQ4b_bkrRi74MzNnWt7YWTO49cSv4yjbg@mail.gmail.com>
Subject: Re: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 8:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Jan 16, 2021 at 02:27:09PM +0800, Lai Jiangshan wrote:
> > On Thu, Jan 14, 2021 at 11:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > >
> > > -void kthread_set_per_cpu(struct task_struct *k, bool set)
> > > +void kthread_set_per_cpu(struct task_struct *k, int cpu)
> > >  {
> > >         struct kthread *kthread = to_kthread(k);
> > >         if (!kthread)
> > >                 return;
> > >
> > > -       if (set) {
> > > -               WARN_ON_ONCE(!(k->flags & PF_NO_SETAFFINITY));
> > > -               WARN_ON_ONCE(k->nr_cpus_allowed != 1);
> > > -               set_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
> > > -       } else {
> > > +       WARN_ON_ONCE(!(k->flags & PF_NO_SETAFFINITY));
> > > +
> > > +       if (cpu < 0) {
> > >                 clear_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
> > > +               return;
> > >         }
> > > +
> > > +       kthread->cpu = cpu;
> > > +       set_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
> > >  }
> > >
> >
> > I don't see the code to set the mask of the cpu to the task
> > since set_cpus_allowed_ptr() is removed from rebind_worker().
> >
> > Is it somewhere I missed?
>
> kthread_unpark().
>
> > > @@ -4978,9 +4982,9 @@ static void rebind_workers(struct worker_pool *pool)
> > >          * from CPU_ONLINE, the following shouldn't fail.
> > >          */
> > >         for_each_pool_worker(worker, pool) {
> > > -               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
> > > -                                                 pool->attrs->cpumask) < 0);
> > > -               kthread_set_per_cpu(worker->task, true);
> > > +               WARN_ON_ONCE(kthread_park(worker->task) < 0);
> > > +               kthread_set_per_cpu(worker->task, pool->cpu);
> > > +               kthread_unpark(worker->task);
> >
> > I feel nervous to use kthread_park() here and kthread_parkme() in
> > worker thread.  And adding kthread_should_park() to the fast path
> > also daunt me.
>
> Is that really such a hot path that an additional load is problematic?
>
> > How about using a new KTHREAD_XXXX instead of KTHREAD_IS_PER_CPU,
> > so that we can set and clear KTHREAD_XXXX freely, especially before
> > set_cpus_allowed_ptr().
>
> KTHREAD_IS_PER_CPU is exactly what we need, why make another flag?
>
> The above sequence is nice in that it restores both the
> KTHREAD_IS_PER_CPU flag and affinity while the task is frozen, so there
> are no races where one is observed and not the other.
>
> It is also the exact sequence normal per-cpu threads (smpboot) use to
> preserve affinity.

Other per-cpu threads normally do short-live works. wq's work can be
lengthy, cpu-intensive, heavy-lock-acquiring or even call
get_online_cpus() which might result in a deadlock with kthread_park().
