Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D25227B0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgI1P2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgI1P2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:28:51 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35C6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 08:28:50 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z2so1024435qtv.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SdaMFw97cf/Q1TN8aRLLIrSS3mA2HFqPFCAsEcXXVs0=;
        b=QbGhE6r1mnMF/M5ZWzcuH+kuybo2Vj51SGXdbu6LsJw12e9HeKRjPbM1dCpA5d408l
         869bsMq3e2yOJnIMRBVbXKfhCrd6mZUEuT2/v2ls++qF+/U6sGNm3V1UKOo9sKQb8rmS
         jiAANJoqZkJMEmoltsryagvpRTiCn7ez21nVM/SAFPuG+Dtg/sNFbMjsgnWogeYlZl47
         alEoVtTBZVdigkER43uak84gTuqbA2/4fou4sK123yVBX3J1BV57OsIWGMo0oQuBohfv
         VeFBBaXy9gMxfSYmuo929vuOzpYnVkOalIKDR/Jv/QXCylwelkfveweMEtMmS0xAKi+R
         wS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SdaMFw97cf/Q1TN8aRLLIrSS3mA2HFqPFCAsEcXXVs0=;
        b=pSZfGAg0wUjXPosR42Xg7LAY91El+u/w5qpiyykT+1XtDJjdvCFDAJrrYa9CM6Q2G8
         mJS/eFian9ib/0T688iOs7gYp+nomnutOQdT7vjRqwNGytz+VRbhNYDnIfo+kj57+Udt
         eriICsKjVzBOhriORHR6uMd0fCNWw9JO/KYA150o2pMODBHzkV5H8cTCU7AqI2E9V/sF
         ZcN0cEpgboxCyxGzl9oNhGSuYO0k+WDoOmZBar9zYZC5T7Fd/2L5uQ4Nw4JO00WmwL0T
         dqO7iDJG/rJWBFJwmDGj/avUPr0JcvrgK+R1pFcxPuM2NHUzvZv1tOHjJ4yPSfYkypGA
         ZXQQ==
X-Gm-Message-State: AOAM531JTLwbNjMVcbapQxs3mrfg7E6ikIbt+YQWak7gqf1i8tdSbcTy
        5Au6EvhzvNwfaQsmAUSmhJatc2Nj18VusLGIfA+JLKDIR0Z/7g==
X-Google-Smtp-Source: ABdhPJyewgX87wcKSgo+ZGmAUmVcnz0ZdPkoO3FKaqzNfC9w/yQjGvOJxwMoHKdhpLtHYxv2g78ZOihjJTazgi36RTU=
X-Received: by 2002:ac8:4658:: with SMTP id f24mr1369435qto.158.1601306929504;
 Mon, 28 Sep 2020 08:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+a8yAm2HFJkz+pgYDm4QV+5S8K5FH3wVn4e8kgbMzcXdg@mail.gmail.com>
 <20200928151911.GA964@home.goodmis.org>
In-Reply-To: <20200928151911.GA964@home.goodmis.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 28 Sep 2020 17:28:38 +0200
Message-ID: <CACT4Y+aaRm8rLthzt6o_T85epmeyutzyx-wGXTL1ZwDo7iUwYQ@mail.gmail.com>
Subject: Re: KASAN: global-out-of-bounds in console_unlock
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 5:19 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sun, Sep 27, 2020 at 11:12:23AM +0200, Dmitry Vyukov wrote:
> > Hi printk maintainers,
> >
> > I've got the following out-of-bounds in printk code.
> > This is on next-20200925. Config is attached.
> > This is just on pr_cont("\n"). Something overreads the string.
> >
> > ==================================================================
> > BUG: KASAN: global-out-of-bounds in memchr+0x65/0x80 lib/string.c:1058
> > Read of size 1 at addr ffffffff8c68c860 by task swapper/0/0
>
> Would be helpful to show the text before this, so we have a better idea of
> where it happened.


Here is full output:

[  923.904916][    C2] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  923.908851][    C2] rcu: 1-...0: (1 GPs behind)
idle=c9a/1/0x4000000000000000 softirq=65097/65098 fqs=5000
[  923.910258][    C2] (detected by 2, t=10002 jiffies, g=79113, q=1645)
[  923.910273][    C2] Sending NMI from CPU 2 to CPUs 1:
[  923.912954][    C2] NMI backtrace for cpu 1
[  923.912960][    C2] CPU: 1 PID: 24557 Comm: getty Not tainted
5.9.0-rc5-next-20200916 #36
[  923.912966][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1 04/01/2014
[  923.912971][    C2] RIP: 0010:check_memory_region+0x16/0x1b0
[  923.912983][    C2] Code: 01 0f 1f 00 48 89 f2 be f8 00 00 00 e9 63
3c f4 01 0f 1f 00 48 85 f6 0f 84 53 01 00 00 49 89 fa 41 54 0f b6 d2
49 01 f2 55 53 <0f> 82 2d 01 00 00 48 b8 ff ff ff ff ff 7f ff ff 48 39
c7 0f 86 1a
[  923.912988][    C2] RSP: 0018:ffffc90000170db8 EFLAGS: 00000086
[  923.913012][    C2] RAX: dffffc0000000000 RBX: ffff88802bb4ca58
RCX: ffffffff862b781d
[  923.913017][    C2] RDX: 0000000000000000 RSI: 0000000000000008
RDI: ffff88802bb4ca20
[  923.913023][    C2] RBP: ffff88802bb4ca20 R08: ffff88803b44a680
R09: fffff5200002e1ae
[  923.913028][    C2] R10: ffff88802bb4ca28 R11: fffff5200002e1ad
R12: ffff8880412f8f00
[  923.913034][    C2] R13: 1b8d2fad371a5f5a R14: 0000000000000000
R15: 1b8d2fad371a5f5a
[  923.913039][    C2] FS:  00007fa3bed78700(0000)
GS:ffff88806ea80000(0000) knlGS:0000000000000000
[  923.913043][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  923.913048][    C2] CR2: 00007f5f11a2df18 CR3: 000000001c78b001
CR4: 0000000000770ee0
[  923.913053][    C2] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[  923.913057][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[  923.913060][    C2] PKRU: 55555554
[  923.913064][    C2] Call Trace:
[  923.913066][    C2]  <IRQ>
[  923.913069][    C2]  advance_sched+0x2ed/0x6d0
[  923.913073][    C2]  ? taprio_enqueue+0x1090/0x1090
[  923.913077][    C2]  __hrtimer_run_queues+0x331/0x820
[  923.913081][    C2]  ? enqueue_hrtimer+0x250/0x250
[  923.913085][    C2]  ? ktime_get_update_offsets_now+0x1d8/0x280
[  923.913089][    C2]  hrtimer_interrupt+0x31c/0x790
[  923.913093][    C2]  __sysvec_apic_timer_interrupt+0x10d/0x390
[  923.913096][    C2]  asm_call_on_stack+0xf/0x20
[  923.913099][    C2]  </IRQ>
[  923.913103][    C2]  sysvec_apic_timer_interrupt+0x9a/0xb0
[  923.913108][    C2]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  923.913111][    C2] RIP: 0010:rw_verify_area+0x128/0x340
[  923.913121][    C2] Code: 6e 4c b7 ff 41 83 e4 02 48 89 ef 41 83 c4
02 44 89 e6 e8 bb cd 8c 01 41 89 c4 e8 53 4c b7 ff 44 89 e0 5b 5d 41
5c 41 5d 41 5e <41> 5f c3 e8 40 4c b7 ff 48 8d 7d 5c 48 b8 00 00 00 00
00 fc ff df
[  923.913127][    C2] RSP: 0018:ffffc9000120fe58 EFLAGS: 00000293
[  923.913134][    C2] RAX: 0000000000000000 RBX: ffff888031dc5c40
RCX: ffffffff81c7fbb1
[  923.913140][    C2] RDX: 0000000000000000 RSI: ffffffff81b6610d
RDI: 0000000000000005
[  923.913146][    C2] RBP: 0000000000000001 R08: ffff88803b44a680
R09: ffffed1002376dd9
[  923.913151][    C2] R10: ffffc9000120fdf0 R11: ffffed1002376dd8
R12: 00007fffcaf7db99
[  923.913156][    C2] R13: ffffc9000120fed0 R14: ffff888031dc5c9c
R15: 0000000000000001
[  923.913159][    C2]  ? __fsnotify_parent+0x641/0xa70
[  923.913164][    C2]  ? rw_verify_area+0x11d/0x340
[  923.913168][    C2]  vfs_read+0x120/0x560
[  923.913171][    C2]  ksys_read+0x127/0x250
[  923.913175][    C2]  ? vfs_write+0x700/0x700
[  923.913180][    C2]  ? fpregs_assert_state_consistent+0xbc/0xe0
[  923.913185][    C2]  ? exit_to_user_mode_prepare+0x34/0x160
[  923.913189][    C2]  do_syscall_64+0x2d/0x70
[  923.913193][    C2]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  923.913198][    C2] RIP: 0033:0x7fa3be6a3310
[  923.913210][    C2] Code: 73 01 c3 48 8b 0d 28 4b 2b 00 31 d2 48 29
c2 64 89 11 48 83 c8 ff eb ea 90 90 83 3d e5 a2 2b 00 00 75 10 b8 00
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 6e 8a 01 00
48 89 04 24
[  923.913214][    C2] RSP: 002b:00007fffcaf7db48 EFLAGS: 00000246
ORIG_RAX: 0000000000000000
[  923.913224][    C2] RAX: ffffffffffffffda RBX: 00007fa3bed786a8
RCX: 00007fa3be6a3310
[  923.913230][    C2] RDX: 0000000000000001 RSI: 00007fffcaf7db98
RDI: 0000000000000000
[  923.913235][    C2] RBP: 00007fffcaf7e380 R08: 00000000000000bb
R09: 00007fa3be959e90
[  923.913240][    C2] R10: 0000000000000000 R11: 0000000000000246
R12: 00000000006075a0
[  923.913245][    C2] R13: 00007fffcaf81f46 R14: 0000000000000000
R15: 0000000000000000
[  927.904983][   T12] Bluetooth: hci5: command 0x041b tx timeout
[  927.907990][    C0] BUG: workqueue lockup - pool cpus=0-3 flags=0x4
nice=0 stuck for 103s!
[  927.909030][    C0] Showing busy workqueues and worker pools:
[  927.909946][    C0] workqueue events: flags=0x0
[  927.910513][    C0]   pwq 6: cpus=3 node=0 flags=0x0 nice=0
active=2/256 refcnt=3
[  927.911590][    C0]     in-flight: 8599:xfrm_state_gc_task xfrm_state_gc_task
[  927.912639][    C0]   pwq 4: cpus=2 node=0 flags=0x0 nice=0
active=2/256 refcnt=3
[  927.913810][    C0]     pending: cache_reap, macvlan_process_broadcast
[  927.914780][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0
active=11/256 refcnt=12
[  927.916019][    C0]     pending: nsim_dev_trap_report_work,
nsim_dev_trap_report_work, nsim_dev_trap_report_work,
ovs_dp_masks_rebalance, ovs_dp_masks_rebalance,
ovs_dp_masks_rebalance, ovs_dp_masks_rebalance, psi_avgs_work,
psi_avgs_work, check_corruption, cache_reap
[  927.919876][    C0]   pwq 0: cpus=0 node=0 flags=0x0 nice=0
active=4/256 refcnt=5
[  927.920369][ T8592] GRED: Unable to relocate VQ 0x0 after dequeue,
screwing up backlog
[  927.920940][    C0]     pending: cache_reap,
ovs_dp_masks_rebalance, switchdev_deferred_process_work,
key_garbage_collector
[  927.922233][   T17] GRED: Unable to relocate VQ 0x0 after dequeue,
screwing up backlog
[  927.924007][    C0] workqueue events_long: flags=0x0
[  927.926021][    C0]   pwq 0: cpus=0 node=0 flags=0x0 nice=0
active=1/256 refcnt=2
[  927.927067][    C0]     pending: br_multicast_gc_work
[  927.928241][    C0] workqueue events_unbound: flags=0x2
[  927.929390][    C0]   pwq 8: cpus=0-3 flags=0x4 nice=0 active=6/512 refcnt=8
[  927.932368][    C0]     pending: io_ring_exit_work,
io_ring_exit_work, io_ring_exit_work, io_ring_exit_work,
fsnotify_connector_destroy_workfn, fsnotify_mark_destroy_workfn
[  927.936923][    C0] workqueue writeback: flags=0x4a
[  927.939002][    C0]   pwq 8: cpus=0-3 flags=0x4 nice=0 active=8/256 refcnt=10
[  927.940685][    C0]     in-flight: 2590:wb_workfn
[  927.941693][    C0]     pending: wb_workfn, wb_workfn, wb_workfn,
wb_workfn, wb_workfn, wb_workfn, wb_workfn
[  927.943712][    C0] workqueue krxrpcd: flags=0x0
[  927.944568][    C0]   pwq 0: cpus=0 node=0 flags=0x0 nice=0
active=1/1 refcnt=4
[  927.946044][    C0]     pending: rxrpc_peer_keepalive_worker
[  927.947217][    C0]     delayed: rxrpc_peer_keepalive_worker,
rxrpc_peer_keepalive_worker
[  927.948953][    C0] workqueue bat_events: flags=0xe000a
[  927.949807][    C0]   pwq 8: cpus=0-3 flags=0x4 nice=0 active=1/1 refcnt=73
[  927.950953][    C0]     in-flight:
275:batadv_iv_send_outstanding_bat_ogm_packet
[  927.953941][    C0]
==================================================================
[  927.953948][    C0] BUG: KASAN: global-out-of-bounds in memchr+0x65/0x80
[  927.953953][    C0] Read of size 1 at addr ffffffff8cb11b60 by task
ksoftirqd/0/9
[  927.953955][    C0]
[  927.953961][    C0] CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted
5.9.0-rc5-next-20200916 #36
[  927.953967][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1 04/01/2014
[  927.953970][    C0] Call Trace:
[  927.953973][    C0]  dump_stack+0x14b/0x18f
[  927.953977][    C0]  ? memchr+0x65/0x80
[  927.953980][    C0]  ? memchr+0x65/0x80
[  927.953985][    C0]  print_address_description.constprop.0.cold+0x5/0x4c5
[  927.953989][    C0]  ? rwlock_bug.part.0+0x90/0x90
[  927.953992][    C0]  ? desc_read+0x1a5/0x230
[  927.953996][    C0]  ? vprintk_func+0xfd/0x1e0
[  927.953999][    C0]  ? memchr+0x65/0x80
[  927.954001][    C0]  ? memchr+0x65/0x80
[  927.954005][    C0]  kasan_report.cold+0x1f/0x37
[  927.954008][    C0]  ? memchr+0x65/0x80
[  927.954011][    C0]  memchr+0x65/0x80
[  927.954015][    C0]  record_print_text+0x22d/0x310
[  927.954019][    C0]  ? get_record_print_text_size+0x110/0x110
[  927.954023][    C0]  ? prb_read_valid+0x75/0xa0
[  927.954026][    C0]  ? prb_final_commit+0x20/0x20
[  927.954030][    C0]  console_unlock+0x374/0xc20
[  927.954034][    C0]  ? devkmsg_read+0x940/0x940
[  927.954037][    C0]  ? do_raw_spin_lock+0x120/0x2d0
[  927.954041][    C0]  ? do_raw_spin_unlock+0x171/0x260
[  927.954045][    C0]  ? _raw_spin_unlock_irqrestore+0x42/0x70
[  927.954049][    C0]  vprintk_emit+0x352/0x4c0
[  927.954052][    C0]  vprintk_func+0x8d/0x1e0
[  927.954055][    C0]  printk+0xba/0xed
[  927.954059][    C0]  ? record_print_text.cold+0x16/0x16
[  927.954064][    C0]  ? __batadv_dat_purge.isra.0.part.0+0x3d0/0x3d0
[  927.954067][    C0]  ? show_pwq+0x738/0x7e5
[  927.954070][    C0]  ? show_pwq+0x70c/0x7e5
[  927.954073][    C0]  show_pwq+0x744/0x7e5
[  927.954077][    C0]  show_workqueue_state.cold+0xd0/0x3c0
[  927.954080][    C0]  ? print_worker_info+0x280/0x280
[  927.954084][    C0]  ? idr_get_next_ul+0x2a0/0x2a0
[  927.954088][    C0]  ? _raw_spin_unlock_irqrestore+0x42/0x70
[  927.954092][    C0]  wq_watchdog_timer_fn+0x2dc/0x370
[  927.954096][    C0]  ? show_workqueue_state+0x2f0/0x2f0
[  927.954099][    C0]  ? do_raw_spin_lock+0x120/0x2d0
[  927.954103][    C0]  ? show_workqueue_state+0x2f0/0x2f0
[  927.954107][    C0]  ? show_workqueue_state+0x2f0/0x2f0
[  927.954111][    C0]  call_timer_fn+0x38/0x2d0
[  927.954115][    C0]  ? show_workqueue_state+0x2f0/0x2f0
[  927.954119][    C0]  run_timer_softirq+0xad2/0x1440
[  927.954124][    C0]  ? trace_event_raw_event_hrtimer_start+0x350/0x350
[  927.954128][    C0]  ? kvm_clock_read+0x14/0x30
[  927.954132][    C0]  ? kvm_sched_clock_read+0x5/0x10
[  927.954135][    C0]  ? sched_clock+0x2a/0x40
[  927.954139][    C0]  ? sched_clock_cpu+0x18/0x1f0
[  927.954143][    C0]  ? tasklet_action+0x70/0x70
[  927.954147][    C0]  __do_softirq+0x1f0/0x6c4
[  927.954151][    C0]  ? tasklet_action+0x70/0x70
[  927.954155][    C0]  run_ksoftirqd+0x7f/0x100
[  927.954159][    C0]  smpboot_thread_fn+0x655/0x9e0
[  927.954163][    C0]  ? smpboot_register_percpu_thread+0x380/0x380
[  927.954168][    C0]  ? __kthread_parkme+0x13f/0x1e0
[  927.954173][    C0]  ? smpboot_register_percpu_thread+0x380/0x380
[  927.954176][    C0]  kthread+0x3ac/0x490
[  927.954180][    C0]  ? kthread_bind+0x50/0x50
[  927.954183][    C0]  ret_from_fork+0x1f/0x30
[  927.954185][    C0]
[  927.954190][    C0] The buggy address belongs to the variable:
[  927.954193][    C0]  text.49533+0x400/0x420
[  927.954196][    C0]
[  927.954200][    C0] Memory state around the buggy address:
[  927.954205][    C0]  ffffffff8cb11a00: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[  927.954211][    C0]  ffffffff8cb11a80: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[  927.954216][    C0] >ffffffff8cb11b00: 00 00 00 00 00 00 00 00 00
00 00 00 f9 f9 f9 f9
[  927.954221][    C0]                                                        ^
[  927.954227][    C0]  ffffffff8cb11b80: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[  927.954232][    C0]  ffffffff8cb11c00: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[  927.954238][    C0]
==================================================================
[  927.954242][    C0] Disabling lock debugging due to kernel taint
[  927.954247][    C0] Kernel panic - not syncing: panic_on_warn set ...
[  927.954253][    C0] CPU: 0 PID: 9 Comm: ksoftirqd/0 Tainted: G    B
            5.9.0-rc5-next-20200916 #36
[  927.954259][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1 04/01/2014
[  927.954262][    C0] Call Trace:
[  927.954266][    C0]  dump_stack+0x14b/0x18f
[  927.954269][    C0]  ? memchr+0x10/0x80
[  927.954272][    C0]  panic+0x319/0x765
[  927.954276][    C0]  ? print_oops_end_marker.cold+0x15/0x15
[  927.954279][    C0]  ? memchr+0x65/0x80
[  927.954282][    C0]  ? memchr+0x65/0x80
[  927.954286][    C0]  end_report+0x58/0x5e
[  927.954289][    C0]  kasan_report.cold+0xd/0x37
[  927.954292][    C0]  ? memchr+0x65/0x80
[  927.954296][    C0]  memchr+0x65/0x80
[  927.954299][    C0]  record_print_text+0x22d/0x310
[  927.954303][    C0]  ? get_record_print_text_size+0x110/0x110
[  927.954307][    C0]  ? prb_read_valid+0x75/0xa0
[  927.954311][    C0]  ? prb_final_commit+0x20/0x20
[  927.954314][    C0]  console_unlock+0x374/0xc20
[  927.954318][    C0]  ? devkmsg_read+0x940/0x940
[  927.954322][    C0]  ? do_raw_spin_lock+0x120/0x2d0
[  927.954326][    C0]  ? do_raw_spin_unlock+0x171/0x260
[  927.954330][    C0]  ? _raw_spin_unlock_irqrestore+0x42/0x70
[  927.954334][    C0]  vprintk_emit+0x352/0x4c0
[  927.954337][    C0]  vprintk_func+0x8d/0x1e0
[  927.954340][    C0]  printk+0xba/0xed
[  927.954344][    C0]  ? record_print_text.cold+0x16/0x16
[  927.954349][    C0]  ? __batadv_dat_purge.isra.0.part.0+0x3d0/0x3d0
[  927.954352][    C0]  ? show_pwq+0x738/0x7e5
[  927.954356][    C0]  ? show_pwq+0x70c/0x7e5
[  927.954359][    C0]  show_pwq+0x744/0x7e5
[  927.954363][    C0]  show_workqueue_state.cold+0xd0/0x3c0
[  927.954367][    C0]  ? print_worker_info+0x280/0x280
[  927.954370][    C0]  ? idr_get_next_ul+0x2a0/0x2a0
[  927.954375][    C0]  ? _raw_spin_unlock_irqrestore+0x42/0x70
[  927.954379][    C0]  wq_watchdog_timer_fn+0x2dc/0x370
[  927.954383][    C0]  ? show_workqueue_state+0x2f0/0x2f0
[  927.954387][    C0]  ? do_raw_spin_lock+0x120/0x2d0
[  927.954391][    C0]  ? show_workqueue_state+0x2f0/0x2f0
[  927.954394][    C0]  ? show_workqueue_state+0x2f0/0x2f0
[  927.954398][    C0]  call_timer_fn+0x38/0x2d0
[  927.954402][    C0]  ? show_workqueue_state+0x2f0/0x2f0
[  927.954406][    C0]  run_timer_softirq+0xad2/0x1440
[  927.954411][    C0]  ? trace_event_raw_event_hrtimer_start+0x350/0x350
[  927.954415][    C0]  ? kvm_clock_read+0x14/0x30
[  927.954418][    C0]  ? kvm_sched_clock_read+0x5/0x10
[  927.954422][    C0]  ? sched_clock+0x2a/0x40
[  927.954426][    C0]  ? sched_clock_cpu+0x18/0x1f0
[  927.954430][    C0]  ? tasklet_action+0x70/0x70
[  927.954433][    C0]  __do_softirq+0x1f0/0x6c4
[  927.954437][    C0]  ? tasklet_action+0x70/0x70
[  927.954440][    C0]  run_ksoftirqd+0x7f/0x100
[  927.954444][    C0]  smpboot_thread_fn+0x655/0x9e0
[  927.954449][    C0]  ? smpboot_register_percpu_thread+0x380/0x380
[  927.954453][    C0]  ? __kthread_parkme+0x13f/0x1e0
[  927.954457][    C0]  ? smpboot_register_percpu_thread+0x380/0x380
[  927.954460][    C0]  kthread+0x3ac/0x490
[  927.954464][    C0]  ? kthread_bind+0x50/0x50
[  927.954468][    C0]  ret_from_fork+0x1f/0x30
[  927.954472][    C0] Dumping ftrace buffer:
[  927.954475][    C0]    (ftrace buffer empty)
[  927.954479][    C0] Kernel Offset: disabled
