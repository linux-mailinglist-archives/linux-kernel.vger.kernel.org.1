Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45B62D07CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 00:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgLFXAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 18:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgLFXAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 18:00:09 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED5CC0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 14:59:28 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 4so5709078qvh.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 14:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vv6iFUqkL94sPwQ2xC06XNtvXitukry4+NVPo/3bk+o=;
        b=rOYi/8c+ypk9++BE8/0IunLZipx4Rav67/2kjjIqyzuuzJLMzSVUcW1JVrnXkgz+WJ
         o036N8+QfkrG5oFpBQoBeNTOFoAtcC5UcY0G+h+zmjLtQcXCELf72HViH/dzHzTfkQvk
         R7KqX7oSVT0TVaTxKhmFiTCUIoxH8K/vxsirumOuK58LUxLpO2Csv1G5MunLFPLffu7Z
         Hhc9XOIgGbgiNDL7tly+d1aljArJKgf9jYEHrZ3itufyyC22HZwDxag2E9d+JRjiwOut
         PQ9rPPY7jOLxN40M97ewcDUL+B3IhbGkXZt8HI8aT3/OIskVTI7Tx1avA/q+sYbn52vo
         LyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vv6iFUqkL94sPwQ2xC06XNtvXitukry4+NVPo/3bk+o=;
        b=akN1mVyhJGmwvu/1DOG9CggIeBlS8nHHFPdGAgdxR6S/jKz+bQRcUO2IExvZ8Zd6is
         GJQHullRN+eVQ2tA43WPoRCwG60F2QXyih/+NKrA516HDPjX8sK56Ia5TTiBAV1+Qisd
         pivYvZ8MjRoWR7UyK2VMz9ykBbfGsCcSFQzf0j4uSjJ7qa7cQ+4xuwznUdk4LKbIZ59N
         5kcfCUMPi9ubBYNenvIk5l/QbXdLidJLLgGGxXEFxFf7e2qbGAkOKBYrFnoREtxD/NPM
         wyj73bckfrHvfyF2SKmWrzYNL/+myNSCEsmlDIQMm2R/2jdssXTqsTT76WUoKdkTfEU3
         IC/g==
X-Gm-Message-State: AOAM533RlNnSMNT4/X0x14lKE4ApixQ3sy2kHEz4XmmPXyy16dSk26sF
        FIYTZopOQ1vLDn3TGr0pnx0QxmdWCE/RB3wxtJdGeCGS9iQ=
X-Google-Smtp-Source: ABdhPJy7GZ/nAqCfjIqrRJRceNk3KZ+5aKrqf84hRWQWl/RP/yFU/ISebh2yBPZHam7hQRzB0cUmbWAQXlYEksN6X2M=
X-Received: by 2002:a05:6214:114f:: with SMTP id b15mr17948421qvt.34.1607295567389;
 Sun, 06 Dec 2020 14:59:27 -0800 (PST)
MIME-Version: 1.0
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 6 Dec 2020 23:59:16 +0100
Message-ID: <CAFLxGvwienJ7sU2+QAhFt+ywS9iYkbAXDGviuTC-4CVwLOhXfA@mail.gmail.com>
Subject: BUG: Invalid wait context with KMEMLEAK and KASAN enabled
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, aryabinin@virtuozzo.com,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

With both KMEMLEAK and KASAN enabled, I'm facing the following lockdep
splat at random times on Linus' tree as of today.
Sometimes it happens at bootup, sometimes much later when userspace has started.

Does this ring a bell?

[    2.298447] =============================
[    2.298971] [ BUG: Invalid wait context ]
[    2.298971] 5.10.0-rc6+ #388 Not tainted
[    2.298971] -----------------------------
[    2.298971] ksoftirqd/1/15 is trying to lock:
[    2.298971] ffff888100b94598 (&n->list_lock){....}-{3:3}, at:
free_debug_processing+0x3d/0x210
[    2.298971] other info that might help us debug this:
[    2.298971] context-{2:2}
[    2.298971] 1 lock held by ksoftirqd/1/15:
[    2.298971]  #0: ffffffff835f4140 (rcu_callback){....}-{0:0}, at:
rcu_core+0x408/0x1040
[    2.298971] stack backtrace:
[    2.298971] CPU: 1 PID: 15 Comm: ksoftirqd/1 Not tainted 5.10.0-rc6+ #388
[    2.298971] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-0-ga698c89-rebuilt.opensuse.org 04/01/2014
[    2.298971] Call Trace:
[    2.298971]  <IRQ>
[    2.298971]  dump_stack+0x9a/0xcc
[    2.298971]  __lock_acquire.cold+0xce/0x34b
[    2.298971]  ? lockdep_hardirqs_on_prepare+0x1f0/0x1f0
[    2.298971]  ? rcu_read_lock_sched_held+0x9c/0xd0
[    2.298971]  lock_acquire+0x153/0x4c0
[    2.298971]  ? free_debug_processing+0x3d/0x210
[    2.298971]  ? lock_release+0x690/0x690
[    2.298971]  ? rcu_read_lock_bh_held+0xb0/0xb0
[    2.298971]  ? pvclock_clocksource_read+0xd9/0x1a0
[    2.298971]  _raw_spin_lock_irqsave+0x3b/0x80
[    2.298971]  ? free_debug_processing+0x3d/0x210
[    2.298971]  ? qlist_free_all+0x35/0xd0
[    2.298971]  free_debug_processing+0x3d/0x210
[    2.298971]  __slab_free+0x286/0x490
[    2.298971]  ? lockdep_enabled+0x39/0x50
[    2.298971]  ? rcu_read_lock_sched_held+0x9c/0xd0
[    2.298971]  ? run_posix_cpu_timers+0x256/0x2c0
[    2.298971]  ? rcu_read_lock_bh_held+0xb0/0xb0
[    2.298971]  ? posix_cpu_timers_exit_group+0x30/0x30
[    2.298971]  qlist_free_all+0x59/0xd0
[    2.298971]  ? qlist_free_all+0xd0/0xd0
[    2.298971]  per_cpu_remove_cache+0x47/0x50
[    2.298971]  flush_smp_call_function_queue+0xea/0x2b0
[    2.298971]  __sysvec_call_function+0x6c/0x250
[    2.298971]  asm_call_irq_on_stack+0x12/0x20
[    2.298971]  </IRQ>
[    2.298971]  sysvec_call_function+0x84/0xa0
[    2.298971]  asm_sysvec_call_function+0x12/0x20
[    2.298971] RIP: 0010:__asan_load4+0x1d/0x80
[    2.298971] Code: 10 00 75 ee c3 0f 1f 84 00 00 00 00 00 4c 8b 04
24 48 83 ff fb 77 4d 48 b8 ff ff ff ff ff 7f ff ff 48 39 c7 76 3e 48
8d 47 03 <48> 89 c2 83 e2 07 48 83 fa 02 76 17 48 b9 00 00 00 00 00 fc
ff df
[    2.298971] RSP: 0000:ffff888100e4f858 EFLAGS: 00000216
[    2.298971] RAX: ffffffff83c55773 RBX: ffffffff81002431 RCX: dffffc0000000000
[    2.298971] RDX: 0000000000000001 RSI: ffffffff83ee8d78 RDI: ffffffff83c55770
[    2.298971] RBP: ffffffff83c5576c R08: ffffffff81083433 R09: fffffbfff07e333d
[    2.298971] R10: 000000000001803d R11: fffffbfff07e333c R12: ffffffff83c5575c
[    2.298971] R13: ffffffff83c55774 R14: ffffffff83c55770 R15: ffffffff83c55770
[    2.298971]  ? ret_from_fork+0x21/0x30
[    2.298971]  ? __orc_find+0x63/0xc0
[    2.298971]  ? stack_access_ok+0x35/0x90
[    2.298971]  __orc_find+0x63/0xc0
[    2.298971]  unwind_next_frame+0x1ee/0xbd0
[    2.298971]  ? ret_from_fork+0x22/0x30
[    2.298971]  ? ret_from_fork+0x21/0x30
[    2.298971]  ? deref_stack_reg+0x40/0x40
[    2.298971]  ? __unwind_start+0x2e8/0x370
[    2.298971]  ? create_prof_cpu_mask+0x20/0x20
[    2.298971]  arch_stack_walk+0x83/0xf0
[    2.298971]  ? ret_from_fork+0x22/0x30
[    2.298971]  ? rcu_core+0x488/0x1040
[    2.298971]  stack_trace_save+0x8c/0xc0
[    2.298971]  ? stack_trace_consume_entry+0x80/0x80
[    2.298971]  ? sched_clock_local+0x99/0xc0
[    2.298971]  kasan_save_stack+0x1b/0x40
[    2.298971]  ? kasan_save_stack+0x1b/0x40
[    2.298971]  ? kasan_set_track+0x1c/0x30
[    2.298971]  ? kasan_set_free_info+0x1b/0x30
[    2.298971]  ? __kasan_slab_free+0x10f/0x150
[    2.298971]  ? kmem_cache_free+0xa8/0x350
[    2.298971]  ? rcu_core+0x488/0x1040
[    2.298971]  ? __do_softirq+0x101/0x573
[    2.298971]  ? run_ksoftirqd+0x21/0x50
[    2.298971]  ? smpboot_thread_fn+0x1fc/0x380
[    2.298971]  ? kthread+0x1c7/0x220
[    2.298971]  ? ret_from_fork+0x22/0x30
[    2.298971]  ? lockdep_hardirqs_on_prepare+0x1f0/0x1f0
[    2.298971]  ? rcu_read_lock_sched_held+0x9c/0xd0
[    2.298971]  ? lock_acquire+0x153/0x4c0
[    2.298971]  ? rcu_core+0x408/0x1040
[    2.298971]  ? lock_release+0x690/0x690
[    2.298971]  ? lockdep_enabled+0x39/0x50
[    2.298971]  ? mark_held_locks+0x49/0x90
[    2.298971]  kasan_set_track+0x1c/0x30
[    2.298971]  kasan_set_free_info+0x1b/0x30
[    2.298971]  __kasan_slab_free+0x10f/0x150
[    2.298971]  ? rcu_core+0x488/0x1040
[    2.298971]  kmem_cache_free+0xa8/0x350
[    2.298971]  ? __ia32_compat_sys_move_pages+0x130/0x130
[    2.298971]  rcu_core+0x488/0x1040
[    2.298971]  ? call_rcu+0x5d0/0x5d0
[    2.298971]  ? rcu_read_lock_sched_held+0x9c/0xd0
[    2.298971]  ? rcu_read_lock_bh_held+0xb0/0xb0
[    2.298971]  __do_softirq+0x101/0x573
[    2.298971]  ? trace_event_raw_event_irq_handler_exit+0x150/0x150
[    2.298971]  run_ksoftirqd+0x21/0x50
[    2.298971]  smpboot_thread_fn+0x1fc/0x380
[    2.298971]  ? smpboot_register_percpu_thread+0x180/0x180
[    2.298971]  ? __kthread_parkme+0xbb/0xd0
[    2.298971]  ? smpboot_register_percpu_thread+0x180/0x180
[    2.298971]  kthread+0x1c7/0x220
[    2.298971]  ? kthread_create_on_node+0xd0/0xd0
[    2.298971]  ret_from_fork+0x22/0x30

-- 
Thanks,
//richard
