Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB6D2B014D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgKLIjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgKLIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:39:49 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DBBC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 00:39:48 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d9so4548155qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 00:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44tChU8hOKh0CYBI3rBAGUumkOlh+n1tK4+x7kNNhRE=;
        b=ES7Ip+66QrOQHp37MF69HQyk628RHF1vADfUkAvtHmvG6Aprc61Q+66pZvplPO+F6g
         bTIoxAnOIo3Bzjt6SYyh1NLs+J+tDlgDzGjszoiTVgSYQPwWkfNCxto2/Op7eI4a15T9
         NOo5pNKo/yJWhvveQ+DrFinDK/NvbbI2UA5UW2vb+Mi+4JRdFqoHBdPKSeOFvBz7+LeB
         bxJe6JvXTczBZA3qXUKSEjnPkTaAEKuqNwuTjzZbJuWpYq6vbxqN5XllLK0MMJfiEC5X
         avYXBxCLjUIKfcY59wrOAh7BdwZvakacPq9qEcXlfWJvcOzQeYPkGNHNlSfTtnwUOn9U
         h2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44tChU8hOKh0CYBI3rBAGUumkOlh+n1tK4+x7kNNhRE=;
        b=igWK+eF2riihcObQ/PyZcJzinshTzrAvUspMY3BvjuhnHKqkBQtR7hi5e46HMj1Vil
         g1FTt84ss1EGcRNu6ZKp/0ZsPd0AkEjd4nYBkiGg6GCBg8TVqwkycyJKC1y22DAHkvBy
         9TOEHhlNjTGth+BE8kGrqQ6nAmCd07JP+7onrgvaB2uS4L3pQBJTvPymEnyUYWI7P7UO
         ipNRpQpM5JCl+qChQ6vrMFONoT6tXUEd2e8VxFC+B5rfE3jzNO9YT8S0rupfo4dv/izQ
         uSE5wN2v0ilPkmKx7toRsKUBBMHZttPtEahzThxSPtn3CxnPntGidSu4lp6xNhVFNvtk
         ChMg==
X-Gm-Message-State: AOAM532lBrL0IfWU6kMwJmznarxOR+JcASIlrL9yNK3wYWOZz582MJc/
        u6lxpsg9tC7YteoyNilBDRts5DmFUIuwYYJ8sI9+/A==
X-Google-Smtp-Source: ABdhPJx+FX8++B67dKHfb8qHSWkZlmIdjSpjnVw6aXudHiQCrTdo8ffFNBFtQaJPeB9zOHB1tf6VUd6Rk/kUB4OAxbQ=
X-Received: by 2002:a05:620a:15ce:: with SMTP id o14mr30802446qkm.231.1605170387779;
 Thu, 12 Nov 2020 00:39:47 -0800 (PST)
MIME-Version: 1.0
References: <1605162252-23886-1-git-send-email-Kuan-Ying.Lee@mediatek.com> <1605162252-23886-2-git-send-email-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <1605162252-23886-2-git-send-email-Kuan-Ying.Lee@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 Nov 2020 09:39:36 +0100
Message-ID: <CACT4Y+bpDTqQRRdV0_O07H=Kczj3nXUY9ngQgX5K=BtT=Y60RQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] kasan: fix object remain in offline per-cpu quarantine
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        nicholas.tang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 7:25 AM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> We hit this issue in our internal test.
> When enabling generic kasan, a kfree()'d object is put into per-cpu
> quarantine first. If the cpu goes offline, object still remains in
> the per-cpu quarantine. If we call kmem_cache_destroy() now, slub
> will report "Objects remaining" error.
>
> [   74.982625] =============================================================================
> [   74.983380] BUG test_module_slab (Not tainted): Objects remaining in test_module_slab on __kmem_cache_shutdown()
> [   74.984145] -----------------------------------------------------------------------------
> [   74.984145]
> [   74.984883] Disabling lock debugging due to kernel taint
> [   74.985561] INFO: Slab 0x(____ptrval____) objects=34 used=1 fp=0x(____ptrval____) flags=0x2ffff00000010200
> [   74.986638] CPU: 3 PID: 176 Comm: cat Tainted: G    B             5.10.0-rc1-00007-g4525c8781ec0-dirty #10
> [   74.987262] Hardware name: linux,dummy-virt (DT)
> [   74.987606] Call trace:
> [   74.987924]  dump_backtrace+0x0/0x2b0
> [   74.988296]  show_stack+0x18/0x68
> [   74.988698]  dump_stack+0xfc/0x168
> [   74.989030]  slab_err+0xac/0xd4
> [   74.989346]  __kmem_cache_shutdown+0x1e4/0x3c8
> [   74.989779]  kmem_cache_destroy+0x68/0x130
> [   74.990176]  test_version_show+0x84/0xf0
> [   74.990679]  module_attr_show+0x40/0x60
> [   74.991218]  sysfs_kf_seq_show+0x128/0x1c0
> [   74.991656]  kernfs_seq_show+0xa0/0xb8
> [   74.992059]  seq_read+0x1f0/0x7e8
> [   74.992415]  kernfs_fop_read+0x70/0x338
> [   74.993051]  vfs_read+0xe4/0x250
> [   74.993498]  ksys_read+0xc8/0x180
> [   74.993825]  __arm64_sys_read+0x44/0x58
> [   74.994203]  el0_svc_common.constprop.0+0xac/0x228
> [   74.994708]  do_el0_svc+0x38/0xa0
> [   74.995088]  el0_sync_handler+0x170/0x178
> [   74.995497]  el0_sync+0x174/0x180
> [   74.996050] INFO: Object 0x(____ptrval____) @offset=15848
> [   74.996752] INFO: Allocated in test_version_show+0x98/0xf0 age=8188 cpu=6 pid=172
> [   75.000802]  stack_trace_save+0x9c/0xd0
> [   75.002420]  set_track+0x64/0xf0
> [   75.002770]  alloc_debug_processing+0x104/0x1a0
> [   75.003171]  ___slab_alloc+0x628/0x648
> [   75.004213]  __slab_alloc.isra.0+0x2c/0x58
> [   75.004757]  kmem_cache_alloc+0x560/0x588
> [   75.005376]  test_version_show+0x98/0xf0
> [   75.005756]  module_attr_show+0x40/0x60
> [   75.007035]  sysfs_kf_seq_show+0x128/0x1c0
> [   75.007433]  kernfs_seq_show+0xa0/0xb8
> [   75.007800]  seq_read+0x1f0/0x7e8
> [   75.008128]  kernfs_fop_read+0x70/0x338
> [   75.008507]  vfs_read+0xe4/0x250
> [   75.008990]  ksys_read+0xc8/0x180
> [   75.009462]  __arm64_sys_read+0x44/0x58
> [   75.010085]  el0_svc_common.constprop.0+0xac/0x228
> [   75.011006] kmem_cache_destroy test_module_slab: Slab cache still has objects
>
> Register a cpu hotplug function to remove all objects in the offline
> per-cpu quarantine when cpu is going offline. Set a per-cpu variable
> to indicate this cpu is offline.
>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> ---
>  mm/kasan/quarantine.c | 59 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 4c5375810449..67fb91ae2bd0 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -29,6 +29,7 @@
>  #include <linux/srcu.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> +#include <linux/cpuhotplug.h>
>
>  #include "../slab.h"
>  #include "kasan.h"
> @@ -97,6 +98,7 @@ static void qlist_move_all(struct qlist_head *from, struct qlist_head *to)
>   * guarded by quarantine_lock.
>   */

Hi Kuan-Ying,

Thanks for fixing this.

>  static DEFINE_PER_CPU(struct qlist_head, cpu_quarantine);
> +static DEFINE_PER_CPU(int, cpu_quarantine_offline);

I think cpu_quarantine_offline is better be part of cpu_quarantine
because it logically is and we already obtain a pointer to
cpu_quarantine in quarantine_put, so it will also make the code a bit
shorter.


>  /* Round-robin FIFO array of batches. */
>  static struct qlist_head global_quarantine[QUARANTINE_BATCHES];
> @@ -176,6 +178,8 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
>         unsigned long flags;
>         struct qlist_head *q;
>         struct qlist_head temp = QLIST_INIT;
> +       int *offline;
> +       struct qlist_head q_offline = QLIST_INIT;
>
>         /*
>          * Note: irq must be disabled until after we move the batch to the
> @@ -187,8 +191,16 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
>          */
>         local_irq_save(flags);
>
> -       q = this_cpu_ptr(&cpu_quarantine);
> -       qlist_put(q, &info->quarantine_link, cache->size);
> +       offline = this_cpu_ptr(&cpu_quarantine_offline);
> +       if (*offline == 0) {
> +               q = this_cpu_ptr(&cpu_quarantine);
> +               qlist_put(q, &info->quarantine_link, cache->size);
> +       } else {
> +               qlist_put(&q_offline, &info->quarantine_link, cache->size);
> +               qlist_free_all(&q_offline, cache);

This looks like a convoluted way to call qlink_free. I think it will
be better to call qlink_free directly here.

And why do we need this? Because CPU shutdown code can still free some
objects afterwards?

> +               local_irq_restore(flags);
> +               return;

You add both if/else and early return, this looks like unnecessary
code complication. It would be simpler with:

if (*offline) {
    qlink_free(...);
    return;
}
... all current per-cpu local ...


> +       }
>         if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
>                 qlist_move_all(q, &temp);
>
> @@ -328,3 +340,46 @@ void quarantine_remove_cache(struct kmem_cache *cache)
>
>         synchronize_srcu(&remove_cache_srcu);
>  }
> +
> +static int kasan_cpu_online(unsigned int cpu)
> +{
> +       int *offline;
> +       unsigned long flags;
> +
> +       local_irq_save(flags);

I assume this local_irq_save/restore is to prevent some warnings from
this_cpu_ptr.
But CPU online/offline callbacks should run without preemption already
(preempting/rescheduling on other CPUs does not make sense for them,
right?), so I would assume that is already at least preemption
disabled or something. Is there this_cpu_ptr variant that won't
produce warnings on its own in cpu online/offline callbacks?
This whole function could be a 1-liner:
this_cpu_ptr(&cpu_quarantine)->offline = true;
So I am trying to understand if we could avoid all this unnecessary danse.


> +       offline = this_cpu_ptr(&cpu_quarantine_offline);
> +       *offline = 0;
> +       local_irq_restore(flags);
> +       return 0;
> +}
> +
> +static int kasan_cpu_offline(unsigned int cpu)
> +{
> +       struct kmem_cache *s;
> +       int *offline;
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +       offline = this_cpu_ptr(&cpu_quarantine_offline);
> +       *offline = 1;
> +       local_irq_restore(flags);
> +
> +       mutex_lock(&slab_mutex);
> +       list_for_each_entry(s, &slab_caches, list) {
> +               per_cpu_remove_cache(s);
> +       }
> +       mutex_unlock(&slab_mutex);

We just want to drop the whole per-cpu cache at once, right? I would
assume there should be a simpler way to do this all at once, rather
than doing this per-slab.

> +       return 0;
> +}
> +
> +static int __init kasan_cpu_offline_quarantine_init(void)
> +{
> +       int ret = 0;
> +
> +       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mm/kasan:online",
> +                               kasan_cpu_online, kasan_cpu_offline);
> +       if (ret)
> +               pr_err("kasan offline cpu quarantine register failed [%d]\n", ret);
> +       return ret;
> +}
> +late_initcall(kasan_cpu_offline_quarantine_init);
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/1605162252-23886-2-git-send-email-Kuan-Ying.Lee%40mediatek.com.
