Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B37928E03D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 14:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgJNMCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 08:02:18 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:37364 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgJNMCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:02:18 -0400
Received: by mail-io1-f71.google.com with SMTP id e21so2226729ioe.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 05:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PpanVSG5QtxgDny7I3jFKCGyv0HeDeutlW8J5GIIZ1c=;
        b=HtsOkbkCZtor7QFPvnBDrAPXf1VuD2HwW5t8LLYoSW6n426yDS6MKH0R9g4twhh/xe
         yZyc0sPqqC5C9ym9nPdWxe8OuoxLBC5uTjOwotbR8cPjIGqPIwcR7X98AAX3bc5rMEcp
         i5vdeGmFKk3EvlW0f58wiEtS/ah2F7KN7vzmhbrIRwne58FiNd8vsNVaYHpohyOxk3KR
         XQUhkJI5rI+BnMagVuybvAKCfARtMcfs/7wX/m0d5M2w9xvnLqo9/3a2Ia7+cWtKEMad
         p7IXxxa7w7npxpX7hLQZg/xAb3IZhmJ33CkMLgIwnYKOXkIOOOxTSVgWruKxH8dF/VtY
         AOSA==
X-Gm-Message-State: AOAM530seldC3EphvxaQCh005nzSRBGXGwU4PUuSEockTY/MAdKMwpVX
        OzKEibs6O9w0oixd4v2WmjeLbI1QxcWeQNQqePtFhE2o3oJR
X-Google-Smtp-Source: ABdhPJz924CB3e7OMG+B2tRssSKyjo4uJeq/05wULilZx+OJLSnePKSrqNhpRQg6GjleKxKiB4y5W6oLHNAYGzx3DIVudRtTB/9V
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:101:: with SMTP id t1mr3134383ilm.12.1602676936921;
 Wed, 14 Oct 2020 05:02:16 -0700 (PDT)
Date:   Wed, 14 Oct 2020 05:02:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083d80105b1a04db2@google.com>
Subject: possible deadlock in snd_pcm_period_elapsed
From:   syzbot <syzbot+9e4ce89a893162de3148@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, arnd@arndb.de, baolin.wang@linaro.org,
        linux-kernel@vger.kernel.org, paulhsia@chromium.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    029f56db Merge tag 'x86_asm_for_v5.10' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1366d607900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5327fbeef7650a
dashboard link: https://syzkaller.appspot.com/bug?extid=9e4ce89a893162de3148
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9e4ce89a893162de3148@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
5.9.0-syzkaller #0 Not tainted
--------------------------------------------------------
swapper/0/0 just changed the state of lock:
ffff88809a617108 (&group->lock){..-.}-{2:2}, at: snd_pcm_period_elapsed+0x2c/0x210 sound/core/pcm_lib.c:1799
but this lock took another, SOFTIRQ-READ-unsafe lock in the past:
 (&card->ctl_files_rwlock){.+.+}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&card->ctl_files_rwlock);
                               local_irq_disable();
                               lock(&group->lock);
                               lock(&card->ctl_files_rwlock);
  <Interrupt>
    lock(&group->lock);

 *** DEADLOCK ***

1 lock held by swapper/0/0:
 #0: ffffc90000007db0 ((&dpcm->timer)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:45 [inline]
 #0: ffffc90000007db0 ((&dpcm->timer)){+.-.}-{0:0}, at: call_timer_fn+0x57/0x160 kernel/time/timer.c:1405

the shortest dependencies between 2nd lock and 1st lock:
 -> (&card->ctl_files_rwlock){.+.+}-{2:2} {
    HARDIRQ-ON-R at:
                      lock_acquire+0x160/0x710 kernel/locking/lockdep.c:5442
                      __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                      _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:223
                      snd_ctl_notify+0x86/0x550 sound/core/control.c:153
                      __snd_ctl_add_replace+0x582/0x8a0 sound/core/control.c:382
                      snd_ctl_add_replace sound/core/control.c:399 [inline]
                      snd_ctl_add+0x6e/0x110 sound/core/control.c:426
                      snd_card_dummy_new_mixer sound/drivers/dummy.c:885 [inline]
                      snd_dummy_probe+0xb9e/0x1000 sound/drivers/dummy.c:1080
                      platform_drv_probe+0xcd/0x150 drivers/base/platform.c:747
                      really_probe+0x753/0x1110 drivers/base/dd.c:557
                      driver_probe_device+0x106/0x1a0 drivers/base/dd.c:738
                      bus_for_each_drv+0x108/0x170 drivers/base/bus.c:431
                      __device_attach+0x262/0x3f0 drivers/base/dd.c:912
                      bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:491
                      device_add+0x1630/0x19b0 drivers/base/core.c:2926
                      platform_device_add+0x4ad/0x6e0 drivers/base/platform.c:597
                      platform_device_register_full+0x448/0x530 drivers/base/platform.c:720
                      platform_device_register_resndata include/linux/platform_device.h:131 [inline]
                      platform_device_register_simple include/linux/platform_device.h:160 [inline]
                      alsa_card_dummy_init+0x1b3/0x398 sound/drivers/dummy.c:1168
                      do_one_initcall+0x14b/0x350 init/main.c:1205
                      do_initcall_level+0x101/0x14c init/main.c:1278
                      do_initcalls+0x59/0x9b init/main.c:1294
                      kernel_init_freeable+0x356/0x474 init/main.c:1514
                      kernel_init+0xd/0x290 init/main.c:1403
                      ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
    SOFTIRQ-ON-R at:
                      lock_acquire+0x160/0x710 kernel/locking/lockdep.c:5442
                      __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                      _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:223
                      snd_ctl_notify+0x86/0x550 sound/core/control.c:153
                      __snd_ctl_add_replace+0x582/0x8a0 sound/core/control.c:382
                      snd_ctl_add_replace sound/core/control.c:399 [inline]
                      snd_ctl_add+0x6e/0x110 sound/core/control.c:426
                      snd_card_dummy_new_mixer sound/drivers/dummy.c:885 [inline]
                      snd_dummy_probe+0xb9e/0x1000 sound/drivers/dummy.c:1080
                      platform_drv_probe+0xcd/0x150 drivers/base/platform.c:747
                      really_probe+0x753/0x1110 drivers/base/dd.c:557
                      driver_probe_device+0x106/0x1a0 drivers/base/dd.c:738
                      bus_for_each_drv+0x108/0x170 drivers/base/bus.c:431
                      __device_attach+0x262/0x3f0 drivers/base/dd.c:912
                      bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:491
                      device_add+0x1630/0x19b0 drivers/base/core.c:2926
                      platform_device_add+0x4ad/0x6e0 drivers/base/platform.c:597
                      platform_device_register_full+0x448/0x530 drivers/base/platform.c:720
                      platform_device_register_resndata include/linux/platform_device.h:131 [inline]
                      platform_device_register_simple include/linux/platform_device.h:160 [inline]
                      alsa_card_dummy_init+0x1b3/0x398 sound/drivers/dummy.c:1168
                      do_one_initcall+0x14b/0x350 init/main.c:1205
                      do_initcall_level+0x101/0x14c init/main.c:1278
                      do_initcalls+0x59/0x9b init/main.c:1294
                      kernel_init_freeable+0x356/0x474 init/main.c:1514
                      kernel_init+0xd/0x290 init/main.c:1403
                      ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
    INITIAL READ USE at:
                          lock_acquire+0x160/0x710 kernel/locking/lockdep.c:5442
                          __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                          _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:223
                          snd_ctl_notify+0x86/0x550 sound/core/control.c:153
                          __snd_ctl_add_replace+0x582/0x8a0 sound/core/control.c:382
                          snd_ctl_add_replace sound/core/control.c:399 [inline]
                          snd_ctl_add+0x6e/0x110 sound/core/control.c:426
                          snd_card_dummy_new_mixer sound/drivers/dummy.c:885 [inline]
                          snd_dummy_probe+0xb9e/0x1000 sound/drivers/dummy.c:1080
                          platform_drv_probe+0xcd/0x150 drivers/base/platform.c:747
                          really_probe+0x753/0x1110 drivers/base/dd.c:557
                          driver_probe_device+0x106/0x1a0 drivers/base/dd.c:738
                          bus_for_each_drv+0x108/0x170 drivers/base/bus.c:431
                          __device_attach+0x262/0x3f0 drivers/base/dd.c:912
                          bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:491
                          device_add+0x1630/0x19b0 drivers/base/core.c:2926
                          platform_device_add+0x4ad/0x6e0 drivers/base/platform.c:597
                          platform_device_register_full+0x448/0x530 drivers/base/platform.c:720
                          platform_device_register_resndata include/linux/platform_device.h:131 [inline]
                          platform_device_register_simple include/linux/platform_device.h:160 [inline]
                          alsa_card_dummy_init+0x1b3/0x398 sound/drivers/dummy.c:1168
                          do_one_initcall+0x14b/0x350 init/main.c:1205
                          do_initcall_level+0x101/0x14c init/main.c:1278
                          do_initcalls+0x59/0x9b init/main.c:1294
                          kernel_init_freeable+0x356/0x474 init/main.c:1514
                          kernel_init+0xd/0x290 init/main.c:1403
                          ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
  }
  ... key      at: [<ffffffff8c877e10>] snd_card_new.__key.3+0x0/0x10
  ... acquired at:
   lock_acquire+0x160/0x710 kernel/locking/lockdep.c:5442
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:223
   snd_ctl_notify+0x86/0x550 sound/core/control.c:153
   loopback_check_format sound/drivers/aloop.c:358 [inline]
   loopback_trigger+0xc40/0x1500 sound/drivers/aloop.c:387
   snd_pcm_do_start sound/core/pcm_native.c:1350 [inline]
   snd_pcm_action_single sound/core/pcm_native.c:1207 [inline]
   snd_pcm_action sound/core/pcm_native.c:1290 [inline]
   snd_pcm_start+0x471/0x6c0 sound/core/pcm_native.c:1391
   __snd_pcm_lib_xfer+0xf73/0x1320 sound/core/pcm_lib.c:2247
   snd_pcm_oss_write3+0x209/0x330 sound/core/oss/pcm_oss.c:1221
   snd_pcm_plug_write_transfer+0x28b/0x490 sound/core/oss/pcm_plugin.c:624
   snd_pcm_oss_write2+0x156/0x370 sound/core/oss/pcm_oss.c:1353
   snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1419 [inline]
   snd_pcm_oss_write+0x911/0xd70 sound/core/oss/pcm_oss.c:2765
   vfs_write+0x2dd/0xd20 fs/read_write.c:584
   ksys_write+0x11b/0x220 fs/read_write.c:639
   do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> (&group->lock){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire+0x160/0x710 kernel/locking/lockdep.c:5442
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xaa/0xd0 kernel/locking/spinlock.c:159
                    snd_pcm_period_elapsed+0x2c/0x210 sound/core/pcm_lib.c:1799
                    call_timer_fn+0x91/0x160 kernel/time/timer.c:1415
                    expire_timers kernel/time/timer.c:1460 [inline]
                    __run_timers+0x65e/0x830 kernel/time/timer.c:1757
                    run_timer_softirq+0x46/0x80 kernel/time/timer.c:1770
                    __do_softirq+0x256/0x6e0 kernel/softirq.c:298
                    asm_call_irq_on_stack+0xf/0x20
                    __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
                    run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
                    do_softirq_own_stack+0x9a/0xf0 arch/x86/kernel/irq_64.c:77
                    invoke_softirq kernel/softirq.c:393 [inline]
                    __irq_exit_rcu+0x21f/0x230 kernel/softirq.c:423
                    irq_exit_rcu+0x5/0x20 kernel/softirq.c:435
                    sysvec_apic_timer_interrupt+0xe0/0xf0 arch/x86/kernel/apic/apic.c:1091
                    asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
                    native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:60
                    arch_safe_halt arch/x86/include/asm/paravirt.h:150 [inline]
                    acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
                    acpi_idle_do_entry+0xde/0x2d0 drivers/acpi/processor_idle.c:517
                    acpi_idle_enter+0x2fa/0x440 drivers/acpi/processor_idle.c:648
                    cpuidle_enter_state+0x38a/0x980 drivers/cpuidle/cpuidle.c:237
                    cpuidle_enter+0x59/0x90 drivers/cpuidle/cpuidle.c:350
                    call_cpuidle kernel/sched/idle.c:132 [inline]
                    cpuidle_idle_call kernel/sched/idle.c:213 [inline]
                    do_idle+0x4a7/0x650 kernel/sched/idle.c:273
                    cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:369
                    start_kernel+0x4b0/0x57c init/main.c:1049
                    secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
   INITIAL USE at:
                   lock_acquire+0x160/0x710 kernel/locking/lockdep.c:5442
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                   _raw_spin_lock_irq+0xa6/0xc0 kernel/locking/spinlock.c:167
                   spin_lock_irq include/linux/spinlock.h:379 [inline]
                   snd_pcm_group_lock_irq sound/core/pcm_native.c:97 [inline]
                   snd_pcm_stream_lock_irq sound/core/pcm_native.c:136 [inline]
                   snd_pcm_hw_params+0xca/0x16b0 sound/core/pcm_native.c:672
                   snd_pcm_oss_change_params_locked+0x25e0/0x4410 sound/core/oss/pcm_oss.c:941
                   snd_pcm_oss_make_ready_locked sound/core/oss/pcm_oss.c:1166 [inline]
                   snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1384 [inline]
                   snd_pcm_oss_write+0x269/0xd70 sound/core/oss/pcm_oss.c:2765
                   vfs_write+0x2dd/0xd20 fs/read_write.c:584
                   ksys_write+0x11b/0x220 fs/read_write.c:639
                   do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
                   entry_SYSCALL_64_after_hwframe+0x44/0xa9
 }
 ... key      at: [<ffffffff8c8794a8>] snd_pcm_group_init.__key+0x0/0x10
 ... acquired at:
   mark_usage kernel/locking/lockdep.c:4305 [inline]
   __lock_acquire+0xa67/0x2bd0 kernel/locking/lockdep.c:4791
   lock_acquire+0x160/0x710 kernel/locking/lockdep.c:5442
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0xaa/0xd0 kernel/locking/spinlock.c:159
   snd_pcm_period_elapsed+0x2c/0x210 sound/core/pcm_lib.c:1799
   call_timer_fn+0x91/0x160 kernel/time/timer.c:1415
   expire_timers kernel/time/timer.c:1460 [inline]
   __run_timers+0x65e/0x830 kernel/time/timer.c:1757
   run_timer_softirq+0x46/0x80 kernel/time/timer.c:1770
   __do_softirq+0x256/0x6e0 kernel/softirq.c:298
   asm_call_irq_on_stack+0xf/0x20
   __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
   run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
   do_softirq_own_stack+0x9a/0xf0 arch/x86/kernel/irq_64.c:77
   invoke_softirq kernel/softirq.c:393 [inline]
   __irq_exit_rcu+0x21f/0x230 kernel/softirq.c:423
   irq_exit_rcu+0x5/0x20 kernel/softirq.c:435
   sysvec_apic_timer_interrupt+0xe0/0xf0 arch/x86/kernel/apic/apic.c:1091
   asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
   native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:60
   arch_safe_halt arch/x86/include/asm/paravirt.h:150 [inline]
   acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
   acpi_idle_do_entry+0xde/0x2d0 drivers/acpi/processor_idle.c:517
   acpi_idle_enter+0x2fa/0x440 drivers/acpi/processor_idle.c:648
   cpuidle_enter_state+0x38a/0x980 drivers/cpuidle/cpuidle.c:237
   cpuidle_enter+0x59/0x90 drivers/cpuidle/cpuidle.c:350
   call_cpuidle kernel/sched/idle.c:132 [inline]
   cpuidle_idle_call kernel/sched/idle.c:213 [inline]
   do_idle+0x4a7/0x650 kernel/sched/idle.c:273
   cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:369
   start_kernel+0x4b0/0x57c init/main.c:1049
   secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243


stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 print_irq_inversion_bug+0xa5c/0xd70 kernel/locking/lockdep.c:3817
 check_usage_forwards kernel/locking/lockdep.c:191 [inline]
 mark_lock_irq kernel/locking/lockdep.c:3980 [inline]
 mark_lock+0xe80/0x2050 kernel/locking/lockdep.c:4408
 mark_usage kernel/locking/lockdep.c:4305 [inline]
 __lock_acquire+0xa67/0x2bd0 kernel/locking/lockdep.c:4791
 lock_acquire+0x160/0x710 kernel/locking/lockdep.c:5442
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xaa/0xd0 kernel/locking/spinlock.c:159
 snd_pcm_period_elapsed+0x2c/0x210 sound/core/pcm_lib.c:1799
 call_timer_fn+0x91/0x160 kernel/time/timer.c:1415
 expire_timers kernel/time/timer.c:1460 [inline]
 __run_timers+0x65e/0x830 kernel/time/timer.c:1757
 run_timer_softirq+0x46/0x80 kernel/time/timer.c:1770
 __do_softirq+0x256/0x6e0 kernel/softirq.c:298
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0x9a/0xf0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:393 [inline]
 __irq_exit_rcu+0x21f/0x230 kernel/softirq.c:423
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:435
 sysvec_apic_timer_interrupt+0xe0/0xf0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: 80 e1 07 80 c1 03 38 c1 7c bc 48 89 df e8 0a 4e 60 f9 eb b2 cc cc cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d f6 6a 4d 00 fb f4 <c3> 90 e9 07 00 00 00 0f 00 2d e6 6a 4d 00 f4 c3 cc cc 41 56 53 65
RSP: 0018:ffffffff89807d68 EFLAGS: 00000282
RAX: 1ffffffff131a5c7 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff817b4020 R09: fffffbfff1312d39
R10: fffffbfff1312d39 R11: 0000000000000000 R12: ffff8880a6732864
R13: ffff8880a3185804 R14: ffff8880a6732864 R15: dffffc0000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:150 [inline]
 acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
 acpi_idle_do_entry+0xde/0x2d0 drivers/acpi/processor_idle.c:517
 acpi_idle_enter+0x2fa/0x440 drivers/acpi/processor_idle.c:648
 cpuidle_enter_state+0x38a/0x980 drivers/cpuidle/cpuidle.c:237
 cpuidle_enter+0x59/0x90 drivers/cpuidle/cpuidle.c:350
 call_cpuidle kernel/sched/idle.c:132 [inline]
 cpuidle_idle_call kernel/sched/idle.c:213 [inline]
 do_idle+0x4a7/0x650 kernel/sched/idle.c:273
 cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:369
 start_kernel+0x4b0/0x57c init/main.c:1049
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
