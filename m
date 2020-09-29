Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486E227D134
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgI2OdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbgI2OdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:33:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601389998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1dXwN/gQHjgpimFQFyfQlWV9Z1paasODx41KPbBDDvg=;
        b=DTq/TvFZYDHd0X8hNpBl33c016PZx8WVkBRviw1iNIyU4XAwT4I2tNp86ZHrX5YnqkBik+
        Goqu80Z1PSCvkFRnTlwPsRwvQ49BvcucVMs0CZU9BZEFD5+/K/kx5kter86NsgX3ZMbdfs
        1yYPK2WmTGzEIQr6PpOL2/noQOCQ1nI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-e66tAtY_PpK9JY02i0jX-g-1; Tue, 29 Sep 2020 10:33:15 -0400
X-MC-Unique: e66tAtY_PpK9JY02i0jX-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08372905BB3;
        Tue, 29 Sep 2020 14:31:59 +0000 (UTC)
Received: from ovpn-66-32.rdu2.redhat.com (ovpn-66-32.rdu2.redhat.com [10.10.66.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDF5772FC4;
        Tue, 29 Sep 2020 14:31:57 +0000 (UTC)
Message-ID: <5fd046115645daa00f8841f5467da4c4d960ca92.camel@redhat.com>
Subject: lockdep null-ptr-deref
From:   Qian Cai <cai@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Date:   Tue, 29 Sep 2020 10:31:56 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to add a few new Kconfig options like LEDS_TRIGGERS instantly trigger a
warning during the boot, and then there is null-ptr-deref in lockdep below. Any
idea?

[   16.487309] WARNING: possible irq lock inversion dependency detected
[   16.488313] 5.9.0-rc7-next-20200928+ #9 Not tainted
[   16.488936] --------------------------------------------------------
[   16.489767] swapper/6/0 just changed the state of lock:
[   16.490449] ffff8889eea6f418 (&host->lock){-...}-{2:2}, at: ata_bmdma_interrupt+0x1e/0x530 [libata]
__ata_sff_interrupt at /home/linux-mm/linux-next/drivers/ata/libata-sff.c:1534
(inlined by) ata_bmdma_interrupt at /home/linux-mm/linux-next/drivers/ata/libata-sff.c:2832
[   16.491639] but this lock took another, HARDIRQ-READ-unsafe lock in the past:
[   16.492561]  (&trig->leddev_list_lock){.+.?}-{2:2}
[   16.492565] 
[   16.492565] 
[   16.492565] and interrupts could create inverse lock ordering between them.
[   16.492565] 
[   16.494635] 
[   16.494635] other info that might help us debug this:
[   16.495479]  Possible interrupt unsafe locking scenario:
[   16.495479] 
[   16.496360]        CPU0                    CPU1
[   16.496941]        ----                    ----
[   16.497542]   lock(&trig->leddev_list_lock);
[   16.498095]                                local_irq_disable();
[   16.498864]                                lock(&host->lock);
[   16.499611]                                lock(&trig->leddev_list_lock);
[   16.500481]   <Interrupt>
[   16.500833]     lock(&host->lock);
[   16.501289] 
[   16.501289]  *** DEADLOCK ***
[   16.501289] 
[   16.502044] no locks held by swapper/6/0.
[   16.502566] 
[   16.502566] the shortest dependencies between 2nd lock and 1st lock:
[   16.503578]  -> (&trig->leddev_list_lock){.+.?}-{2:2} {
[   16.504259]     HARDIRQ-ON-R at:
[   16.504692]                       lock_acquire+0x17f/0x7e0
[   16.505411]                       _raw_read_lock+0x38/0x70
[   16.506120]                       led_trigger_event+0x2b/0xb0
led_trigger_event at drivers/leds/led-triggers.c:386
(inlined by) led_trigger_event at drivers/leds/led-triggers.c:377
[   16.506868]                       kbd_propagate_led_state+0x5d/0x80
[   16.507680]                       kbd_bh+0x14d/0x1d0
[   16.508335]                       tasklet_action_common.isra.13+0x23a/0x2e0
[   16.509235]                       __do_softirq+0x1ce/0x828
[   16.509940]                       run_ksoftirqd+0x26/0x50
[   16.510647]                       smpboot_thread_fn+0x30f/0x740
[   16.511413]                       kthread+0x357/0x420
[   16.512068]                       ret_from_fork+0x22/0x30
[   16.512762]     IN-SOFTIRQ-R at:
[   16.513187]                       lock_acquire+0x17f/0x7e0
[   16.513891]                       _raw_read_lock+0x38/0x70
[   16.514602]                       led_trigger_event+0x2b/0xb0
[   16.515356]                       kbd_propagate_led_state+0x5d/0x80
[   16.516165]                       kbd_bh+0x14d/0x1d0
[   16.516810]                       tasklet_action_common.isra.13+0x23a/0x2e0
[   16.517701]                       __do_softirq+0x1ce/0x828
[   16.518418]                       run_ksoftirqd+0x26/0x50
[   16.519119]                       smpboot_thread_fn+0x30f/0x740
[   16.519874]                       kthread+0x357/0x420
[   16.520460] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[   16.520528]                       ret_from_fork+0x22/0x30
[   16.520531]     SOFTIRQ-ON-R at:
[   16.522704]                       lock_acquire+0x17f/0x7e0
[   16.523423]                       _raw_read_lock+0x5d/0x70
[   16.524124]                       led_trigger_event+0x2b/0xb0
[   16.524865]                       kbd_propagate_led_state+0x5d/0x80
[   16.525671]                       kbd_start+0xd2/0xf0
[   16.526332]                       input_register_handle+0x282/0x4f0
[   16.527142]                       kbd_connect+0xc0/0x120
[   16.527826]                       input_attach_handler+0x10a/0x170
[   16.528758]                       input_register_device.cold.22+0xac/0x29d
[   16.529651]                       atkbd_connect+0x58f/0x810
[   16.530374]                       serio_connect_driver+0x4a/0x70
[   16.531144]                       really_probe+0x222/0xb20
[   16.531861]                       driver_probe_device+0x1f6/0x380
[   16.532650]                       device_driver_attach+0xea/0x120
[   16.533441]                       __driver_attach+0xf5/0x270
[   16.534172]                       bus_for_each_dev+0x11c/0x1b0
[   16.534924]                       serio_handle_event+0x1df/0x7f0
[   16.535701]                       process_one_work+0x842/0x1410
[   16.536470]                       worker_thread+0x87/0xb40
[   16.537178]                       kthread+0x357/0x420
[   16.537828]                       ret_from_fork+0x22/0x30
[   16.538674]     INITIAL USE at:
[   16.539220]                      lock_acquire+0x17f/0x7e0
[   16.540116]                      _raw_read_lock+0x38/0x70
[   16.540999]                      led_trigger_event+0x2b/0xb0
[   16.541923]                      kbd_propagate_led_state+0x5d/0x80
[   16.542879]                      kbd_bh+0x14d/0x1d0
[   16.543538]                      tasklet_action_common.isra.13+0x23a/0x2e0
[   16.544427]                      __do_softirq+0x1ce/0x828
[   16.545117]                      run_ksoftirqd+0x26/0x50
[   16.545807]                      smpboot_thread_fn+0x30f/0x740
[   16.546566]                      kthread+0x357/0x420
[   16.547227]                      ret_from_fork+0x22/0x30
[   16.547899]     (null) at:
[   16.548298] general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN PTI
[   16.549666] KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
[   16.550644] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.9.0-rc7-next-20200928+ #9
[   16.551615] Hardware name: Red Hat KVM, BIOS 1.14.0-1.module+el8.3.0+7638+07cf13d2 04/01/2014
[   16.552722] RIP: 0010:print_shortest_lock_dependencies.cold.65+0x10b/0x2a4
print_shortest_lock_dependencies.cold.65+0x10b/0x2a4:
print_lock_trace at kernel/locking/lockdep.c:1751
(inlined by) print_lock_class_header at kernel/locking/lockdep.c:2240
(inlined by) print_shortest_lock_dependencies at kernel/locking/lockdep.c:2263
[   16.553613] Code: 41 01 c6 4c 89 e8 48 c1 e8 03 45 01 fe 80 3c 18 00 74 08 4c 89 ef e8 db e2 ac fe 49 8b 45 00 48 8d 78 14 48 89 fa 48 c1 ea 03 <0f> b6 0c 1a 48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 82
[   16.555983] RSP: 0018:ffff888a7eb09988 EFLAGS: 00010003
[   16.556658] RAX: 0000000000000001 RBX: dffffc0000000000 RCX: 0000000000000027
[   16.557571] RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000015
[   16.558499] RBP: ffffffffb3dd5888 R08: ffffed114fd640c2 R09: ffffed114fd640c2
[   16.559420] R10: ffff888a7eb2060b R11: ffffed114fd640c1 R12: 0000000000000009
[   16.560329] R13: ffffffffb3dd5928 R14: 000000000000000f R15: 0000000000000001
[   16.561237] FS:  0000000000000000(0000) GS:ffff888a7eb00000(0000) knlGS:0000000000000000
[   16.562264] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.562989] CR2: 00007fdc00f597a0 CR3: 000000091f02e006 CR4: 0000000000770ee0
[   16.563909] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   16.564818] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   16.565728] PKRU: 55555554
[   16.566080] Call Trace:
[   16.566410]  <IRQ>
[   16.566679]  print_irq_inversion_bug.cold.66+0x31b/0x36e
print_irq_inversion_bug at kernel/locking/lockdep.c:3771
(inlined by) print_irq_inversion_bug at kernel/locking/lockdep.c:3716
[   16.567369]  mark_lock.part.49+0x116a/0x1900
[   16.567915]  ? print_usage_bug+0x1f0/0x1f0
[   16.568456]  ? __lock_acquire+0xc66/0x3ac0
[   16.568983]  ? print_usage_bug+0x1f0/0x1f0
[   16.569521]  ? mark_lock.part.49+0x107/0x1900
[   16.570085]  __lock_acquire+0x14ec/0x3ac0
[   16.570610]  ? static_obj+0xb0/0xc0
[   16.571064]  ? lockdep_hardirqs_on_prepare+0x4d0/0x4d0
[   16.571731]  ? rcu_read_lock_sched_held+0xa1/0xd0
[   16.572347]  lock_acquire+0x17f/0x7e0
[   16.572825]  ? ata_bmdma_interrupt+0x1e/0x530 [libata]
[   16.573494]  ? rcu_read_unlock+0x40/0x40
[   16.573994]  ? __lock_acquire+0x1864/0x3ac0
[   16.574543]  _raw_spin_lock_irqsave+0x35/0x50
[   16.575111]  ? ata_bmdma_interrupt+0x1e/0x530 [libata]
[   16.575779]  ? ata_bmdma_port_intr+0x320/0x320 [libata]
[   16.576460]  ata_bmdma_interrupt+0x1e/0x530 [libata]
[   16.577092]  ? rcu_read_lock_bh_held+0xb0/0xb0
[   16.577676]  ? find_held_lock+0x33/0x1c0
[   16.578205]  ? ata_bmdma_port_intr+0x320/0x320 [libata]
[   16.578875]  __handle_irq_event_percpu+0xeb/0x5f0
[   16.579491]  handle_irq_event_percpu+0x73/0x140
[   16.580072]  ? __handle_irq_event_percpu+0x5f0/0x5f0
[   16.580714]  ? rwlock_bug.part.1+0x90/0x90
[   16.581251]  ? do_raw_spin_unlock+0x14b/0x230
[   16.581805]  handle_irq_event+0xa1/0x130
[   16.582324]  handle_edge_irq+0x1ee/0x770
[   16.582841]  asm_call_irq_on_stack+0x12/0x20
[   16.583416]  </IRQ>
[   16.583699]  common_interrupt+0xe2/0x180
[   16.584225]  asm_common_interrupt+0x1e/0x40
[   16.584760] RIP: 0010:default_idle+0x18/0x20
[   16.585323] Code: 5d e9 bc cd 35 ff cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 e8 96 07 6b fe e9 07 00 00 00 0f 00 2d 4a 98 5b 00 fb f4 <c3> 0f 1f 80 00 00 00 00 0f 1f 44 00 00 53 be 08 00 00 00 65 4b
[   16.587687] RSP: 0018:ffff888107317df8 EFLAGS: 00000202
[   16.588378] RAX: 0000000000008ca1 RBX: 0000000000000006 RCX: ffffffffb143f2e0
[   16.589297] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffb1464e4a
[   16.590207] RBP: 0000000000000006 R08: 0000000000000001 R09: 0000000000000001
[   16.591109] R10: ffff888a7eb360eb R11: ffffed114fd66c1d R12: ffffffffb2d6fca0
[   16.592012] R13: 0000000000000000 R14: 1ffff11020e62fc6 R15: 0000000000000000
[   16.592931]  ? rcu_eqs_enter.constprop.75+0xa0/0xc0
[   16.593572]  ? default_idle+0xa/0x20
[   16.594034]  ? default_idle+0xa/0x20
[   16.594511]  default_idle_call+0xa0/0x370
[   16.595028]  do_idle+0x3c1/0x570
[   16.595462]  ? arch_cpu_idle_exit+0x40/0x40
[   16.595995]  ? lockdep_hardirqs_on_prepare+0x32b/0x4d0
[   16.596663]  ? _raw_spin_unlock_irqrestore+0x39/0x40
[   16.597306]  cpu_startup_entry+0x19/0x20
[   16.597817]  start_secondary+0x250/0x2f0
[   16.598342]  ? set_cpu_sibling_map+0x2430/0x2430
[   16.598935]  ? start_cpu0+0xc/0xc
[   16.599378]  secondary_startup_64_no_verify+0xb8/0xbb
[   16.600017] Modules linked in: crct10dif_pclmul crc32_pclmul crc32c_intel virtiofs ata_piix ghash_clmulni_intel fuse libata serio_raw e1000(+) sunrpc dm_mirror dm_region_hash dm_log dm_mod
[   16.602209] ---[ end trace f713527030b9fc6e ]---
[   16.602804] RIP: 0010:print_shortest_lock_dependencies.cold.65+0x10b/0x2a4
[   16.603695] Code: 41 01 c6 4c 89 e8 48 c1 e8 03 45 01 fe 80 3c 18 00 74 08 4c 89 ef e8 db e2 ac fe 49 8b 45 00 48 8d 78 14 48 89 fa 48 c1 ea 03 <0f> b6 0c 1a 48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 82
[   16.606060] RSP: 0018:ffff888a7eb09988 EFLAGS: 00010003
[   16.606730] RAX: 0000000000000001 RBX: dffffc0000000000 RCX: 0000000000000027
[   16.607640] RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000015
[   16.608568] RBP: ffffffffb3dd5888 R08: ffffed114fd640c2 R09: ffffed114fd640c2
[   16.609495] R10: ffff888a7eb2060b R11: ffffed114fd640c1 R12: 0000000000000009
[   16.610410] R13: ffffffffb3dd5928 R14: 000000000000000f R15: 0000000000000001
[   16.611322] FS:  0000000000000000(0000) GS:ffff888a7eb00000(0000) knlGS:0000000000000000
[   16.612351] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.613078] CR2: 00007fdc00f597a0 CR3: 000000091f02e006 CR4: 0000000000770ee0
[   16.613980] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   16.614903] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   16.615824] PKRU: 55555554
[   16.616177] Kernel panic - not syncing: Fatal exception in interrupt
[   16.617445] Kernel Offset: 0x2e600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   16.618792] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

