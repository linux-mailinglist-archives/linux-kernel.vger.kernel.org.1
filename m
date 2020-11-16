Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E5B2B3FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgKPJ1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgKPJ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:27:04 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8702BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 01:27:04 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id 7so12414313qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 01:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xO0juaBQE580WCmD+C2do+lXaG7MUpIc228ombtl2So=;
        b=AYmtyXEdWrp6kXBVb78bCbobLpl22LmlY+utW0OW+ZWvmj3ctCp2iAfvCycLas1hiL
         d6KyORZMBhYvZkJ1jLvAMtdCPvu4CNi7rw9IigvxkV306dlpusAmgkM2cl/Kv25Tlicl
         K2/YCP43uopQqAa8JnplZGPhC6h9001ILf/bhvEAhsi9I+GslKf/CjwTTFxjj6SZPkC+
         6nka7ZBJGOC6Mt9asBZ/GhUtEH64p6KIhLwL7Ja9MQXwDu0ZoKlBEbIAJXuZkPlMfPtg
         o9TH3KIJ38r+x9OrmVqfOOgpX5/ECr2jshRc52HLRlV83P4nFHzZp2QikA1OUCjuoW/4
         1odA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xO0juaBQE580WCmD+C2do+lXaG7MUpIc228ombtl2So=;
        b=Doy0KfPgGHxXFgCi32Mro3k8t26PqxiMw1Sw6BP2ZylF7UXBGquYSx13z1lxhqGTK0
         Vtz9fI3lh+juD4DNzoLXvzQ1PXA+MITY8Zc5b9LGSCtyOAk7Qjws0LDX6jshepBkwH1J
         /dxCsmsWVjw+fs6dsVmD+v4WEDukvgARFG/B+xLjp1ojQ6I7oKmRHJawz2HDPVCFDhVx
         Pl6N/ZU+r19b7SN9Ae0CbUQJ9FYe/Iy+eDEERADZxXeDzENLaqZrkhvE+xhVhidv5Qvt
         RPbq2Wpqg6zEHFl4Fh7VaC6oY4MgOasqGab6hvvzvHf/Im5l8IgWtQgGh3jpmWscbeV1
         mTjQ==
X-Gm-Message-State: AOAM531LgDl9VFjGCc4rP4j4dRXbOjFUEpGf6npXJSsNTqqrjxQ1x9J0
        959qxwpe8OzFnFFVoQeh5whcjfmpGaEUY/9hhI7qTQ==
X-Google-Smtp-Source: ABdhPJyOnYx143blG3oTAJfoG1SkneonElF+InYoaKB3gm9FknORy0i0cO0JvZ+xkKiMt/Ri89Nio4h0t1Uyle7xRqc=
X-Received: by 2002:ac8:37f2:: with SMTP id e47mr13349765qtc.290.1605518823487;
 Mon, 16 Nov 2020 01:27:03 -0800 (PST)
MIME-Version: 1.0
References: <1605508168-7418-1-git-send-email-Kuan-Ying.Lee@mediatek.com> <1605508168-7418-2-git-send-email-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <1605508168-7418-2-git-send-email-Kuan-Ying.Lee@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 16 Nov 2020 10:26:52 +0100
Message-ID: <CACT4Y+Zy_JQ3y7_P2NXffiijTuxcnh7VPcAGL66Ks2LaLTj-eg@mail.gmail.com>
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

On Mon, Nov 16, 2020 at 7:30 AM Kuan-Ying Lee
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
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Reported-by: Guangye Yang <guangye.yang@mediatek.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  mm/kasan/quarantine.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 4c5375810449..16e618ea805e 100644
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
> @@ -43,6 +44,7 @@ struct qlist_head {
>         struct qlist_node *head;
>         struct qlist_node *tail;
>         size_t bytes;
> +       bool offline;
>  };
>
>  #define QLIST_INIT { NULL, NULL, 0 }
> @@ -188,6 +190,11 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
>         local_irq_save(flags);
>
>         q = this_cpu_ptr(&cpu_quarantine);
> +       if (q->offline) {
> +               qlink_free(&info->quarantine_link, cache);
> +               local_irq_restore(flags);
> +               return;
> +       }
>         qlist_put(q, &info->quarantine_link, cache->size);
>         if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
>                 qlist_move_all(q, &temp);
> @@ -328,3 +335,31 @@ void quarantine_remove_cache(struct kmem_cache *cache)
>
>         synchronize_srcu(&remove_cache_srcu);
>  }
> +
> +static int kasan_cpu_online(unsigned int cpu)
> +{
> +       this_cpu_ptr(&cpu_quarantine)->offline = false;
> +       return 0;
> +}
> +
> +static int kasan_cpu_offline(unsigned int cpu)
> +{
> +       struct qlist_head *q;
> +
> +       q = this_cpu_ptr(&cpu_quarantine);
> +       q->offline = true;
> +       qlist_free_all(q, NULL);

Looks much nicer now!

What is the story with interrupts in these callbacks?
In the previous patch you mentioned that this CPU can still receive
interrupts for a brief period of time. If these interrupts also free
something, can't we corrupt the per-cpu quarantine? In quarantine_put
we protect it by disabling interrupts I think.


> +       return 0;
> +}
> +
> +static int __init kasan_cpu_offline_quarantine_init(void)
> +{
> +       int ret = 0;
> +
> +       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mm/kasan:online",
> +                               kasan_cpu_online, kasan_cpu_offline);
> +       if (ret < 0)
> +               pr_err("kasan offline cpu quarantine register failed [%d]\n", ret);
> +       return ret;
> +}
> +late_initcall(kasan_cpu_offline_quarantine_init);
> --
> 2.18.0
