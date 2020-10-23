Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C5429723D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465796AbgJWP0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:26:30 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:52465 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465754AbgJWP0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:26:22 -0400
Received: by mail-io1-f69.google.com with SMTP id e10so1410408ioq.19
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 08:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KqIcLxoWMOgyDIHlPgDtbim81ixqYlsTiyIh2/2tzCw=;
        b=AGs6teoVA2ZfaJYkoBk+t+13uHYofUWBdSwjTj3NEeVUO1oBIj6Zvg8/68MIWlGtpR
         hMvFuQ9SlFA2RC9EewSQfMkjFpkjXIzZnMs1HCaRbl4WxUQaLB8rpgScNBdZjNayrHy1
         +KagDk/+sDg4ankn22SLS+WnMTvtoU8l6e4e8TW/y56VgRrNwHMr36duJiWTYBCII2DD
         8VoMK5O1qHc5DxQJmqclJY34fRYhylJ4B7ThR38dr5RByvr6bTmSR6kK6pkjTNy7+nkh
         l6BAfHVhGG+hD1LKCoC4FmSYRBrZfFgw5MUHIae7iD5XoFQlX+o9jwm8sYiDVET0ebxW
         x6yg==
X-Gm-Message-State: AOAM5327lfX5wwekmXm+N1jZiPHtqB6euya02qaQ6tzO8of0yhOAahXD
        3qBMpTcqhw0m07CbcnjXORB5e7tRx2RmtdXTgSYHgwwuyCoE
X-Google-Smtp-Source: ABdhPJyQJG0klV3QpY/n69STwAcXuoqdz8cqXb2l79ISbKCrbLFAfWl2C5+b+6t9lIwtd5cVx5M8ahHyAiBJLzLxNWdUg0YFGc8S
MIME-Version: 1.0
X-Received: by 2002:a02:cb0c:: with SMTP id j12mr2415315jap.54.1603466781423;
 Fri, 23 Oct 2020 08:26:21 -0700 (PDT)
Date:   Fri, 23 Oct 2020 08:26:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea810305b2583377@google.com>
Subject: memory leak in gadget_bind
From:   syzbot <syzbot+0a4ec40b66726854dd11@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, balbi@kernel.org, dan.carpenter@oracle.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f9893351 Merge tag 'kconfig-v5.10' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ff53f7900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8e9005328853c49
dashboard link: https://syzkaller.appspot.com/bug?extid=0a4ec40b66726854dd11
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177a731c500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1328d038500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a4ec40b66726854dd11@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888110c4d9c0 (size 32):
  comm "syz-executor693", pid 8462, jiffies 4294942114 (age 13.040s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000b2b2ae2f>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000b2b2ae2f>] raw_event_queue_add drivers/usb/gadget/legacy/raw_gadget.c:66 [inline]
    [<00000000b2b2ae2f>] raw_queue_event drivers/usb/gadget/legacy/raw_gadget.c:225 [inline]
    [<00000000b2b2ae2f>] gadget_bind+0x223/0x340 drivers/usb/gadget/legacy/raw_gadget.c:303
    [<000000005cc0921f>] udc_bind_to_driver+0x62/0x150 drivers/usb/gadget/udc/core.c:1413
    [<000000009fe15fa6>] usb_gadget_probe_driver+0x1c7/0x230 drivers/usb/gadget/udc/core.c:1476
    [<00000000a41bab17>] raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:512 [inline]
    [<00000000a41bab17>] raw_ioctl+0x5da/0xf30 drivers/usb/gadget/legacy/raw_gadget.c:1210
    [<0000000085e98ccd>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<0000000085e98ccd>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<0000000085e98ccd>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<0000000085e98ccd>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000b1e8d60c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000084cf691c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810ba5e4e0 (size 32):
  comm "softirq", pid 0, jiffies 4294942152 (age 12.660s)
  hex dump (first 32 bytes):
    02 00 00 00 08 00 00 00 80 06 00 01 00 00 40 00  ..............@.
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000203e8439>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000203e8439>] raw_event_queue_add drivers/usb/gadget/legacy/raw_gadget.c:66 [inline]
    [<00000000203e8439>] raw_queue_event drivers/usb/gadget/legacy/raw_gadget.c:225 [inline]
    [<00000000203e8439>] gadget_setup+0xf6/0x220 drivers/usb/gadget/legacy/raw_gadget.c:343
    [<000000009fb695b0>] dummy_timer+0xb9f/0x14c0 drivers/usb/gadget/udc/dummy_hcd.c:1899
    [<00000000c61b4b01>] call_timer_fn+0x38/0x200 kernel/time/timer.c:1415
    [<0000000044ef2390>] expire_timers kernel/time/timer.c:1460 [inline]
    [<0000000044ef2390>] __run_timers.part.0+0x319/0x400 kernel/time/timer.c:1757
    [<000000005e8b3107>] __run_timers kernel/time/timer.c:1738 [inline]
    [<000000005e8b3107>] run_timer_softirq+0x3d/0x80 kernel/time/timer.c:1770
    [<000000000af0f05c>] __do_softirq+0xcc/0x2c2 kernel/softirq.c:298
    [<0000000065b29993>] asm_call_irq_on_stack+0xf/0x20
    [<00000000670a912a>] __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
    [<00000000670a912a>] run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
    [<00000000670a912a>] do_softirq_own_stack+0x32/0x40 arch/x86/kernel/irq_64.c:77
    [<00000000b238919a>] invoke_softirq kernel/softirq.c:393 [inline]
    [<00000000b238919a>] __irq_exit_rcu kernel/softirq.c:423 [inline]
    [<00000000b238919a>] irq_exit_rcu+0x91/0xc0 kernel/softirq.c:435
    [<00000000ab949bfc>] sysvec_apic_timer_interrupt+0x36/0x80 arch/x86/kernel/apic/apic.c:1091
    [<00000000ae73d7f6>] asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:631
    [<00000000c54c318f>] native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
    [<00000000c54c318f>] arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
    [<00000000c54c318f>] acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
    [<00000000c54c318f>] acpi_idle_do_entry+0xc3/0xd0 drivers/acpi/processor_idle.c:517
    [<00000000ac55bfeb>] acpi_idle_enter+0x128/0x1f0 drivers/acpi/processor_idle.c:648
    [<000000008d561dc0>] cpuidle_enter_state+0xc9/0x650 drivers/cpuidle/cpuidle.c:237
    [<000000007b67805b>] cpuidle_enter+0x29/0x40 drivers/cpuidle/cpuidle.c:351
    [<000000001370c1be>] call_cpuidle kernel/sched/idle.c:132 [inline]
    [<000000001370c1be>] cpuidle_idle_call kernel/sched/idle.c:213 [inline]
    [<000000001370c1be>] do_idle+0x1c8/0x250 kernel/sched/idle.c:273

BUG: memory leak
unreferenced object 0xffff888110f48b20 (size 32):
  comm "softirq", pid 0, jiffies 4294942183 (age 12.350s)
  hex dump (first 32 bytes):
    02 00 00 00 08 00 00 00 80 06 00 01 00 00 40 00  ..............@.
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000203e8439>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000203e8439>] raw_event_queue_add drivers/usb/gadget/legacy/raw_gadget.c:66 [inline]
    [<00000000203e8439>] raw_queue_event drivers/usb/gadget/legacy/raw_gadget.c:225 [inline]
    [<00000000203e8439>] gadget_setup+0xf6/0x220 drivers/usb/gadget/legacy/raw_gadget.c:343
    [<000000009fb695b0>] dummy_timer+0xb9f/0x14c0 drivers/usb/gadget/udc/dummy_hcd.c:1899
    [<00000000c61b4b01>] call_timer_fn+0x38/0x200 kernel/time/timer.c:1415
    [<0000000044ef2390>] expire_timers kernel/time/timer.c:1460 [inline]
    [<0000000044ef2390>] __run_timers.part.0+0x319/0x400 kernel/time/timer.c:1757
    [<000000005e8b3107>] __run_timers kernel/time/timer.c:1738 [inline]
    [<000000005e8b3107>] run_timer_softirq+0x3d/0x80 kernel/time/timer.c:1770
    [<000000000af0f05c>] __do_softirq+0xcc/0x2c2 kernel/softirq.c:298
    [<0000000065b29993>] asm_call_irq_on_stack+0xf/0x20
    [<00000000670a912a>] __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
    [<00000000670a912a>] run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
    [<00000000670a912a>] do_softirq_own_stack+0x32/0x40 arch/x86/kernel/irq_64.c:77
    [<00000000b238919a>] invoke_softirq kernel/softirq.c:393 [inline]
    [<00000000b238919a>] __irq_exit_rcu kernel/softirq.c:423 [inline]
    [<00000000b238919a>] irq_exit_rcu+0x91/0xc0 kernel/softirq.c:435
    [<00000000ab949bfc>] sysvec_apic_timer_interrupt+0x36/0x80 arch/x86/kernel/apic/apic.c:1091
    [<00000000ae73d7f6>] asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:631
    [<00000000c54c318f>] native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
    [<00000000c54c318f>] arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
    [<00000000c54c318f>] acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
    [<00000000c54c318f>] acpi_idle_do_entry+0xc3/0xd0 drivers/acpi/processor_idle.c:517
    [<00000000ac55bfeb>] acpi_idle_enter+0x128/0x1f0 drivers/acpi/processor_idle.c:648
    [<000000008d561dc0>] cpuidle_enter_state+0xc9/0x650 drivers/cpuidle/cpuidle.c:237
    [<000000007b67805b>] cpuidle_enter+0x29/0x40 drivers/cpuidle/cpuidle.c:351
    [<000000001370c1be>] call_cpuidle kernel/sched/idle.c:132 [inline]
    [<000000001370c1be>] cpuidle_idle_call kernel/sched/idle.c:213 [inline]
    [<000000001370c1be>] do_idle+0x1c8/0x250 kernel/sched/idle.c:273



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
