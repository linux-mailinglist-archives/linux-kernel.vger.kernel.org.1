Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88F32C71F6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389993AbgK1Vua convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 28 Nov 2020 16:50:30 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:55701 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733282AbgK1SPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:15:44 -0500
Received: by mail-io1-f70.google.com with SMTP id j10so5024878iog.22
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 10:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=UT5nO1yoU//6Ra23GqwqwpAguaR4aacijny1VQiMHp4=;
        b=oUTWHSBAqtaEkNMSBkEZz/wS2CdWGz/cERqed390vhFOTgSvTlWNsIE/a3OyFNnHVT
         xcRMWwim3yuV3qoowJnREhtGgZfqPOpAI9uBiRS/bNsQPX4l2Ce/eiyofIsPw+WqYbBH
         PBkzJD+CPgeAV+CKTZh8jp4icO+XUfJmL2l+GB8Dxd34ykgQdVpfhpgbpwggM7mpXnJW
         HYs/tsq5uCvRr/fG0zDlzxJI+dj0IJSnGiX0Yxzp7W4nVrVUo2qzr+qMpkLaAHPI1xFA
         0SPFIUxbqrUSL7xuhxZresSV8/4pzn4PEhsRS9752qI1vFukvczV64xFTRCgC89F1581
         PsAw==
X-Gm-Message-State: AOAM53208dp21js34mG98CFPm8pa1cQBkm+g6nKbKZP51WJuY4ZDLR6S
        W89txBXpv6W2/BDYlpRt20wsR+eO0oqcvNNBWq0f1CJwYEho
X-Google-Smtp-Source: ABdhPJx8v1YuQcY8VB0sexh9toq6TUz2AaTdbni7H9MLHarzMcglSQBmik2BPgNmNplktq73m0+kRTywS4Y18tCTThlu6766DXPC
MIME-Version: 1.0
X-Received: by 2002:a6b:fa1a:: with SMTP id p26mr8799373ioh.70.1606547955258;
 Fri, 27 Nov 2020 23:19:15 -0800 (PST)
Date:   Fri, 27 Nov 2020 23:19:15 -0800
In-Reply-To: <0000000000002da9cd05a9c74d87@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030214605b525983e@google.com>
Subject: Re: INFO: rcu detected stall in input_repeat_key
From:   syzbot <syzbot+33510b19568e6f5f59c9@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, fweisbec@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ab37fa85 usb: typec: Add type sysfs attribute file for par..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=16cd7653500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=641c279821d16ddb
dashboard link: https://syzkaller.appspot.com/bug?extid=33510b19568e6f5f59c9
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a598c9500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174bcbb3500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33510b19568e6f5f59c9@syzkaller.appspotmail.com

Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
rcu: INFO: rcu_sched self-detected stall on CPU
rcu: 	0-....: (1 GPs behind) idle=efa/1/0x4000000000000000 softirq=14648/14649 fqs=397 
	(t=10519 jiffies g=19417 q=9469)
NMI backtrace for cpu 0
CPU: 0 PID: 11632 Comm: systemd-udevd Not tainted 5.10.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x46/0xe0 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1da/0x200 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x1e3/0x21e kernel/rcu/tree_stall.h:318
 print_cpu_stall kernel/rcu/tree_stall.h:551 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:625 [inline]
 rcu_pending kernel/rcu/tree.c:3694 [inline]
 rcu_sched_clock_irq.cold+0x49d/0x973 kernel/rcu/tree.c:2567
 update_process_times+0x139/0x1b0 kernel/time/timer.c:1709
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:176
 tick_sched_timer+0x1c5/0x290 kernel/time/tick-sched.c:1328
 __run_hrtimer kernel/time/hrtimer.c:1519 [inline]
 __hrtimer_run_queues+0x1ce/0xdf0 kernel/time/hrtimer.c:1583
 hrtimer_interrupt+0x300/0x8f0 kernel/time/hrtimer.c:1645
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0xf5/0x420 arch/x86/kernel/apic/apic.c:1097
 run_sysvec_on_irqstack_cond arch/x86/include/asm/irq_stack.h:91 [inline]
 sysvec_apic_timer_interrupt+0x3e/0xa0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:631
RIP: 0010:__preempt_count_sub arch/x86/include/asm/preempt.h:84 [inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x25/0x40 kernel/locking/spinlock.c:191
Code: 80 00 00 00 00 55 48 89 fd 48 83 c7 18 53 48 89 f3 48 8b 74 24 10 e8 7a 3b 89 fb 48 89 ef e8 12 f9 89 fb f6 c7 02 75 0c 53 9d <65> ff 0d 54 bf 64 7a 5b 5d c3 e8 4c 59 a7 fb eb ed 66 2e 0f 1f 84
RSP: 0018:ffffc90000007c90 EFLAGS: 00000246
RAX: 00000000000068d4 RBX: 0000000000000246 RCX: ffffffff8125db97
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff859d2fb4
RBP: ffff88810d20a218 R08: 0000000000000001 R09: ffffffff898cb53f
R10: fffffbfff13196a7 R11: 0000000000000000 R12: 0000000000000246
R13: ffff88810d20a218 R14: 0000000000000021 R15: ffff88810d20a108
 spin_unlock_irqrestore include/linux/spinlock.h:409 [inline]
 input_repeat_key+0x118/0x380 drivers/input/input.c:201
 call_timer_fn+0x1a5/0x630 kernel/time/timer.c:1410
 expire_timers kernel/time/timer.c:1455 [inline]
 __run_timers.part.0+0x67c/0xa10 kernel/time/timer.c:1747
 __run_timers kernel/time/timer.c:1728 [inline]
 run_timer_softirq+0x80/0x120 kernel/time/timer.c:1760
 __do_softirq+0x1b2/0x945 kernel/softirq.c:298
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0x80/0xa0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:393 [inline]
 __irq_exit_rcu kernel/softirq.c:423 [inline]
 irq_exit_rcu+0x110/0x1a0 kernel/softirq.c:435
 sysvec_apic_timer_interrupt+0x43/0xa0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:631
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x9/0x60 kernel/kcov.c:197
Code: 00 00 00 4d 8b 0b 48 0f bd c8 49 8b 14 24 48 63 c9 e9 66 ff ff ff 4c 01 ca 49 89 13 e9 12 fd ff ff 65 48 8b 14 25 40 ef 01 00 <65> 8b 05 a0 0c c3 7e a9 00 01 ff 00 48 8b 34 24 74 0f f6 c4 01 74
RSP: 0018:ffffc900064379f0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888109e7b500 RCX: ffffffff81d6d43b
RDX: ffff888103a1cbc0 RSI: ffff888103a1cbc0 RDI: 0000000000000001
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffffff898cb50f
R10: 0000000000000000 R11: ffffc90006437f58 R12: ffffc90006437ad8
R13: ffff888102f9a990 R14: 0000000000000000 R15: 0000000000000001
 tomoyo_check_acl+0xd9/0x450 security/tomoyo/domain.c:173
 tomoyo_path2_perm+0x41c/0x6b0 security/tomoyo/file.c:942
 tomoyo_path_rename+0xd2/0x130 security/tomoyo/tomoyo.c:279
 security_path_rename+0x1b5/0x2e0 security/security.c:1136
 do_renameat2+0x481/0xbf0 fs/namei.c:4453
 __do_sys_rename fs/namei.c:4503 [inline]
 __se_sys_rename fs/namei.c:4501 [inline]
 __x64_sys_rename+0x5d/0x80 fs/namei.c:4501
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fbb9ac4dd47
Code: 75 12 48 89 df e8 19 84 07 00 85 c0 0f 95 c0 0f b6 c0 f7 d8 5b c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 52 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 21 41 33 00 f7 d8 64 89 01 48
RSP: 002b:00007fff8bf62be8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 0000562a963f2130 RCX: 00007fbb9ac4dd47
RDX: 0000000000000000 RSI: 00007fff8bf62bf0 RDI: 0000562a963f3290
RBP: 00007fff8bf62cc0 R08: 0000562a963f33b0 R09: 0000562a963f32d0
R10: 00007fbb9be518c0 R11: 0000000000000246 R12: 00007fff8bf62bf0
R13: 0000000000000001 R14: 0000562a9548f6cb R15: 0000000000000000
Mem-Info:
active_anon:121 inactive_anon:9048 isolated_anon:0
 active_file:5418 inactive_file:12987 isolated_file:0
 unevictable:0 dirty:73 writeback:0
 slab_reclaimable:8871 slab_unreclaimable:67466
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:819 free_cma:0
Node 0 active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52016kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:352kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3534668kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52016kB unevictable:0kB writepending:352kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:1904kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 3*4kB (UME) 2*8kB (ME) 1*16kB (U) 105*32kB (UM) 21*64kB (UM) 27*128kB (UE) 17*256kB (U) 1*512kB (U) 3*1024kB (UME) 2*2048kB (UM) 858*4096kB (M) = 3534604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24101 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9060 isolated_anon:0
 active_file:5418 inactive_file:13004 isolated_file:0
 unevictable:0 dirty:88 writeback:0
 slab_reclaimable:8885 slab_unreclaimable:67462
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:816 free_cma:0
Node 0 active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52016kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:352kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 
DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]:
 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3534668kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52016kB unevictable:0kB writepending:352kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:1884kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 3*4kB (UME) 2*8kB (ME) 1*16kB (U) 105*32kB (UM) 21*64kB (UM) 27*128kB (UE) 17*256kB (U) 1*512kB (U) 3*1024kB (UME) 2*2048kB (UM) 858*4096kB (M) = 3534604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24101 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9060 isolated_anon:0
 active_file:5418 inactive_file:13004 isolated_file:0
 unevictable:0 dirty:88 writeback:0
 slab_reclaimable:8885 slab_unreclaimable:67462
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:813 free_cma:0
Node 0 active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52016kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:352kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3534668kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52016kB unevictable:0kB writepending:352kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:1880kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 3*4kB (UME) 2*8kB (ME) 1*16kB (U) 105*32kB (UM) 21*64kB (UM) 27*128kB (UE) 17*256kB (U) 1*512kB (U) 3*1024kB (UME) 2*2048kB (UM) 858*4096kB (M) = 3534604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24101 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9060 isolated_anon:0
 active_file:5418 inactive_file:13004 isolated_file:0
 unevictable:0 dirty:88 writeback:0
 slab_reclaimable:8885 slab_unreclaimable:67462
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:809 free_cma:0
Node 0 active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52016kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:352kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3534668kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52016kB unevictable:0kB writepending:352kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:1864kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 3*4kB (UME) 2*8kB (ME) 1*16kB (U) 105*32kB (UM) 21*64kB (UM) 27*128kB (UE) 17*256kB (U) 1*512kB (U) 3*1024kB (UME) 2*2048kB (UM) 858*4096kB (M) = 3534604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24101 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9060 isolated_anon:0
 active_file:5418 inactive_file:13004 isolated_file:0
 unevictable:0 dirty:88 writeback:0
 slab_reclaimable:8885 slab_unreclaimable:67462
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:809 free_cma:0
Node 0 active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52016kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:352kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3534668kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52016kB unevictable:0kB writepending:352kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:1844kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 3*4kB (UME) 2*8kB (ME) 1*16kB (U) 105*32kB (UM) 21*64kB (UM) 27*128kB (UE) 17*256kB (U) 1*512kB (U) 3*1024kB (UME) 2*2048kB (UM) 858*4096kB (M) = 3534604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24101 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9060 isolated_anon:0
 active_file:5418 inactive_file:13004 isolated_file:0
 unevictable:0 dirty:88 writeback:0
 slab_reclaimable:8885 slab_unreclaimable:67462
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:802 free_cma:0
Node 0 active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52016kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:352kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 
DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935

Node 0 Normal free:3534668kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52016kB unevictable:0kB writepending:352kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:1836kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]:
 0 0 0 0
Node 0 
DMA: 
1*4kB (U) 0*8kB 0*16kB 1*32kB 
(U) 2*64kB 
(U) 1*128kB 
(U) 1*256kB (U) 0*512kB 1*1024kB 
(U) 1*2048kB 
(M) 3*4096kB 
(M) = 15908kB
Node 0 
DMA32: 6*4kB 
(M) 3*8kB (M) 3*16kB (M) 
4*32kB (M) 
5*64kB (M) 
5*128kB (M) 
5*256kB (M) 
4*512kB (M) 3*1024kB (M) 2*2048kB 
(M) 708*4096kB (M) = 2911648kB
Node 0 
Normal: 3*4kB 
(UME) 2*8kB 
(ME) 1*16kB 
(U) 105*32kB 
(UM) 21*64kB 
(UM) 27*128kB (UE) 17*256kB (U) 
1*512kB (U) 3*1024kB (UME) 2*2048kB 
(UM) 858*4096kB (M) = 3534604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24101 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9060 isolated_anon:0
 active_file:5418 inactive_file:13004 isolated_file:0
 unevictable:0 dirty:88 writeback:0
 slab_reclaimable:8885 slab_unreclaimable:67462
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:802 free_cma:0
Node 0 active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52016kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:352kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]:
 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]:
 0 0
 3935 3935

Node 0 
Normal free:3534668kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52016kB unevictable:0kB writepending:352kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:1836kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]:
 0 0 0 0
Node 0 DMA: 1*4kB (U) 
0*8kB 0*16kB 
1*32kB (U) 
2*64kB (U) 
1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 
3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB 
(M) 3*8kB 
(M) 3*16kB 
(M) 4*32kB (M) 5*64kB (M) 5*128kB 
(M) 5*256kB (M) 4*512kB (M) 3*1024kB 
(M) 2*2048kB 
(M) 708*4096kB (M) = 2911648kB
Node 0 
Normal: 3*4kB (UME) 2*8kB (ME) 1*16kB (U) 105*32kB (UM) 21*64kB (UM) 27*128kB (UE) 17*256kB (U) 1*512kB (U) 3*1024kB (UME) 2*2048kB (UM) 858*4096kB (M) = 3534604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24116 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9060 isolated_anon:0
 active_file:5418 inactive_file:13019 isolated_file:0
 unevictable:0 dirty:103 writeback:0
 slab_reclaimable:8886 slab_unreclaimable:67462
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:790 free_cma:0
Node 0 active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52076kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:412kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3534668kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52076kB unevictable:0kB writepending:412kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:1788kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 3*4kB (UME) 2*8kB (ME) 1*16kB (U) 105*32kB (UM) 21*64kB (UM) 27*128kB (UE) 17*256kB (U) 1*512kB (U) 3*1024kB (UME) 2*2048kB (UM) 858*4096kB (M) = 3534604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24116 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9060 isolated_anon:0
 active_file:5418 inactive_file:13019 isolated_file:0
 unevictable:0 dirty:103 writeback:0
 slab_reclaimable:8886 slab_unreclaimable:67462
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:786 free_cma:0
Node 0 active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52076kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:412kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3534668kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52076kB unevictable:0kB writepending:412kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:1772kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 3*4kB (UME) 2*8kB (ME) 1*16kB (U) 105*32kB (UM) 21*64kB (UM) 27*128kB (UE) 17*256kB (U) 1*512kB (U) 3*1024kB (UME) 2*2048kB (UM) 858*4096kB (M) = 3534604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24116 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9060 isolated_anon:0
 active_file:5418 inactive_file:13044 isolated_file:0
 unevictable:0 dirty:103 writeback:0
 slab_reclaimable:8886 slab_unreclaimable:67462
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:783 free_cma:0
Node 0 active_anon:484kB inactive_anon:36240kB active_file:21672kB inactive_file:52176kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:412kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3534668kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB writepending:480kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:1760kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 3*4kB (UME) 2*8kB (ME) 1*16kB (U) 105*32kB (UM) 21*64kB (UM) 27*128kB (UE) 17*256kB (U) 1*512kB (U) 3*1024kB (UME) 2*2048kB (UM) 858*4096kB (M) = 3534604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24133 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9062 isolated_anon:0
 active_file:5418 inactive_file:13047 isolated_file:0
 unevictable:0 dirty:120 writeback:0
 slab_reclaimable:8887 slab_unreclaimable:67462
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:780 free_cma:0
Node 0 active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:480kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3534668kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB writepending:480kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:1748kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 3*4kB (UME) 2*8kB (ME) 1*16kB (U) 105*32kB (UM) 21*64kB (UM) 27*128kB (UE) 17*256kB (U) 1*512kB (U) 3*1024kB (UME) 2*2048kB (UM) 858*4096kB (M) = 3534604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24133 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9062 isolated_anon:0
 active_file:5418 inactive_file:13047 isolated_file:0
 unevictable:0 dirty:120 writeback:0
 slab_reclaimable:8887 slab_unreclaimable:67462
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:778 free_cma:0
Node 0 active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:480kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3534668kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB writepending:480kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:1740kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 3*4kB (UME) 2*8kB (ME) 1*16kB (U) 105*32kB (UM) 21*64kB (UM) 27*128kB (UE) 17*256kB (U) 1*512kB (U) 3*1024kB (UME) 2*2048kB (UM) 858*4096kB (M) = 3534604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24133 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9062 isolated_anon:0
 active_file:5418 inactive_file:13047 isolated_file:0
 unevictable:0 dirty:120 writeback:0
 slab_reclaimable:8887 slab_unreclaimable:67462
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:776 free_cma:0
Node 0 active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:480kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3534668kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB writepending:480kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:1732kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 3*4kB (UME) 2*8kB (ME) 1*16kB (U) 105*32kB (UM) 21*64kB (UM) 27*128kB (UE) 17*256kB (U) 1*512kB (U) 3*1024kB (UME) 2*2048kB (UM) 858*4096kB (M) = 3534604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24133 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9062 isolated_anon:0
 active_file:5418 inactive_file:13047 isolated_file:0
 unevictable:0 dirty:120 writeback:0
 slab_reclaimable:8887 slab_unreclaimable:67462
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:773 free_cma:0
Node 0 active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:480kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3534668kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB writepending:520kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:1720kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 3*4kB (UME) 2*8kB (ME) 1*16kB (U) 105*32kB (UM) 21*64kB (UM) 27*128kB (UE) 17*256kB (U) 1*512kB (U) 3*1024kB (UME) 2*2048kB (UM) 858*4096kB (M) = 3534604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24143 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9062 isolated_anon:0
 active_file:5418 inactive_file:13047 isolated_file:0
 unevictable:0 dirty:130 writeback:0
 slab_reclaimable:8887 slab_unreclaimable:67462
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615556 free_pcp:769 free_cma:0
Node 0 active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:520kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3533732kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB writepending:520kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:2088kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 1*4kB (E) 2*8kB (UE) 3*16kB (UME) 90*32kB (UME) 22*64kB (UME) 26*128kB (U) 18*256kB (UM) 2*512kB (UM) 2*1024kB (UE) 2*2048kB (UM) 858*4096kB (M) = 3533828kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24143 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9062 isolated_anon:0
 active_file:5418 inactive_file:13047 isolated_file:0
 unevictable:0 dirty:130 writeback:0
 slab_reclaimable:8887 slab_unreclaimable:67509
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615354 free_pcp:898 free_cma:0
Node 0 active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:520kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3533860kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB writepending:520kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:2220kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 1*4kB (E) 2*8kB (UE) 3*16kB (UME) 90*32kB (UME) 22*64kB (UME) 26*128kB (U) 18*256kB (UM) 2*512kB (UM) 2*1024kB (UE) 2*2048kB (UM) 858*4096kB (M) = 3533828kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24143 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9062 isolated_anon:0
 active_file:5418 inactive_file:13047 isolated_file:0
 unevictable:0 dirty:130 writeback:0
 slab_reclaimable:8887 slab_unreclaimable:67509
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615354 free_pcp:896 free_cma:0
Node 0 active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:520kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3533860kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB writepending:520kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:2212kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 1*4kB (E) 2*8kB (UE) 3*16kB (UME) 90*32kB (UME) 22*64kB (UME) 26*128kB (U) 18*256kB (UM) 2*512kB (UM) 2*1024kB (UE) 2*2048kB (UM) 858*4096kB (M) = 3533828kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24143 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9062 isolated_anon:0
 active_file:5418 inactive_file:13047 isolated_file:0
 unevictable:0 dirty:130 writeback:0
 slab_reclaimable:8887 slab_unreclaimable:67509
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615354 free_pcp:896 free_cma:0
Node 0 active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:520kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]:
 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3533860kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36248kB active_file:21672kB inactive_file:52188kB unevictable:0kB writepending:520kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:2196kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 1*4kB (E) 2*8kB (UE) 3*16kB (UME) 90*32kB (UME) 22*64kB (UME) 26*128kB (U) 18*256kB (UM) 2*512kB (UM) 2*1024kB (UE) 2*2048kB (UM) 858*4096kB (M) = 3533828kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24157 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9076 isolated_anon:0
 active_file:5418 inactive_file:13061 isolated_file:0
 unevictable:0 dirty:144 writeback:0
 slab_reclaimable:8893 slab_unreclaimable:67493
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615362 free_pcp:889 free_cma:0
Node 0 active_anon:484kB inactive_anon:36304kB active_file:21672kB inactive_file:52244kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:576kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3533892kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36304kB active_file:21672kB inactive_file:52244kB unevictable:0kB writepending:576kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:2184kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 1*4kB (E) 2*8kB (UE) 3*16kB (UME) 90*32kB (UME) 22*64kB (UME) 26*128kB (U) 18*256kB (UM) 2*512kB (UM) 2*1024kB (UE) 2*2048kB (UM) 858*4096kB (M) = 3533828kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24157 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9076 isolated_anon:0
 active_file:5418 inactive_file:13061 isolated_file:0
 unevictable:0 dirty:144 writeback:0
 slab_reclaimable:8893 slab_unreclaimable:67493
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615362 free_pcp:886 free_cma:0
Node 0 active_anon:484kB inactive_anon:36304kB active_file:21672kB inactive_file:52244kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:576kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3533892kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36304kB active_file:21672kB inactive_file:52244kB unevictable:0kB writepending:576kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:2172kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 1*4kB (E) 2*8kB (UE) 3*16kB (UME) 90*32kB (UME) 22*64kB (UME) 26*128kB (U) 18*256kB (UM) 2*512kB (UM) 2*1024kB (UE) 2*2048kB (UM) 858*4096kB (M) = 3533828kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24157 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9076 isolated_anon:0
 active_file:5418 inactive_file:13061 isolated_file:0
 unevictable:0 dirty:144 writeback:0
 slab_reclaimable:8893 slab_unreclaimable:67493
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615362 free_pcp:882 free_cma:0
Node 0 active_anon:484kB inactive_anon:36304kB active_file:21672kB inactive_file:52244kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:576kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3533892kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36304kB active_file:21672kB inactive_file:52244kB unevictable:0kB writepending:576kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:2156kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 1*4kB (E) 2*8kB (UE) 3*16kB (UME) 89*32kB (UME) 22*64kB (UME) 26*128kB (U) 18*256kB (UM) 2*512kB (UM) 2*1024kB (UE) 2*2048kB (UM) 858*4096kB (M) = 3533796kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24157 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9076 isolated_anon:0
 active_file:5418 inactive_file:13061 isolated_file:0
 unevictable:0 dirty:144 writeback:0
 slab_reclaimable:8893 slab_unreclaimable:67493
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615362 free_pcp:879 free_cma:0
Node 0 active_anon:484kB inactive_anon:36304kB active_file:21672kB inactive_file:52244kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:576kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3533892kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36304kB active_file:21672kB inactive_file:52244kB unevictable:0kB writepending:576kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:2144kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 1*4kB (E) 2*8kB (UE) 3*16kB (UME) 89*32kB (UME) 22*64kB (UME) 26*128kB (U) 18*256kB (UM) 2*512kB (UM) 2*1024kB (UE) 2*2048kB (UM) 858*4096kB (M) = 3533796kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24157 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9076 isolated_anon:0
 active_file:5418 inactive_file:13061 isolated_file:0
 unevictable:0 dirty:144 writeback:0
 slab_reclaimable:8893 slab_unreclaimable:67493
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615362 free_pcp:876 free_cma:0
Node 0 active_anon:484kB inactive_anon:36304kB active_file:21672kB inactive_file:52244kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:576kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3533892kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36304kB active_file:21672kB inactive_file:52244kB unevictable:0kB writepending:576kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:2128kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 1*4kB (E) 2*8kB (UE) 3*16kB (UME) 89*32kB (UME) 22*64kB (UME) 26*128kB (U) 18*256kB (UM) 2*512kB (UM) 2*1024kB (UE) 2*2048kB (UM) 858*4096kB (M) = 3533796kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24157 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9076 isolated_anon:0
 active_file:5418 inactive_file:13061 isolated_file:0
 unevictable:0 dirty:144 writeback:0
 slab_reclaimable:8893 slab_unreclaimable:67493
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615362 free_pcp:873 free_cma:0
Node 0 active_anon:484kB inactive_anon:36304kB active_file:21672kB inactive_file:52244kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:576kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3533892kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36304kB active_file:21672kB inactive_file:52244kB unevictable:0kB writepending:576kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:2120kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 1*4kB (E) 2*8kB (UE) 3*16kB (UME) 89*32kB (UME) 22*64kB (UME) 26*128kB (U) 18*256kB (UM) 2*512kB (UM) 2*1024kB (UE) 2*2048kB (UM) 858*4096kB (M) = 3533796kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24157 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9076 isolated_anon:0
 active_file:5418 inactive_file:13086 isolated_file:0
 unevictable:0 dirty:144 writeback:0
 slab_reclaimable:8893 slab_unreclaimable:67493
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615362 free_pcp:870 free_cma:0
Node 0 active_anon:484kB inactive_anon:36308kB active_file:21672kB inactive_file:52360kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:648kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3533860kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36308kB active_file:21672kB inactive_file:52360kB unevictable:0kB writepending:648kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:2108kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 1*4kB (E) 2*8kB (UE) 3*16kB (UME) 89*32kB (UME) 22*64kB (UME) 26*128kB (U) 18*256kB (UM) 2*512kB (UM) 2*1024kB (UE) 2*2048kB (UM) 858*4096kB (M) = 3533796kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24175 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9077 isolated_anon:0
 active_file:5418 inactive_file:13090 isolated_file:0
 unevictable:0 dirty:162 writeback:0
 slab_reclaimable:8894 slab_unreclaimable:67501
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615354 free_pcp:867 free_cma:0
Node 0 active_anon:484kB inactive_anon:36308kB active_file:21672kB inactive_file:52360kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:24172kB dirty:648kB writeback:0kB shmem:22672kB writeback_tmp:0kB kernel_stack:3872kB all_unreclaimable? no
Node 0 DMA free:15908kB min:24kB low:36kB high:48kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2840 6775 6775
Node 0 DMA32 free:2911648kB min:4408kB low:7316kB high:10224kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2913020kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1372kB local_pcp:56kB free_cma:0kB
lowmem_reserve[]: 0 0 3935 3935
Node 0 Normal free:3533860kB min:6112kB low:10140kB high:14168kB reserved_highatomic:0KB active_anon:484kB inactive_anon:36308kB active_file:21672kB inactive_file:52360kB unevictable:0kB writepending:648kB present:5242880kB managed:4030200kB mlocked:0kB pagetables:3176kB bounce:0kB free_pcp:2096kB local_pcp:1432kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15908kB
Node 0 DMA32: 6*4kB (M) 3*8kB (M) 3*16kB (M) 4*32kB (M) 5*64kB (M) 5*128kB (M) 5*256kB (M) 4*512kB (M) 3*1024kB (M) 2*2048kB (M) 708*4096kB (M) = 2911648kB
Node 0 Normal: 1*4kB (E) 2*8kB (UE) 3*16kB (UME) 89*32kB (UME) 22*64kB (UME) 26*128kB (U) 18*256kB (UM) 2*512kB (UM) 2*1024kB (UE) 2*2048kB (UM) 858*4096kB (M) = 3533796kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
24175 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
357269 pages reserved
Mem-Info:
active_anon:121 inactive_anon:9077 isolated_anon:0
 active_file:5418 inactive_file:13090 isolated_file:0
 unevictable:0 dirty:162 writeback:0
 slab_reclaimable:8894 slab_unreclaimable:67501
 mapped:6043 shmem:5668 pagetables:794 bounce:0
 free:1615354 free_pcp:
