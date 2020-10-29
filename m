Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F3229EDCF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgJ2ODY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:03:24 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:43862 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJ2ODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:03:22 -0400
Received: by mail-il1-f197.google.com with SMTP id t6so2043041ilj.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZOEBR3Ct93s4mST8cv/tX28Wu/ZhGYjbiVCnyQI+6MQ=;
        b=fmxACgM7YmlrWFZQUCZOXp3dim6wF3yUtJvROR+mMcwBB0S1040ByEgJf/yotSwJLC
         B83QRIWhCb/VcT28nlS0Ga4hscVYaU9KVktCUmHoZhBtjxr8BpPC682DDes698NEtP3u
         Xc0BOSLs8ONTHFrChFlnSru1M0Vs1d5gn4Lz3TZ5sRibATqLu16mSqfyjj/L1DuzbZf9
         JFCjwlJO3D+l25ngMLm1TiDM/sk4wVApcW5SYtc/x2yRMWnx1HkjbM6PephUN5mQyxG1
         IoA+mWQ6xqJ3usiFKe1o0QSOMz31meZ51GvFke995sKgozM2xGg8HhlFGTOhMiJk2EN9
         T2Og==
X-Gm-Message-State: AOAM531D8vUcQW2+UbVEeCoDd94y9zzs0DCriZ+uWwBj02aHUGmUd3yy
        Ff90xdTTbaHZlr1HN16WpepbwzQJ1e6+DAm+ga9Z+gch/BMU
X-Google-Smtp-Source: ABdhPJxYx7w6ge32jm0RNxObth7B2AWNZ540gVL6u7Ufzxf336GMWMcu4VuEdUzNKfRF+TPAsnef/ZjIrxtMpH4iLkEOxBsb6KsW
MIME-Version: 1.0
X-Received: by 2002:a6b:3c14:: with SMTP id k20mr3596452iob.12.1603980201792;
 Thu, 29 Oct 2020 07:03:21 -0700 (PDT)
Date:   Thu, 29 Oct 2020 07:03:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000279c7405b2cfbe57@google.com>
Subject: INFO: task hung in __do_sys_reboot (2)
From:   syzbot <syzbot+6ac02052974329933524@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3650b228 Linux 5.10-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=141b20c0500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1c5bd23a80035ea
dashboard link: https://syzkaller.appspot.com/bug?extid=6ac02052974329933524
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ac02052974329933524@syzkaller.appspotmail.com

INFO: task systemd-shutdow:1 blocked for more than 143 seconds.
      Not tainted 5.10.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-shutdow state:D stack:23432 pid:    1 ppid:     0 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 wait_for_device_probe+0x1be/0x220 drivers/base/dd.c:702
 device_shutdown+0x18/0x5c0 drivers/base/core.c:4009
 kernel_restart_prepare kernel/reboot.c:76 [inline]
 kernel_restart kernel/reboot.c:246 [inline]
 __do_sys_reboot.cold+0x5d/0x97 kernel/reboot.c:347
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fe1cf5eb8c6
Code: Unable to access opcode bytes at RIP 0x7fe1cf5eb89c.
RSP: 002b:00007ffcd3779e08 EFLAGS: 00000202 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe1cf5eb8c6
RDX: 0000000001234567 RSI: 0000000028121969 RDI: fffffffffee1dead
RBP: 00007ffcd3779e98 R08: 0000000000002800 R09: 0000000000000005
R10: 0000000000000002 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 000055992d955150 R15: 00007ffcd377a188

Showing all locks held in the system:
1 lock held by systemd-shutdow/1:
 #0: ffffffff871287a8 (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot+0x1a4/0x3e0 kernel/reboot.c:344
1 lock held by khungtaskd/1262:
 #0: ffffffff872491e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x269 kernel/locking/lockdep.c:6259
5 locks held by kworker/1:2/2642:
5 locks held by kworker/1:4/6746:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1262 Comm: khungtaskd Not tainted 5.10.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x46/0xe0 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1da/0x200 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd32/0xf70 kernel/hung_task.c:295
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_idle_do_entry+0x1c9/0x250 drivers/acpi/processor_idle.c:517


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
