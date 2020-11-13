Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A952B1E33
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgKMPHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:07:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726662AbgKMPHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605280022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k19eyl5gUqzooy8Jc6VfX8yC3bkmTUJ0gn/9qEiQ++A=;
        b=MHVEyn4Of8HYIpt2yzmRg1A3J0Y5Qg2Df9yEaobMSniDEkbbwqF0kL14YnRmtzkJWkcMWD
        tVzb97UplqQMls/4q90gm/H17fIi2PTsbYfcmBNMWPK7OdhzC86nGx3BaIMAU/nLHVz/w7
        Sx9UD/TPjjlPAM6jtn3btsRWwCVgGUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-i9Mh3YWWNnC2qCSPwfjmiA-1; Fri, 13 Nov 2020 10:06:58 -0500
X-MC-Unique: i9Mh3YWWNnC2qCSPwfjmiA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46B4DCFF23;
        Fri, 13 Nov 2020 15:06:56 +0000 (UTC)
Received: from ovpn-116-200.rdu2.redhat.com (ovpn-116-200.rdu2.redhat.com [10.10.116.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B48560C0F;
        Fri, 13 Nov 2020 15:06:54 +0000 (UTC)
Message-ID: <ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com>
Subject: Re: [PATCH v4 11/19] sched/core: Make migrate disable and CPU
 hotplug cooperative
From:   Qian Cai <cai@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Date:   Fri, 13 Nov 2020 10:06:53 -0500
In-Reply-To: <20201023102347.067278757@infradead.org>
References: <20201023101158.088940906@infradead.org>
         <20201023102347.067278757@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-23 at 12:12 +0200, Peter Zijlstra wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> On CPU unplug tasks which are in a migrate disabled region cannot be pushed
> to a different CPU until they returned to migrateable state.
> 
> Account the number of tasks on a runqueue which are in a migrate disabled
> section and make the hotplug wait mechanism respect that.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c  |   36 ++++++++++++++++++++++++++++++------
>  kernel/sched/sched.h |    4 ++++
>  2 files changed, 34 insertions(+), 6 deletions(-)
> 
[] 
> @@ -7310,7 +7334,7 @@ int sched_cpu_dying(unsigned int cpu)
>  	sched_tick_stop(cpu);
>  
>  	rq_lock_irqsave(rq, &rf);
> -	BUG_ON(rq->nr_running != 1);
> +	BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));

CPU hotplug is now triggering this. This is with Valentin's affine_move_task()
fix on top:

https://lore.kernel.org/lkml/20201113112414.2569-1-valentin.schneider@arm.com/

[  809.412232][  T428] kernel BUG at kernel/sched/core.c:7547!
[  809.417841][  T428] invalid opcode: 0000 [#1] SMP KASAN PTI
[  809.423445][  T428] CPU: 72 PID: 428 Comm: migration/72 Tainted: G          I       5.10.0-rc3-next-20201113+ #1
[  809.433678][  T428] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10, BIOS U34 11/13/2019
[  809.442951][  T428] Stopper: multi_cpu_stop+0x0/0x350 <- 0x0
[  809.448643][  T428] RIP: 0010:sched_cpu_dying+0x10f/0x130
[  809.454071][  T428] Code: 10 00 31 c0 48 83 c4 08 5b 41 5c 41 5d 5d c3 be 08 00 00 00 48 c7 c7 60 3f b5 96 e8 ab 81 4d 00 f0 4c 01 25 73 c4 5a 09 eb a3 <0f> 0b 48 89 34 24 e8 86 7d 4d 00 48 8b 34 24 e9 5d ff ff ff e8 88
[  809.473650][  T428] RSP: 0018:ffffc9000889fca0 EFLAGS: 00010002
[  809.479606][  T428] RAX: 0000000000000000 RBX: ffff8887dfcb23c0 RCX: ffffffff8e057e0d
[  809.487482][  T428] RDX: 1ffff110fbf96480 RSI: 0000000000007c11 RDI: ffff8887dfcb2400
[  809.495355][  T428] RBP: ffffc9000889fcc0 R08: fffffbfff2cb8e96 R09: fffffbfff2cb8e96
[  809.503229][  T428] R10: ffffffff965c74af R11: fffffbfff2cb8e95 R12: ffff8887dfcb23d8
[  809.511103][  T428] R13: 0000000000000086 R14: ffffffff8d5038e0 R15: 0000000000000003
[  809.518979][  T428] FS:  0000000000000000(0000) GS:ffff8887dfc80000(0000) knlGS:0000000000000000
[  809.527815][  T428] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  809.534291][  T428] CR2: 00007fea4cdf899c CR3: 00000018c7414002 CR4: 00000000007706e0
[  809.542165][  T428] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  809.550040][  T428] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  809.557913][  T428] PKRU: 55555554
[  809.561332][  T428] Call Trace:
[  809.564489][  T428]  ? x86_pmu_starting_cpu+0x20/0x20
[  809.569570][  T428]  ? sched_cpu_wait_empty+0x220/0x220
[  809.574826][  T428]  cpuhp_invoke_callback+0x1d8/0x1520
[  809.580082][  T428]  ? x2apic_send_IPI_mask+0x10/0x10
[  809.585161][  T428]  ? clear_local_APIC+0x788/0xc10
[  809.590068][  T428]  ? cpuhp_invoke_callback+0x1520/0x1520
[  809.595584][  T428]  take_cpu_down+0x10f/0x1a0
[  809.600053][  T428]  multi_cpu_stop+0x149/0x350
[  809.604607][  T428]  ? stop_machine_yield+0x10/0x10
[  809.609511][  T428]  cpu_stopper_thread+0x200/0x400
[  809.614416][  T428]  ? cpu_stop_create+0x70/0x70
[  809.619059][  T428]  smpboot_thread_fn+0x30a/0x770
[  809.623878][  T428]  ? smpboot_register_percpu_thread+0x370/0x370
[  809.630005][  T428]  ? trace_hardirqs_on+0x1c/0x150
[  809.634910][  T428]  ? __kthread_parkme+0xcc/0x1a0
[  809.639729][  T428]  ? smpboot_register_percpu_thread+0x370/0x370
[  809.645855][  T428]  kthread+0x352/0x420
[  809.649798][  T428]  ? kthread_create_on_node+0xc0/0xc0
[  809.655052][  T428]  ret_from_fork+0x22/0x30
[  809.659345][  T428] Modules linked in: nls_ascii nls_cp437 vfat fat kvm_intel kvm ses enclosure irqbypass efivarfs ip_tables x_tables sd_mod nvme tg3 firmware_class smartpqi nvme_core scsi_transport_sas libphy dm_mirror dm_region_hash dm_log dm_mod
[  809.681502][  T428] ---[ end trace 416318a3e677bf17 ]---
[  809.686844][  T428] RIP: 0010:sched_cpu_dying+0x10f/0x130
[  809.692273][  T428] Code: 10 00 31 c0 48 83 c4 08 5b 41 5c 41 5d 5d c3 be 08 00 00 00 48 c7 c7 60 3f b5 96 e8 ab 81 4d 00 f0 4c 01 25 73 c4 5a 09 eb a3 <0f> 0b 48 89 34 24 e8 86 7d 4d 00 48 8b 34 24 e9 5d ff ff ff e8 88
[  809.711853][  T428] RSP: 0018:ffffc9000889fca0 EFLAGS: 00010002
[  809.717807][  T428] RAX: 0000000000000000 RBX: ffff8887dfcb23c0 RCX: ffffffff8e057e0d
[  809.725681][  T428] RDX: 1ffff110fbf96480 RSI: 0000000000007c11 RDI: ffff8887dfcb2400
[  809.733556][  T428] RBP: ffffc9000889fcc0 R08: fffffbfff2cb8e96 R09: fffffbfff2cb8e96
[  809.741432][  T428] R10: ffffffff965c74af R11: fffffbfff2cb8e95 R12: ffff8887dfcb23d8
[  809.749307][  T428] R13: 0000000000000086 R14: ffffffff8d5038e0 R15: 0000000000000003
[  809.757182][  T428] FS:  0000000000000000(0000) GS:ffff8887dfc80000(0000) knlGS:0000000000000000
[  809.766018][  T428] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  809.772495][  T428] CR2: 00007fea4cdf899c CR3: 00000018c7414002 CR4: 00000000007706e0
[  809.780369][  T428] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  809.788242][  T428] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  809.796118][  T428] PKRU: 55555554
[  809.799538][  T428] Kernel panic - not syncing: Fatal exception
[  809.805543][  T428] 
[  809.805544][  T428] unchecked MSR access error: WRMSR to 0x83f (tried to write 0x00000000000000f6) at rIP: 0xffffffff8d4c8a43 (native_apic_msr_write+0x23/0x40)
[  809.805545][  T428] Call Trace:
[  809.805546][  T428]  arch_irq_work_raise+0x9b/0x110
[  809.805547][  T428]  irq_work_queue+0x24/0x40
[  809.805548][  T428]  printk_safe_log_store+0x185/0x1b0
[  809.805549][  T428]  ? kmsg_dump_rewind_nolock+0x80/0x80
[  809.805549][  T428]  ? ret_from_fork+0x22/0x30
[  809.805550][  T428]  printk+0x9a/0xc0
[  809.805551][  T428]  ? record_print_text.cold.38+0x11/0x11
[  809.805552][  T428]  ? stack_trace_consume_entry+0x160/0x160
[  809.805553][  T428]  ? save_trace+0x3d/0xb40
[  809.805554][  T428]  print_circular_bug_header.cold.69+0x10/0xd7
[  809.805556][  T428]  print_circular_bug.isra.42+0x1ac/0x300
[  809.805557][  T428]  check_noncircular+0x27b/0x320
[  809.805558][  T428]  ? print_circular_bug.isra.42+0x300/0x300
[  809.805559][  T428]  ? data_alloc.isra.8+0x15f/0x470
[  809.805560][  T428]  ? mark_lock.part.47+0x109/0x1a30
[  809.805560][  T428]  ? data_push_tail.part.6+0x310/0x310
[  809.805561][  T428]  ? print_usage_bug+0x1a0/0x1a0
[  809.805562][  T428]  check_prevs_add+0x38e/0x26f0
[  809.805563][  T428]  ? lock_is_held_type+0x19/0xe0
[  809.805563][  T428]  ? check_irq_usage+0xbb0/0xbb0
[  809.805564][  T428]  ? rcu_read_lock_held+0xb0/0xb0
[  809.805565][  T428]  __lock_acquire+0x2b9e/0x3920
[  809.805566][  T428]  ? __add_preferred_console.constprop.25+0x1d0/0x1d0
[  809.805567][  T428]  ? lockdep_hardirqs_on_prepare+0x3d0/0x3d0
[  809.805567][  T428]  lock_acquire+0x1c8/0x820
[  809.805568][  T428]  ? down_trylock+0xe/0x70
[  809.805569][  T428]  ? rcu_read_unlock+0x40/0x40
[  809.805570][  T428]  ? vprintk_emit+0x89/0x2c0
[  809.805571][  T428]  ? lock_downgrade+0x700/0x700
[  809.805572][  T428]  ? rcu_read_unlock+0x40/0x40
[  809.805573][  T428]  ? vprintk_emit+0x107/0x2c0
[  809.805575][  T428]  _raw_spin_lock_irqsave+0x30/0x50
[  809.805576][  T428]  ? down_trylock+0xe/0x70
[  809.805577][  T428]  down_trylock+0xe/0x70
[  809.805578][  T428]  __down_trylock_console_sem+0x23/0x90
[  809.805578][  T428]  console_trylock+0xe/0x60
[  809.805579][  T428]  vprintk_emit+0x107/0x2c0
[  809.805580][  T428]  ? sched_cpu_dying+0x10f/0x130
[  809.805581][  T428]  printk+0x9a/0xc0
[  809.805582][  T428]  ? record_print_text.cold.38+0x11/0x11
[  809.805583][  T428]  report_bug.cold.2+0x30/0x52
[  809.805584][  T428]  handle_bug+0x44/0x80
[  809.805585][  T428]  exc_invalid_op+0x13/0x40
[  809.805585][  T428]  asm_exc_invalid_op+0x12/0x20
[  809.805586][  T428] RIP: 0010:sched_cpu_dying+0x10f/0x130
[  809.805588][  T428] Code: 10 00 31 c0 48 83 c4 08 5b 41 5c 41 5d 5d c3 be 08 00 00 00 48 c7 c7 60 3f b5 96 e8 ab 81 4d 00 f0 4c 01 25 73 c4 5a 09 eb a3 <0f> 0b 48 89 34 24 e8 86 7d 4d 00 48 8b 34 24 e9 5d ff ff ff e8 88
[  809.805589][  T428] RSP: 0018:ffffc9000889fca0 EFLAGS: 00010002
[  809.805591][  T428] RAX: 0000000000000000 RBX: ffff8887dfcb23c0 RCX: ffffffff8e057e0d
[  809.805591][  T428] RDX: 1ffff110fbf96480 RSI: 0000000000007c11 RDI: ffff8887dfcb2400
[  809.805593][  T428] RBP: ffffc9000889fcc0 R08: fffffbfff2cb8e96 R09: fffffbfff2cb8e96
[  809.805594][  T428] R10: ffffffff965c74af R11: fffffbfff2cb8e95 R12: ffff8887dfcb23d8
[  809.805594][  T428] R13: 0000000000000086 R14: ffffffff8d5038e0 R15: 0000000000000003
[  809.805595][  T428]  ? cpuhp_invoke_callback+0x1520/0x1520
[  809.805596][  T428]  ? prandom_u32+0x18d/0x390
[  809.805597][  T428]  ? x86_pmu_starting_cpu+0x20/0x20
[  809.805598][  T428]  ? sched_cpu_wait_empty+0x220/0x220
[  809.805599][  T428]  cpuhp_invoke_callback+0x1d8/0x1520
[  809.805600][  T428]  ? x2apic_send_IPI_mask+0x10/0x10
[  809.805600][  T428]  ? clear_local_APIC+0x788/0xc10
[  809.805601][  T428]  ? cpuhp_invoke_callback+0x1520/0x1520
[  809.805602][  T428]  take_cpu_down+0x10f/0x1a0
[  809.805603][  T428]  multi_cpu_stop+0x149/0x350
[  809.805603][  T428]  ? stop_machine_yield+0x10/0x10
[  809.805604][  T428]  cpu_stopper_thread+0x200/0x400
[  809.805605][  T428]  ? cpu_stop_create+0x70/0x70
[  809.805606][  T428]  smpboot_thread_fn+0x30a/0x770
[  809.805607][  T428]  ? smpboot_register_percpu_thread+0x370/0x370
[  809.805607][  T428]  ? trace_hardirqs_on+0x1c/0x150
[  809.805608][  T428]  ? __kthread_parkme+0xcc/0x1a0
[  809.805609][  T428]  ? smpboot_register_percpu_thread+0x370/0x370
[  809.805610][  T428]  kthread+0x352/0x420
[  809.805611][  T428]  ? kthread_create_on_node+0xc0/0xc0
[  809.805612][  T428]  ret_from_fork+0x22/0x30
[  809.805613][  T428] ======================================================
[  809.805614][  T428] WARNING: possible circular locking dependency detected
[  809.805616][  T428] 5.10.0-rc3-next-20201113+ #1 Tainted: G          I      
[  809.805617][  T428] ------------------------------------------------------
[  809.805618][  T428] migration/72/428 is trying to acquire lock:
[  809.805619][  T428] ffffffff962c7d58 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0xe/0x70
[  809.805623][  T428] 
[  809.805623][  T428] but task is already holding lock:
[  809.805624][  T428] ffff8887dfcb23d8 (&rq->lock){-.-.}-{2:2}, at: sched_cpu_dying+0x4e/0x130
[  809.805628][  T428] 
[  809.805628][  T428] which lock already depends on the new lock.
[  809.805629][  T428] 
[  809.805630][  T428] 
[  809.805631][  T428] the existing dependency chain (in reverse order) is:
[  809.805631][  T428] 
[  809.805632][  T428] -> #2 (&rq->lock){-.-.}-{2:2}:
[  809.805635][  T428]        lock_acquire+0x1c8/0x820
[  809.805636][  T428]        _raw_spin_lock+0x27/0x40
[  809.805637][  T428]        task_fork_fair+0x32/0x4c0
[  809.805637][  T428]        sched_fork+0x3aa/0x8c0
[  809.805638][  T428]        copy_process+0x1c87/0x6440
[  809.805639][  T428]        kernel_clone+0xbd/0xc90
[  809.805640][  T428]        kernel_thread+0x95/0xd0
[  809.805640][  T428]        rest_init+0x21/0x28a
[  809.805641][  T428]        start_kernel+0x381/0x39f
[  809.805642][  T428]        secondary_startup_64_no_verify+0xc2/0xcb
[  809.805642][  T428] 
[  809.805643][  T428] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[  809.805646][  T428]        lock_acquire+0x1c8/0x820
[  809.805647][  T428]        _raw_spin_lock_irqsave+0x30/0x50
[  809.805648][  T428]        try_to_wake_up+0x9b/0xc40
[  809.805648][  T428]        up+0x8d/0xd0
[  809.805649][  T428]        __up_console_sem+0x29/0x60
[  809.805650][  T428]      0x89/0x2c0
[  809.805726][  T428]  ? lock_downgrade+0x700/0x700
[  809.805727][  T428]  ? rcu_read_unlock+0x40/0x40
[  809.805727][  T428]  ? vprintk_emit+0x107/0x2c0
[  809.805728][  T428]  _raw_spin_lock_irqsave+0x30/0x50
[  809.805729][  T428]  ? down_trylock+0xe/0x70
[  809.805729][  T428]  down_trylock+0xe/0x70
[  809.805730][  T428]  __down_trylock_console_sem+0x23/0x90
[  809.805731][  T428]  console_trylock+0xe/0x60
[  809.805732][  T428]  vprintk_emit+0x107/0x2c0
[  809.805733][  T428]  ? sched_cpu_dying+0x10f/0x130
[  809.805733][  T428]  printk+0x9a/0xc0
[  809.805734][  T428]  ? record_print_text.cold.38+0x11/0x11
[  809.805735][  T428]  report_bug.cold.2+0x30/0x52
[  809.805735][  T428]  handle_bug+0x44/0x80
[  809.805736][  T428]  exc_invalid_op+0x13/0x40
[  809.805737][  T428]  asm_exc_invalid_op+0x12/0x20
[  809.805738][  T428] RIP: 0010:sched_cpu_dying+0x10f/0x130
[  809.805739][  T428] Code: 10 00 31 c0 48 83 c4 08 5b 41 5c 41 5d 5d c3 be 08 00 00 00 48 c7 c7 60 3f b5 96 e8 ab 81 4d 00 f0 4c 01 25 73 c4 5a 09 eb a3 <0f> 0b 48 89 34 24 e8 86 7d 4d 00 48

>  	rq_unlock_irqrestore(rq, &rf);
>  
>  	calc_load_migrate(rq);


