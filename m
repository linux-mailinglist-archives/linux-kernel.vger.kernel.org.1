Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756EC2D8B26
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 04:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390615AbgLMD0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 22:26:11 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:54844 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732692AbgLMDZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 22:25:51 -0500
Received: by mail-il1-f200.google.com with SMTP id z8so10552978ilq.21
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 19:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VCpMT1eNhU+gOu68/EUxLGO9lUWKpSAIgMzP9pdVwmI=;
        b=XUvdmBgE//SzBd16armTxk1o/VkusrpspH4WlGfu1w132MF7JdUMGKlifcP3w/3g5L
         sw9N0PiOwDQGDZ1eLWw91alkB837tbBXk4QLd2D27Xd8N0KWpS8rgxpXgNLEzDt7W5B2
         meP8SRypAtoeEGlzRhS42F/qBQCrLScuObeWnvf9WOt40VnbdfmwZ8lsFZ2jsZsTxQPf
         xWkVJyUedkteim6Gw7M2VMmw3fxMsc4bQcyiweUbwWTxSrleZsYOztMtcyy84FFX3fg7
         8B6xaILwaKU0Gdp2TaaL99rJ9ksQJHc8JiJCcvL47LrAQnLLROWjMKant0S0jKFNI/k5
         BtSw==
X-Gm-Message-State: AOAM532njcIZHHN1GnM2T/aHvtqU34HxsFFyeh9xvI7ZMeWRPtfhIMEs
        BEk8h2NzM/DtdsxaD+79ZKQn37/AEnhpyq4BH+S6wNosKM9H
X-Google-Smtp-Source: ABdhPJwBDaa2cd6qbq2DvDpD8LVAOF7Wmcm0F0jsL40wo89OV9zqGc4Rso7hw1iFJ24r/T+umDEyrzjIfoPcvSbCFZXfUYnBJDX+
MIME-Version: 1.0
X-Received: by 2002:a92:ae10:: with SMTP id s16mr26245153ilh.142.1607829909871;
 Sat, 12 Dec 2020 19:25:09 -0800 (PST)
Date:   Sat, 12 Dec 2020 19:25:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a321c205b65012ff@google.com>
Subject: INFO: task can't die in irqentry_exit (2)
From:   syzbot <syzbot+b3c4057ecb552e754f4a@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    14240d4c Add linux-next specific files for 20201210
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=137b0f9b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6dbe20fdaa5aaebe
dashboard link: https://syzkaller.appspot.com/bug?extid=b3c4057ecb552e754f4a
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176d1287500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1236046b500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3c4057ecb552e754f4a@syzkaller.appspotmail.com

INFO: task syz-executor349:9910 can't die for more than 143 seconds.
task:syz-executor349 state:R  running task     stack:27536 pid: 9910 ppid:  8512 flags:0x00004006
Call Trace:
 context_switch kernel/sched/core.c:4325 [inline]
 __schedule+0x8eb/0x21b0 kernel/sched/core.c:5076
 preempt_schedule_irq+0x4e/0x90 kernel/sched/core.c:5338
 irqentry_exit_cond_resched kernel/entry/common.c:393 [inline]
 irqentry_exit_cond_resched kernel/entry/common.c:385 [inline]
 irqentry_exit+0x7a/0xa0 kernel/entry/common.c:423
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:628
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/irqflags.h:85 [inline]
RIP: 0010:lock_acquire kernel/locking/lockdep.c:5440 [inline]
RIP: 0010:lock_acquire+0x2c7/0x750 kernel/locking/lockdep.c:5402
Code: 48 c7 c7 00 9c 6b 89 48 83 c4 20 e8 83 49 be 07 b8 ff ff ff ff 65 0f c1 05 c6 e3 a9 7e 83 f8 01 0f 85 40 03 00 00 ff 34 24 9d <e9> 3a fe ff ff 65 ff 05 2d d2 a9 7e 48 8b 05 a6 51 11 0c e8 a1 3e
RSP: 0018:ffffc9000a90f7c8 EFLAGS: 00000246
RAX: 0000000000000001 RBX: 1ffff92001521efb RCX: 0000000000000001
RDX: 1ffff110053f47f1 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8f4fe767
R10: fffffbfff1e9fcec R11: 0000000000000000 R12: 0000000000000002
R13: ffffffff8b78f120 R14: 0000000000000000 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:255 [inline]
 rcu_read_lock include/linux/rcupdate.h:644 [inline]
 inet_twsk_purge+0x112/0x810 net/ipv4/inet_timewait_sock.c:268
 ops_exit_list+0x10d/0x160 net/core/net_namespace.c:190
 setup_net+0x508/0x850 net/core/net_namespace.c:365
 copy_net_ns+0x376/0x7b0 net/core/net_namespace.c:483
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 copy_namespaces+0x3e5/0x4d0 kernel/nsproxy.c:179
 copy_process+0x2aa7/0x6fe0 kernel/fork.c:2103
 kernel_clone+0xe7/0xad0 kernel/fork.c:2465
 __do_sys_clone+0xc8/0x110 kernel/fork.c:2582
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44c9c9
RSP: 002b:00007f1b22b4fce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00000000006e3c68 RCX: 000000000044c9c9
RDX: 9999999999999999 RSI: 0000000000000000 RDI: 00000000e1004d7c
RBP: 00000000006e3c60 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e3c6c
R13: 00007fffa37c4aef R14: 00007f1b22b509c0 R15: 0000000000000001

Showing all locks held in the system:
4 locks held by kworker/u4:0/9:
 #0: ffff888140baf138 ((wq_completion)netns){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888140baf138 ((wq_completion)netns){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888140baf138 ((wq_completion)netns){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888140baf138 ((wq_completion)netns){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888140baf138 ((wq_completion)netns){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888140baf138 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x871/0x1630 kernel/workqueue.c:2246
 #1: ffffc90000ce7da8 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x8a5/0x1630 kernel/workqueue.c:2250
 #2: ffffffff8d0bcb50 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x9b/0xb10 net/core/net_namespace.c:566
 #3: ffffffff8b799728 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:290 [inline]
 #3: ffffffff8b799728 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x4ff/0x620 kernel/rcu/tree_exp.h:836
1 lock held by khungtaskd/1661:
 #0: ffffffff8b78f120 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x28c kernel/locking/lockdep.c:6254
2 locks held by kworker/0:3/3202:
1 lock held by in:imklog/8197:
 #0: ffff888018541c70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:923
2 locks held by kworker/0:2/8489:
 #0: ffff88801087c538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801087c538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff88801087c538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff88801087c538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff88801087c538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff88801087c538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x871/0x1630 kernel/workqueue.c:2246
 #1: ffffc9000178fda8 ((work_completion)(&rew.rew_work)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x1630 kernel/workqueue.c:2250
2 locks held by syz-executor349/9910:
2 locks held by syz-executor349/9935:
2 locks held by syz-executor349/10031:
1 lock held by syz-executor349/10264:
2 locks held by syz-executor349/10269:
 #0: ffffffff8d0bcb50 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x352/0x7b0 net/core/net_namespace.c:479
 #1: ffffffff8d0d76e8 (rtnl_mutex){+.+.}-{3:3}, at: ip_fib_net_exit+0x1b/0x2b0 net/ipv4/fib_frontend.c:1544
2 locks held by syz-executor349/10397:
3 locks held by syz-executor349/10412:

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
