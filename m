Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79752F35E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbhALQht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhALQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:37:48 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C12C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:37:08 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u17so5373260iow.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGcIxP3xSCmccTrgJpEutyIYQByyM8g97pTqKfUQq3Q=;
        b=oxuNi2+dTMfsYTp63oASQOLp2nUTeYsJRACVFjAjtZyrRFfeOJTPBN5fADgcdWjUzP
         lm2GCcdr5T8LcHaZrJWGkDB4AcmfwuyITntlo14viwteoNwWzt8PP+bM5a6iBFJjI0/p
         tugnozrjBOIp4fbEE51Qd/b6X3i8kiwmU+V0sYoJ8CdbYfjF1ZxtnI+cFM87H+bOfUX2
         xk9NREv+LtRsbXrAHnPFI3SlVxxPupXQZ6cBQxMTLDYoYKp3Yr0mdIxIb7Trwj+MFTtL
         tdtTBnr2C0omjHT9OOjBRFP6zpfmYds6QOeHIltGMktHrcAtoSy8pS2wsnQhM0ZmKzPY
         kn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGcIxP3xSCmccTrgJpEutyIYQByyM8g97pTqKfUQq3Q=;
        b=h82X7b+in5naMit5gNHuU3cuWkO7VgZBzrrwCJfh+7t4doocV9L5zJobzEWVGZEcsS
         BWpalV8Sq/GroBAVBApOvoCou2O7TSVLBNIURbMZPw6LGSfI2XwuWSTQbt93m+kyMKpq
         X+N4LTZxtY3rxzCONShG50x2VHzer+zbnaS+kHGamznwtTI6eNKK4qIAzi1viV9QByLv
         w7fkNsHi8FV1nGSLkUM9ZsErDIiCCLj351gq9l7OMsNQQZMbOiJ7kMbUeoN9swMPZozJ
         CYkZQn1vrcyr6aR+r6Wvb4jX6dHxOTdA/rPJ4aPjJfC+2se03smxIjSr9EM06jmyClKM
         j54g==
X-Gm-Message-State: AOAM530i35rtwf0SJkXq9iLi+RpAs5/G4ZYhKoKjtZuSwekwG8R6dAx6
        R3ztGev6tOSHyJdp9FD1w3Ldnb6IvYRGMIUzJqw=
X-Google-Smtp-Source: ABdhPJwMLWNMYJDVv24pw+Y4P1OBQtZmTYYW/S8MeaRsA+U+hRwcPYFoX8WVTlMwAlNlGMTFuEqXHzYJSVWUisNRfgU=
X-Received: by 2002:a05:6e02:f14:: with SMTP id x20mr4772267ilj.94.1610469427394;
 Tue, 12 Jan 2021 08:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20210112144344.850850975@infradead.org> <20210112144843.849135905@infradead.org>
In-Reply-To: <20210112144843.849135905@infradead.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 13 Jan 2021 00:36:55 +0800
Message-ID: <CAJhGHyDWn91eH7-ZPj-utuaugz3UEdGXSKgLYHkdwBr5op=8iA@mail.gmail.com>
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

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

I like this patchset in that the scheduler takes care of the
affinities of the tasks when we don't want it to be per-cpu.

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
> +       }
>
>         raw_spin_lock_irq(&pool->lock);
>
>
>
