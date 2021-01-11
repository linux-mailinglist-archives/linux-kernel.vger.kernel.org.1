Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F392F1A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbhAKQMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:12:09 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:38278 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbhAKQMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:12:08 -0500
Received: by mail-io1-f69.google.com with SMTP id q140so12886565iod.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5CAjaGHSYJE2WLa9pL5056qaBJTZ2udGNpMcmfF1yiQ=;
        b=TwcKCr0aEzEyeO6LF1Fu9ahFHWtZ+3kLG3r22Va0hDIQwvqXz+BcawevGvOLPdAFAS
         HbQ5uEc1FDIG+TzffVSDDjvsZY26ZYB8/HA68QsRj5QMmotxcgknMG1Dc5yEVWVr9dmM
         EIua7sZDr9c5MU3T+4U2dxIPzPVzx/HfDQu9mCbgLaetW1cKEHJCzLHeobpc1ZoyFoin
         PJ1IOnG2eiJJntWZUPihqyp0iff/tegqFTXgZTfW16xo4X0WB9pYE748JMh/FiyMvQOj
         +NJyyGkcOaHRGqP6KwXb9P3ENSQKUxCWiLq7jNLmOmmfDvOQXiLNI4qZAR3d/mhAlaJs
         GvDg==
X-Gm-Message-State: AOAM530Y4+sTiH5zD3vo9vh4lxsDOh7f4tz/gMkyNtQrTMTLMkvZkFds
        72JY3FACeIjvk6MvbXOW37qQ3lFO7W/GIHWslHlNKfxnvidD
X-Google-Smtp-Source: ABdhPJzJWw0V/HH8gieg4mfsX/cRdE7GWYTYtkwwgYQA+dErbph1Het0lRObF7pRxM4/WjGUD5OJSS1ntsw8NTNw/JuucGvUUVPT
MIME-Version: 1.0
X-Received: by 2002:a05:6602:228c:: with SMTP id d12mr15429377iod.67.1610381486763;
 Mon, 11 Jan 2021 08:11:26 -0800 (PST)
Date:   Mon, 11 Jan 2021 08:11:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078b53f05b8a2286b@google.com>
Subject: KASAN: use-after-free Read in usb_anchor_resume_wakeups (2)
From:   syzbot <syzbot+39c636a0650bcbb172ec@syzkaller.appspotmail.com>
To:     a.darwish@linutronix.de, allen.lkml@gmail.com,
        andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        gregkh@linuxfoundation.org, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    841081d8 usb: usbip: Use DEFINE_SPINLOCK() for spinlock
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12f42a3f500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f9911c273a88e5
dashboard link: https://syzkaller.appspot.com/bug?extid=39c636a0650bcbb172ec
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39c636a0650bcbb172ec@syzkaller.appspotmail.com

xpad 6-1:0.65: xpad_irq_in - usb_submit_urb failed with result -19
xpad 6-1:0.65: xpad_irq_out - usb_submit_urb failed with result -19
==================================================================
BUG: KASAN: use-after-free in register_lock_class+0xecc/0x1100 kernel/locking/lockdep.c:1291
Read of size 2 at addr ffff888137488092 by task systemd-udevd/7474

CPU: 1 PID: 7474 Comm: systemd-udevd Not tainted 5.11.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 register_lock_class+0xecc/0x1100 kernel/locking/lockdep.c:1291
 __lock_acquire+0x101/0x54f0 kernel/locking/lockdep.c:4711
 lock_acquire kernel/locking/lockdep.c:5437 [inline]
 lock_acquire+0x288/0x700 kernel/locking/lockdep.c:5402
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x36/0x50 kernel/locking/spinlock.c:159
 __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:137
 usb_anchor_resume_wakeups drivers/usb/core/urb.c:937 [inline]
 usb_anchor_resume_wakeups+0xbe/0xe0 drivers/usb/core/urb.c:930
 __usb_hcd_giveback_urb+0x2df/0x5c0 drivers/usb/core/hcd.c:1661
 usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1728
 dummy_timer+0x11f4/0x32a0 drivers/usb/gadget/udc/dummy_hcd.c:1971
 call_timer_fn+0x1a5/0x630 kernel/time/timer.c:1417
 expire_timers kernel/time/timer.c:1462 [inline]
 __run_timers.part.0+0x67c/0xa10 kernel/time/timer.c:1731
 __run_timers kernel/time/timer.c:1712 [inline]
 run_timer_softirq+0x80/0x120 kernel/time/timer.c:1744
 __do_softirq+0x1b7/0x977 kernel/softirq.c:343
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0x80/0xa0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:226 [inline]
 __irq_exit_rcu kernel/softirq.c:420 [inline]
 irq_exit_rcu+0x110/0x1a0 kernel/softirq.c:432
 sysvec_apic_timer_interrupt+0x43/0xa0 arch/x86/kernel/apic/apic.c:1096
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:628
RIP: 0010:__sanitizer_cov_trace_pc+0x37/0x60 kernel/kcov.c:197
Code: 81 e1 00 01 00 00 65 48 8b 14 25 40 ef 01 00 a9 00 01 ff 00 74 0e 85 c9 74 35 8b 82 dc 13 00 00 85 c0 74 2b 8b 82 b8 13 00 00 <83> f8 02 75 20 48 8b 8a c0 13 00 00 8b 92 bc 13 00 00 48 8b 01 48
RSP: 0018:ffffc90005f875b0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff888116d85040 RSI: ffffffff81dabe81 RDI: 0000000000000003
RBP: ffff888102c2bf00 R08: 0000000000000000 R09: 0000000000000003
R10: ffffffff81dabeba R11: 0000000000000010 R12: 0000000000000002
R13: 00000000000001cc R14: dffffc0000000000 R15: 0000000000000000
 tomoyo_domain_quota_is_ok+0x2f1/0x550 security/tomoyo/util.c:1093
 tomoyo_supervisor+0x2f2/0xf00 security/tomoyo/common.c:2089
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3a0 security/tomoyo/file.c:573
 tomoyo_check_open_permission+0x33e/0x380 security/tomoyo/file.c:777
 tomoyo_file_open security/tomoyo/tomoyo.c:313 [inline]
 tomoyo_file_open+0xa3/0xd0 security/tomoyo/tomoyo.c:308
 security_file_open+0x52/0x4f0 security/security.c:1576
 do_dentry_open+0x353/0x1090 fs/open.c:804
 do_open fs/namei.c:3254 [inline]
 path_openat+0x1b9a/0x2730 fs/namei.c:3371
 do_filp_open+0x17e/0x3c0 fs/namei.c:3398
 do_sys_openat2+0x16d/0x420 fs/open.c:1172
 do_sys_open fs/open.c:1188 [inline]
 __do_sys_open fs/open.c:1196 [inline]
 __se_sys_open fs/open.c:1192 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1192
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f97523546f0
Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 83 3d 19 30 2c 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 fe 9d 01 00 48 89 04 24
RSP: 002b:00007ffda8db42a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000560343083730 RCX: 00007f97523546f0
RDX: 00000000000001b6 RSI: 0000000000080000 RDI: 00007ffda8db4450
RBP: 0000000000000008 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000080000 R11: 0000000000000246 R12: 000056034175268a
R13: 0000000000000001 R14: 000056034308c587 R15: 00007ffda8db44c0

Allocated by task 7307:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:401 [inline]
 ____kasan_kmalloc.constprop.0+0x82/0xa0 mm/kasan/common.c:429
 kmalloc include/linux/slab.h:552 [inline]
 kzalloc include/linux/slab.h:682 [inline]
 xpad_probe+0x26c/0x1c10 drivers/input/joystick/xpad.c:1731
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 really_probe+0x291/0xde0 drivers/base/dd.c:561
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:745
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:851
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:919
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbc4/0x1d90 drivers/base/core.c:3091
 usb_set_configuration+0x113c/0x1910 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 really_probe+0x291/0xde0 drivers/base/dd.c:561
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:745
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:851
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:919
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbc4/0x1d90 drivers/base/core.c:3091
 usb_new_device.cold+0x725/0x1057 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x2348/0x42d0 drivers/usb/core/hub.c:5591
 process_one_work+0x98d/0x1580 kernel/workqueue.c:2275
 process_scheduled_works kernel/workqueue.c:2337 [inline]
 worker_thread+0x82b/0x1120 kernel/workqueue.c:2423
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Freed by task 7368:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:354
 ____kasan_slab_free+0xe1/0x110 mm/kasan/common.c:362
 kasan_slab_free include/linux/kasan.h:188 [inline]
 slab_free_hook mm/slub.c:1547 [inline]
 slab_free_freelist_hook+0x5d/0x150 mm/slub.c:1580
 slab_free mm/slub.c:3143 [inline]
 kfree+0xdb/0x390 mm/slub.c:4125
 xpad_disconnect+0x1cb/0x530 drivers/input/joystick/xpad.c:1879
 usb_unbind_interface+0x1d8/0x8d0 drivers/usb/core/driver.c:458
 __device_release_driver+0x3bd/0x6f0 drivers/base/dd.c:1161
 device_release_driver_internal drivers/base/dd.c:1192 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1215
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x502/0xd40 drivers/base/core.c:3270
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1413
 usb_disconnect.cold+0x27d/0x780 drivers/usb/core/hub.c:2218
 hub_port_connect drivers/usb/core/hub.c:5074 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x1c8a/0x42d0 drivers/usb/core/hub.c:5591
 process_one_work+0x98d/0x1580 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

The buggy address belongs to the object at ffff888137488000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 146 bytes inside of
 1024-byte region [ffff888137488000, ffff888137488400)
The buggy address belongs to the page:
page:000000001b181346 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x137488
head:000000001b181346 order:2 compound_mapcount:0 compound_pincount:0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 dead000000000100 dead000000000122 ffff888100041140
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888137487f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888137488000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888137488080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888137488100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888137488180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
