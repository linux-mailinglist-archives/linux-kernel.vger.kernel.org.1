Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5F72EB51C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbhAEWB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbhAEWB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:01:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 158AE22D74;
        Tue,  5 Jan 2021 22:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609884076;
        bh=I1TNPuuArW9XmxExKkKICQUAVr9gn+sfdMgKhrRyXqo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=LRfAIfWZ2ZnvkULNDNiN8hAu72pRjux+VEury0gSD/yO9oQ7U8eN2h8PRNqTe6L/n
         2ytrjZZ4wtQk6rElakdLmLPPnVa5GP3B/dEfkHzXcXqYlzibhP+5MY0pwIEFuof8zQ
         obtMqGJOin2PRrf3/FfMyR5tFcPs9Y/TKg9c2jOKjbxd5aYADkxdUjE4hAclxS7Soa
         4TW7ssRn2zcJqiJBy13cH07zCkzqejRhJXKdLc2LhPVl2qqn8t/icgha17RwltLoyG
         5RiWIB2CDQO2Izj6/HMrMKhTv6GzpX06PwtHGNg2WB2uJhxwttzH2hrUMtE3JufpPG
         yLOPgyYq3knTA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D23DC3522A62; Tue,  5 Jan 2021 14:01:15 -0800 (PST)
Date:   Tue, 5 Jan 2021 14:01:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        valentin.schneider@arm.com, bristot@redhat.com, frederic@kernel.org
Subject: lockdep splat in v5.11-rc1 involving console_sem and rq locks
Message-ID: <20210105220115.GA27357@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The RUDE01 rcutorture scenario (and less often, the TASKS01 scenario)
results in occasional lockdep splats on v5.11-rc1 on x86.  This failure
is probabalistic, sometimes happening as much as 30% of the time, but
sometimes happening quite a bit less frequently.  (And yes, this did
result in a false bisection.  Why do you ask?)  The problem seems to
happen more frequently shortly after boot, so for fastest reproduction
run lots of 10-minute RUDE01 runs, which did eventually result in a
good bisection.  (Yes, I did hammer the last good commit for awhile.)

The first bad commit is 1cf12e08bc4d ("sched/hotplug: Consolidate task
migration on CPU unplug").  An example splat is shown below.

Thoughts?

							Thanx, Paul

======================================================
WARNING: possible circular locking dependency detected
5.10.0-rc1+ #835 Not tainted
------------------------------------------------------
migration/1/14 is trying to acquire lock:
ffffffffb014ed38 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0xa/0x30

but task is already holding lock:
ffff92a1df52b158 (&rq->lock){-.-.}-{2:2}, at: sched_cpu_dying+0x2b/0xe0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&rq->lock){-.-.}-{2:2}:
       lock_acquire+0xc7/0x3a0
       _raw_spin_lock+0x2a/0x40
       task_fork_fair+0x39/0x150
       sched_fork+0x109/0x210
       copy_process+0x9b7/0x1da0
       kernel_clone+0x98/0x6d0
       kernel_thread+0x50/0x70
       rest_init+0x1d/0x236
       start_kernel+0x535/0x55a
       secondary_startup_64_no_verify+0xb8/0xbb

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0xc7/0x3a0
       _raw_spin_lock_irqsave+0x33/0x50
       try_to_wake_up+0x5a/0x760
       up+0x3b/0x50
       __up_console_sem+0x29/0x60
       console_unlock+0x31e/0x550
       vprintk_emit+0x1c5/0x2d0
       printk+0x53/0x6a
       rcu_torture_read_exit.cold.36+0x5b/0x7f
       kthread+0x13b/0x160
       ret_from_fork+0x22/0x30

-> #0 ((console_sem).lock){-.-.}-{2:2}:
       validate_chain+0x8b4/0x1c20
       __lock_acquire+0x576/0xaf0
       lock_acquire+0xc7/0x3a0
       _raw_spin_lock_irqsave+0x33/0x50
       down_trylock+0xa/0x30
       __down_trylock_console_sem+0x23/0x90
       console_trylock+0xe/0x50
       vprintk_emit+0xcb/0x2d0
       printk+0x53/0x6a
       report_bug.cold.4+0xc/0x4c
       handle_bug+0x44/0x80
       exc_invalid_op+0x13/0x60
       asm_exc_invalid_op+0x12/0x20
       sched_cpu_dying+0xd2/0xe0
       cpuhp_invoke_callback+0x9e/0x890
       take_cpu_down+0x62/0xa0
       multi_cpu_stop+0x5e/0x100
       cpu_stopper_thread+0x8a/0x130
       smpboot_thread_fn+0x193/0x230
       kthread+0x13b/0x160
       ret_from_fork+0x22/0x30

other info that might help us debug this:

Chain exists of:
  (console_sem).lock --> &p->pi_lock --> &rq->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->lock);
                               lock(&p->pi_lock);
                               lock(&rq->lock);
  lock((console_sem).lock);

 *** DEADLOCK ***

1 lock held by migration/1/14:
 #0: ffff92a1df52b158 (&rq->lock){-.-.}-{2:2}, at: sched_cpu_dying+0x2b/0xe0

stack backtrace:
CPU: 1 PID: 14 Comm: migration/1 Not tainted 5.10.0-rc1+ #835
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
Stopper: multi_cpu_stop+0x0/0x100 <- 0x0
Call Trace:
 dump_stack+0x77/0x97
 check_noncircular+0xfe/0x110
 validate_chain+0x8b4/0x1c20
 __lock_acquire+0x576/0xaf0
 lock_acquire+0xc7/0x3a0
 ? down_trylock+0xa/0x30
 ? vprintk_emit+0xcb/0x2d0
 _raw_spin_lock_irqsave+0x33/0x50
 ? down_trylock+0xa/0x30
 down_trylock+0xa/0x30
 __down_trylock_console_sem+0x23/0x90
 console_trylock+0xe/0x50
 vprintk_emit+0xcb/0x2d0
 printk+0x53/0x6a
 ? sched_cpu_dying+0xd2/0xe0
 report_bug.cold.4+0xc/0x4c
 handle_bug+0x44/0x80
 exc_invalid_op+0x13/0x60
 asm_exc_invalid_op+0x12/0x20
RIP: 0010:sched_cpu_dying+0xd2/0xe0
Code: c0 41 5c 41 5d 41 5e 41 5f 5d c3 f0 48 01 05 b5 ff 00 02 eb c9 48 89 df e8 db 10 06 00 31 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b 0f 0b 66 2e 0f 1f 84 00 00 00 00 00 53 48 89 fb e8 a7 72 02
RSP: 0000:ffff9c0740087db0 EFLAGS: 00010002
RAX: ffff92a1c1063000 RBX: ffff92a1df52b140 RCX: 00000000000b71b0
RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff92a1df52b140
RBP: ffff9c0740087dd8 R08: ffff92a1c105d094 R09: ffff92a1c118db00
R10: ffff9c0740087bc8 R11: ffff92a1c118e400 R12: 0000000000000001
R13: ffff92a1df52b158 R14: 0000000000000082 R15: 000000000000b319
 ? sched_cpu_wait_empty+0x80/0x80
 cpuhp_invoke_callback+0x9e/0x890
 ? hpet_assign_irq+0x90/0x90
 take_cpu_down+0x62/0xa0
 multi_cpu_stop+0x5e/0x100
 ? stop_machine_yield+0x10/0x10
 cpu_stopper_thread+0x8a/0x130
 ? sort_range+0x20/0x20
 smpboot_thread_fn+0x193/0x230
 kthread+0x13b/0x160
 ? kthread_insert_work_sanity_check+0x50/0x50
 ret_from_fork+0x22/0x30
