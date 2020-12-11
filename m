Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274342D6E25
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 03:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391774AbgLKCa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 21:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391620AbgLKCar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 21:30:47 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F7C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 18:30:07 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id z5so7903026iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 18:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P47W7MLz0njFiEj74PlWxQvywR8mwLfhMl+8nLtmBmY=;
        b=JfhbAkFDNCVtYk2MSguky4VVaDBAL307ynUpPenayxU6vK1u6Ex/zSAgHYaFj4jgQy
         rujyJO5/aQTtvHkzBpJlpA2hOhcrdCF2gyc8+YRnzNkIT7pROZKC3XqWivq6v98bDuQt
         lrmHPyQcflVARUfa2FzyJFbhB1s8wkCkiHQsXOHcT5AcwNOkbTj+1pUdokUcsurKXJwg
         tW0s3Es+ecB9fH6SAoQFWbmRr1gLap9zWJ1+QeAGv0EUZd5XfTQ672aB09YzLAamFUfu
         LQpjedX5QwtVk+w6tnWtpWM9RIfr8zMwxPNfxTsTImVYrmKcX2WZ4i5VtxMi2LVvMnbA
         Jh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P47W7MLz0njFiEj74PlWxQvywR8mwLfhMl+8nLtmBmY=;
        b=oTROj3dJIt6UcbrL5HaQiVR/m3cMCJBChU6jBKZ+wbmPpBjg/EOYppvtxrlhTFFr6g
         aBrS/bCCIZL1L/vfyw50uWg2UyMnEBbSusiyPgroudVZfiFY2hD3nOUuhc5ePE7V8fdJ
         Y6d3peJ2ski+2EAG+W0MYLbDsdO12JhSK/WsY4DKG4M8bl6pdtQgiK3FTc0JCq/EaB+1
         r44V1nVOnOu2ux3VPo+qjsuDOet+VpFbBhH3KLbh9lDMRdxxv/kePFR1dwoDoMLJYns+
         DjvDK16RrxqDu29WyM+p8nxU1CbaFAx7KSkY2h/CEbScbS7oFMQn8TutDcVgDw5Re+S0
         aqbQ==
X-Gm-Message-State: AOAM531AGz4Oo+Gyhc/bUZfOUGVE7WovZ1yY3NQGAXB0L3yrXhD1Dt45
        gGOAewS23CU4rkE/7bh4AgoW0hV4QvW3JiaZCQ8=
X-Google-Smtp-Source: ABdhPJxeETWCrqVCfuOB5gAPIF+qCe4hlFe1Ma9v2vP3RgkhEoj4admqIdDnCSo8/irQVL9xFyuEwAtGfzJ5W6+F5M8=
X-Received: by 2002:a05:6638:a9b:: with SMTP id 27mr12635431jas.137.1607653806906;
 Thu, 10 Dec 2020 18:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20201209083426.2866-1-hdanton@sina.com>
In-Reply-To: <20201209083426.2866-1-hdanton@sina.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 11 Dec 2020 10:29:55 +0800
Message-ID: <CAJhGHyAbjbpzp_+eLEEVVgUUCh6aJjUYbEigVwTrM1_Gx1Jf1w@mail.gmail.com>
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

On Wed, Dec 9, 2020 at 4:34 PM Hillf Danton <hdanton@sina.com> wrote:
>
> This makes the cpumask intact for worker pools of unbound workqueues
> when CPUs go offline because we need to rebind workers to the original
> cpumask(of the original pool) when they come back, as represented by
> the cpu check in restore_unbound_workers_cpumask().
>
> Note this is now only for comments.
>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
>
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4117,6 +4117,32 @@ static void wq_update_unbound_numa(struc
>         copy_workqueue_attrs(target_attrs, wq->unbound_attrs);
>         pwq = unbound_pwq_by_node(wq, node);
>
> +       cpumask = pwq->pool->attrs->cpumask;
> +       if (!online || !cpumask_test_cpu(cpu, cpumask))
> +               return;
> +       do {
> +               struct worker *worker;
> +               int i;
> +
> +               for_each_cpu_and(i, cpu_online_mask, cpumask) {
> +                       if (i != cpu)
> +                               return;
> +               }
> +
> +               /*
> +                * rebind workers only when the first CPU in
> +                * pool's attrs cpumask comes back because scheduler
> +                * may have unbound them when the last CPU went offline
> +                */
> +               mutex_lock(&wq_pool_attach_mutex);
> +
> +               for_each_pool_worker(worker, pwq->pool)
> +                       set_cpus_allowed_ptr(worker->task, cpumask);
> +

There might be multiple pwqs that share the same pool, this line of
code might update the same pool multiple times.

Please keep the logic in restore_unbound_workers_cpumask().

> +               mutex_unlock(&wq_pool_attach_mutex);
> +               return;
> +       } while (0);
> +
>         /*
>          * Let's determine what needs to be done.  If the target cpumask is
>          * different from the default pwq's, we need to compare it to @pwq's
> @@ -5004,34 +5030,6 @@ static void rebind_workers(struct worker
>         raw_spin_unlock_irq(&pool->lock);
>  }
>
> -/**
> - * restore_unbound_workers_cpumask - restore cpumask of unbound workers
> - * @pool: unbound pool of interest
> - * @cpu: the CPU which is coming up
> - *
> - * An unbound pool may end up with a cpumask which doesn't have any online
> - * CPUs.  When a worker of such pool get scheduled, the scheduler resets
> - * its cpus_allowed.  If @cpu is in @pool's cpumask which didn't have any
> - * online CPU before, cpus_allowed of all its workers should be restored.
> - */
> -static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
> -{
> -       static cpumask_t cpumask;
> -       struct worker *worker;
> -
> -       lockdep_assert_held(&wq_pool_attach_mutex);
> -
> -       /* is @cpu allowed for @pool? */
> -       if (!cpumask_test_cpu(cpu, pool->attrs->cpumask))
> -               return;
> -
> -       cpumask_and(&cpumask, pool->attrs->cpumask, cpu_online_mask);

Good catch of the problem.
But please fix it where the problem is found (here!)
Like this:

+        /* only restore the cpumask of the pool's workers when @cpu is
+           the first online cpu in @pool's cpumask */
+        if (cpumask_weight(cpumask) > 1)
+                return;

        /* as we're called from CPU_ONLINE, the following shouldn't fail */
        for_each_pool_worker(worker, pool)
-                WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
+                WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
pool->attrs->cpumask) < 0);

> -
> -       /* as we're called from CPU_ONLINE, the following shouldn't fail */
> -       for_each_pool_worker(worker, pool)
> -               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
> -}
> -
>  int workqueue_prepare_cpu(unsigned int cpu)
>  {
>         struct worker_pool *pool;
> @@ -5058,8 +5056,6 @@ int workqueue_online_cpu(unsigned int cp
>
>                 if (pool->cpu == cpu)
>                         rebind_workers(pool);
> -               else if (pool->cpu < 0)
> -                       restore_unbound_workers_cpumask(pool, cpu);
>
>                 mutex_unlock(&wq_pool_attach_mutex);
>         }
