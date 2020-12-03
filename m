Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5B12CD589
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbgLCMcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:32:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34696 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729188AbgLCMcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606998684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/d+/SZntr+r6UTmufeingOHAgXIdzDOCpqozuP2v40=;
        b=bWzhDCpsCYilreH0l8r7s6V3UChdbPHqXkpIXFpf9n5Ye3vzTWRpg70aZ6abXBecY3Kz6H
        ot6uOoXwDr69JK6lbhwY66f6HVhVn0N6Y90ewu1EK30V3YxQBWXh1rg52OEcpXhAxlHwdf
        UzBRRV5z9Rx1yTQ0jJWvzOKEkx9s7QA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-yKgRifU-M8SAn81G447F9g-1; Thu, 03 Dec 2020 07:31:14 -0500
X-MC-Unique: yKgRifU-M8SAn81G447F9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BCAA84A5E0;
        Thu,  3 Dec 2020 12:31:12 +0000 (UTC)
Received: from ovpn-66-132.rdu2.redhat.com (unknown [10.10.67.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AF121899A;
        Thu,  3 Dec 2020 12:31:03 +0000 (UTC)
Message-ID: <6981c30bfb74d7087dbfa7f1579a0ba254ed6b7e.camel@redhat.com>
Subject: Re: [PATCH v4 11/19] sched/core: Make migrate disable and CPU
 hotplug cooperative
From:   Qian Cai <qcai@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Date:   Thu, 03 Dec 2020 07:31:02 -0500
In-Reply-To: <20201123181313.ug4fwjcqnmbvo3f2@linutronix.de>
References: <20201023101158.088940906@infradead.org>
         <20201023102347.067278757@infradead.org>
         <ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com>
         <jhjpn4bwznx.mognet@arm.com>
         <dda3b8f67a23dd60d36e5325dbb0c406be18e1db.camel@redhat.com>
         <20201123181313.ug4fwjcqnmbvo3f2@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-23 at 19:13 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-11-18 09:44:34 [-0500], Qian Cai wrote:
> > On Tue, 2020-11-17 at 19:28 +0000, Valentin Schneider wrote:
> > > We did have some breakage in that area, but all the holes I was aware of
> > > have been plugged. What would help here is to see which tasks are still
> > > queued on that outgoing CPU, and their recent activity.
> > > 
> > > Something like
> > > - ftrace_dump_on_oops on your kernel cmdline
> > > - trace-cmd start -e 'sched:*'
> > >  <start the test here>
> > > 
> > > ought to do it. Then you can paste the (tail of the) ftrace dump.
> > > 
> > > I also had this laying around, which may or may not be of some help:
> > 
> > Once I have found a reliable reproducer, I'll report back.
> 
> any update?

Hmm, the bug is still there after running a bit longer. Let me apply Valentin's
patch and setup ftrace to try to catch it again.

[ 6152.085915][   T61] kernel BUG at kernel/sched/core.c:7594!
[ 6152.091523][   T61] invalid opcode: 0000 [#1] SMP KASAN PTI
[ 6152.097126][   T61] CPU: 10 PID: 61 Comm: migration/10 Tainted: G          IO      5.10.0-rc6-next-20201201+ #1
[ 6152.107272][   T61] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10, BIOS U34 11/13/2019
[ 6152.116545][   T61] Stopper: multi_cpu_stop+0x0/0x350 <- 0x0
[ 6152.122237][   T61] RIP: 0010:sched_cpu_dying+0x14f/0x180
[ 6152.127667][   T61] Code: 10 00 31 c0 48 83 c4 08 5b 41 5c 41 5d 5d c3 be 08 00 00 00 48 c7 c7 60 5f 15 a1 e8 1b e5 4d 00 f0 4c 01 25 63 c8 5a 09 eb a3 <0f> 0b 48 89 34 24 e8 f6 e0 4d 00 48 8b 34 24 e9 1e ff ff ff 48 89
[ 6152.147248][   T61] RSP: 0018:ffffc90006fbfca0 EFLAGS: 00010002
[ 6152.153202][   T61] RAX: 000000000000723d RBX: ffff8887dfab2400 RCX: 1ffff110fbf56488
[ 6152.161076][   T61] RDX: 0000000000000000 RSI: 000000000000723d RDI: ffff8887dfab2440
[ 6152.168950][   T61] RBP: ffffc90006fbfcc0 R08: fffffbfff417923d R09: fffffbfff417923d
[ 6152.176824][   T61] R10: ffffffffa0bc91e7 R11: fffffbfff417923c R12: ffff8887dfab2418
[ 6152.184698][   T61] R13: 0000000000000086 R14: ffffffff97b03da0 R15: 0000000000000003
[ 6152.192574][   T61] FS:  0000000000000000(0000) GS:ffff8887dfa80000(0000) knlGS:0000000000000000
[ 6152.201409][   T61] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6152.207886][   T61] CR2: 000055fed2192f58 CR3: 0000000cb7e14006 CR4: 00000000007706e0
[ 6152.215761][   T61] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 6152.223636][   T61] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 6152.231509][   T61] PKRU: 55555554
[ 6152.234928][   T61] Call Trace:
[ 6152.238086][   T61]  ? x86_pmu_starting_cpu+0x20/0x20
[ 6152.243166][   T61]  ? sched_cpu_wait_empty+0x290/0x290
[ 6152.248422][   T61]  cpuhp_invoke_callback+0x1d8/0x1520
[ 6152.253677][   T61]  ? x2apic_send_IPI_mask+0x10/0x10
[ 6152.258758][   T61]  ? clear_local_APIC+0x788/0xc10
[ 6152.263663][   T61]  ? cpuhp_invoke_callback+0x1520/0x1520
[ 6152.269178][   T61]  take_cpu_down+0x10f/0x1a0
[ 6152.273646][   T61]  multi_cpu_stop+0x149/0x350
[ 6152.278201][   T61]  ? stop_machine_yield+0x10/0x10
[ 6152.283106][   T61]  cpu_stopper_thread+0x200/0x400
[ 6152.288012][   T61]  ? cpu_stop_create+0x70/0x70
[ 6152.292655][   T61]  smpboot_thread_fn+0x30a/0x770
[ 6152.297472][   T61]  ? smpboot_register_percpu_thread+0x370/0x370
[ 6152.303600][   T61]  ? trace_hardirqs_on+0x1c/0x150
[ 6152.308504][   T61]  ? __kthread_parkme+0xcc/0x1a0
[ 6152.313321][   T61]  ? smpboot_register_percpu_thread+0x370/0x370
[ 6152.319447][   T61]  kthread+0x354/0x420
[ 6152.323390][   T61]  ? kthread_create_on_node+0xc0/0xc0
[ 6152.328645][   T61]  ret_from_fork+0x22/0x30
[ 6152.332938][   T61] Modules linked in: isofs cdrom fuse loop nls_ascii nls_cp437 vfat fat kvm_intel kvm irqbypass ses enclosure efivarfs ip_tables x_tables sd_mod tg3 nvme firmware_class smartpqi nvme_core libphy scsi_transport_sas dm_mirror dm_region_hash dm_log dm_mod [last unloaded: dummy_del_mod]
[ 6152.359732][   T61] ---[ end trace f59b31dec044f746 ]---
[ 6152.365076][   T61] RIP: 0010:sched_cpu_dying+0x14f/0x180
[ 6152.370505][   T61] Code: 10 00 31 c0 48 83 c4 08 5b 41 5c 41 5d 5d c3 be 08 00 00 00 48 c7 c7 60 5f 15 a1 e8 1b e5 4d 00 f0 4c 01 25 63 c8 5a 09 eb a3 <0f> 0b 48 89 34 24 e8 f6 e0 4d 00 48 8b 34 24 e9 1e ff ff ff 48 89
[ 6152.390085][   T61] RSP: 0018:ffffc90006fbfca0 EFLAGS: 00010002
[ 6152.396039][   T61] RAX: 000000000000723d RBX: ffff8887dfab2400 RCX: 1ffff110fbf56488
[ 6152.403914][   T61] RDX: 0000000000000000 RSI: 000000000000723d RDI: ffff8887dfab2440
[ 6152.411789][   T61] RBP: ffffc90006fbfcc0 R08: fffffbfff417923d R09: fffffbfff417923d
[ 6152.419662][   T61] R10: ffffffffa0bc91e7 R11: fffffbfff417923c R12: ffff8887dfab2418
[ 6152.427537][   T61] R13: 0000000000000086 R14: ffffffff97b03da0 R15: 0000000000000003
[ 6152.435412][   T61] FS:  0000000000000000(0000) GS:ffff8887dfa80000(0000) knlGS:0000000000000000
[ 6152.444248][   T61] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6152.450725][   T61] CR2: 000055fed2192f58 CR3: 0000000cb7e14006 CR4: 00000000007706e0
[ 6152.458600][   T61] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 6152.466476][   T61] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 6152.474350][   T61] PKRU: 55555554
[ 6152.477771][   T61] Kernel panic - not syncing: Fatal exception
[ 6152.483729][   T61] 
[ 6152.483731][   T61] unchecked MSR access error: WRMSR to 0x83f (tried to write 0x00000000000000f6) at rIP: 0xffffffff97ac8b93 (native_apic_msr_write+0x23/0x40)
[ 6152.483732][   T61] Call Trace:
[ 6152.483733][   T61]  arch_irq_work_raise+0x9b/0x110
[ 6152.483733][   T61]  irq_work_queue+0x24/0x40
[ 6152.483734][   T61]  printk_safe_log_store+0x185/0x1b0
[ 6152.483735][   T61]  ? kmsg_dump_rewind_nolock+0x80/0x80
[ 6152.483736][   T61]  ? ret_from_fork+0x22/0x30
[ 6152.483736][   T61]  printk+0x9a/0xc0
[ 6152.483737][   T61]  ? record_print_text.cold.37+0x11/0x11
[ 6152.483739][   T61]  ? stack_trace_consume_entry+0x160/0x160
[ 6152.483740][   T61]  ? save_trace+0x3d/0xc40
[ 6152.483741][   T61]  print_circular_bug_header.cold.69+0x10/0xd7
[ 6152.483742][   T61]  print_circular_bug.isra.42+0x230/0x430
[ 6152.483743][   T61]  check_noncircular+0x27b/0x320
[ 6152.483745][   T61]  ? print_circular_bug.isra.42+0x430/0x430
[ 6152.483746][   T61]  ? mark_lock.part.47+0x109/0x1f90
[ 6152.483747][   T61]  ? print_usage_bug+0x2b0/0x2b0
[ 6152.483748][   T61]  ? mark_lock.part.47+0x109/0x1f90
[ 6152.483749][   T61]  check_prevs_add+0x38e/0x2800
[ 6152.483749][   T61]  ? lock_is_held_type+0x19/0xe0
[ 6152.483750][   T61]  ? check_irq_usage+0xcf0/0xcf0
[ 6152.483751][   T61]  ? rcu_read_lock_held+0xb0/0xb0
[ 6152.483752][   T61]  __lock_acquire+0x2c86/0x3e60
[ 6152.483753][   T61]  ? __add_preferred_console.constprop.25+0x220/0x220
[ 6152.483753][   T61]  ? lockdep_hardirqs_on_prepare+0x3d0/0x3d0
[ 6152.483754][   T61]  lock_acquire+0x1c8/0x820
[ 6152.483755][   T61]  ? down_trylock+0xe/0x70
[ 6152.483756][   T61]  ? rcu_read_unlock+0x40/0x40
[ 6152.483757][   T61]  ? vprintk_emit+0x89/0x2c0
[ 6152.483758][   T61]  ? lock_downgrade+0x700/0x700
[ 6152.483759][   T61]  ? rcu_read_unlock+0x40/0x40
[ 6152.483760][   T61]  ? vprintk_emit+0x107/0x2c0
[ 6152.483761][   T61]  _raw_spin_lock_irqsave+0x30/0x50
[ 6152.483761][   T61]  ? down_trylock+0xe/0x70
[ 6152.483762][   T61]  down_trylock+0xe/0x70
[ 6152.483763][   T61]  __down_trylock_console_sem+0x23/0x90
[ 6152.483764][   T61]  console_trylock+0xe/0x60
[ 6152.483764][   T61]  vprintk_emit+0x107/0x2c0
[ 6152.483765][   T61]  ? sched_cpu_dying+0x14f/0x180
[ 6152.483765][   T61]  printk+0x9a/0xc0
[ 6152.483766][   T61]  ? record_print_text.cold.37+0x11/0x11
[ 6152.483767][   T61]  report_bug.cold.2+0x30/0x52
[ 6152.483768][   T61]  handle_bug+0x44/0x80
[ 6152.483769][   T61]  exc_invalid_op+0x13/0x40
[ 6152.483769][   T61]  asm_exc_invalid_op+0x12/0x20
[ 6152.483770][   T61] RIP: 0010:sched_cpu_dying+0x14f/0x180
[ 6152.483772][   T61] Code: 10 00 31 c0 48 83 c4 08 5b 41 5c 41 5d 5d c3 be 08 00 00 00 48 c7 c7 60 5f 15 a1 e8 1b e5 4d 00 f0 4c 01 25 63 c8 5a 09 eb a3 <0f> 0b 48 89 34 24 e8 f6 e0 4d 00 48 8b 34 24 e9 1e ff ff ff 48 89
[ 6152.483774][   T61] RSP: 0018:ffffc90006fbfca0 EFLAGS: 00010002
[ 6152.483775][   T61] RAX: 000000000000723d RBX: ffff8887dfab2400 RCX: 1ffff110fbf56488
[ 6152.483777][   T61] RDX: 0000000000000000 RSI: 000000000000723d RDI: ffff8887dfab2440
[ 6152.483778][   T61] RBP: ffffc90006fbfcc0 R08: fffffbfff417923d R09: fffffbfff417923d
[ 6152.483779][   T61] R10: ffffffffa0bc91e7 R11: fffffbfff417923c R12: ffff8887dfab2418
[ 6152.483780][   T61] R13: 0000000000000086 R14: ffffffff97b03da0 R15: 0000000000000003
[ 6152.483781][   T61]  ? cpuhp_invoke_callback+0x1520/0x1520
[ 6152.483781][   T61]  ? x86_pmu_starting_cpu+0x20/0x20
[ 6152.483782][   T61]  ? sched_cpu_wait_empty+0x290/0x290
[ 6152.483783][   T61]  cpuhp_invoke_callback+0x1d8/0x1520
[ 6152.483784][   T61]  ? x2apic_send_IPI_mask+0x10/0x10
[ 6152.483784][   T61]  ? clear_local_APIC+0x788/0xc10
[ 6152.483785][   T61]  ? cpuhp_invoke_callback+0x1520/0x1520
[ 6152.483786][   T61]  take_cpu_down+0x10f/0x1a0
[ 6152.483786][   T61]  multi_cpu_stop+0x149/0x350
[ 6152.483787][   T61]  ? stop_machine_yield+0x10/0x10
[ 6152.483788][   T61]  cpu_stopper_thread+0x200/0x400
[ 6152.483789][   T61]  ? cpu_stop_create+0x70/0x70
[ 6152.483789][   T61]  smpboot_thread_fn+0x30a/0x770
[ 6152.483790][   T61]  ? smpboot_register_percpu_thread+0x370/0x370
[ 6152.483791][   T61]  ? trace_hardirqs_on+0x1c/0x150
[ 6152.483792][   T61]  ? __kthread_parkme+0xcc/0x1a0
[ 6152.483792][   T61]  ? smpboot_register_percpu_thread+0x370/0x370
[ 6152.483793][   T61]  kthread+0x354/0x420
[ 6152.483794][   T61]  ? kthread_create_on_node+0xc0/0xc0
[ 6152.483794][   T61]  ret_from_fork+0x22/0x30
[ 6152.483796][   T61] ======================================================
[ 6152.483797][   T61] WARNING: possible circular locking dependency detected
[ 6152.483798][   T61] 5.10.0-rc6-next-20201201+ #1 Tainted: G          IO     
[ 6152.483799][   T61] ------------------------------------------------------
[ 6152.483800][   T61] migration/10/61 is trying to acquire lock:
[ 6152.483801][   T61] ffffffffa08c7e98 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0xe/0x70
[ 6152.483805][   T61] 
[ 6152.483805][   T61] but task is already holding lock:
[ 6152.483806][   T61] ffff8887dfab2418 (&rq->lock){-.-.}-{2:2}, at: sched_cpu_dying+0x4e/0x180
[ 6152.483809][   T61] 
[ 6152.483810][   T61] which lock already depends on the new lock.
[ 6152.483810][   T61] 
[ 6152.483811][   T61] 
[ 6152.483812][   T61] the existing dependency chain (in reverse order) is:
[ 6152.483812][   T61] 
[ 6152.483813][   T61] -> #2 (&rq->lock){-.-.}-{2:2}:
[ 6152.483815][   T61]        lock_acquire+0x1c8/0x820
[ 6152.483816][   T61]        _raw_spin_lock+0x27/0x40
[ 6152.483817][   T61]        task_fork_fair+0x32/0x4c0
[ 6152.483818][   T61]        sched_fork+0x3b3/0x8d0
[ 6152.483818][   T61]        copy_process+0x1c89/0x6470
[ 6152.483819][   T61]        kernel_clone+0xbd/0xc90
[ 6152.483820][   T61]        kernel_thread+0x95/0xd0
[ 6152.483820][   T61]        rest_init+0x21/0x28a
[ 6152.483821][   T61]        start_kernel+0x37c/0x39a
[ 6152.483822][   T61]        secondary_startup_64_no_verify+0xc2/0xcb
[ 6152.483822][   T61] 
[ 6152.483823][   T61] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[ 6152.483826][   T61]        lock_acquire+0x1c8/0x820
[ 6152.483827][   T61]        _raw_spin_lock_irqsave+0x30/0x50
[ 6152.483827][   T61]        try_to_wake_up+0x9c/0xf90
[ 6152.483828][   T61]        up+0x8d/0xd0
[ 6152.483829][   T61]        __up_console_sem+0x29/0x60
[ 6152.483830][   T61]        console_unlock+0x581/0xa20
[ 6152.483830][   T61]        vprintk_emit+0x201/0x2c0
[ 6152.483831][   T61]        printk+0x9a/0xc0
[ 6152.483832][   T61]        do_exit.cold.38+0x55/0x1e5
[ 6152.483832][   T61]        do_group_exit+0xeb/0x2d0
[ 6152.483833][   T61]        __x64_sys_exit_group+0x35/0x40
[ 6152.483834][   T61]        do_syscall_64+0x33/0x40
[ 6152.483835][   T61]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 6152.483835][   T61] 
[ 6152.483836][   T61] -> #0 ((console_sem).lock){-.-.}-{2:2}:
[ 6152.483839][   T61]        check_prevs_add+0x38e/0x2800
[ 6152.483839][   T61]        __lock_acquire+0x2c86/0x3e60
[ 6152.483840][   T61]        lock_acquire+0x1c8/0x820
[ 6152.483841][   T61]        _raw_spin_lock_irqsave+0x30/0x50
[ 6152.483842][   T61]        down_trylock+0xe/0x70
[ 6152.483843][   T61]        __down_trylock_console_sem+0x23/0x90
[ 6152.483844][   T61]        console_trylock+0xe/0x60
[ 6152.483845][   T61]        vprintk_emit+0x107/0x2c0
[ 6152.483846][   T61]        printk+0x9a/0xc0
[ 6152.483847][   T61]        report_bug.cold.2+0x30/0x52
[ 6152.483848][   T61]        handle_bug+0x44/0x80
[ 6152.483849][   T61]        exc_invalid_][   T61] R10: ffffffffa0bc91e7 R11: fffffbfff417923c R12: ffff8887dfab2418
[ 6152.483920][   T61] R13: 0000000000000086 R14: ffffffff97b03da0 R15: 0000000000000003
[ 6152.483920][   T61]  ? cpuhp_invoke_callback+0x1520/0x1520
[ 6152.483921][   T61]  ? x86_pmu_starting_cpu+0x20/0x20
[ 6152.483922][   T61]  ? sched_cpu_wait_empty+0x290/0x290
[ 6152.483923][   T61]  cpuhp_invoke_callback+0x1d8/0x1520
[ 6152.483923][   T61]  ? x2apic_send_IPI_mask+0x10/0x10
[ 6152.483924][   T61]  ? clear_local_APIC+0x788/0xc10
[ 6152.483925][   T61]  ? cpuhp_invoke_callback+0x1520/0x1520
[ 6152.483925][   T61]  take_cpu_down+0x10f/0x1a0
[ 6152.483926][   T61]  multi_cpu_stop+0x149/0x350
[ 6152.483927][   T61]  ? stop_machine_yield+0x10/0x10
[ 6152.483928][   T61]  cpu_stopper_thread+0x200/0x400
[ 6152.483929][   T61]  ? cpu_stop_create+0x70/0x70
[ 6152.483930][   T61]  smpboot_thread_fn+0x30a/0x770
[ 6152.483931][   T61]  ? smpboot_register_percpu_thread+0x370/0x370
[ 6152.483932][   T61]  ? trace_hardirqs_on+0x1c/0x150

