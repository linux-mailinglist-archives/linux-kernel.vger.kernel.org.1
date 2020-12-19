Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2499C2DEC98
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 02:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgLSBL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 20:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgLSBLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 20:11:55 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ED1C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 17:11:15 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id q1so3867581ilt.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 17:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GIfob2K2ak7BiPE34AIHUJ/V/XzbMuiGYiTL3w+Zll0=;
        b=ASqtUL24oIaTfy58cXfVAa/srzqScTrAtwst/2ZnhEInXG495n4XvdIjOlhCXDYvCz
         52y8WPY3HQDCftsRVOiWQmus3IPIeMiVtS8Aaaz6K/uCvAjylI91P1I8n/leGVKbDZY3
         puIgf39WUDwcZMi+mJgoh2gpOg3WgYhFaKrqmEldgGwLZpzP/kINs917LS52C76ikHU3
         0RWbHkKS6rEpo97JVTaRAyEw4MSQtsStn6WrOv+Ymi2NLVN0LkX9ctMokwRohMhllbR5
         ZKqXsQUfmQu0LGRNH84YsNB+38w4/ioBQwJLbfmjDIw28/lVCkVRCgiBObbcpfN9Ithy
         7/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GIfob2K2ak7BiPE34AIHUJ/V/XzbMuiGYiTL3w+Zll0=;
        b=ktFPmIpbS4T0+Nu0JrwDgR+G5iJBFnBNdXSnsHRZv5KDcBxYtbcuOUP0ElLs0huSZV
         RZCh1n7lGtzG5pTFWG9Np3G5B5NjKbraKL5uW//ZabK6BDoMwwfTWMSiqdhHNjzqC+mJ
         Hv1VNBCX8TzuaFOn7gc0u8qWODCsvdGHyP3VV75HEvoHhRukCnO7P1uSY7Yv4DN54YxR
         CX0NWlKf+CDlKnq4Xm+L7ovXkAF27BMlWyk+o0XtCeAZVMtk/cAjeCE/fCK4QJNSTBP7
         O6/dqEw9DdKzDARzvb55DVEgqzbDLGkTdDchl3yICgfSD27i6mI1oGjSZdxgGT/19/+a
         CA9Q==
X-Gm-Message-State: AOAM530fgrovrsEvvaFs5DPPKIPAPR8UT+WMH8N8VzSddvr4aVOfJXq5
        4JdBXCt0zw3JO7J8d/SEW3u7fIVHzm0CWjOBu6I=
X-Google-Smtp-Source: ABdhPJy30Vx7hPBno5emQC0zVtXW7IE5+AYl3JRBg0qq3x75wVXmhBacYIM9E7wkp7J7aGrZX1+2ciQds+mBTCQQH7Y=
X-Received: by 2002:a92:dcc4:: with SMTP id b4mr6856848ilr.164.1608340274551;
 Fri, 18 Dec 2020 17:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20201218170919.2950-1-jiangshanlai@gmail.com> <20201218170919.2950-11-jiangshanlai@gmail.com>
 <jhjpn37ro4u.mognet@arm.com>
In-Reply-To: <jhjpn37ro4u.mognet@arm.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sat, 19 Dec 2020 09:11:03 +0800
Message-ID: <CAJhGHyBBuv1o+o6_o6uR6D1mR68xLs3PQZzEGqQf0a9nBnm51A@mail.gmail.com>
Subject: Re: [PATCH -tip V2 10/10] workqueue: Fix affinity of kworkers when
 attaching into pool
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 1:59 AM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 18/12/20 17:09, Lai Jiangshan wrote:
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > When worker_attach_to_pool() is called, we should not put the workers
> > to pool->attrs->cpumask when there is not CPU online in it.
> >
> > We have to use wq_online_cpumask in worker_attach_to_pool() to check
> > if pool->attrs->cpumask is valid rather than cpu_online_mask or
> > cpu_active_mask due to gaps between stages in cpu hot[un]plug.
> >
> > So for that late-spawned per-CPU kworker case: the outgoing CPU should have
> > already been cleared from wq_online_cpumask, so it gets its affinity reset
> > to the possible mask and the subsequent wakeup will ensure it's put on an
> > active CPU.
> >
> > To use wq_online_cpumask in worker_attach_to_pool(), we need to protect
> > wq_online_cpumask in wq_pool_attach_mutex and we modify workqueue_online_cpu()
> > and workqueue_offline_cpu() to enlarge wq_pool_attach_mutex protected
> > region. We also put updating wq_online_cpumask and [re|un]bind_workers()
> > in the same wq_pool_attach_mutex protected region to make the update
> > for percpu workqueue atomically.
> >
> > Cc: Qian Cai <cai@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vincent Donnefort <vincent.donnefort@arm.com>
> > Link: https://lore.kernel.org/lkml/20201210163830.21514-3-valentin.schneider@arm.com/
> > Acked-by: Valentin Schneider <valentin.schneider@arm.com>
>
> So an etiquette thing: I never actually gave an Acked-by. I did say it
> looked good to me, and that probably should've been bundled with a
> Reviewed-by, but it wasn't (I figured I'd wait for v2). Forging is bad,
> m'kay.
>
> When in doubt (e.g. someone says they're ok with your patch but don't give
> any Ack/Reviewed-by), just ask via mail or on IRC.

Hello, Valentin

I'm sorry not to have asked for your option.  When I saw
"Seems alright to me." I felt a huge encouragement and rushed.

I was in doubt should I promote "Seems alright to me." to "Ack".
Instead of asking, I wrongly did it right the way.  I knew may I'm
just forging, and added a log in the cover letter:

>        Add Valentin's ack for patch 10 because "Seems alright to me." and
>        add Valentin's comments to the changelog which is integral.

Anyway, it is my bad and I learnt.

>
> For now, please make this a:
>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Hello Peter, cloud you help change it if there is no other
feedback that causes V3 patchset to be made.

Thanks
Lai

>
> > Acked-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > ---
> >  kernel/workqueue.c | 32 +++++++++++++++-----------------
> >  1 file changed, 15 insertions(+), 17 deletions(-)
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 65270729454c..eeb726598f80 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -310,7 +310,7 @@ static bool workqueue_freezing;           /* PL: have wqs started freezing? */
> >  /* PL: allowable cpus for unbound wqs and work items */
> >  static cpumask_var_t wq_unbound_cpumask;
> >
> > -/* PL: online cpus (cpu_online_mask with the going-down cpu cleared) */
> > +/* PL&A: online cpus (cpu_online_mask with the going-down cpu cleared) */
> >  static cpumask_var_t wq_online_cpumask;
> >
> >  /* CPU where unbound work was last round robin scheduled from this CPU */
> > @@ -1848,11 +1848,11 @@ static void worker_attach_to_pool(struct worker *worker,
> >  {
> >       mutex_lock(&wq_pool_attach_mutex);
> >
> > -     /*
> > -      * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
> > -      * online CPUs.  It'll be re-applied when any of the CPUs come up.
> > -      */
> > -     set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> > +     /* Is there any cpu in pool->attrs->cpumask online? */
> > +     if (cpumask_intersects(pool->attrs->cpumask, wq_online_cpumask))
> > +             WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
> > +     else
> > +             WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
> >
> >       /*
> >        * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
> > @@ -5081,13 +5081,12 @@ int workqueue_online_cpu(unsigned int cpu)
> >       int pi;
> >
> >       mutex_lock(&wq_pool_mutex);
> > -     cpumask_set_cpu(cpu, wq_online_cpumask);
> >
> > -     for_each_cpu_worker_pool(pool, cpu) {
> > -             mutex_lock(&wq_pool_attach_mutex);
> > +     mutex_lock(&wq_pool_attach_mutex);
> > +     cpumask_set_cpu(cpu, wq_online_cpumask);
> > +     for_each_cpu_worker_pool(pool, cpu)
> >               rebind_workers(pool);
> > -             mutex_unlock(&wq_pool_attach_mutex);
> > -     }
> > +     mutex_unlock(&wq_pool_attach_mutex);
> >
> >       /* update CPU affinity of workers of unbound pools */
> >       for_each_pool(pool, pi) {
> > @@ -5117,14 +5116,13 @@ int workqueue_offline_cpu(unsigned int cpu)
> >       if (WARN_ON(cpu != smp_processor_id()))
> >               return -1;
> >
> > -     for_each_cpu_worker_pool(pool, cpu) {
> > -             mutex_lock(&wq_pool_attach_mutex);
> > -             unbind_workers(pool);
> > -             mutex_unlock(&wq_pool_attach_mutex);
> > -     }
> > -
> >       mutex_lock(&wq_pool_mutex);
> > +
> > +     mutex_lock(&wq_pool_attach_mutex);
> >       cpumask_clear_cpu(cpu, wq_online_cpumask);
> > +     for_each_cpu_worker_pool(pool, cpu)
> > +             unbind_workers(pool);
> > +     mutex_unlock(&wq_pool_attach_mutex);
> >
> >       /* update CPU affinity of workers of unbound pools */
> >       for_each_pool(pool, pi) {
