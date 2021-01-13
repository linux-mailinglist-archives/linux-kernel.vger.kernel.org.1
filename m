Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35162F4AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbhAMMBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMMBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:01:33 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCB8C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:00:52 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id u17so3552030iow.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LA1GuJKcbqCWCGBVFrg1djl2K55ygdfBsa654vAMCo=;
        b=pk3475P6QFH6JUljjpgIKcK5d81dUjL0j2Y8ESVQEaERi2FSlCmS/bwsn9pBDXUuTF
         jOFcPzXedDxMdVdH8DRYkMaIdOth8TwaQRyVQuHwMC/ojCwRxgcweLqrc1yv/lMZ1Ekj
         NR6lVkDSa+rl8oEWwGl0PWyAaRAijgNege86C8eFYqcrX0KMEYNZ/q23pu/jAPEEQFek
         e+zpXtcPaMImCxHMTHRfFukwosFhMNeebntsayZewyRWgV3xRcdwi9uaQSlIZDGFSuYd
         ty0Xvz6V9AUIs9ooFj64CT/LJ2JGzBwzHpxpLv/BvIjqr3qNPYJpDhdxcIV5eMOKumfZ
         qc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LA1GuJKcbqCWCGBVFrg1djl2K55ygdfBsa654vAMCo=;
        b=FpA4XOTijwbLBxn//RNsNFlpSkzCWFEFyBJ0vXhKvLpCGfe+i+yGMO/hlHNbCA9oRj
         +qXwSxNLLFSQLBjF3/OblQszr3Oa3241gHV03OLZH0fBpFrAtNxxXaAQ8eASPrvly3Os
         4V7y4wBG8p5MFgbMbpYNXM4FPMCIsnT1ZYvfPy0UCRtpRtL+XgeDp7iuxZDBhrnsQbeN
         LJRER/ENRy8EnGic2XOKvWJRYFGgNXZRN5NQrsSZ7xb+eCPesV0+dgqiqyP65n/VQfYb
         0SDGAa/F3/sA8jNrws6F+/6th35F21rgavAL4Dk9Yv02ojKaGhekevMD+b47zoeMyo0B
         3amQ==
X-Gm-Message-State: AOAM53163JgLF+M02ITsB/VG8PfhKKLLc9mGTTGJpZ3KJgGkrWPzfhkK
        y3nd52YOgzl2difUt/q2mjf0+kxoqxrga377UiIqdqsZ
X-Google-Smtp-Source: ABdhPJzfe496emQL2ga8lY0noF9wxQqNekAn647s6h8+4tIT/jgvClJkhw+v1K9MXLUgekCbFDdL9HFrwlhyeOklRgI=
X-Received: by 2002:a92:2802:: with SMTP id l2mr1946024ilf.47.1610539252174;
 Wed, 13 Jan 2021 04:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20201226025117.2770-1-jiangshanlai@gmail.com> <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de> <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net> <jhj7doj1dr1.mognet@arm.com>
 <X/yzrJw4UbQsK3KB@hirez.programming.kicks-ass.net> <CAJhGHyA0rfR92W7T7RnhPrmLMkmV4Mb7fUSeG2VEHhsH-pSxsw@mail.gmail.com>
 <X/236obyM0nqL5+X@hirez.programming.kicks-ass.net> <CAJhGHyDtku6PjLtkq7TGmcQnds5cakR6viki=bPoxxkdC0p-Tw@mail.gmail.com>
 <X/7VQ8pF5h/K+Cj1@hirez.programming.kicks-ass.net>
In-Reply-To: <X/7VQ8pF5h/K+Cj1@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 13 Jan 2021 20:00:40 +0800
Message-ID: <CAJhGHyDZMGtHztzZSfBjXzhZfqo07HUTXXDxV3JSyM0+vOwqdA@mail.gmail.com>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paul McKenney <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 7:11 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 12, 2021 at 11:38:12PM +0800, Lai Jiangshan wrote:
>
> > But the hard problem is "how to suppress the warning of
> > online&!active in __set_cpus_allowed_ptr()" for late spawned
> > unbound workers during hotplug.
>
> I cannot see create_worker() go bad like that.
>
> The thing is, it uses:
>
>   kthread_bind_mask(, pool->attr->cpumask)
>   worker_attach_to_pool()
>     set_cpus_allowed_ptr(, pool->attr->cpumask)
>
> which means set_cpus_allowed_ptr() must be a NOP, because the affinity
> is already set by kthread_bind_mask(). Further, the first wakeup of that
> worker will then hit:
>
>   select_task_rq()
>     is_cpu_allowed()
>       is_per_cpu_kthread() -- false
>     select_fallback_rq()
>
>
> So normally that really isn't a problem. I can only see a tiny hole
> there, where someone changes the cpumask between kthread_bind_mask() and
> set_cpus_allowed_ptr(). AFAICT that can be fixed in two ways:
>
>  - add wq_pool_mutex around things in create_worker(), or
>  - move the set_cpus_allowed_ptr() out of worker_attach_to_pool() and
>    into rescuer_thread().
>
> Which then brings us to rescuer_thread...  If we manage to trigger the
> rescuer during hotplug, then yes, I think that can go wobbly.

Oh, I forgot set_cpus_allowed_ptr() is NOP when combined with
kthread_bind_mask()(create_worker()).

So the problem becomes "how to suppress the warning of online&!active in
__set_cpus_allowed_ptr()" for late *attached unbound rescuer* workers
during hotplug.


>
> Let me consider that a bit more while I try and make sense of that splat
> Paul reported.
>
> ---
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index ec0771e4a3fb..fe05308dc472 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1844,15 +1844,19 @@ static struct worker *alloc_worker(int node)
>   * cpu-[un]hotplugs.
>   */
>  static void worker_attach_to_pool(struct worker *worker,
> -                                  struct worker_pool *pool)
> +                                 struct worker_pool *pool,
> +                                 bool set_affinity)
>  {
>         mutex_lock(&wq_pool_attach_mutex);
>
> -       /*
> -        * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
> -        * online CPUs.  It'll be re-applied when any of the CPUs come up.
> -        */
> -       set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> +       if (set_affinity) {
> +               /*
> +                * set_cpus_allowed_ptr() will fail if the cpumask doesn't have
> +                * any online CPUs.  It'll be re-applied when any of the CPUs
> +                * come up.
> +                */
> +               set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> +       }
>
>         /*
>          * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
> @@ -1944,7 +1948,7 @@ static struct worker *create_worker(struct worker_pool *pool)
>         kthread_bind_mask(worker->task, pool->attrs->cpumask);
>
>         /* successful, attach the worker to the pool */
> -       worker_attach_to_pool(worker, pool);
> +       worker_attach_to_pool(worker, pool, false);
>
>         /* start the newly created worker */
>         raw_spin_lock_irq(&pool->lock);
> @@ -2509,7 +2513,11 @@ static int rescuer_thread(void *__rescuer)
>
>                 raw_spin_unlock_irq(&wq_mayday_lock);
>
> -               worker_attach_to_pool(rescuer, pool);
> +               /*
> +                * XXX can go splat when running during hot-un-plug and
> +                * the pool affinity is wobbly.
> +                */
> +               worker_attach_to_pool(rescuer, pool, true);
>
>                 raw_spin_lock_irq(&pool->lock);
>
