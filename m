Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299F826884A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgINJ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:29:39 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:55348 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgINJ3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:29:17 -0400
Received: by mail-il1-f206.google.com with SMTP id a15so12148839ilb.22
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Wm08DhwS/R1AzpRgD33MpGLQLtwuIhwm8YNVOqVyATo=;
        b=QXgdkN01+hNtRaDVtzzmLw29L5KrI0pQtWI7wqfh/HztlwDL7Rh7q/X2iIkMV/Iap6
         WNJLMXJq6Wy3hOVJpX30/lFExDXgIs4bO5t0w87lj77wqEHQ9dtDRT1/c997esdft3YI
         kRfvfTEgkcLUSiY0XJWmwCvkGeSMR2UVxrdRHmwa7xDLraKBtRZc/5YpyCf3TxON+HfR
         V7+8yM+qzNNOgukLIe2Meipq4aVQPRQwQbpgkhEn+HhL/wNgO7b0C7PTEWTZOGsDQaz2
         WnQmwEWxS/3BKcXtpfegO59zqrGH8dFIVNUtk6pDFEsWxYvO5Urk/II74FQHpiKK4ipU
         DMrQ==
X-Gm-Message-State: AOAM5305GIS6tx/Jti7f9ks6EGnwS3xus5gpJ8vSMGsups5EspJR+8g8
        KQnBuj6QFHDwR0I3tuupXQi/eWNTsHtn23rMb8nkjNq+Npu/
X-Google-Smtp-Source: ABdhPJxfwVMpPwrnr7gVYoLozYbhsenz3WBuFsakMUNKPwKNdzTNWzMgpM7aOAFIkOXSNxm5Y1753hmeYfihyCVJEtnWC2VWhujC
MIME-Version: 1.0
X-Received: by 2002:a02:7055:: with SMTP id f82mr12498078jac.54.1600075755547;
 Mon, 14 Sep 2020 02:29:15 -0700 (PDT)
Date:   Mon, 14 Sep 2020 02:29:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005f0b605af42ab4e@google.com>
Subject: KASAN: unknown-crash Read in do_exit
From:   syzbot <syzbot+d9ae84069cff753e94bf@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, christian@brauner.io,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    729e3d09 Merge tag 'ceph-for-5.9-rc5' of git://github.com/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170a7cf1900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
dashboard link: https://syzkaller.appspot.com/bug?extid=d9ae84069cff753e94bf
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10642545900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141f2bed900000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b9ffcd900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1479ffcd900000
console output: https://syzkaller.appspot.com/x/log.txt?x=1079ffcd900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d9ae84069cff753e94bf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: unknown-crash in stack_not_used include/linux/sched/task_stack.h:101 [inline]
BUG: KASAN: unknown-crash in check_stack_usage kernel/exit.c:692 [inline]
BUG: KASAN: unknown-crash in do_exit+0x24a6/0x29f0 kernel/exit.c:849
Read of size 8 at addr ffffc9000cf30130 by task syz-executor624/10359

CPU: 1 PID: 10359 Comm: syz-executor624 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 stack_not_used include/linux/sched/task_stack.h:101 [inline]
 check_stack_usage kernel/exit.c:692 [inline]
 do_exit+0x24a6/0x29f0 kernel/exit.c:849
 do_group_exit+0x125/0x310 kernel/exit.c:903
 get_signal+0x428/0x1f00 kernel/signal.c:2757
 arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:159 [inline]
 exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:190
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:265
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446b99
Code: Bad RIP value.
RSP: 002b:00007f70f5ed9d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: 0000000000002878 RBX: 00000000006dbc58 RCX: 0000000000446b99
RDX: 9999999999999999 RSI: 0000000000000000 RDI: 0000020002004ffc
RBP: 00000000006dbc50 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc5c
R13: 00007f70f5ed9d20 R14: 00007f70f5ed9d20 R15: 000000000000002d


Memory state around the buggy address:
 ffffc9000cf30000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000cf30080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000cf30100: 00 00 00 00 00 00 70 07 00 00 77 00 00 00 00 00
                                     ^
 ffffc9000cf30180: 00 00 70 07 00 00 70 07 00 00 00 00 77 00 70 07
 ffffc9000cf30200: 00 70 07 00 77 00 00 00 00 00 70 07 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
