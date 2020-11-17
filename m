Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BC52B5A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgKQHNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 02:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgKQHNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 02:13:33 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2737BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 23:13:33 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y197so19523250qkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 23:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zr5Zwdnm9g0v0RoWFdb/Hft1niHdwCm4sqYnYTlZRA0=;
        b=ZMRHKDiuXueL/8jyVbzGk+0iT/AIEbWL6GWC5QTrV2A7rPKuoGLaXxRitj9EC9IwtR
         cNewNcdIAov9nYZIGyeib8EoNwIycq4gAuAZUe/et3xvlchA894HLfcpuAlF4K37bFDW
         UmiOUVH7m9ZY2SibIh/bUyIHJ/h3GMLtL582Xm4j3rRXBzgMnokEcmHDGiYYGjm7AI4B
         fPBuJPoMTMV4cuUNMmjIipkwnR0XkWrYEtqJN3zrgWf3wxoPeb2c+EZ9hbeX69w5WX+1
         Azx3WAjuRl+XU7wXFatycydI7NbLFCfBodLwj6LJNJQkLzXW2KnAwaydlzhYxkB6IqiC
         L7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zr5Zwdnm9g0v0RoWFdb/Hft1niHdwCm4sqYnYTlZRA0=;
        b=hGkNBwXUQ967+7Ax25KUG6Q2RyaLSa1PphSzsz8OKpX/7RzBJVORmjSLdztLUBhvuv
         Rn+/m4EhlyDX8xjjNpkYAS4xLL4z9AcsJj9JgB2t5ylI4NvH7hKNfndf5Zc3lSeXxsbm
         uDe0f3yfaBM4G3ymTxcEKhDRU5sCRb1cVeRBE884RMn0pBwkDllzFPqk5Y1PDUSf3W2d
         BCTa4SRqzSIfIcawfzLp28s3WwiB7b+KWksD6wkLiVQY2fJzrzEujP0VEyWriR2k1E99
         VY8F2cWOcC+oLArLqek05dXg+NiDQD+zP5OYJfGBfAbu7QH9FCtKg1frPcJBQEX3e3Gy
         f0Uw==
X-Gm-Message-State: AOAM533X/24tE2PYqNy7HZgFkPF2C3SWzFXPpobQYrTHj5fhuUUuBOkz
        ecgVmP8CkF9k0zLTySR3M6p4DmJKvqILGMNzR89CkQ==
X-Google-Smtp-Source: ABdhPJw8b30PxRuXNHPWCgSoAq0sYHVucwIBErjKYF4ve78qZaiDmTiLrDDHpTCjOXqRjFaoxGsq8HIpFSxFRy2RTCM=
X-Received: by 2002:a05:620a:15ce:: with SMTP id o14mr19106447qkm.231.1605597212067;
 Mon, 16 Nov 2020 23:13:32 -0800 (PST)
MIME-Version: 1.0
References: <1605508168-7418-1-git-send-email-Kuan-Ying.Lee@mediatek.com>
 <1605508168-7418-2-git-send-email-Kuan-Ying.Lee@mediatek.com>
 <CACT4Y+Zy_JQ3y7_P2NXffiijTuxcnh7VPcAGL66Ks2LaLTj-eg@mail.gmail.com> <1605595583.29084.24.camel@mtksdccf07>
In-Reply-To: <1605595583.29084.24.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Nov 2020 08:13:20 +0100
Message-ID: <CACT4Y+ZpK5YKLrN_jvaD60YFKQ-kVHc=91NTBzhX5PZRTHVd7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] kasan: fix object remain in offline per-cpu quarantine
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, nicholas.tang@mediatek.com,
        Miles Chen <miles.chen@mediatek.com>,
        guangye.yang@mediatek.com, wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 7:46 AM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> On Mon, 2020-11-16 at 10:26 +0100, Dmitry Vyukov wrote:
> > On Mon, Nov 16, 2020 at 7:30 AM Kuan-Ying Lee
> > <Kuan-Ying.Lee@mediatek.com> wrote:
> > >
> > > We hit this issue in our internal test.
> > > When enabling generic kasan, a kfree()'d object is put into per-cpu
> > > quarantine first. If the cpu goes offline, object still remains in
> > > the per-cpu quarantine. If we call kmem_cache_destroy() now, slub
> > > will report "Objects remaining" error.
> > >
> > > [   74.982625] =============================================================================
> > > [   74.983380] BUG test_module_slab (Not tainted): Objects remaining in test_module_slab on __kmem_cache_shutdown()
> > > [   74.984145] -----------------------------------------------------------------------------
> > > [   74.984145]
> > > [   74.984883] Disabling lock debugging due to kernel taint
> > > [   74.985561] INFO: Slab 0x(____ptrval____) objects=34 used=1 fp=0x(____ptrval____) flags=0x2ffff00000010200
> > > [   74.986638] CPU: 3 PID: 176 Comm: cat Tainted: G    B             5.10.0-rc1-00007-g4525c8781ec0-dirty #10
> > > [   74.987262] Hardware name: linux,dummy-virt (DT)
> > > [   74.987606] Call trace:
> > > [   74.987924]  dump_backtrace+0x0/0x2b0
> > > [   74.988296]  show_stack+0x18/0x68
> > > [   74.988698]  dump_stack+0xfc/0x168
> > > [   74.989030]  slab_err+0xac/0xd4
> > > [   74.989346]  __kmem_cache_shutdown+0x1e4/0x3c8
> > > [   74.989779]  kmem_cache_destroy+0x68/0x130
> > > [   74.990176]  test_version_show+0x84/0xf0
> > > [   74.990679]  module_attr_show+0x40/0x60
> > > [   74.991218]  sysfs_kf_seq_show+0x128/0x1c0
> > > [   74.991656]  kernfs_seq_show+0xa0/0xb8
> > > [   74.992059]  seq_read+0x1f0/0x7e8
> > > [   74.992415]  kernfs_fop_read+0x70/0x338
> > > [   74.993051]  vfs_read+0xe4/0x250
> > > [   74.993498]  ksys_read+0xc8/0x180
> > > [   74.993825]  __arm64_sys_read+0x44/0x58
> > > [   74.994203]  el0_svc_common.constprop.0+0xac/0x228
> > > [   74.994708]  do_el0_svc+0x38/0xa0
> > > [   74.995088]  el0_sync_handler+0x170/0x178
> > > [   74.995497]  el0_sync+0x174/0x180
> > > [   74.996050] INFO: Object 0x(____ptrval____) @offset=15848
> > > [   74.996752] INFO: Allocated in test_version_show+0x98/0xf0 age=8188 cpu=6 pid=172
> > > [   75.000802]  stack_trace_save+0x9c/0xd0
> > > [   75.002420]  set_track+0x64/0xf0
> > > [   75.002770]  alloc_debug_processing+0x104/0x1a0
> > > [   75.003171]  ___slab_alloc+0x628/0x648
> > > [   75.004213]  __slab_alloc.isra.0+0x2c/0x58
> > > [   75.004757]  kmem_cache_alloc+0x560/0x588
> > > [   75.005376]  test_version_show+0x98/0xf0
> > > [   75.005756]  module_attr_show+0x40/0x60
> > > [   75.007035]  sysfs_kf_seq_show+0x128/0x1c0
> > > [   75.007433]  kernfs_seq_show+0xa0/0xb8
> > > [   75.007800]  seq_read+0x1f0/0x7e8
> > > [   75.008128]  kernfs_fop_read+0x70/0x338
> > > [   75.008507]  vfs_read+0xe4/0x250
> > > [   75.008990]  ksys_read+0xc8/0x180
> > > [   75.009462]  __arm64_sys_read+0x44/0x58
> > > [   75.010085]  el0_svc_common.constprop.0+0xac/0x228
> > > [   75.011006] kmem_cache_destroy test_module_slab: Slab cache still has objects
> > >
> > > Register a cpu hotplug function to remove all objects in the offline
> > > per-cpu quarantine when cpu is going offline. Set a per-cpu variable
> > > to indicate this cpu is offline.
> > >
> > > Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> > > Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> > > Reported-by: Guangye Yang <guangye.yang@mediatek.com>
> > > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > > Cc: Alexander Potapenko <glider@google.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > ---
> > >  mm/kasan/quarantine.c | 35 +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 35 insertions(+)
> > >
> > > diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> > > index 4c5375810449..16e618ea805e 100644
> > > --- a/mm/kasan/quarantine.c
> > > +++ b/mm/kasan/quarantine.c
> > > @@ -29,6 +29,7 @@
> > >  #include <linux/srcu.h>
> > >  #include <linux/string.h>
> > >  #include <linux/types.h>
> > > +#include <linux/cpuhotplug.h>
> > >
> > >  #include "../slab.h"
> > >  #include "kasan.h"
> > > @@ -43,6 +44,7 @@ struct qlist_head {
> > >         struct qlist_node *head;
> > >         struct qlist_node *tail;
> > >         size_t bytes;
> > > +       bool offline;
> > >  };
> > >
> > >  #define QLIST_INIT { NULL, NULL, 0 }
> > > @@ -188,6 +190,11 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
> > >         local_irq_save(flags);
> > >
> > >         q = this_cpu_ptr(&cpu_quarantine);
> > > +       if (q->offline) {
> > > +               qlink_free(&info->quarantine_link, cache);
> > > +               local_irq_restore(flags);
> > > +               return;
> > > +       }
>
> I think we need to make sure objects will not be put in per-cpu
> quarantine which is offline.
>
> > >         qlist_put(q, &info->quarantine_link, cache->size);
> > >         if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
> > >                 qlist_move_all(q, &temp);
> > > @@ -328,3 +335,31 @@ void quarantine_remove_cache(struct kmem_cache *cache)
> > >
> > >         synchronize_srcu(&remove_cache_srcu);
> > >  }
> > > +
> > > +static int kasan_cpu_online(unsigned int cpu)
> > > +{
> > > +       this_cpu_ptr(&cpu_quarantine)->offline = false;
> > > +       return 0;
> > > +}
> > > +
> > > +static int kasan_cpu_offline(unsigned int cpu)
> > > +{
> > > +       struct qlist_head *q;
> > > +
> > > +       q = this_cpu_ptr(&cpu_quarantine);
> > > +       q->offline = true;
> > > +       qlist_free_all(q, NULL);
> >
> > Looks much nicer now!
> >
> > What is the story with interrupts in these callbacks?
> > In the previous patch you mentioned that this CPU can still receive
> > interrupts for a brief period of time. If these interrupts also free
> > something, can't we corrupt the per-cpu quarantine? In quarantine_put
> > we protect it by disabling interrupts I think.
> >
>
> Here is a situation.
> After we freed all objects from the per-cpu quarantine which is going
> offline, the interrupts happened. These interrupts free something and
> put objects into this per-cpu quarantine. If we call
> kmem_cache_destroy() now, slub still detect objects remain in
> the per-cpu quarantine and report "Object remaining" error.
>
> Thus, we need to check q->offline in quarantine_put and make sure
> the offline per-cpu quarantine is not corrupted.

If an interrupt can happen later, can't it happen right during our
call to qlist_free_all and corrupt the per-cpu cache?
Perhaps we need something like:

// ... explain the subtleness ...
WRITE_ONCE(q->offline, true);
barrier();
qlist_free_all(q, NULL);

?

> > > +       return 0;
> > > +}
> > > +
> > > +static int __init kasan_cpu_offline_quarantine_init(void)
> > > +{
> > > +       int ret = 0;
> > > +
> > > +       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mm/kasan:online",
> > > +                               kasan_cpu_online, kasan_cpu_offline);
> > > +       if (ret < 0)
> > > +               pr_err("kasan offline cpu quarantine register failed [%d]\n", ret);
> > > +       return ret;
> > > +}
> > > +late_initcall(kasan_cpu_offline_quarantine_init);
> > > --
> > > 2.18.0
