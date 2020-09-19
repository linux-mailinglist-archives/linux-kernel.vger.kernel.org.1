Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73734270BE0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 10:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgISIcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 04:32:16 -0400
Received: from mail-io1-f79.google.com ([209.85.166.79]:50911 "EHLO
        mail-io1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgISIcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 04:32:16 -0400
Received: by mail-io1-f79.google.com with SMTP id b16so6436350iod.17
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 01:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HIMwPuqQFiA2XqENrPZHq0KB/Dygu2+rr8pyJn8QkbM=;
        b=nIoDuYafiAFhnPb42JQkumP32YChmrntvtc25HPOn30LEpSCnqdNIMaLwy0kIZ+e47
         IuvuJED/h1blBG+z6wUghWO5jyDiscKqB2UbdPd0sIcqAlIxEvYa7WbHNpbFGel3GBBV
         w6yACbrpmwMlm3cOqC7q8lgyFpEZrvxEp0xgxiUaNRvYnHBOWeCZHUCeJDU1nCkdvsae
         q/mZH2aVniSna9ZmJg0s4jK3BJxNgNgptqq1GYTgDsozjai4duobV7J4uYi1mi0nNTg4
         evEbQecDQgKLGvaiqzNwG0WSPzOnYLaKt90i07FbABCuS7XLJ2j4Goo5ppXdBzwx9PSV
         xnfQ==
X-Gm-Message-State: AOAM531xVYZ8UhAudYSn65CRx3IRgDSHtb3MuywOyN6B7J66NfDxqBMr
        iCjEmuv3bGkMEu/vdMlFqbD9brnv991K4eRR+IIdcivLe51Y
X-Google-Smtp-Source: ABdhPJwgVixcZQ6IrGlNYVh6R3B9b7CmKs7LlnAHozeyqjVPbmhC5R1iHZf/m6I1XrvWiy3+eg+m+7vaWjxEt0nkVw/RvVnp2H+8
MIME-Version: 1.0
X-Received: by 2002:a92:340b:: with SMTP id b11mr21373145ila.124.1600504334536;
 Sat, 19 Sep 2020 01:32:14 -0700 (PDT)
Date:   Sat, 19 Sep 2020 01:32:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052569205afa67426@google.com>
Subject: general protection fault in perf_misc_flags
From:   syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com, bp@alien8.de,
        hpa@zytor.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    92ab97ad Merge tag 'sh-for-5.9-part2' of git://git.libc.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1069669b900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62
dashboard link: https://syzkaller.appspot.com/bug?extid=ce179bc99e64377c24bc
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xffff518084501e28: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfffaac042280f140-0xfffaac042280f147]
CPU: 0 PID: 17449 Comm: syz-executor.5 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:perf_misc_flags+0x125/0x150 arch/x86/events/core.c:2638
Code: e4 48 83 e6 03 41 0f 94 c4 31 ff e8 95 fa 73 00 bb 02 00 00 00 4c 29 e3 49 81 c6 90 00 00 00 4c 89 f0 48 c1 e8 00 00 00 00 38 <00> 74 08 4c 89 f7 e8 40 c0 b3 00 41 8b 06 83 e0 08 48 c1 e0 0b 48
RSP: 0018:ffffc90000007a08 EFLAGS: 00010002
RAX: ffffc90017db7aa8 RBX: 0000000000000001 RCX: ffff88806c74a380
RDX: ffff88806c74a380 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000007ac0 R08: ffffffff810117eb R09: fffffbfff167da99
R10: fffffbfff167da99 R11: 0000000000000000 R12: 0000000000000001
R13: dffffc0000000000 R14: ffffc90017db7aa8 R15: dffffc0000000000
FS:  00007f1165303700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004d8750 CR3: 0000000095a35000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 perf_prepare_sample+0xea/0x19f0 kernel/events/core.c:7001
 __perf_event_output kernel/events/core.c:7170 [inline]
 perf_event_output_forward+0xa7/0x1c0 kernel/events/core.c:7190
 __perf_event_overflow+0x1b9/0x340 kernel/events/core.c:8845
 perf_swevent_hrtimer+0x43c/0x4d0 kernel/events/core.c:10247
 __run_hrtimer kernel/time/hrtimer.c:1524 [inline]
 __hrtimer_run_queues+0x42d/0x930 kernel/time/hrtimer.c:1588
 hrtimer_interrupt+0x373/0xd60 kernel/time/hrtimer.c:1650
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0xf0/0x260 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0x94/0xf0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:770 [inline]
RIP: 0010:lock_acquire+0x195/0x6f0 kernel/locking/lockdep.c:5009
Code: c1 e8 03 80 3c 18 00 74 0c 48 c7 c7 b8 17 4d 89 e8 20 df 5a 00 48 83 3d 80 1e f3 07 00 0f 84 fc 04 00 00 48 8b 7c 24 08 57 9d <0f> 1f 44 00 00 65 48 8b 04 25 28 00 00 00 48 3b 44 24 48 0f 85 d3
RSP: 0018:ffffc90017db7ac8 EFLAGS: 0000022a
RAX: 1ffffffff129a2f7 RBX: dffffc0000000000 RCX: ffffffff815adc44
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: 0000000000000282
RBP: 0000000000000001 R08: dffffc0000000000 R09: fffffbfff167da9c
R10: fffffbfff167da9c R11: 0000000000000000 R12: ffff88806c74ac64
R13: 0000000000000000 R14: ffff888094349228 R15: 1ffff1100d8e958c
 __might_fault+0xf1/0x150 mm/memory.c:4870
 _copy_from_user+0x28/0x170 lib/usercopy.c:12
 copy_from_user include/linux/uaccess.h:160 [inline]
 __copy_msghdr_from_user+0x45/0x700 net/socket.c:2235
 copy_msghdr_from_user net/socket.c:2286 [inline]
 sendmsg_copy_msghdr net/socket.c:2384 [inline]
 ___sys_sendmsg net/socket.c:2403 [inline]
 __sys_sendmmsg+0x2a1/0x680 net/socket.c:2497
 __do_sys_sendmmsg net/socket.c:2526 [inline]
 __se_sys_sendmmsg net/socket.c:2523 [inline]
 __x64_sys_sendmmsg+0x9c/0xb0 net/socket.c:2523
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5f9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1165302c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000027c00 RCX: 000000000045d5f9
RDX: 04924924924925c6 RSI: 0000000020000680 RDI: 0000000000000005
RBP: 000000000118cf88 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007fffb49ba86f R14: 00007f11653039c0 R15: 000000000118cf4c
Modules linked in:
---[ end trace 2cb388c0ff8c4c87 ]---
RIP: 0010:perf_misc_flags+0x125/0x150 arch/x86/events/core.c:2638
Code: e4 48 83 e6 03 41 0f 94 c4 31 ff e8 95 fa 73 00 bb 02 00 00 00 4c 29 e3 49 81 c6 90 00 00 00 4c 89 f0 48 c1 e8 00 00 00 00 38 <00> 74 08 4c 89 f7 e8 40 c0 b3 00 41 8b 06 83 e0 08 48 c1 e0 0b 48
RSP: 0018:ffffc90000007a08 EFLAGS: 00010002
RAX: ffffc90017db7aa8 RBX: 0000000000000001 RCX: ffff88806c74a380
RDX: ffff88806c74a380 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000007ac0 R08: ffffffff810117eb R09: fffffbfff167da99
R10: fffffbfff167da99 R11: 0000000000000000 R12: 0000000000000001
R13: dffffc0000000000 R14: ffffc90017db7aa8 R15: dffffc0000000000
FS:  00007f1165303700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004d8750 CR3: 0000000095a35000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
