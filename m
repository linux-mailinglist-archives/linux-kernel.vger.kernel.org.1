Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC02F8D59
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 13:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbhAPMrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 07:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbhAPMrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 07:47:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE93AC061757
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 04:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ApWhEWEq2U/Fnsy6bmueoba1eIHlAGt2zjhEFTZAyBY=; b=JD4SyomqUw3gpKgN0lQWSsHRYx
        t9axn8mBPyjmzEwj4ll8R09bZJba82DJhQ76zuaK0Cacn70cZvO1LgcCbrJW7QABRb3oHKvyw9nto
        y8/w9vhDH/EzFtYp3Cr/16xhtHKAUMyeRIKQ7FKqIfsIIu8FMQ5H6pPnLuawG2CqXGdO1dInnaLuC
        yCXz5faMrn/RjcJqIEoVnSY9gkm1oHa/hB4DIOmyv1wwCeMBFr1BtHXzp51DaaDw2SWdtlqNB6M14
        rvHAKsV7mxuzbrzjdfYCQCKkEsTenB35OFHrQuJVU9dW3uZ5efLVTwZ5wIphmAt8U20NrJyVGZGOn
        A7tOuUHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l0kxI-00AGUn-P4; Sat, 16 Jan 2021 12:45:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43AFA300F7A;
        Sat, 16 Jan 2021 13:45:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2773920299B4E; Sat, 16 Jan 2021 13:45:23 +0100 (CET)
Date:   Sat, 16 Jan 2021 13:45:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
Message-ID: <YALf4xDwTKCERPbf@hirez.programming.kicks-ass.net>
References: <20210112144344.850850975@infradead.org>
 <20210112144843.849135905@infradead.org>
 <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
 <YABDI6Qkp5PNslUS@hirez.programming.kicks-ass.net>
 <jhjlfcvhcx5.mognet@arm.com>
 <YABknAqDe4h35+GY@hirez.programming.kicks-ass.net>
 <CAJhGHyBazDix9tLTV0HnobeSzneUK8Y9GKf6AgXspf=c9O5dhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyBazDix9tLTV0HnobeSzneUK8Y9GKf6AgXspf=c9O5dhQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 02:27:09PM +0800, Lai Jiangshan wrote:
> On Thu, Jan 14, 2021 at 11:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> >
> > -void kthread_set_per_cpu(struct task_struct *k, bool set)
> > +void kthread_set_per_cpu(struct task_struct *k, int cpu)
> >  {
> >         struct kthread *kthread = to_kthread(k);
> >         if (!kthread)
> >                 return;
> >
> > -       if (set) {
> > -               WARN_ON_ONCE(!(k->flags & PF_NO_SETAFFINITY));
> > -               WARN_ON_ONCE(k->nr_cpus_allowed != 1);
> > -               set_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
> > -       } else {
> > +       WARN_ON_ONCE(!(k->flags & PF_NO_SETAFFINITY));
> > +
> > +       if (cpu < 0) {
> >                 clear_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
> > +               return;
> >         }
> > +
> > +       kthread->cpu = cpu;
> > +       set_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
> >  }
> >
> 
> I don't see the code to set the mask of the cpu to the task
> since set_cpus_allowed_ptr() is removed from rebind_worker().
> 
> Is it somewhere I missed?

kthread_unpark().

> > @@ -4978,9 +4982,9 @@ static void rebind_workers(struct worker_pool *pool)
> >          * from CPU_ONLINE, the following shouldn't fail.
> >          */
> >         for_each_pool_worker(worker, pool) {
> > -               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
> > -                                                 pool->attrs->cpumask) < 0);
> > -               kthread_set_per_cpu(worker->task, true);
> > +               WARN_ON_ONCE(kthread_park(worker->task) < 0);
> > +               kthread_set_per_cpu(worker->task, pool->cpu);
> > +               kthread_unpark(worker->task);
> 
> I feel nervous to use kthread_park() here and kthread_parkme() in
> worker thread.  And adding kthread_should_park() to the fast path
> also daunt me.

Is that really such a hot path that an additional load is problematic?

> How about using a new KTHREAD_XXXX instead of KTHREAD_IS_PER_CPU,
> so that we can set and clear KTHREAD_XXXX freely, especially before
> set_cpus_allowed_ptr().

KTHREAD_IS_PER_CPU is exactly what we need, why make another flag?

The above sequence is nice in that it restores both the
KTHREAD_IS_PER_CPU flag and affinity while the task is frozen, so there
are no races where one is observed and not the other.

It is also the exact sequence normal per-cpu threads (smpboot) use to
preserve affinity.
