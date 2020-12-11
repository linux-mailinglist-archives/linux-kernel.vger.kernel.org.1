Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BA82D71E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436861AbgLKIiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392135AbgLKIhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:37:37 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE31FC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:36:56 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id g1so8043261ilk.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8dbYRVAbj93DNiCVJa+P/BywHjk20kATo2plUAkA74=;
        b=e5e2uMrzV6wD1Gt3GNkk0b4khQg0C5zLcGUhGsxsrgXOhe9epq+liIfm1VdSPSKIRQ
         pdIrelwjTRkTak3hk/tZRuPBdC5sVMqrSPblI87NghQNxMjvg6U3vpz50DGtkTIl75Ki
         89e2eBbYk0VAleS7Mf/g23OzLKj5iEJDkYqzpkZdohYTWcsS9br/TxaUNdfl6pXa7naA
         lPVq7uiCNrSoMCdVkVtga4FLz7WHjDFad/EzMiz9Fr4g/5ic9hBFIDWk2P6eeUNDUUJd
         oXfR78gLnT7dutAMfv7g5uUdSzK24uWJSju3Lnz1bPYMmWZXkNclmRjHttFEF7JFfCJ6
         Oq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8dbYRVAbj93DNiCVJa+P/BywHjk20kATo2plUAkA74=;
        b=kr/A9BkhuQqvP5V/u8L+pQbAl6wxB+iaMIEvXcCF4b/tp3LUuop3FYw+02G/l3M9lX
         IrHa5psCZiWa7kFdwV4revKd5R4djBy2BCK7lJCuxInaLsPDhHrPXGmXOupwxnDJr7el
         OBxivjRUg3BvRbfu4IZsH20kX2Htkw9TZaOwQwOCPy1Zft0qdg89wCa08A0yk90T0WcO
         oOBT9PE97FRyGOxpJc5dR/8Fbz4PvW3FDARH0XTuzwW8q0yPID9OksaJov+MgSgdFnwk
         v5ZmmMDyDFs1xAqZi+f1obNSx+tR+TWxhvfIcJHJShq8bRux7i7+jKmrz7FT/GWNePmq
         15/w==
X-Gm-Message-State: AOAM530+oRzmCHyLY7Q6mgCGpPD2Y6j4qZ2YpYxSuFPhpzwxrB+wzG0h
        KNTDYXl8DlqwtyJZ9rib42hNSTYrCowUDs+BNwc=
X-Google-Smtp-Source: ABdhPJw1ZQCsB4eiJJ48luTI4N5mSACvPS2Fh+YmK2SzrWs4lCbnCliR0dMfYQQqKDkMKn8DFrQt2xzGOc8wnQhXg44=
X-Received: by 2002:a05:6e02:12a1:: with SMTP id f1mr14441966ilr.164.1607675816236;
 Fri, 11 Dec 2020 00:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20201209083426.2866-1-hdanton@sina.com> <CAJhGHyAbjbpzp_+eLEEVVgUUCh6aJjUYbEigVwTrM1_Gx1Jf1w@mail.gmail.com>
 <20201211072131.3137-1-hdanton@sina.com>
In-Reply-To: <20201211072131.3137-1-hdanton@sina.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 11 Dec 2020 16:36:45 +0800
Message-ID: <CAJhGHyB2eUpKvkt3m+qyJvbhZ21z1Bgz_9frjaao0CdDmT4sRg@mail.gmail.com>
Subject: Re: [RFC PATCH] workqueue: handle CPU hotplug without updating worker
 pool's attrs
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.de>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 3:21 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Fri, 11 Dec 2020 10:29:55 +0800 Lai Jiangshan wrote:
> >On Wed, Dec 9, 2020 at 4:34 PM Hillf Danton <hdanton@sina.com> wrote:
> >>
> >> This makes the cpumask intact for worker pools of unbound workqueues
> >> when CPUs go offline because we need to rebind workers to the original
> >> cpumask(of the original pool) when they come back, as represented by
> >> the cpu check in restore_unbound_workers_cpumask().
> >>
> >> Note this is now only for comments.
> >>
> >> Signed-off-by: Hillf Danton <hdanton@sina.com>
> >> ---
> >>
> >> --- a/kernel/workqueue.c
> >> +++ b/kernel/workqueue.c
> >> @@ -4117,6 +4117,32 @@ static void wq_update_unbound_numa(struc
> >>         copy_workqueue_attrs(target_attrs, wq->unbound_attrs);
> >>         pwq = unbound_pwq_by_node(wq, node);
> >>
> >> +       cpumask = pwq->pool->attrs->cpumask;
> >> +       if (!online || !cpumask_test_cpu(cpu, cpumask))
> >> +               return;
> >> +       do {
> >> +               struct worker *worker;
> >> +               int i;
> >> +
> >> +               for_each_cpu_and(i, cpu_online_mask, cpumask) {
> >> +                       if (i != cpu)
> >> +                               return;
> >> +               }
> >> +
> >> +               /*
> >> +                * rebind workers only when the first CPU in
> >> +                * pool's attrs cpumask comes back because scheduler
> >> +                * may have unbound them when the last CPU went offline
> >> +                */
> >> +               mutex_lock(&wq_pool_attach_mutex);
> >> +
> >> +               for_each_pool_worker(worker, pwq->pool)
> >> +                       set_cpus_allowed_ptr(worker->task, cpumask);
> >> +
> >
> >There might be multiple pwqs that share the same pool, this line of
> >code might update the same pool multiple times.
>
> Thanks for taking a look at it.
>
> It is the pool (shared between multiple pwqs or not) attrs cpumask, in
> combination with the above i != cpu check, that ensures single update.

When the pool is shared by multiple pwqs, it will be visited
multiple times when each pwq is visited, and your code touches
the pool multiple times.

wq_update_unbound_numa() updates the pwq table.
restore_unbound_workers_cpumask() updates the scheduler cpumasks.

>
> >
> >Please keep the logic in restore_unbound_workers_cpumask().
> >
> >> +               mutex_unlock(&wq_pool_attach_mutex);
> >> +               return;
> >> +       } while (0);
> >> +
> >>         /*
> >>          * Let's determine what needs to be done.  If the target cpumask is
> >>          * different from the default pwq's, we need to compare it to @pwq's
> >> @@ -5004,34 +5030,6 @@ static void rebind_workers(struct worker
> >>         raw_spin_unlock_irq(&pool->lock);
> >>  }
> >>
> >> -/**
> >> - * restore_unbound_workers_cpumask - restore cpumask of unbound workers
> >> - * @pool: unbound pool of interest
> >> - * @cpu: the CPU which is coming up
> >> - *
> >> - * An unbound pool may end up with a cpumask which doesn't have any online
> >> - * CPUs.  When a worker of such pool get scheduled, the scheduler resets
> >> - * its cpus_allowed.  If @cpu is in @pool's cpumask which didn't have any
> >> - * online CPU before, cpus_allowed of all its workers should be restored.
> >> - */
> >> -static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
> >> -{
> >> -       static cpumask_t cpumask;
> >> -       struct worker *worker;
> >> -
> >> -       lockdep_assert_held(&wq_pool_attach_mutex);
> >> -
> >> -       /* is @cpu allowed for @pool? */
> >> -       if (!cpumask_test_cpu(cpu, pool->attrs->cpumask))
> >> -               return;
> >> -
> >> -       cpumask_and(&cpumask, pool->attrs->cpumask, cpu_online_mask);
> >
> >Good catch of the problem.
> >But please fix it where the problem is found (here!)
>
> The cause of the issue is the update of pool->attrs->cpumask in
> wq_update_unbound_numa() for offline CPUs, and it is too late to
> add changes only when they come back online.
>

pool->attrs->cpumask is read only, it is not updated.

This function just updates the pwq table, using(allocating when needed)
the pwq for the node or using the default pwq. It does not change the
attrs->cpumask.

And
+       if (!online || !cpumask_test_cpu(cpu, cpumask))
+               return;

is totally incorrect for !online. In both cases (online&offline)
we may need to update the pwq table.

> >Like this:
> >
> >+        /* only restore the cpumask of the pool's workers when @cpu is
> >+           the first online cpu in @pool's cpumask */
> >+        if (cpumask_weight(cpumask) > 1)
> >+                return;
> >
> >        /* as we're called from CPU_ONLINE, the following shouldn't fail */
> >        for_each_pool_worker(worker, pool)
> >-                WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
> >+                WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
>
> Got it.  And we have the bonus of cutting static cpumask_t cpumask; if
> fix goes in wq_update_unbound_numa(). And some tiny followup cleanup there.

I don't see any problem related to wq_update_unbound_numa() so far.
The only the problem I see is that the code is not matched the comments:

 * An unbound pool may end up with a cpumask which doesn't have any online
 * CPUs.  When a worker of such pool get scheduled, the scheduler resets
 * its cpus_allowed.  If @cpu is in @pool's cpumask which didn't have any
 * online CPU before, cpus_allowed of all its workers should be restored.

The cpumask for any given worker pool is intact no matter what serials of
CPU hot[un]plot events happen. We just need to RESTORE the scheduler cpumasks
to the pool's cpumasks when the pool's cpumask includes this onlining CPU
but didn't have any online CPU before.

> >
> >> -
> >> -       /* as we're called from CPU_ONLINE, the following shouldn't fail */
> >> -       for_each_pool_worker(worker, pool)
> >> -               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
> >> -}
> >> -
> >>  int workqueue_prepare_cpu(unsigned int cpu)
> >>  {
> >>         struct worker_pool *pool;
> >> @@ -5058,8 +5056,6 @@ int workqueue_online_cpu(unsigned int cp
> >>
> >>                 if (pool->cpu == cpu)
> >>                         rebind_workers(pool);
> >> -               else if (pool->cpu < 0)
> >> -                       restore_unbound_workers_cpumask(pool, cpu);
> >>
> >>                 mutex_unlock(&wq_pool_attach_mutex);
> >>         }
>
