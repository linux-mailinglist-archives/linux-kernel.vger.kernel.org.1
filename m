Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CFD281441
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgJBNk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387908AbgJBNk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601646055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uqylIXrnUot3hK9rTTUvLioQ0LaU1Kj2LenrDLO3SyA=;
        b=cZgueoldyzttC8MxByM81tZRB3DcqS4EhESCgf1IrkA7O9gbocz+RmdSJPlPY8d6Ywe9gU
        j/bWEvadEvcMJHJl34eq9TlhDib5JpLCM2DZYzikfTjXrtXihHimRNaQOVzDteccC99x04
        jQCnq7jt2KoDvbhvNahqyfQN5gDOlRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-iJcZCUTuNmCyRZfkreMhtQ-1; Fri, 02 Oct 2020 09:40:51 -0400
X-MC-Unique: iJcZCUTuNmCyRZfkreMhtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81E456408A;
        Fri,  2 Oct 2020 13:40:50 +0000 (UTC)
Received: from ovpn-113-213.rdu2.redhat.com (ovpn-113-213.rdu2.redhat.com [10.10.113.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4849655797;
        Fri,  2 Oct 2020 13:40:43 +0000 (UTC)
Message-ID: <708b591a9350ba0a308afecb84b61c65511a8190.camel@redhat.com>
Subject: Re: lockdep null-ptr-deref
From:   Qian Cai <cai@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Date:   Fri, 02 Oct 2020 09:40:42 -0400
In-Reply-To: <20201002100607.GH2651@hirez.programming.kicks-ass.net>
References: <5fd046115645daa00f8841f5467da4c4d960ca92.camel@redhat.com>
         <20200929230823.GC17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
         <20200930091610.GV2628@hirez.programming.kicks-ass.net>
         <20200930094937.GE2651@hirez.programming.kicks-ass.net>
         <20201002100607.GH2651@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-02 at 12:06 +0200, Peter Zijlstra wrote:
> On Wed, Sep 30, 2020 at 11:49:37AM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 30, 2020 at 11:16:11AM +0200, Peter Zijlstra wrote:
> > > On Wed, Sep 30, 2020 at 07:08:23AM +0800, Boqun Feng wrote:
> > > > I think there are two problems here:
> > > > 
> > > > 1) the "(null)" means we don't have the "usage_str" for a usage bit,
> > > > which I think is the LOCK_USED_READ bit introduced by Peter at
> > > > 23870f122768 ('locking/lockdep: Fix "USED" <- "IN-NMI" inversions').
> > > > 
> > > > 2) the next null-ptr-deref, and I think this is also caused by
> > > > LOCK_USED_READ bit, because in the loop inside
> > > > print_lock_class_header(), we iterate from 0 to LOCK_USAGE_STATES (which
> > > > is 4*2 + 3), however the class->usage_traces[] only has
> > > > XXX_LOCK_USAGE_STATES (which is 4*2 + 1) elements, so if we have
> > > > LOCK_USED_READ bit set in ->usage_mask, we will try to access an element
> > > > out of the ->usage_traces[] array.
> > > > 
> > > > Probably the following helps? And another possible fix is to enlarge the
> > > > ->usage_trace[] array and record the call trace of LOCK_READ_USED.
> > > 
> > > Urgh.. yeah, I wanted to avoid saving that trace; it's pretty useless :/
> > > The existing USED trace is already mostly pointless, the consistent
> > > thing would be to remove both but that might be too radical.
> > > 
> > > But you're right in that I made a right mess of it. Not sure what's
> > > best here.
> > > 
> > > Let me have a play.
> > 
> > How's something like this? It's bigger than I'd like, but I feel the
> > result is more consistent/readable.
> > 
> 
> Qian, could you confirm this works for you?

It works fine. No crash. The new report looks like this:

[   29.439920] ========================================================
[   29.449225] WARNING: possible irq lock inversion dependency detected
[   29.453195] 5.9.0-rc7-next-20201002+ #5 Not tainted
[   29.456023] --------------------------------------------------------
[   29.459012] swapper/6/0 just changed the state of lock:
[   29.461442] ffff8889e8cc0818 (&host->lock){-...}-{2:2}, at: ata_bmdma_interrupt+0x1e/0x530 [libata]
[   29.462752] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[   29.465625] but this lock took another, HARDIRQ-READ-unsafe lock in the past:
[   29.465626]  (&trig->leddev_list_lock){.+.?}-{2:2}
[   29.465629] 
               
               and interrupts could create inverse lock ordering between them.

[   29.465630] 
               other info that might help us debug this:
[   29.465631]  Possible interrupt unsafe locking scenario:

[   29.465632]        CPU0                    CPU1
[   29.465638]        ----                    ----
[   29.490458]   lock(&trig->leddev_list_lock);
[   29.492455]                                local_irq_disable();
[   29.495248]                                lock(&host->lock);
[   29.497882]                                lock(&trig->leddev_list_lock);
[   29.501018]   <Interrupt>
[   29.502293]     lock(&host->lock);
[   29.503853] 
                *** DEADLOCK ***

[   29.506636] no locks held by swapper/6/0.
[   29.508558] 
               the shortest dependencies between 2nd lock and 1st lock:
[   29.512201]  -> (&trig->leddev_list_lock){.+.?}-{2:2} {
[   29.514614]     HARDIRQ-ON-R at:
[   29.516194]                       lock_acquire+0x17f/0x7e0
[   29.518755]                       _raw_read_lock+0x38/0x70
[   29.521310]                       led_trigger_event+0x2b/0xb0
[   29.523945]                       kbd_propagate_led_state+0x5d/0x80
[   29.526858]                       kbd_bh+0x14d/0x1d0
[   29.529139]                       tasklet_action_common.isra.13+0x23a/0x2e0
[   29.532338]                       __do_softirq+0x1ce/0x828
[   29.534847]                       run_ksoftirqd+0x26/0x50
[   29.537390]                       smpboot_thread_fn+0x30f/0x740
[   29.540094]                       kthread+0x357/0x420
[   29.542468]                       ret_from_fork+0x22/0x30
[   29.544957]     IN-SOFTIRQ-R at:
[   29.546487]                       lock_acquire+0x17f/0x7e0
[   29.549003]                       _raw_read_lock+0x38/0x70
[   29.551577]                       led_trigger_event+0x2b/0xb0
[   29.554257]                       kbd_propagate_led_state+0x5d/0x80
[   29.557200]                       kbd_bh+0x14d/0x1d0
[   29.559497]                       tasklet_action_common.isra.13+0x23a/0x2e0
[   29.562705]                       __do_softirq+0x1ce/0x828
[   29.565315]                       run_ksoftirqd+0x26/0x50
[   29.567798]                       smpboot_thread_fn+0x30f/0x740
[   29.570543]                       kthread+0x357/0x420
[   29.572867]                       ret_from_fork+0x22/0x30
[   29.575428]     SOFTIRQ-ON-R at:
[   29.576915]                       lock_acquire+0x17f/0x7e0
[   29.579460]                       _raw_read_lock+0x5d/0x70
[   29.581954]                       led_trigger_event+0x2b/0xb0
[   29.584621]                       kbd_propagate_led_state+0x5d/0x80
[   29.587551]                       kbd_start+0xd2/0xf0
[   29.589901]                       input_register_handle+0x282/0x4f0
[   29.592811]                       kbd_connect+0xc0/0x120
[   29.595347]                       input_attach_handler+0x10a/0x170
[   29.598212]                       input_register_device.cold.22+0xac/0x29d
[   29.601390]                       atkbd_connect+0x58f/0x810
[   29.603950]                       serio_connect_driver+0x4a/0x70
[   29.606791]                       really_probe+0x222/0xb20
[   29.609369]                       driver_probe_device+0x1f6/0x380
[   29.612193]                       device_driver_attach+0xea/0x120
[   29.615002]                       __driver_attach+0xf5/0x270
[   29.617660]                       bus_for_each_dev+0x11c/0x1b0
[   29.620370]                       serio_handle_event+0x1df/0x7f0
[   29.623129]                       process_one_work+0x842/0x1410
[   29.625874]                       worker_thread+0x87/0xb40
[   29.628428]                       kthread+0x357/0x420
[   29.630740]                       ret_from_fork+0x22/0x30
[   29.633256]     INITIAL USE at:
[   29.634723]                      lock_acquire+0x17f/0x7e0
[   29.637236]                      _raw_write_lock_irqsave+0x35/0x50
[   29.640049]                      led_trigger_set+0x44b/0xb70
[   29.642692]                      led_trigger_set_default+0x163/0x200
[   29.645672]                      led_classdev_register_ext+0x482/0x670
[   29.648689]                      input_leds_connect+0x375/0x620
[   29.651449]                      input_attach_handler+0x10a/0x170
[   29.654293]                      input_register_device.cold.22+0xac/0x29d
[   29.657468]                      atkbd_connect+0x58f/0x810
[   29.659979]                      serio_connect_driver+0x4a/0x70
[   29.662731]                      really_probe+0x222/0xb20
[   29.665297]                      driver_probe_device+0x1f6/0x380
[   29.668039]                      device_driver_attach+0xea/0x120
[   29.670817]                      __driver_attach+0xf5/0x270
[   29.673510]                      bus_for_each_dev+0x11c/0x1b0
[   29.676237]                      serio_handle_event+0x1df/0x7f0
[   29.678962]                      process_one_work+0x842/0x1410
[   29.681676]                      worker_thread+0x87/0xb40
[   29.684198]                      kthread+0x357/0x420
[   29.686523]                      ret_from_fork+0x22/0x30
[   29.688958]   }
[   29.689836]   ... key      at: [<ffffffffbea9c780>] __key.33862+0x0/0x40
[   29.692932]   ... acquired at:
[   29.694395]    lock_acquire+0x17f/0x7e0
[   29.696221]    _raw_read_lock+0x5d/0x70
[   29.697972]    led_trigger_blink_oneshot+0x39/0xd0
[   29.700232]    ledtrig_disk_activity+0x77/0xf0
[   29.702322]    ata_qc_complete+0x63/0xd70 [libata]
[   29.704542]    ata_do_link_abort+0x1ae/0x340 [libata]
[   29.706909]    ata_sff_hsm_move+0x55f/0x1a30 [libata]
[   29.709298]    ata_sff_pio_task+0x397/0x4a0 [libata]
[   29.711582]    process_one_work+0x842/0x1410
[   29.713567]    worker_thread+0x87/0xb40
[   29.715392]    kthread+0x357/0x420
[   29.716945]    ret_from_fork+0x22/0x30

[   29.719446] -> (&host->lock){-...}-{2:2} {
[   29.721368]    IN-HARDIRQ-W at:
[   29.722817]                     lock_acquire+0x17f/0x7e0
[   29.725316]                     _raw_spin_lock_irqsave+0x35/0x50
[   29.728053]                     ata_bmdma_interrupt+0x1e/0x530 [libata]
[   29.731122]                     __handle_irq_event_percpu+0xeb/0x5f0
[   29.734033]                     handle_irq_event_percpu+0x73/0x140
[   29.736929]                     handle_irq_event+0xa1/0x130
[   29.739532]                     handle_edge_irq+0x1ee/0x770
[   29.742097]                     asm_call_irq_on_stack+0x12/0x20
[   29.744885]                     common_interrupt+0xe2/0x180
[   29.747514]                     asm_common_interrupt+0x1e/0x40
[   29.750208]                     default_idle+0x18/0x20
[   29.752579]                     default_idle_call+0xa0/0x370
[   29.755225]                     do_idle+0x3c1/0x570
[   29.757515]                     cpu_startup_entry+0x19/0x20
[   29.760094]                     start_secondary+0x250/0x2f0
[   29.762690]                     secondary_startup_64_no_verify+0xb8/0xbb
[   29.765805]    INITIAL USE at:
[   29.767270]                    lock_acquire+0x17f/0x7e0
[   29.769671]                    _raw_spin_lock_irqsave+0x35/0x50
[   29.772429]                    ata_dev_init+0x195/0x3c0 [libata]
[   29.775241]                    ata_link_init+0x19f/0x300 [libata]
[   29.778018]                    ata_port_alloc+0x498/0x580 [libata]
[   29.780885]                    ata_host_alloc+0x1c4/0x250 [libata]
[   29.783751]                    ata_host_alloc_pinfo+0x1d/0x540 [libata]
[   29.786840]                    ata_pci_sff_prepare_host+0x3c/0xb0 [libata]
[   29.790017]                    ata_pci_bmdma_prepare_host+0x12/0x60 [libata]
[   29.793318]                    piix_init_one+0x3f3/0xb62 [ata_piix]
[   29.796259]                    local_pci_probe+0xd8/0x170
[   29.798752]                    pci_device_probe+0x322/0x600
[   29.801363]                    really_probe+0x222/0xb20
[   29.803767]                    driver_probe_device+0x1f6/0x380
[   29.806511]                    device_driver_attach+0xea/0x120
[   29.809223]                    __driver_attach+0xf5/0x270
[   29.811716]                    bus_for_each_dev+0x11c/0x1b0
[   29.814320]                    bus_add_driver+0x39e/0x560
[   29.816821]                    driver_register+0x18e/0x310
[   29.819389]                    piix_init+0x1f/0x1000 [ata_piix]
[   29.822116]                    do_one_initcall+0xbb/0x3e0
[   29.824649]                    do_init_module+0x1f2/0x760
[   29.827156]                    load_module+0x5846/0x6e80
[   29.829595]                    __do_sys_finit_module+0x11a/0x1b0
[   29.832371]                    do_syscall_64+0x33/0x40
[   29.834714]                    entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   29.837755]  }
[   29.838569]  ... key      at: [<ffffffffc0552600>] __key.69338+0x0/0xfffffffffffbfa00 [libata]
[   29.842534]  ... acquired at:
[   29.843920]    __lock_acquire+0x14ec/0x3ac0
[   29.845895]    lock_acquire+0x17f/0x7e0
[   29.847707]    _raw_spin_lock_irqsave+0x35/0x50
[   29.849831]    ata_bmdma_interrupt+0x1e/0x530 [libata]
[   29.852253]    __handle_irq_event_percpu+0xeb/0x5f0
[   29.854480]    handle_irq_event_percpu+0x73/0x140
[   29.856678]    handle_irq_event+0xa1/0x130
[   29.858581]    handle_edge_irq+0x1ee/0x770
[   29.860507]    asm_call_irq_on_stack+0x12/0x20
[   29.862570]    common_interrupt+0xe2/0x180
[   29.864484]    asm_common_interrupt+0x1e/0x40
[   29.866517]    default_idle+0x18/0x20
[   29.868232]    default_idle_call+0xa0/0x370
[   29.870172]    do_idle+0x3c1/0x570
[   29.871747]    cpu_startup_entry+0x19/0x20
[   29.873655]    start_secondary+0x250/0x2f0
[   29.875580]    secondary_startup_64_no_verify+0xb8/0xbb

[   29.878701] 
               stack backtrace:
[   29.880737] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.9.0-rc7-next-20201002+ #5
[   29.884206] Hardware name: Red Hat KVM, BIOS 1.14.0-1.module+el8.3.0+7638+07cf13d2 04/01/2014
[   29.888111] Call Trace:
[   29.889288]  <IRQ>
[   29.890254]  dump_stack+0x99/0xcb
[   29.891778]  mark_lock.part.48+0x131c/0x1be0
[   29.893756]  ? print_usage_bug+0x1f0/0x1f0
[   29.895678]  ? print_usage_bug+0x1f0/0x1f0
[   29.897582]  ? mark_lock.part.48+0x105/0x1be0
[   29.899595]  ? mark_lock.part.48+0x105/0x1be0
[   29.901607]  ? print_usage_bug+0x1f0/0x1f0
[   29.903517]  __lock_acquire+0x14ec/0x3ac0
[   29.905399]  ? __bpf_trace_lock+0xf0/0xf0
[   29.907257]  ? lockdep_hardirqs_on_prepare+0x4d0/0x4d0
[   29.909614]  ? rcu_read_lock_sched_held+0xa1/0xd0
[   29.911775]  lock_acquire+0x17f/0x7e0
[   29.913499]  ? ata_bmdma_interrupt+0x1e/0x530 [libata]
[   29.915868]  ? rcu_read_unlock+0x40/0x40
[   29.917690]  ? __lock_acquire+0x1864/0x3ac0
[   29.919637]  _raw_spin_lock_irqsave+0x35/0x50
[   29.921657]  ? ata_bmdma_interrupt+0x1e/0x530 [libata]
[   29.924010]  ? ata_bmdma_port_intr+0x320/0x320 [libata]
[   29.926469]  ata_bmdma_interrupt+0x1e/0x530 [libata]
[   29.928744]  ? rcu_read_lock_bh_held+0xb0/0xb0
[   29.930795]  ? find_held_lock+0x33/0x1c0
[   29.932625]  ? ata_bmdma_port_intr+0x320/0x320 [libata]
[   29.935034]  __handle_irq_event_percpu+0xeb/0x5f0
[   29.937254]  handle_irq_event_percpu+0x73/0x140
[   29.939369]  ? __handle_irq_event_percpu+0x5f0/0x5f0
[   29.941659]  ? rwlock_bug.part.1+0x90/0x90
[   29.943568]  ? do_raw_spin_unlock+0x14b/0x230
[   29.945613]  handle_irq_event+0xa1/0x130
[   29.947466]  handle_edge_irq+0x1ee/0x770
[   29.949301]  asm_call_irq_on_stack+0x12/0x20
[   29.951291]  </IRQ>
[   29.952297]  common_interrupt+0xe2/0x180
[   29.954103]  asm_common_interrupt+0x1e/0x40
[   29.956072] RIP: 0010:default_idle+0x18/0x20
[   29.958068] Code: 5d e9 7c 52 35 ff cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 e8 c6 a4 69 fe e9 07 00 00 00 0f 00 2d 0a 2a 5a 00 fb f4 <c3> 0f 1f 80 00 00 00 00 0f 1f 44 00 00 53 be 08 00 00 00 65 48 8b
[   29.966729] RSP: 0018:ffff8881068d7df8 EFLAGS: 00000202
[   29.969173] RAX: 000000000001235b RBX: 0000000000000006 RCX: ffffffffbac561f0
[   29.972467] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffbac7bf0a
[   29.975767] RBP: 0000000000000006 R08: 0000000000000001 R09: 0000000000000001
[   29.979051] R10: ffff888a7eb3606b R11: ffffed114fd66c0d R12: ffffffffbc5718a0
[   29.982377] R13: 0000000000000000 R14: 1ffff11020d1afc6 R15: 0000000000000000
[   29.985667]  ? rcu_eqs_enter.constprop.74+0xa0/0xc0
[   29.987913]  ? default_idle+0xa/0x20
[   29.989593]  ? default_idle+0xa/0x20
[   29.991282]  default_idle_call+0xa0/0x370
[   29.993228]  do_idle+0x3c1/0x570
[   29.994740]  ? arch_cpu_idle_exit+0x40/0x40
[   29.996670]  ? lockdep_hardirqs_on_prepare+0x32b/0x4d0
[   29.999021]  ? _raw_spin_unlock_irqrestore+0x39/0x40
[   30.001355]  cpu_startup_entry+0x19/0x20
[   30.003178]  start_secondary+0x250/0x2f0
[   30.004986]  ? set_cpu_sibling_map+0x2430/0x2430
[   30.007155]  ? start_cpu0+0xc/0xc
[   30.008700]  secondary_startup_64_no_verify+0xb8/0xbb


