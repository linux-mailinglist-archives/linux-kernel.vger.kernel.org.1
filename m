Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EFB26E406
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgIQSks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgIQRSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:18:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75C5B221E7;
        Thu, 17 Sep 2020 17:18:24 +0000 (UTC)
Date:   Thu, 17 Sep 2020 13:18:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [WARNING] kernel/rcu/tree.c:1058 rcu_irq_enter+0x15/0x20
Message-ID: <20200917131647.2b55ebb1@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I ran my tests on a series of patches on top of 5.9-rc4, and hit the
following splat:

 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 2557 at kernel/rcu/tree.c:1058 rcu_irq_enter+0x15/0x20
 Modules linked in: [..]
 CPU: 0 PID: 2557 Comm: ftracetest Tainted: G        W         5.9.0-rc4-test+ #499
 Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
 RIP: 0010:rcu_irq_enter+0x15/0x20
 Code: 00 00 00 eb b6 0f 0b eb 81 66 66 2e 0f 1f 84 00 00 00 00 00 90 8b 05 86 6e c4 00 85 c0 74 0d 65 8b 05 db 71 4a 76 85 c0 74 02 <0f> 0b e9 34 ff ff ff 0f 1f 40 00 53 48 c7 c3 80 cc 02 00 e8 63 09
 RSP: 0018:ffff9372786538a0 EFLAGS: 00010002
 RAX: 0000000000000001 RBX: 0000000000000086 RCX: ffff937278654000
 RDX: 000000000001ec80 RSI: ffffffff890721f1 RDI: ffffffff8a677f20
 RBP: ffffffff890721f1 R08: 0000000000000000 R09: ffffffff8b58b430
 R10: ffff937278653a60 R11: 0000000000000001 R12: ffffffff890721f1
 R13: 0000000000000000 R14: ffff937278653920 R15: ffff9372cee128c0
 FS:  00007fde773f2740(0000) GS:ffff9372daa00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000564b58579d68 CR3: 000000007eebe001 CR4: 00000000001706f0
 Call Trace:
  rcu_irq_enter_irqson+0x21/0x40
  trace_preempt_off+0x6e/0xd0
  ? __unwind_start+0x18c/0x1e0
  unwind_next_frame+0x41/0x560
  ? noop_count+0x10/0x10
  __unwind_start+0x153/0x1e0
  ? profile_setup.cold+0xa1/0xa1
  arch_stack_walk+0x76/0x100
  ? __unwind_start+0x18c/0x1e0
  stack_trace_save+0x4b/0x70
  save_trace+0x42/0x350
  __lock_acquire+0x1858/0x2460
  lock_acquire+0xdc/0x3b0
  ? __sched_setscheduler+0x4d4/0x970
  cpuset_read_lock+0x26/0xc0
  ? __sched_setscheduler+0x4d4/0x970
  __sched_setscheduler+0x4d4/0x970
  ? trace_benchmark_reg+0x50/0x50
  _sched_setscheduler+0x68/0xa0
  __kthread_create_on_node+0x145/0x1c0
  ? perf_trace_benchmark_event+0x170/0x170
  kthread_create_on_node+0x51/0x70
  trace_benchmark_reg+0x28/0x50
  tracepoint_probe_register_prio+0x12f/0x310
  ? __mutex_unlock_slowpath+0x45/0x2a0
  __ftrace_event_enable_disable+0x75/0x240
  __ftrace_set_clr_event_nolock+0xef/0x130
  __ftrace_set_clr_event+0x39/0x60
  ftrace_set_clr_event+0x4a/0xa0
  ftrace_event_write+0xda/0x110
  vfs_write+0xca/0x210
  ksys_write+0x70/0xf0
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7fde774e7487
 Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
 RSP: 002b:00007ffeb8ec9d38 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fde774e7487
 RDX: 0000000000000004 RSI: 0000564b584eb690 RDI: 0000000000000001
 RBP: 0000564b584eb690 R08: 000000000000000a R09: 0000000000000003
 R10: 0000564b58544510 R11: 0000000000000246 R12: 0000000000000004
 R13: 00007fde775b8500 R14: 0000000000000004 R15: 00007fde775b8700
 irq event stamp: 108343
 hardirqs last  enabled at (108343): [<ffffffff89b6efbc>] exc_nmi+0xbc/0x160
 hardirqs last disabled at (108342): [<ffffffff89b6ef9d>] exc_nmi+0x9d/0x160
 softirqs last  enabled at (107622): [<ffffffff89e003b4>] __do_softirq+0x3b4/0x501
 softirqs last disabled at (107615): [<ffffffff89c01072>] asm_call_on_stack+0x12/0x20


What looks to have happened was:

  cpuset_read_lock()
     lockdep called
       save stack trace
          preempt_disable()
             trace_preempt_disable();
                rcu_irq_enter_irqson();
                   local_irq_save() (ignored by lockdep due to recursion set)
                      rcu_irq_enter();
                         lockdep_assert_irqs_disabled() (no, because it was ignored by recursion being set)

                          BOOM!


Thoughts?

Note, the warning goes away with the below patch.

-- Steve

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6a584b3e5c74..3e5bc1dd71c6 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -550,7 +550,8 @@ do {									\
 
 #define lockdep_assert_irqs_disabled()					\
 do {									\
-	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled));	\
+	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled) &&	\
+           likely(!(current->lockdep_recursion & LOCKDEP_RECURSION_MASK)));\
 } while (0)
 
 #define lockdep_assert_in_irq()						\
