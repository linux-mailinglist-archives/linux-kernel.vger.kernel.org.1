Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2AE2E1BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgLWLdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgLWLd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:33:28 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9398EC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:32:48 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id i18so14844893ioa.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MfphX/3jcL+adOexPe8EyhNRZOELS86em6ZhMXdrk+U=;
        b=BAMu0GCh2386bD+56EKunaR+96enjoTDX0HBnMPj3ffQRgoWO0m+NXH+Cx7fpkEbQo
         oDyvTL+ECfiCt9rd+OviSa3LqSxCsREa8UNbNvZXV9QrJOPXPgmwfebcG76CrSV7UCkX
         X8faOahfWIeKVZOSkV+gm1RGwfJ2tQV0i2PSxX/U5MjSQ+ML8IyvU5V2+ewB9hICAfNL
         KJHwzMkDVxGxnk+tyYCP4lfyMBtqBl2pugXSV4dd+psBifpbTm2wbKSEHXYq87GDoIDN
         IUC0F2jug2Y1RFhCN6IA8fb4TjgvMFB0Ai+4CG2C7grg41H201Uf3xMnuYpkZdmcweJU
         3r5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MfphX/3jcL+adOexPe8EyhNRZOELS86em6ZhMXdrk+U=;
        b=uc/gSLtEkP5lRCDeBvQ3NLO4VVREQMooJ+98i8N0kQn9dj4clL4Oajgu8aYWozKsze
         vpvBX4eEFlmGGAj0MSytfunjHgUN0CZq/9M5MeGs0C9vjj/jUewb4UucCBSgbxTVoSeK
         gCyg6ZofdE5uZIP+quiwT0bNRrXEgLNX1Nw43t/2XooTEbAJf9jnJLVwgaCBQJNWqLl4
         yh5bjD7isX3qZmz1LIQEF6C8DiwfjMqE1DKqXlnIzqR/hMDYLCSS7eOnq9cHwpBU+SGX
         Q8Zzq1KxAl84l7KzXe9I1ijDD1Thegb9cqBTuIi6GtGCqHS66gK8yKvGzUy+ZaOE7YLG
         IQfA==
X-Gm-Message-State: AOAM533Qd1GpS6AIxb3w/IQFHzqEze9BZ+7gsRGVx4cB2Bx1VoDdZD/d
        aqNHKpW2Cjph0R1PhBVE6CTTIQFo9pPjxIud22k=
X-Google-Smtp-Source: ABdhPJx7rSYcaqnsQ/tg8lvaK4RV1dU+OYPd71RPP+3dhtFKnlH8fyQpu9DC74w1BCVKi506EhVUr8Ia6vVlsX0BHao=
X-Received: by 2002:a05:6602:388:: with SMTP id f8mr21209108iov.56.1608723167974;
 Wed, 23 Dec 2020 03:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20201218170919.2950-1-jiangshanlai@gmail.com> <CAA42JLa=r5c7_D5K1rHr5Tx5Enrib3rAdFZzajXumCq7-i-Q+g@mail.gmail.com>
In-Reply-To: <CAA42JLa=r5c7_D5K1rHr5Tx5Enrib3rAdFZzajXumCq7-i-Q+g@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 23 Dec 2020 19:32:36 +0800
Message-ID: <CAJhGHyDCD5wK6X40kCNV-AZBSHHC7tK06HATy+CYvvcqvHuE9A@mail.gmail.com>
Subject: Re: [PATCH -tip V2 00/10] workqueue: break affinity initiatively
To:     Dexuan-Linux Cui <dexuan.linux@gmail.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 5:39 AM Dexuan-Linux Cui <dexuan.linux@gmail.com> wrote:
>
> On Fri, Dec 18, 2020 at 8:11 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> >
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > 06249738a41a ("workqueue: Manually break affinity on hotplug")
> > said that scheduler will not force break affinity for us.
> >
> > But workqueue highly depends on the old behavior. Many parts of the codes
> > relies on it, 06249738a41a ("workqueue: Manually break affinity on hotplug")
> > is not enough to change it, and the commit has flaws in itself too.
> >
> > It doesn't handle for worker detachment.
> > It doesn't handle for worker attachement, mainly worker creation
> >   which is handled by Valentin Schneider's patch [1].
> > It doesn't handle for unbound workers which might be possible
> > per-cpu-kthread.
> >
> > We need to thoroughly update the way workqueue handles affinity
> > in cpu hot[un]plug, what is this patchset intends to do and
> > replace the Valentin Schneider's patch [1].  The equivalent patch
> > is patch 10.
> >
> > Patch 1 fixes a flaw reported by Hillf Danton <hdanton@sina.com>.
> > I have to include this fix because later patches depends on it.
> >
> > The patchset is based on tip/master rather than workqueue tree,
> > because the patchset is a complement for 06249738a41a ("workqueue:
> > Manually break affinity on hotplug") which is only in tip/master by now.
> >
> > And TJ acked to route the series through tip.
> >
> > Changed from V1:
> >         Add TJ's acked-by for the whole patchset
> >
> >         Add more words to the comments and the changelog, mainly derived
> >         from discussion with Peter.
> >
> >         Update the comments as TJ suggested.
> >
> >         Update a line of code as Valentin suggested.
> >
> >         Add Valentin's ack for patch 10 because "Seems alright to me." and
> >         add Valentin's comments to the changelog which is integral.
> >
> > [1]: https://lore.kernel.org/r/ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com
> > [V1 patcheset]: https://lore.kernel.org/lkml/20201214155457.3430-1-jiangshanlai@gmail.com/
> >
> > Cc: Hillf Danton <hdanton@sina.com>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Qian Cai <cai@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vincent Donnefort <vincent.donnefort@arm.com>
> > Cc: Tejun Heo <tj@kernel.org>
> >
> > Lai Jiangshan (10):
> >   workqueue: restore unbound_workers' cpumask correctly
> >   workqueue: use cpu_possible_mask instead of cpu_active_mask to break
> >     affinity
> >   workqueue: Manually break affinity on pool detachment
> >   workqueue: don't set the worker's cpumask when kthread_bind_mask()
> >   workqueue: introduce wq_online_cpumask
> >   workqueue: use wq_online_cpumask in restore_unbound_workers_cpumask()
> >   workqueue: Manually break affinity on hotplug for unbound pool
> >   workqueue: reorganize workqueue_online_cpu()
> >   workqueue: reorganize workqueue_offline_cpu() unbind_workers()
> >   workqueue: Fix affinity of kworkers when attaching into pool
> >
> >  kernel/workqueue.c | 214 ++++++++++++++++++++++++++++-----------------
> >  1 file changed, 132 insertions(+), 82 deletions(-)
> >
> > --
> > 2.19.1.6.gb485710b
>
> Hi,

Hello,

thanks for reporting.

I have just been debugging it in a short time, I will continue tomorrow.


> I tested this patchset on today's tip.git's master branch
> (981316394e35 ("Merge branch 'locking/urgent'")).
>
> Every time the kernel boots with 32 CPUs (I'm running the Linux VM on
> Hyper-V), I get the below warning.
> (BTW, with 8 or 16 CPUs, I don't see the warning).
> By printing the cpumasks with "%*pbl", I know the warning happens because:
> new_mask = 16-31
> cpu_online_mask= 0-16
> cpu_active_mask= 0-15
> p->nr_cpus_allowed=16


From the call stack, we can see that we are bringing cpu#16 up.
And workqueue_online_cpu is being called and sched_cpu_activate()
is not called. So cpu_online_mask= 0-16, cpu_active_mask= 0-15.

Why isn't it legitimate to set the worker's cpumask
to be new_mask(16-31) since cpu#16 is being brought up?

Anyway, it revealed there must be a problem in the patchset
which raised the warning.

>
> 2374         if (p->flags & PF_KTHREAD) {
> 2375                 /*
> 2376                  * For kernel threads that do indeed end up on online &&
> 2377                  * !active we want to ensure they are strict
> per-CPU threads.
> 2378                  */
> 2379                 WARN_ON(cpumask_intersects(new_mask, cpu_online_mask) &&
> 2380                         !cpumask_intersects(new_mask, cpu_active_mask) &&
> 2381                         p->nr_cpus_allowed != 1);
> 2382         }
> 2383
>
> (FWIW, it looks like this patchset can fix a panic I noticed during
> hibernation:
> https://lkml.org/lkml/2020/12/22/141, though I see the same warning
> during hibernation.)
>
> [    1.698042] smp: Bringing up secondary CPUs ...
> [    1.701707] x86: Booting SMP configuration:
> [    1.705368] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
> #8  #9 #10 #11 #12 #13 #14 #15
> [    1.721589] .... node  #1, CPUs:   #16
> [    1.013388] smpboot: CPU 16 Converting physical 0 to logical die 1
> [    1.809716] ------------[ cut here ]------------
> [    1.813553] WARNING: CPU: 16 PID: 90 at kernel/sched/core.c:2381
> __set_cpus_allowed_ptr+0x19e/0x1b0
> [    1.813553] Modules linked in:
> [    1.813553] CPU: 16 PID: 90 Comm: cpuhp/16 Not tainted 5.10.0+ #1
> [    1.813553] Hardware name: Microsoft Corporation Virtual
> Machine/Virtual Machine, BIOS 090008  12/07/2018
> [    1.813553] RIP: 0010:__set_cpus_allowed_ptr+0x19e/0x1b0
> [    1.813553] Code: e8 e7 a3 39 00 85 c0 74 a7 ba 00 02 00 00 48 c7
> c6 20 4b 9b 84 4c 89 ff e8 cf a3 39 00 85 c0 75 8f 83 bb a0 03 00 00
> 01 74 86 <0f> 0b eb 82 e8 49 ba 74 00 66 0f 1f 84 00 00 00 00 00 0f 1f
> 44 00
> [    1.813553] RSP: 0000:ffffba9bc1ca7cf8 EFLAGS: 00010016
> [    1.813553] RAX: 0000000000000000 RBX: ffff98ed48d58000 RCX: 0000000000000008
> [    1.813553] RDX: 0000000000000200 RSI: ffffffff849b4b20 RDI: ffff98ed48d035a8
> [    1.813553] RBP: ffff98ed42a2ac00 R08: 0000000000000008 R09: 0000000000000008
> [    1.813553] R10: ffff98ed48d035a8 R11: ffffffff8484da40 R12: 0000000000000000
> [    1.813553] R13: 0000000000000010 R14: ffffffff849b4ba0 R15: ffff98ed48d035a8
> [    1.813553] FS:  0000000000000000(0000) GS:ffff98ee3aa00000(0000)
> knlGS:0000000000000000
> [    1.813553] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.813553] CR2: 0000000000000000 CR3: 000000019980a001 CR4: 00000000003706e0
> [    1.813553] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    1.813553] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    1.813553] Call Trace:
> [    1.813553]  worker_attach_to_pool+0x53/0xd0
> [    1.813553]  create_worker+0xf9/0x190
> [    1.813553]  alloc_unbound_pwq+0x3a5/0x3b0
> [    1.813553]  wq_update_unbound_numa+0x112/0x1c0
> [    1.813553]  workqueue_online_cpu+0x1d0/0x220
> [    1.813553]  ? workqueue_prepare_cpu+0x70/0x70
> [    1.813553]  cpuhp_invoke_callback+0x82/0x4a0
> [    1.813553]  ? sort_range+0x20/0x20
> [    1.813553]  cpuhp_thread_fun+0xb8/0x120
> [    1.813553]  smpboot_thread_fn+0x198/0x230
> [    1.813553]  kthread+0x13d/0x160
> [    1.813553]  ? kthread_create_on_node+0x60/0x60
> [    1.813553]  ret_from_fork+0x22/0x30
> [    1.813553] ---[ end trace bc73d8bab71235fe ]---
> [    1.817553]  #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31
> [    1.826499] smp: Brought up 2 nodes, 32 CPUs
> [    1.833345] smpboot: Max logical packages: 2
> [    1.833574] smpboot: Total of 32 processors activated (146959.07 BogoMIPS)
>
>
> Thanks,
> Dexuan
