Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E0A2F4C37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbhAMN3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbhAMN3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:29:06 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F55C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:28:25 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id b19so1493584ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQ0FGJIAPQ3AK2cmfRAw+2priH2HhjXXuce1eLd1Gzs=;
        b=i/EMI6wF17Lop+6P6KCNDud4+Qy6zgN7w/WeXcIajA6Qjq/l3FsED+nNudB8rBtZ0C
         D49bpMuqfPfiPvFeVNjTEARhpFAGTwhCEaFKfHjB9D91CzNFFmfthnjGwVy2F4WhnLzr
         LGX3qRsUN2/m8nffgKiM5vvLo/akGylSxmT9VDoAoL//4JR19QQ1H6m5UJSLn0PdQAfs
         p/vMz7pGSnTiZBxIlNU8Vsf8raf8jmArrKHdv1Ob/OjorvysO08tL5dLT5Uoi7Z1uRH0
         DCpxzdseWd7dv507myEt0J/XMj411h89oLXDi4hyfO5NRBVXudO6Bz+emiWC5Wt9dMr/
         tfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQ0FGJIAPQ3AK2cmfRAw+2priH2HhjXXuce1eLd1Gzs=;
        b=tXaJcClEKnQ+JXlac+mE8dAeygiOkvPFXkzr7eBpnihpoLZiEEyex9f06XfqFYJds7
         B48cxrS47weVe9LKIk8wSOdMrulACC3jNl77lLcy78A3MwkqOSoUkc30ZFsetpgaTKID
         tQnQhOr2wrHAcoIpScdoDX4aTXthSlKXK07RnEaJ4XI/gSzsIbG2t7ENu/QI2PrbOra1
         YjWG88PGECQvheScNbq3PlbtAmztzAF4LEXlS63iux8p4VcOfBscQVVopkOzUX3Q1AuN
         jd5shRUAXDoVlSz9mVUsw/8FOcmBNmOSExTonheaYdPUmD6qPAHHT8aYLMXhWHySKpbh
         hWQA==
X-Gm-Message-State: AOAM531EhoheU2iCgUTHHp3UcPxDfDsHUewf+FfU3Qt0jfd0A2ETOWA4
        HzhIqyb6RrHG69Y0K69svRtqPEttB74Y6JVaiH4=
X-Google-Smtp-Source: ABdhPJzLUiekQnbo3ZqWqjTrGD3Sf7730YmCjGi57Vb7bkjCyR7Zu5GCHPKSJcOKAXEYsuDKyt2o/AcopLhBzGXTJiw=
X-Received: by 2002:a05:6638:b16:: with SMTP id a22mr2414915jab.56.1610544504954;
 Wed, 13 Jan 2021 05:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20210112144344.850850975@infradead.org> <20210112144843.849135905@infradead.org>
In-Reply-To: <20210112144843.849135905@infradead.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 13 Jan 2021 21:28:13 +0800
Message-ID: <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
Subject: Re: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Mark the per-cpu workqueue workers as KTHREAD_IS_PER_CPU.
>
> Workqueues have unfortunate semantics in that per-cpu workers are not
> default flushed and parked during hotplug, however a subset does
> manual flush on hotplug and hard relies on them for correctness.
>
> Therefore play silly games..
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/workqueue.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1861,6 +1861,8 @@ static void worker_attach_to_pool(struct
>          */
>         if (pool->flags & POOL_DISASSOCIATED)
>                 worker->flags |= WORKER_UNBOUND;
> +       else
> +               kthread_set_per_cpu(worker->task, true);
>
>         list_add_tail(&worker->node, &pool->workers);
>         worker->pool = pool;
> @@ -1883,6 +1885,7 @@ static void worker_detach_from_pool(stru
>
>         mutex_lock(&wq_pool_attach_mutex);
>
> +       kthread_set_per_cpu(worker->task, false);
>         list_del(&worker->node);
>         worker->pool = NULL;
>
> @@ -4919,8 +4922,10 @@ static void unbind_workers(int cpu)
>
>                 raw_spin_unlock_irq(&pool->lock);
>
> -               for_each_pool_worker(worker, pool)
> +               for_each_pool_worker(worker, pool) {
> +                       kthread_set_per_cpu(worker->task, false);
>                         WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
> +               }
>
>                 mutex_unlock(&wq_pool_attach_mutex);
>
> @@ -4972,9 +4977,11 @@ static void rebind_workers(struct worker
>          * of all workers first and then clear UNBOUND.  As we're called
>          * from CPU_ONLINE, the following shouldn't fail.
>          */
> -       for_each_pool_worker(worker, pool)
> +       for_each_pool_worker(worker, pool) {
>                 WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
>                                                   pool->attrs->cpumask) < 0);
> +               kthread_set_per_cpu(worker->task, true);

Will the schedule break affinity in the middle of these two lines due to
patch4 allowing it and result in Paul's reported splat.

> +       }
>
>         raw_spin_lock_irq(&pool->lock);
>
>
>
