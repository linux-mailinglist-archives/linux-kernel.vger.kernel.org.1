Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA092F8BE6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 07:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbhAPG2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 01:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbhAPG2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 01:28:02 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9CEC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 22:27:21 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id w18so22632327iot.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 22:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSc9OYqyKr0YMtaTbhwZuTTP+MzL/UVrWs+17zk7w3k=;
        b=d0XMQTWQ2+57aO5vAzTdRbXHxkq3BZy0CSbwnDEiwQ9BXP1qU2FEq8bNxIWvt9i109
         4rkaZ3BtsLGGhWBR0KRTYDEPKVY1ZpfnIwpVqKnfo8/fyyX0KatfMrLgwQum50tPzhkz
         V9yssqoSP63dFM/I6Zj6/d8JbxrBDbJMy4yJkCwJIWYBk61Y5Ppiu169IOq+aIgVUAy0
         v7f4l8th8ZvRMxH7QoWQy8p+6PJFj8boZ46aRXw1wavSgYbPOWavnTcWsF+lwgcv7j88
         x2UdyZpsVGkHROfoDXxSxyUlTgCKCBUWkqn+eCGiU3IchpZNaiRiRc0AmyvqZdbEpBBb
         EWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSc9OYqyKr0YMtaTbhwZuTTP+MzL/UVrWs+17zk7w3k=;
        b=K0CDv33F9eDX4a3Q32m22htecRdcpcWd+5BqgEgsJFT8MD1tHiHUQ6B/bSpGM9xRvO
         Cqrb41Y21YzqzHlBEZpolzahiRMbf0FnVjsN4hsccqU9HHL92SccTkSQohb6IDmZGXCv
         DU/n0pTEMMkIhJxPlVJ7QyoCPHRE2am94pdZ7XsP7torGBAKWSB5YlXehTSokEhpOaF9
         Zb154vhGiv4x5itLAvnGvk3pS58QSJSX/xSLwDdbV4y1tqo6khgubofJK7TeXnaKPoOQ
         Xpv8H7OSWwPvIljuGgMqeLhHH4ninhaxCk80pP31Jz9nE7+MU+YLq6sjj+8z4L9dbI/H
         w2bA==
X-Gm-Message-State: AOAM530ug0JswvTwfWsm8hoWP6oPCH8kuitVzPzqIliXEvYBKZJhhFM+
        o+9sQmLnZfZzVD+2705t3e1sIjR9xBGUKuZcuHU=
X-Google-Smtp-Source: ABdhPJwHkiCjs/bmE74SGcwflW/mS9Yi9BjzLVnAVkm6b4s6UyCh4m2YJSslGpHuaM9KarW6QRO2FdpOUpXt1bZwSlo=
X-Received: by 2002:a6b:441a:: with SMTP id r26mr11013577ioa.105.1610778441019;
 Fri, 15 Jan 2021 22:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20210112144344.850850975@infradead.org> <20210112144843.849135905@infradead.org>
 <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
 <YABDI6Qkp5PNslUS@hirez.programming.kicks-ass.net> <jhjlfcvhcx5.mognet@arm.com>
 <YABknAqDe4h35+GY@hirez.programming.kicks-ass.net>
In-Reply-To: <YABknAqDe4h35+GY@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sat, 16 Jan 2021 14:27:09 +0800
Message-ID: <CAJhGHyBazDix9tLTV0HnobeSzneUK8Y9GKf6AgXspf=c9O5dhQ@mail.gmail.com>
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

On Thu, Jan 14, 2021 at 11:35 PM Peter Zijlstra <peterz@infradead.org> wrote:

>
> -void kthread_set_per_cpu(struct task_struct *k, bool set)
> +void kthread_set_per_cpu(struct task_struct *k, int cpu)
>  {
>         struct kthread *kthread = to_kthread(k);
>         if (!kthread)
>                 return;
>
> -       if (set) {
> -               WARN_ON_ONCE(!(k->flags & PF_NO_SETAFFINITY));
> -               WARN_ON_ONCE(k->nr_cpus_allowed != 1);
> -               set_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
> -       } else {
> +       WARN_ON_ONCE(!(k->flags & PF_NO_SETAFFINITY));
> +
> +       if (cpu < 0) {
>                 clear_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
> +               return;
>         }
> +
> +       kthread->cpu = cpu;
> +       set_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
>  }
>

I don't see the code to set the mask of the cpu to the task
since set_cpus_allowed_ptr() is removed from rebind_worker().

Is it somewhere I missed?

>
> @@ -2371,6 +2371,7 @@ static int worker_thread(void *__worker)
>         /* tell the scheduler that this is a workqueue worker */
>         set_pf_worker(true);
>  woke_up:
> +       kthread_parkme();
>         raw_spin_lock_irq(&pool->lock);
>
>         /* am I supposed to die? */
> @@ -2428,7 +2429,7 @@ static int worker_thread(void *__worker)
>                         move_linked_works(work, &worker->scheduled, NULL);
>                         process_scheduled_works(worker);
>                 }
> -       } while (keep_working(pool));
> +       } while (keep_working(pool) && !kthread_should_park());
>
>         worker_set_flags(worker, WORKER_PREP);
>  sleep:
> @@ -2440,9 +2441,12 @@ static int worker_thread(void *__worker)
>          * event.
>          */
>         worker_enter_idle(worker);
> -       __set_current_state(TASK_IDLE);
> +       set_current_state(TASK_IDLE);
>         raw_spin_unlock_irq(&pool->lock);
> -       schedule();
> +
> +       if (!kthread_should_park())
> +               schedule();
> +
>         goto woke_up;
>  }
>
> @@ -4923,7 +4927,7 @@ static void unbind_workers(int cpu)
>                 raw_spin_unlock_irq(&pool->lock);
>
>                 for_each_pool_worker(worker, pool) {
> -                       kthread_set_per_cpu(worker->task, false);
> +                       kthread_set_per_cpu(worker->task, -1);
>                         WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
>                 }
>
> @@ -4978,9 +4982,9 @@ static void rebind_workers(struct worker_pool *pool)
>          * from CPU_ONLINE, the following shouldn't fail.
>          */
>         for_each_pool_worker(worker, pool) {
> -               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
> -                                                 pool->attrs->cpumask) < 0);
> -               kthread_set_per_cpu(worker->task, true);
> +               WARN_ON_ONCE(kthread_park(worker->task) < 0);
> +               kthread_set_per_cpu(worker->task, pool->cpu);
> +               kthread_unpark(worker->task);

I feel nervous to use kthread_park() here and kthread_parkme() in
worker thread.  And adding kthread_should_park() to the fast path
also daunt me.

How about using a new KTHREAD_XXXX instead of KTHREAD_IS_PER_CPU,
so that we can set and clear KTHREAD_XXXX freely, especially before
set_cpus_allowed_ptr().

For example, we can add a new KTHREAD_ACTIVE_MASK_ONLY which means
even when
  is_per_cpu_kthread() && the_cpu_is_online() &&
  the_cpu_is_not_active() && KTHREAD_ACTIVE_MASK_ONLY
we should also break the affinity.

So that we can easily set KTHREAD_ACTIVE_MASK_ONLY in unbind_workers()
add clear KTHREAD_ACTIVE_MASK_ONLY here and avoid adding new
synchronization like kthread_park().

>         }
>
>         raw_spin_lock_irq(&pool->lock);
