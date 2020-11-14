Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2547F2B2D62
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 14:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgKNNm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 08:42:26 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:53159 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgKNNmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 08:42:25 -0500
Received: by mail-il1-f198.google.com with SMTP id o18so8015114ilg.19
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 05:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tYwQr2UuvWR02DdvEmTl/uoIJczrWOnLpEhBN8EBwmQ=;
        b=ArymqVEzRPhfOaj5XiZ6G9fs4+Tkp5lZS5LkSUXwiFcmXJiRRuUAyf6zR0pLcAkEPD
         RdZHOdRqsHnxW1N6jvLgOIz5pzsgXEeKVX8tnAESXKahLZiXPkU5YK3rBF/+rDNLkVU2
         szEqr9KuLJ1fFbrbODQDSdcJhpCEod1MUcr4Ym5nkHJmvM3SF50fWk2UI2MqRsemE7W4
         MFTQq7byiJzBbe9cwVX0FZyQpJkJGO2VKmjvxG6/OB1G8H0q9OEsZhHbwfb983gVA6vj
         khdr9w0mUgWdu89O/E2B9L6R2Pqpj3XhZvqSk0Xp0RBg9jzm9EsTDfmz3WZcGbCdS5Jh
         bp4Q==
X-Gm-Message-State: AOAM533P0eNbU6b8TF0hxAl7lsi1QKLRN08MnBNoqaJFI9hCPVDebd5Y
        89G0DKzsdVhvtPZdkzBDPbbIFCT48k5Hjf/ug69gphZafdp4
X-Google-Smtp-Source: ABdhPJzfLt2Ibh7VgJd4bWXf8yKPXSiAI3+jeA109CS3d1E4C9n3zRrX7aNzVgMJUeuSGHrykTcJXmQocxbKnYxFvbB06hcS22M8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c61:: with SMTP id f1mr2983634ilj.60.1605361344257;
 Sat, 14 Nov 2020 05:42:24 -0800 (PST)
Date:   Sat, 14 Nov 2020 05:42:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a923c105b411505f@google.com>
Subject: INFO: task hung in reboot
From:   syzbot <syzbot+9dec836197fea6892a28@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e7018751 usb: host: ehci-mxc: Remove the driver
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15d0c6a1500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a84e3059298aeb27
dashboard link: https://syzkaller.appspot.com/bug?extid=9dec836197fea6892a28
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9dec836197fea6892a28@syzkaller.appspotmail.com

INFO: task systemd-shutdow:1 blocked for more than 143 seconds.
      Not tainted 5.10.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-shutdow state:D stack:23432 pid:    1 ppid:     0 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3774 [inline]
 __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
 schedule+0xcb/0x270 kernel/sched/core.c:4601
 wait_for_device_probe+0x1be/0x220 drivers/base/dd.c:702
 device_shutdown+0x18/0x5c0 drivers/base/core.c:4007
 kernel_restart_prepare kernel/reboot.c:76 [inline]
 kernel_restart kernel/reboot.c:246 [inline]
 __do_sys_reboot.cold+0x5d/0x97 kernel/reboot.c:347
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fa389e6c8c6
Code: Unable to access opcode bytes at RIP 0x7fa389e6c89c.
RSP: 002b:00007ffe1fb46e18 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa389e6c8c6
RDX: 0000000001234567 RSI: 0000000028121969 RDI: fffffffffee1dead
RBP: 00007ffe1fb46ea8 R08: 0000000000002800 R09: 0000000000000005
R10: 0000000000000002 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 000055c2d05dc150 R15: 00007ffe1fb47198

Showing all locks held in the system:
1 lock held by systemd-shutdow/1:
 #0: ffffffff871288a8 (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot+0x1a4/0x3e0 kernel/reboot.c:344
5 locks held by kworker/1:0/17:
1 lock held by khungtaskd/1253:
 #0: ffffffff872492e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x269 kernel/locking/lockdep.c:6253

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1253 Comm: khungtaskd Not tainted 5.10.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x46/0xe0 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1da/0x200 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd32/0xf70 kernel/hung_task.c:294
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
