Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BC71B7BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 18:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgDXQe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 12:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgDXQe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:34:56 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD99DC09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:34:54 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id y10so10086094uao.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=m74EbFgut4tRMj4Qc4hZLxVdMXd2GF6ypoHuuNt/91s=;
        b=Vb58zefHpcU2gqiVgxeeFQ6/WHuDV+WtG9baOKM4I+gsKZt6ZF/STJ/1zjfawwiVU+
         Atj3dAvkwU7B/x/sGfG3WPrlnQzljrOZPuD/MwCfLLF2s1CgiI175zJ3m/b5C3K7ZuJQ
         S1ZrjvkZ8kNSzgj9gEadh741YtnS94+VhZiPXwdmgwuIAjfVNMiwK9S0TEsrGTn9IZIM
         xnz9tRGwjt1qh2G9RNMGf2nbPbC9C8160vCpdpg9o42UD8FskCEsnQCErZlUhPKTO46t
         FEnNS5/fXp67vQHHnRY7gqqdmtTaSGmc0JBc7jjRNttNNsEvygZRI9a4PSq/5kKu0PFg
         YCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=m74EbFgut4tRMj4Qc4hZLxVdMXd2GF6ypoHuuNt/91s=;
        b=KCQdZSn5cdL93v41Sibt5Rk56R//RkcIddZI164wwAb4xU4GpEMINZeR0gkdhVSd3P
         DUvoZXiO1jEMFks6Tegl4IaEc2T1/BCxTRv0V4uvMYn+oXDftnM1jdg3azpdMxc3EYpO
         6biQRbsguHHqkm2HmTqz9Vh/frP41VcMjNEYgDRtTn6DG8BhPQ1UwDE56Fy4s7Qry9np
         0wPWFi3Azx5PmpEu9/RRGGRYQSVcHczB019ilnefg+9ayBjFNsDnyxjdWZCkBegd0lPg
         YrRKfRJoRKl7e1ZCA1AGxuJMTZB77zaSAJDRTimqgpiHIhzgt8tTvmYTdXCXz5OTm74G
         ZHmg==
X-Gm-Message-State: AGi0PuZHsiqyIRNzSyD1RH6GMzgSmSVxjKufVVPHsVUSgJmAAK8a4iU5
        T4ZI0H9wq0bp+SOYHKl1ZUxIMEMHClpuIdvoOEKODA==
X-Google-Smtp-Source: APiQypL12Xz+BRm0hmIZGm69bOLS9qpIkW1nHZaviG2BN2MEFHLbgkEICJrJNk07hyJy6vG4YysX57s9Hf24n9B0llY=
X-Received: by 2002:ab0:1d90:: with SMTP id l16mr3217442uak.13.1587746093338;
 Fri, 24 Apr 2020 09:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpG4NkhpQvZjgXZ_3gm6Hf1QgN_eUOQ8iX9Cv1k9whLwSQ@mail.gmail.com>
In-Reply-To: <CAJuCfpG4NkhpQvZjgXZ_3gm6Hf1QgN_eUOQ8iX9Cv1k9whLwSQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 24 Apr 2020 09:34:42 -0700
Message-ID: <CAJuCfpGMdegJvLO-o-96PNf6iV5sWcmj=WUovi9ixRbeiHX70w@mail.gmail.com>
Subject: Re: lockdep warning about possible circular dependency in PSI
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, will@kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to bother you again folks. Any suggestions on how to silence
this lockdep warning which I believe to be a false positive?

On Wed, Apr 15, 2020 at 4:01 PM Suren Baghdasaryan <surenb@google.com> wrot=
e:
>
> I received a report about possible circular locking dependency warning
> generated from PSI polling code. I think we are protected from this
> scenario by poll_scheduled atomic but wanted to double-check and I=E2=80=
=99m
> looking for an advice on how to annotate this case to fix the lockdep
> warning. I copied the detailed information at the end of this email
> but the short story is this:
>
> "WARNING: possible circular locking dependency detected" is generated
> with CONFIG_PSI and CONFIG_LOCKDEP enabled. The dependency chain it
> describes is:
>
> #0
> kthread_delayed_work_timer_fn()
>  |
> worker->lock
>  |
> try_to_wake_up()
>  |
> p->pi_lock
>
> #1
> sched_fork()
>  |
> p->pi_lock
>  |
> task_fork_fair()
>  |
> rq->lock
>
> #2
> psi_memstall_enter
>  |
> rq->lock
>  |
> kthread_queue_delayed_work()
>  |
> worker->lock
>
> #0 holds worker->lock and takes task->pi_lock
> #1 holds task->pi_lock and takes rq->lock;
> #2 holds rq->lock and takes worker->lock;
>
> However before #2 calls kthread_queue_delayed_work (to schedule
> psi_poll_work) and takes worker->lock it checks and sets
> poll_scheduled atomic here:
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L561
> which will prevent it from proceeding. For #0 to hold worker->lock
> psi_poll_work should be scheduled, so these two events should never
> happen at the same time. The logic here is that we do not reschedule
> psi_poll_work if it=E2=80=99s already scheduled and
> kthread_delayed_work_timer_fn will not be holding worker->lock unless
> psi_poll_work is scheduled.
>
> Note: poll_scheduled gets reset inside psi_poll_work
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L589,
> at which time it=E2=80=99s not scheduled and kthread_delayed_work_timer_f=
n
> can=E2=80=99t hold the worker->lock.
> Note: worker used in kthread_delayed_work_timer_fn and in
> kthread_queue_delayed_work is not shared with any other delayed work
> because it is created for each individual PSI group:
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L1068.
>
> Could someone please (1) confirm that this lockdep warning is indeed a
> false positive and (2) advise on how to annotate this situation so
> that lockdep is satisfied. AFAIK there is no construct like
> lockdep_assert_not_held which I could call after setting
> poll_scheduled and before calling kthread_queue_delayed_work to
> declare that worker->lock is not held by anyone.
> Thanks,
> Suren.
>
> COMPLETE REPORT:
>
> <4>[  337.948389] c3 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> <4>[  337.948392] c3 WARNING: possible circular locking dependency detect=
ed
> <4>[  337.948399] c3 4.14.133+ #1 Tainted: G S         O
> <4>[  337.948401] c3 ----------------------------------------------------=
--
> <4>[  337.948407] c3 kswapd0/813 is trying to acquire lock:
> <4>[  337.948410] c3  (&p->pi_lock){-.-.}, at: [<0000000031701355>]
> try_to_wake_up+0x4c/0x6c4
> <4>[  337.948434] c3
> <4>[  337.948434] c3 but task is already holding lock:
> <4>[  337.948436] c3  ((worker)->lock){..-.}, at: [<0000000038d38987>]
> kthread_delayed_work_timer_fn+0x2c/0x98
> <4>[  337.948450] c3
> <4>[  337.948450] c3 which lock already depends on the new lock.
> <4>[  337.948450] c3
> <4>[  337.948452] c3
> <4>[  337.948452] c3 the existing dependency chain (in reverse order) is:
> <4>[  337.948455] c3
> <4>[  337.948455] c3 -> #2 ((worker)->lock){..-.}:
> <4>[  337.948471] c3        _raw_spin_lock_irqsave+0x54/0x94
> <4>[  337.948475] c3        kthread_queue_delayed_work+0x30/0xac
> <4>[  337.948482] c3        psi_schedule_poll_work+0xe0/0x148
> <4>[  337.948486] c3        psi_task_change+0x318/0x374
> <4>[  337.948491] c3        psi_memstall_enter+0xa4/0xbc
> <4>[  337.948497] c3        kswapd+0x69c/0x9d4
> <4>[  337.948501] c3        kthread+0x11c/0x12c
> <4>[  337.948507] c3        ret_from_fork+0x10/0x18
> <4>[  337.948509] c3
> <4>[  337.948509] c3 -> #1 (&rq->lock){-.-.}:
> <4>[  337.948521] c3        _raw_spin_lock+0x48/0x84
> <4>[  337.948526] c3        task_fork_fair+0x3c/0xfc
> <4>[  337.948531] c3        sched_fork+0x100/0x274
> <4>[  337.948536] c3        copy_process+0x608/0x1860
> <4>[  337.948540] c3        _do_fork+0xa8/0x620
> <4>[  337.948544] c3        kernel_thread+0x44/0x54
> <4>[  337.948549] c3        rest_init+0x28/0x200
> <4>[  337.948556] c3        start_kernel+0x3a8/0x41c
> <4>[  337.948560] c3
> <4>[  337.948560] c3 -> #0 (&p->pi_lock){-.-.}:
> <4>[  337.948572] c3        lock_acquire+0x210/0x248
> <4>[  337.948576] c3        _raw_spin_lock_irqsave+0x54/0x94
> <4>[  337.948580] c3        try_to_wake_up+0x4c/0x6c4
> <4>[  337.948584] c3        wake_up_process+0x28/0x34
> <4>[  337.948587] c3        kthread_insert_work+0x54/0x64
> <4>[  337.948591] c3        kthread_delayed_work_timer_fn+0x68/0x98
> <4>[  337.948597] c3        call_timer_fn+0x1f0/0x40c
> <4>[  337.948602] c3        run_timer_softirq+0x33c/0x6fc
> <4>[  337.948606] c3        __do_softirq+0x308/0x52c
> <4>[  337.948611] c3        irq_exit+0xe4/0xf0
> <4>[  337.948617] c3        __handle_domain_irq+0x8c/0xc4
> <4>[  337.948621] c3        gic_handle_irq+0x144/0x1a4
> <4>[  337.948624] c3        el1_irq+0xbc/0x138
> <4>[  337.948629] c3        lock_release+0x460/0x4a4
> <4>[  337.948633] c3        _raw_spin_unlock+0x28/0x60
> <4>[  337.948638] c3        page_vma_mapped_walk+0x30/0x170
> <4>[  337.948642] c3        page_referenced_one+0xa0/0x11c
> <4>[  337.948645] c3        rmap_walk_anon+0x128/0x16c
> <4>[  337.948649] c3        rmap_walk+0x54/0x60
> <4>[  337.948653] c3        page_referenced+0x104/0x158
> <4>[  337.948657] c3        shrink_active_list+0x240/0x538
> <4>[  337.948660] c3        shrink_node_memcg+0x3e8/0x6b4
> <4>[  337.948664] c3        shrink_node+0x1d0/0x30c
> <4>[  337.948668] c3        kswapd+0x858/0x9d4
> <4>[  337.948672] c3        kthread+0x11c/0x12c
> <4>[  337.948676] c3        ret_from_fork+0x10/0x18
> <4>[  337.948678] c3
> <4>[  337.948678] c3 other info that might help us debug this:
> <4>[  337.948678] c3
> <4>[  337.948681] c3 Chain exists of:
> <4>[  337.948681] c3   &p->pi_lock --> &rq->lock --> (worker)->lock
> <4>[  337.948681] c3
> <4>[  337.948696] c3  Possible unsafe locking scenario:
> <4>[  337.948696] c3
> <4>[  337.948698] c3        CPU0                    CPU1
> <4>[  337.948701] c3        ----                    ----
> <4>[  337.948703] c3   lock((worker)->lock);
> <4>[  337.948710] c3                                lock(&rq->lock);
> <4>[  337.948716] c3                                lock((worker)->lock);
> <4>[  337.948722] c3   lock(&p->pi_lock);
> <4>[  337.948728] c3
> <4>[  337.948728] c3  *** DEADLOCK ***
> <4>[  337.948728] c3
> <4>[  337.948732] c3 3 locks held by kswapd0/813:
> <4>[  337.948735] c3  #0:  (&anon_vma->rwsem){++++}, at:
> [<000000007b6a6058>]page_lock_anon_vma_read+0x90/0x200
> <4>[  337.948747] c3  #1:  ((&(&group->poll_work)->timer)){..-.}, at:
> [<00000000e5121d4f>] call_timer_fn+0x54/0x40c
> <4>[  337.948760] c3  #2:  ((worker)->lock){..-.}, at:
> [<0000000038d38987>] kthread_delayed_work_timer_fn+0x2c/0x98
> <4>[  337.948774] c3
> <4>[  337.948774] c3 stack backtrace:
> <4>[  337.948780] c3 CPU: 3 PID: 813 Comm: kswapd0 Tainted: G S
>  O    4.14.133+ #1
> <4>[  337.948783] c3 Hardware name: Unisoc UMS512 1H10 board (DT)
> <4>[  337.948788] c3 Call trace:
> <4>[  337.948794] c3 [<000000004d057b6f>] dump_backtrace+0x0/0x42c
> <4>[  337.948799] c3 [<00000000bb3bf168>] show_stack+0x20/0x2c
> <4>[  337.948804] c3 [<000000004fa8c8e4>] dump_stack+0x94/0xe4
> <4>[  337.948809] c3 [<00000000b04d6c0e>] print_circular_bug+0x29c/0x2b4
> <4>[  337.948813] c3 [<00000000a9e5ccc5>] __lock_acquire+0x15e0/0x15e8
> <4>[  337.948817] c3 [<00000000722130d2>] lock_acquire+0x210/0x248
> <4>[  337.948821] c3 [<00000000260f5fe3>] _raw_spin_lock_irqsave+0x54/0x9=
4
> <4>[  337.948825] c3 [<0000000031701355>] try_to_wake_up+0x4c/0x6c4
> <4>[  337.948829] c3 [<0000000076823b43>] wake_up_process+0x28/0x34
> <4>[  337.948834] c3 [<000000003c172f76>] kthread_insert_work+0x54/0x64
> <4>[  337.948838] c3 [<00000000eb441b43>]
> kthread_delayed_work_timer_fn+0x68/0x98
> <4>[  337.948842] c3 [<000000005366d34d>] call_timer_fn+0x1f0/0x40c
> <4>[  337.948846] c3 [<00000000d5906f3d>] run_timer_softirq+0x33c/0x6fc
> <4>[  337.948850] c3 [<00000000b3d1ef99>] __do_softirq+0x308/0x52c
> <4>[  337.948854] c3 [<00000000c9cf0fe4>] irq_exit+0xe4/0xf0
> <4>[  337.948858] c3 [<0000000020b4257b>] __handle_domain_irq+0x8c/0xc4
> <4>[  337.948862] c3 [<0000000069f6ed49>] gic_handle_irq+0x144/0x1a4
> <4>[  337.948866] c3 Exception stack(0xffffff800b7c3650 to 0xffffff800b7c=
3790)
> <4>[  337.948870] c3 3640:
> 0000000000000000 0000000000000002
> <4>[  337.948874] c3 3660: 0000000000000002 ffffff800b7c3894
> 0000000000000001 0000000000000000
> <4>[  337.948879] c3 3680: 0000000000000000 ffffff8008241768
> 0000000000000001 0000000000000001
> <4>[  337.948883] c3 36a0: ffffffc0fb2f9b60 000000000004b5ca
> 00000000000000e0 000000000000010d
> <4>[  337.948887] c3 36c0: 0000000000000000 ffffff800b7c3b10
> 0000000000000000 00000000c28f5c29
> <4>[  337.948891] c3 36e0: 0000000000000004 ffffffc0f73bb980
> 0000000000000002 0000000000000301
> <4>[  337.948896] c3 3700: ffffff80098fd898 ffffffc0f73bc300
> 0000000000000040 ffffff800a2c1000
> <4>[  337.948900] c3 3720: 0000007f94ef8000 ffffffbf03e86c40
> 000000000000001a ffffff800b7c38e0
> <4>[  337.948905] c3 3740: ffffff8008123540 ffffff800b7c3890
> ffffff80081235e4 0000000060c00045
> <4>[  337.948909] c3 3760: 0000000000000001 0000000000000000
> ffffffffffffffff ffffffc0f73bb980
> <4>[  337.948913] c3 3780: ffffff800b7c38e0 ffffff80081235e4
> <4>[  337.948917] c3 [<00000000be726f21>] el1_irq+0xbc/0x138
> <4>[  337.948921] c3 [<00000000f4a53f17>] lock_release+0x460/0x4a4
> <4>[  337.948926] c3 [<00000000895b89bb>] _raw_spin_unlock+0x28/0x60
> <4>[  337.948929] c3 [<00000000be16e394>] page_vma_mapped_walk+0x30/0x170
> <4>[  337.948933] c3 [<0000000056ad5ed1>] page_referenced_one+0xa0/0x11c
> <4>[  337.948937] c3 [<000000004a62c7eb>] rmap_walk_anon+0x128/0x16c
> <4>[  337.948941] c3 [<0000000087e56155>] rmap_walk+0x54/0x60
> <4>[  337.948944] c3 [<0000000030e2896b>] page_referenced+0x104/0x158
> <4>[  337.948949] c3 [<0000000068cfe94a>] shrink_active_list+0x240/0x538
> <4>[  337.948953] c3 [<00000000ac1be63e>] shrink_node_memcg+0x3e8/0x6b4
> <4>[  337.948957] c3 [<00000000ba3f8cf8>] shrink_node+0x1d0/0x30c
> <4>[  337.948961] c3 [<00000000608ff904>] kswapd+0x858/0x9d4
> <4>[  337.948965] c3 [<00000000fa01e737>] kthread+0x11c/0x12c
> <4>[  337.948969] c3 [<00000000f21b5e5f>] ret_from_fork+0x10/0x18
