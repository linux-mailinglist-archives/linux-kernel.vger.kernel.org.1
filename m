Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A882EB049
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 17:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbhAEQi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 11:38:57 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:56143 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbhAEQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:38:56 -0500
Received: by mail-il1-f197.google.com with SMTP id c13so294253ilg.22
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 08:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ev6bxgmiIzBj6hWnvt6lWoXfvmQdabf3nH6E8EnnnCA=;
        b=fcyNXP7NYSIqff7rmdAHQU0dyuUu9zGj0utQOo2RRL8oAijVyWhN8AX7AWsU4e+e88
         hzNNtYFGOVNHhSeWWeYfKJ10bsoNcbV+9PVq5eVUo5zSNo7Z6FxKVoNlLrfFcSnvxNAM
         OTETEALHi0x8BsH/S9GI9p6mCdCA++C1yE8uABkTev/ix1JqPrDLwqXPwCnYV3dyZhaK
         GXDRiTjkhLezcrowhCsFbvTDnlVMcJMQvD6rkjg/ydiiZ+CtLtmAJH0baTvR1bOUaB8R
         Tw2AonUnX+YiiQHBxTpjBw8pVgfeRwLYX+fyqGFck0hIFgvKCbvGYr0yq3H06xnSAONt
         OE5w==
X-Gm-Message-State: AOAM530GG9FA2soruCVCMXv9nk4TiHJuABc3GeJyn4AnhOqYNlEaTgse
        bqBtQUK+ueSK1gfEbZLExG24eAure9gXBijjk5JrcJ7XPK6U
X-Google-Smtp-Source: ABdhPJyYtVXEvqOT/QvBe46ftlJLlEQAzctn3qdGh/5Yzl4s1kl0xW8tuHcYIMX9pigSvhR6WqNtb+Nt1Qsl/YDip35zRYsbye0v
MIME-Version: 1.0
X-Received: by 2002:a5d:9c57:: with SMTP id 23mr62842165iof.43.1609864695288;
 Tue, 05 Jan 2021 08:38:15 -0800 (PST)
Date:   Tue, 05 Jan 2021 08:38:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c9acf05b829d573@google.com>
Subject: INFO: task hung in kernel_restart (2)
From:   syzbot <syzbot+495c6e4e8a6a71122a88@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8280de6a usb: gadget: composite: Split composite reset and..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1641df4f500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8ac36d562a4f043
dashboard link: https://syzkaller.appspot.com/bug?extid=495c6e4e8a6a71122a88
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+495c6e4e8a6a71122a88@syzkaller.appspotmail.com

INFO: task systemd-shutdow:1 blocked for more than 143 seconds.
      Not tainted 5.11.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-shutdow state:D stack:22896 pid:    1 ppid:     0 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4313 [inline]
 __schedule+0x91b/0x1f90 kernel/sched/core.c:5064
 schedule+0xcb/0x270 kernel/sched/core.c:5143
 wait_for_device_probe+0x1be/0x220 drivers/base/dd.c:709
 device_shutdown+0x18/0x5c0 drivers/base/core.c:4162
 kernel_restart_prepare kernel/reboot.c:76 [inline]
 kernel_restart+0x61/0xa0 kernel/reboot.c:246
 __do_sys_reboot+0x31e/0x3e0 kernel/reboot.c:349
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f8cdeac58c6
RSP: 002b:00007ffd16578bb8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8cdeac58c6
RDX: 0000000001234567 RSI: 0000000028121969 RDI: fffffffffee1dead
RBP: 00007ffd16578c48 R08: 0000000000002800 R09: 0000000000000005
R10: 0000000000000002 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 000055cba9722150 R15: 00007ffd16578f38

Showing all locks held in the system:
1 lock held by systemd-shutdow/1:
 #0: ffffffff8734ad08 (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot+0x1a3/0x3e0 kernel/reboot.c:346
6 locks held by kworker/0:0/5:
 #0: ffff888103f33938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888103f33938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888103f33938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888103f33938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888103f33938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888103f33938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x871/0x1580 kernel/workqueue.c:2246
 #1: ffffc9000005fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x1580 kernel/workqueue.c:2250
 #2: ffff888109114218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:725 [inline]
 #2: ffff888109114218 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c5/0x42d0 drivers/usb/core/hub.c:5537
 #3: ffff88810dc1c218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:725 [inline]
 #3: ffff88810dc1c218 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:894
 #4: ffff8881132111a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:725 [inline]
 #4: ffff8881132111a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:894
 #5: ffff88810faecc60
 (&dev->phy_mutex){+.+.}-{3:3}, at: asix_mdio_read+0x9a/0x320 drivers/net/usb/asix_common.c:452
1 lock held by khungtaskd/1268:
 #0: ffffffff8746d6a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x269 kernel/locking/lockdep.c:6254

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1268 Comm: khungtaskd Not tainted 5.11.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x46/0xe0 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1da/0x200 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd32/0xf70 kernel/hung_task.c:294
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.11.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:io_serial_in+0x60/0x80 drivers/tty/serial/8250/8250_port.c:448
Code: 0f b6 8d f1 00 00 00 48 8d 7d 40 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 d3 e3 80 3c 02 00 75 13 03 5d 40 89 da ec <5b> 0f b6 c0 5d c3 e8 35 8b 32 ff eb c9 e8 5e 8b 32 ff eb e6 66 90
RSP: 0018:ffffc9000005e8a0 EFLAGS: 00000002
RAX: dffffc0000000000 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: ffffffff8238ee4c RDI: ffffffff8a80f160
RBP: ffffffff8a80f120 R08: 0000000000000000 R09: 00000000000008fd
R10: ffffffff811ae353 R11: 000000000000000a R12: 0000000000000020
R13: fffffbfff1501e77 R14: fffffbfff1501e2e R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881f6a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd16577c3c CR3: 0000000104284000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 serial_in drivers/tty/serial/8250/8250.h:113 [inline]
 wait_for_xmitr+0x9a/0x210 drivers/tty/serial/8250/8250_port.c:2061
 serial8250_console_putchar+0x1b/0x50 drivers/tty/serial/8250/8250_port.c:3244
 uart_console_write+0x59/0x100 drivers/tty/serial/serial_core.c:1946
 serial8250_console_write+0x90c/0xa90 drivers/tty/serial/8250/8250_port.c:3316
 call_console_drivers kernel/printk/printk.c:1838 [inline]
 console_unlock+0x848/0xb90 kernel/printk/printk.c:2552
 vprintk_emit+0x1be/0x4a0 kernel/printk/printk.c:2074
 dev_vprintk_emit+0x36e/0x3b2 drivers/base/core.c:4283
 dev_printk_emit+0xba/0xf1 drivers/base/core.c:4294
 __netdev_printk+0x1c6/0x27a net/core/dev.c:11039
 netdev_warn+0xd7/0x109 net/core/dev.c:11092
 asix_read_cmd.cold+0x3a/0x46 drivers/net/usb/asix_common.c:29
 asix_mdio_read+0x149/0x320 drivers/net/usb/asix_common.c:458
 asix_phy_reset+0x104/0x170 drivers/net/usb/asix_devices.c:215
 ax88172_bind+0x412/0x5d0 drivers/net/usb/asix_devices.c:272
 usbnet_probe+0xb70/0x27b0 drivers/net/usb/usbnet.c:1703
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
 usb_new_device.cold+0x71d/0xfe9 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x2348/0x42d0 drivers/usb/core/hub.c:5591
 process_one_work+0x98d/0x1580 kernel/workqueue.c:2275
 process_scheduled_works kernel/workqueue.c:2337 [inline]
 worker_thread+0x82b/0x1120 kernel/workqueue.c:2423
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
