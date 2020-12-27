Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBAB2E316C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 15:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgL0OE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 09:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgL0OEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 09:04:55 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F567C061795
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 06:04:15 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id t8so7317790iov.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 06:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouFMgrctWPBkIpW4NuqWAYjnCBi4w3X4mHmAT792MT4=;
        b=Ilx+Erb6T1m0OSILSQ+EWjnv1floyi4rLQIf/Y9t1qACPlvUuwzsVqllBLvMiu4wN5
         JCetsICw4sj9JkkrMAoNlhkrNJ6M6qSbVRFqQ8fWil4+2ZpLWrpnWk6EO5u2q12kQbzp
         7mGWcblHhsgtPTW6ikJQe7t+v7y3uVNCvYCX2G0R0KqVXJRtgS7+YU5QMGiZvErwzhqW
         SYcKXHSzRB9qUA2j8Az4sXItH8FoHsisfa7ezrMQJuYWUXgXa8Z+umyt73QxL73ANElm
         z32pG+iZWND/0NIHtBlUIOjhUE0S8WZP8TR2wOpSAygK0u7Rr3TL+qC9bzdE1mIZWmgf
         uooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouFMgrctWPBkIpW4NuqWAYjnCBi4w3X4mHmAT792MT4=;
        b=h11qXVe1VhIZgysy2Wtqgv7YoU9yMUGPz8DLj26D7QZ7zudAZk2+2IH58Z2ZA4Sjad
         gAP/VF0e6cztXNceqPcl4rUBajMtAUPEzcfV9rjxpeI2gmX/ox1LoE5Ls1NrHPRiQ/6b
         qWER+pa9jTG023Nw/u299V1xG1UyTFV58WkUude8ktHFNbw1O0XmxtqYNmxjLxPW5aaN
         /CRGvQ66ZllSrRHa2YUq0vWq8RyX54EFYPIVu2VXKL3LFJUlSi0v73s7G1JHzxSaYg1w
         tFVlyOpowaYcI2dSb+pOtkg0PRxEBRTovpk2zvf07MB4E5X99oPUDUc+/s94OvJg+jts
         RVIA==
X-Gm-Message-State: AOAM5311B79AS18ylMF+/wzoK4uCs5lhhgc0aOGcW6sDJHpeXNAXcivp
        NzAFUiJm/njFTnDb62eFNKyqZNbaD4660A0laXk=
X-Google-Smtp-Source: ABdhPJz/bmnfrfwIeIB4ohZrql75DhCvHPEDqABZOOuP3mo8/E/A3J8GPF4EqUH3PRiReS899Cnn3mnnNCR//HEWk20=
X-Received: by 2002:a5d:8c85:: with SMTP id g5mr33410444ion.154.1609077854519;
 Sun, 27 Dec 2020 06:04:14 -0800 (PST)
MIME-Version: 1.0
References: <20201226025117.2770-1-jiangshanlai@gmail.com> <20201226025117.2770-6-jiangshanlai@gmail.com>
 <20201226101631.5448-1-hdanton@sina.com>
In-Reply-To: <20201226101631.5448-1-hdanton@sina.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sun, 27 Dec 2020 22:04:03 +0800
Message-ID: <CAJhGHyDM89Kq_Dop-6c8_6B4K545MHMJDxGggpTmjxu4Wuz7zQ@mail.gmail.com>
Subject: Re: [PATCH -tip V3 5/8] workqueue: Manually break affinity on hotplug
 for unbound pool
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 6:16 PM Hillf Danton <hdanton@sina.com> wrote:
>
> Sat, 26 Dec 2020 10:51:13 +0800
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > There is possible that a per-node pool/woker's affinity is a single
> > CPU.  It can happen when the workqueue user changes the cpumask of the
> > workqueue or when wq_unbound_cpumask is changed by system adim via
> > /sys/devices/virtual/workqueue/cpumask.  And pool->attrs->cpumask
> > is workqueue's cpumask & wq_unbound_cpumask & possible_cpumask_of_the_node,
> > which can be a single CPU and makes the pool's workers to be "per cpu
> > kthread".
> >
> > And it can also happen when the cpu is the first online and has been
> > the only online cpu in pool->attrs->cpumask.  In this case, the worker
> > task cpumask is single cpu no matter what pool->attrs->cpumask since
> > commit d945b5e9f0e3 ("workqueue: Fix setting affinity of unbound worker
> > threads").
> >
> > And the scheduler won't break affinity on the "per cpu kthread" workers
> > when the CPU is going down, so we have to do it by our own.
> >
> > We do it by reusing existing restore_unbound_workers_cpumask() and rename
> > it to update_unbound_workers_cpumask().  When the number of the online
> > CPU of the pool goes from 1 to 0, we break the affinity initiatively.
> >
> > Note here, we even break the affinity for non-per-cpu-kthread workers,
> > because first, the code path is slow path which is not worth too much to
> > optimize, second, we don't need to rely on the code/conditions when the
> > scheduler forces breaking affinity for us.
> >
> > The way to break affinity is to set the workers' affinity to
> > cpu_possible_mask, so that we preserve the same behavisor when
> > the scheduler breaks affinity for us.
> >
> > Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
> > Acked-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > ---
> >  kernel/workqueue.c | 48 ++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 40 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 0a95ae14d46f..79cc87df0cda 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -5019,16 +5019,18 @@ static void rebind_workers(struct worker_pool *pool)
> >  }
> >
> >  /**
> > - * restore_unbound_workers_cpumask - restore cpumask of unbound workers
> > + * update_unbound_workers_cpumask - update cpumask of unbound workers
> >   * @pool: unbound pool of interest
> > - * @cpu: the CPU which is coming up
> > + * @online: whether @cpu is coming up or going down
> > + * @cpu: the CPU which is coming up or going down
> >   *
> >   * An unbound pool may end up with a cpumask which doesn't have any online
> > - * CPUs.  When a worker of such pool get scheduled, the scheduler resets
> > - * its cpus_allowed.  If @cpu is in @pool's cpumask which didn't have any
> > - * online CPU before, cpus_allowed of all its workers should be restored.
> > + * CPUs.  We have to reset workers' cpus_allowed of such pool.  And we
> > + * restore the workers' cpus_allowed when the pool's cpumask has online
> > + * CPU.
> >   */
> > -static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
> > +static void update_unbound_workers_cpumask(struct worker_pool *pool,
> > +                                        bool online, int cpu)
> >  {
> >       static cpumask_t cpumask;
> >       struct worker *worker;
> > @@ -5042,6 +5044,23 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
> >
> >       cpumask_and(&cpumask, pool->attrs->cpumask, wq_online_cpumask);
> >
> > +     if (!online) {
> > +             if (cpumask_weight(&cpumask) > 0)
> > +                     return;
>
> We can apply the weight check also to the online case.
>
> > +             /*
> > +              * All unbound workers can be possibly "per cpu kthread"
> > +              * if this is the only online CPU in pool->attrs->cpumask
> > +              * from the last time it has been brought up until now.
> > +              * And the scheduler won't break affinity on the "per cpu
> > +              * kthread" workers when the CPU is going down, so we have
> > +              * to do it by our own.
> > +              */
> > +             for_each_pool_worker(worker, pool)
> > +                     WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
> > +
> > +             return;
> > +     }
> > +
> >       /* as we're called from CPU_ONLINE, the following shouldn't fail */
> >       for_each_pool_worker(worker, pool)
> >               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
>
> What is the reason that pool->attrs->cpumask is not restored if it is
> not a typo, given that restore appears in the change to the above doc?

reason:

d945b5e9f0e3 ("workqueue: Fix setting affinity of unbound worker
threads").

I don't like this change either, but I don't want to touch it
now.  I will improve it late by moving handling for unbound wq/pool/worker
to a work item (out of cpu hotplug processing) and so that
we can restore pool->attrs->cpumask to workers.

The reason is also the reason I drop the patch1 of the V2 patch.

Did you see any problem with d945b5e9f0e3 except for that it does not
update the comment and it is not so efficient.

>
> BTW is there a git tree available with this patchset tucked in?
>
> > @@ -5075,7 +5094,7 @@ int workqueue_online_cpu(unsigned int cpu)
> >               if (pool->cpu == cpu)
> >                       rebind_workers(pool);
> >               else if (pool->cpu < 0)
> > -                     restore_unbound_workers_cpumask(pool, cpu);
> > +                     update_unbound_workers_cpumask(pool, true, cpu);
> >
> >               mutex_unlock(&wq_pool_attach_mutex);
> >       }
> > @@ -5090,7 +5109,9 @@ int workqueue_online_cpu(unsigned int cpu)
> >
> >  int workqueue_offline_cpu(unsigned int cpu)
> >  {
> > +     struct worker_pool *pool;
> >       struct workqueue_struct *wq;
> > +     int pi;
> >
> >       /* unbinding per-cpu workers should happen on the local CPU */
> >       if (WARN_ON(cpu != smp_processor_id()))
> > @@ -5098,9 +5119,20 @@ int workqueue_offline_cpu(unsigned int cpu)
> >
> >       unbind_workers(cpu);
> >
> > -     /* update NUMA affinity of unbound workqueues */
> >       mutex_lock(&wq_pool_mutex);
> >       cpumask_clear_cpu(cpu, wq_online_cpumask);
> > +
> > +     /* update CPU affinity of workers of unbound pools */
> > +     for_each_pool(pool, pi) {
> > +             mutex_lock(&wq_pool_attach_mutex);
> > +
> > +             if (pool->cpu < 0)
> > +                     update_unbound_workers_cpumask(pool, false, cpu);
> > +
> > +             mutex_unlock(&wq_pool_attach_mutex);
> > +     }
> > +
> > +     /* update NUMA affinity of unbound workqueues */
> >       list_for_each_entry(wq, &workqueues, list)
> >               wq_update_unbound_numa(wq, cpu);
> >       mutex_unlock(&wq_pool_mutex);
> > --
> > 2.19.1.6.gb485710b
