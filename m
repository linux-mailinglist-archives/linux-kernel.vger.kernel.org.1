Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B997297237
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465772AbgJWP0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:26:23 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:41327 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465755AbgJWP0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:26:23 -0400
Received: by mail-io1-f69.google.com with SMTP id j21so1413803iog.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 08:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oMIJBTmP0vIg508VNCbknQmv+Io37D65u+fsrIqcKHc=;
        b=oruJ2pmVrg48OdiqVbi+UOk/H0pwVx+85Hrvv0dFAQ7uPpCREUORydsmCpL50voGGD
         Ox+9C9fQzLqoq7mgG8UeZNh3UtxdAnxk6RqqXSLDJGx/VlfWl66XIsv9NvMxVMwRKcTG
         ej43o0ssCa5cQlpePrzm1VV3Ujyy0Og5RT0EAQfIBz/zVMCtt/lGXaDxmFd3K8omgKf3
         bqesedToBEGPhDP4Y3ROIpZb8WKpqSiPhzZnVueBdqijiSCMjTUij92jr1oZDMxYUHbJ
         BwILqdyAa/Xo3dEa0CfYVXmmB55A5nuIKN9Yqrecbt/f/q6vrieEBNyqtlPPaao2//1e
         FCYQ==
X-Gm-Message-State: AOAM533qgd6GsxBxOpnhhlcIOM66tp3zb2Esg5dzgOQ3uCsH3CrbBXwM
        P3LQpNIhGqr3qbyPnZ6js0OGBTWXqz2ubrH5GdAyHW3RtC3+
X-Google-Smtp-Source: ABdhPJyPRb8gqdjGjwDg4eKpR9nluRHSl1mR/EHKx+GllNBM4d74Lqivc4ACh8LUV3kLNWjFjjCchWjWKwZSZWoCWT4ydQHhR03Z
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1508:: with SMTP id b8mr2340163jat.25.1603466781639;
 Fri, 23 Oct 2020 08:26:21 -0700 (PDT)
Date:   Fri, 23 Oct 2020 08:26:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000edcabe05b25833f7@google.com>
Subject: memory leak in gadget_setup
From:   syzbot <syzbot+bd38200f53df6259e6bf@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, balbi@kernel.org, dan.carpenter@oracle.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    96485e44 Merge tag 'ext4_for_linus' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f1b91c500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=504c0405f28172a
dashboard link: https://syzkaller.appspot.com/bug?extid=bd38200f53df6259e6bf
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ead664500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a44cc4500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd38200f53df6259e6bf@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888110622660 (size 32):
  comm "softirq", pid 0, jiffies 4294941981 (age 12.480s)
  hex dump (first 32 bytes):
    02 00 00 00 08 00 00 00 80 06 00 01 00 00 40 00  ..............@.
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000efd29abd>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000efd29abd>] raw_event_queue_add drivers/usb/gadget/legacy/raw_gadget.c:66 [inline]
    [<00000000efd29abd>] raw_queue_event drivers/usb/gadget/legacy/raw_gadget.c:225 [inline]
    [<00000000efd29abd>] gadget_setup+0xf6/0x220 drivers/usb/gadget/legacy/raw_gadget.c:343
    [<00000000952c4a46>] dummy_timer+0xb9f/0x14c0 drivers/usb/gadget/udc/dummy_hcd.c:1899
    [<0000000074ac2c54>] call_timer_fn+0x38/0x200 kernel/time/timer.c:1415
    [<00000000560a3a79>] expire_timers kernel/time/timer.c:1460 [inline]
    [<00000000560a3a79>] __run_timers.part.0+0x319/0x400 kernel/time/timer.c:1757
    [<000000009d9503d0>] __run_timers kernel/time/timer.c:1738 [inline]
    [<000000009d9503d0>] run_timer_softirq+0x3d/0x80 kernel/time/timer.c:1770
    [<000000009df27c89>] __do_softirq+0xcc/0x2c2 kernel/softirq.c:298
    [<000000007a3f1a47>] asm_call_irq_on_stack+0xf/0x20
    [<000000004a62cc2e>] __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
    [<000000004a62cc2e>] run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
    [<000000004a62cc2e>] do_softirq_own_stack+0x32/0x40 arch/x86/kernel/irq_64.c:77
    [<00000000b0086800>] invoke_softirq kernel/softirq.c:393 [inline]
    [<00000000b0086800>] __irq_exit_rcu kernel/softirq.c:423 [inline]
    [<00000000b0086800>] irq_exit_rcu+0x91/0xc0 kernel/softirq.c:435
    [<00000000175f9523>] sysvec_apic_timer_interrupt+0x36/0x80 arch/x86/kernel/apic/apic.c:1091
    [<00000000a348e847>] asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:631
    [<0000000060661100>] native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
    [<0000000060661100>] arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
    [<0000000060661100>] acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
    [<0000000060661100>] acpi_idle_do_entry+0xc3/0xd0 drivers/acpi/processor_idle.c:517
    [<000000003f413b99>] acpi_idle_enter+0x128/0x1f0 drivers/acpi/processor_idle.c:648
    [<00000000f5e5afb8>] cpuidle_enter_state+0xc9/0x650 drivers/cpuidle/cpuidle.c:237
    [<00000000d50d51fc>] cpuidle_enter+0x29/0x40 drivers/cpuidle/cpuidle.c:351
    [<00000000d674baed>] call_cpuidle kernel/sched/idle.c:132 [inline]
    [<00000000d674baed>] cpuidle_idle_call kernel/sched/idle.c:213 [inline]
    [<00000000d674baed>] do_idle+0x1c8/0x250 kernel/sched/idle.c:273

BUG: memory leak
unreferenced object 0xffff888110622380 (size 32):
  comm "softirq", pid 0, jiffies 4294942017 (age 12.120s)
  hex dump (first 32 bytes):
    02 00 00 00 08 00 00 00 80 06 00 01 00 00 40 00  ..............@.
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000efd29abd>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000efd29abd>] raw_event_queue_add drivers/usb/gadget/legacy/raw_gadget.c:66 [inline]
    [<00000000efd29abd>] raw_queue_event drivers/usb/gadget/legacy/raw_gadget.c:225 [inline]
    [<00000000efd29abd>] gadget_setup+0xf6/0x220 drivers/usb/gadget/legacy/raw_gadget.c:343
    [<00000000952c4a46>] dummy_timer+0xb9f/0x14c0 drivers/usb/gadget/udc/dummy_hcd.c:1899
    [<0000000074ac2c54>] call_timer_fn+0x38/0x200 kernel/time/timer.c:1415
    [<00000000560a3a79>] expire_timers kernel/time/timer.c:1460 [inline]
    [<00000000560a3a79>] __run_timers.part.0+0x319/0x400 kernel/time/timer.c:1757
    [<000000009d9503d0>] __run_timers kernel/time/timer.c:1738 [inline]
    [<000000009d9503d0>] run_timer_softirq+0x3d/0x80 kernel/time/timer.c:1770
    [<000000009df27c89>] __do_softirq+0xcc/0x2c2 kernel/softirq.c:298
    [<000000007a3f1a47>] asm_call_irq_on_stack+0xf/0x20
    [<000000004a62cc2e>] __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
    [<000000004a62cc2e>] run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
    [<000000004a62cc2e>] do_softirq_own_stack+0x32/0x40 arch/x86/kernel/irq_64.c:77
    [<00000000b0086800>] invoke_softirq kernel/softirq.c:393 [inline]
    [<00000000b0086800>] __irq_exit_rcu kernel/softirq.c:423 [inline]
    [<00000000b0086800>] irq_exit_rcu+0x91/0xc0 kernel/softirq.c:435
    [<00000000175f9523>] sysvec_apic_timer_interrupt+0x36/0x80 arch/x86/kernel/apic/apic.c:1091
    [<00000000a348e847>] asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:631
    [<0000000060661100>] native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
    [<0000000060661100>] arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
    [<0000000060661100>] acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
    [<0000000060661100>] acpi_idle_do_entry+0xc3/0xd0 drivers/acpi/processor_idle.c:517
    [<000000003f413b99>] acpi_idle_enter+0x128/0x1f0 drivers/acpi/processor_idle.c:648
    [<00000000f5e5afb8>] cpuidle_enter_state+0xc9/0x650 drivers/cpuidle/cpuidle.c:237
    [<00000000d50d51fc>] cpuidle_enter+0x29/0x40 drivers/cpuidle/cpuidle.c:351
    [<00000000d674baed>] call_cpuidle kernel/sched/idle.c:132 [inline]
    [<00000000d674baed>] cpuidle_idle_call kernel/sched/idle.c:213 [inline]
    [<00000000d674baed>] do_idle+0x1c8/0x250 kernel/sched/idle.c:273

BUG: memory leak
unreferenced object 0xffff888110dfc020 (size 32):
  comm "softirq", pid 0, jiffies 4294942067 (age 11.620s)
  hex dump (first 32 bytes):
    02 00 00 00 08 00 00 00 80 06 00 01 00 00 40 00  ..............@.
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000efd29abd>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000efd29abd>] raw_event_queue_add drivers/usb/gadget/legacy/raw_gadget.c:66 [inline]
    [<00000000efd29abd>] raw_queue_event drivers/usb/gadget/legacy/raw_gadget.c:225 [inline]
    [<00000000efd29abd>] gadget_setup+0xf6/0x220 drivers/usb/gadget/legacy/raw_gadget.c:343
    [<00000000952c4a46>] dummy_timer+0xb9f/0x14c0 drivers/usb/gadget/udc/dummy_hcd.c:1899
    [<0000000074ac2c54>] call_timer_fn+0x38/0x200 kernel/time/timer.c:1415
    [<00000000560a3a79>] expire_timers kernel/time/timer.c:1460 [inline]
    [<00000000560a3a79>] __run_timers.part.0+0x319/0x400 kernel/time/timer.c:1757
    [<000000009d9503d0>] __run_timers kernel/time/timer.c:1738 [inline]
    [<000000009d9503d0>] run_timer_softirq+0x3d/0x80 kernel/time/timer.c:1770
    [<000000009df27c89>] __do_softirq+0xcc/0x2c2 kernel/softirq.c:298
    [<000000007a3f1a47>] asm_call_irq_on_stack+0xf/0x20
    [<000000004a62cc2e>] __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
    [<000000004a62cc2e>] run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
    [<000000004a62cc2e>] do_softirq_own_stack+0x32/0x40 arch/x86/kernel/irq_64.c:77
    [<00000000b0086800>] invoke_softirq kernel/softirq.c:393 [inline]
    [<00000000b0086800>] __irq_exit_rcu kernel/softirq.c:423 [inline]
    [<00000000b0086800>] irq_exit_rcu+0x91/0xc0 kernel/softirq.c:435
    [<00000000175f9523>] sysvec_apic_timer_interrupt+0x36/0x80 arch/x86/kernel/apic/apic.c:1091
    [<00000000a348e847>] asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:631
    [<0000000060661100>] native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
    [<0000000060661100>] arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
    [<0000000060661100>] acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
    [<0000000060661100>] acpi_idle_do_entry+0xc3/0xd0 drivers/acpi/processor_idle.c:517
    [<000000003f413b99>] acpi_idle_enter+0x128/0x1f0 drivers/acpi/processor_idle.c:648
    [<00000000f5e5afb8>] cpuidle_enter_state+0xc9/0x650 drivers/cpuidle/cpuidle.c:237
    [<00000000d50d51fc>] cpuidle_enter+0x29/0x40 drivers/cpuidle/cpuidle.c:351
    [<00000000d674baed>] call_cpuidle kernel/sched/idle.c:132 [inline]
    [<00000000d674baed>] cpuidle_idle_call kernel/sched/idle.c:213 [inline]
    [<00000000d674baed>] do_idle+0x1c8/0x250 kernel/sched/idle.c:273



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
