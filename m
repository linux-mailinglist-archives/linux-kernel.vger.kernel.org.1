Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835532A0665
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgJ3N1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgJ3N1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:27:02 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0DE02075E;
        Fri, 30 Oct 2020 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604064420;
        bh=/GdmPek00sclc1yAS2TgH3u8onwR/BY1Ny0JXUu7VjM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=txTIzWHGcuvwwGskpjhxhzu7aKTZgyqLccx/3XpLkQYNOsGs0gTHZTJB+Y9tlwAGF
         3i+tl/uvRM8+ATRIfp6JkCrQ+jqr3m4dwPk/RfftHAreShHpq7CyNqcM26HU+Ep0my
         lnN5nUGP34P28apKLj2pTGJix/zMthXBRMAg2PVE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3DC7B3522675; Fri, 30 Oct 2020 06:27:00 -0700 (PDT)
Date:   Fri, 30 Oct 2020 06:27:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        syzbot <syzbot+f04854e1c5c9e913cc27@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: INFO: rcu detected stall in sys_exit_group (6)
Message-ID: <20201030132700.GQ3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <000000000000538f3205b00bcb06@google.com>
 <20200924110731.9548-1-hdanton@sina.com>
 <20200924120609.GS18329@kadam>
 <20200925014616.13436-1-hdanton@sina.com>
 <20200925033618.GD29330@paulmck-ThinkPad-P72>
 <CACT4Y+bjRQUjNT7ky89xu21LDzSquC4NUx8oZL7_qi6PVt9Cnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bjRQUjNT7ky89xu21LDzSquC4NUx8oZL7_qi6PVt9Cnw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:57:58AM +0100, Dmitry Vyukov wrote:
> On Fri, Sep 25, 2020 at 5:36 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > On Thu, Sep 24, 2020 at 07:07:31PM +0800, Hillf Danton wrote:
> > > > > >
> > > > > > Thu, 24 Sep 2020 02:26:25 -0700
> > > > > > > syzbot found the following issue on:
> > > > > > >
> > > > > > > HEAD commit:    805c6d3c Merge branch 'fixes' of git://git.kernel.org/pub/..
> > > > > > > git tree:       upstream
> > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=11fef4e3900000
> > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=af502ec9a451c9fc
> > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=f04854e1c5c9e913cc27
> > > > > > > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d419c5900000
> > > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1686b4bb900000
> > > > > > >
> > > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > > Reported-by: syzbot+f04854e1c5c9e913cc27@syzkaller.appspotmail.com
> > > > > > >
> > > > > > > rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > > > rcu:  Tasks blocked on level-0 rcu_node (CPUs 0-1):
> > > > > > > ------------[ cut here ]------------
> > > > > > > WARNING: CPU: 1 PID: 27130 at kernel/sched/core.c:3013 rq_unlock kernel/sched/sched.h:1325 [inline]
> > > > > > > WARNING: CPU: 1 PID: 27130 at kernel/sched/core.c:3013 try_invoke_on_locked_down_task+0x12d/0x270 kernel/sched/core.c:3019
> > > > > > > Kernel panic - not syncing: panic_on_warn set ...
> > > > > > > CPU: 1 PID: 27130 Comm: syz-executor076 Not tainted 5.9.0-rc6-syzkaller #0
> > > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > > > > Call Trace:
> > > > > > >  <IRQ>
> > > > > > >  __dump_stack lib/dump_stack.c:77 [inline]
> > > > > > >  dump_stack+0x1d6/0x29e lib/dump_stack.c:118
> > > > > > >  panic+0x2c0/0x800 kernel/panic.c:231
> > > > > > >  __warn+0x227/0x250 kernel/panic.c:600
> > > > > > >  report_bug+0x1b1/0x2e0 lib/bug.c:198
> > > > > > >  handle_bug+0x42/0x80 arch/x86/kernel/traps.c:234
> > > > > > >  exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:254
> > > > > > >  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
> > > > > > > RIP: 0010:try_invoke_on_locked_down_task+0x12d/0x270 kernel/sched/sched.h:1325
> > > > > > > Code: f8 48 c1 e8 03 42 8a 04 38 84 c0 0f 85 10 01 00 00 8b 74 24 18 48 89 ef e8 90 47 09 00 4c 89 ef e8 48 4c fb 06 e9 a4 00 00 00 <0f> 0b e9 2b ff ff ff 48 c7 c1 34 d6 af 89 80 e1 07 80 c1 03 38 c1
> > > > > > > RSP: 0018:ffffc90000da8c50 EFLAGS: 00010046
> > > > > > > RAX: 0000000000000000 RBX: ffff888097326380 RCX: 6195009cdd28a200
> > > > > > > RDX: ffffc90000da8d00 RSI: ffffffff8162e8d0 RDI: ffff888089c50500
> > > > > > > RBP: ffffffff8162e8d0 R08: dffffc0000000000 R09: fffffbfff12df8f9
> > > > > > > R10: fffffbfff12df8f9 R11: 0000000000000000 R12: 0000000000000000
> > > > > > > R13: ffffffff896ff600 R14: ffff888089c50500 R15: dffffc0000000000
> > > > > > >  rcu_print_task_stall kernel/rcu/tree_stall.h:267 [inline]
> > > > > > >  print_other_cpu_stall kernel/rcu/tree_stall.h:475 [inline]
> > > > > > >  check_cpu_stall kernel/rcu/tree_stall.h:634 [inline]
> > > > > > >  rcu_pending kernel/rcu/tree.c:3637 [inline]
> > > > > > >  rcu_sched_clock_irq+0x12bc/0x1eb0 kernel/rcu/tree.c:2519
> > > > > > >  update_process_times+0x130/0x1b0 kernel/time/timer.c:1710
> > > > > > >  tick_sched_handle kernel/time/tick-sched.c:176 [inline]
> > > > > > >  tick_sched_timer+0x25e/0x410 kernel/time/tick-sched.c:1328
> > > > > > >  __run_hrtimer kernel/time/hrtimer.c:1524 [inline]
> > > > > > >  __hrtimer_run_queues+0x42d/0x930 kernel/time/hrtimer.c:1588
> > > > > > >  hrtimer_interrupt+0x373/0xd60 kernel/time/hrtimer.c:1650
> > > > > > >  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
> > > > > > >  __sysvec_apic_timer_interrupt+0xf0/0x260 arch/x86/kernel/apic/apic.c:1097
> > > > > > >  asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
> > > > > > >  </IRQ>
> > > > > > >  __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
> > > > > > >  run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
> > > > > > >  sysvec_apic_timer_interrupt+0x94/0xf0 arch/x86/kernel/apic/apic.c:1091
> > > > > > >  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
> > > > > > > RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:770 [inline]
> > > > > > > RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
> > > > > > > RIP: 0010:_raw_spin_unlock_irqrestore+0x63/0x90 kernel/locking/spinlock.c:191
> > > > > > > Code: b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 0c 48 c7 c7 b8 17 6d 89 e8 cc 9b 68 f9 48 83 3d 3c d8 20 01 00 74 2a 4c 89 f7 57 9d <0f> 1f 44 00 00 bf 01 00 00 00 e8 4e a3 04 f9 65 8b 05 73 be b5 77
> > > > > > > RSP: 0018:ffffc9000ad479a0 EFLAGS: 00000282
> > > > > > > RAX: 1ffffffff12da2f7 RBX: ffffffff8bc9d3e8 RCX: dffffc0000000000
> > > > > > > RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000282
> > > > > > > RBP: 1ffff11010d98d45 R08: ffffffff817ad120 R09: fffffbfff1793a7e
> > > > > > > R10: fffffbfff1793a7e R11: 0000000000000000 R12: ffff888084aa9000
> > > > > > > R13: 0000000000000013 R14: 0000000000000282 R15: 0000000000000001
> > > > > > >  __debug_check_no_obj_freed lib/debugobjects.c:977 [inline]
> > > > > > >  debug_check_no_obj_freed+0x592/0x640 lib/debugobjects.c:998
> > > > > > >  free_pages_prepare mm/page_alloc.c:1214 [inline]
> > > > > > >  free_pcp_prepare+0x1f5/0x400 mm/page_alloc.c:1244
> > > > > > >  free_unref_page_prepare mm/page_alloc.c:3099 [inline]
> > > > > > >  free_unref_page_list+0xb0/0x550 mm/page_alloc.c:3168
> > > > > > >  release_pages+0x13aa/0x1550 mm/swap.c:913
> > > > > > >  tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
> > > > > > >  tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
> > > > > > >  tlb_flush_mmu+0x780/0x910 mm/mmu_gather.c:249
> > > > > > >  tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:328
> > > > > > >  exit_mmap+0x296/0x550 mm/mmap.c:3185
> > > > > > >  __mmput+0x113/0x370 kernel/fork.c:1076
> > > > > > >  exit_mm+0x4cd/0x550 kernel/exit.c:483
> > > > > > >  do_exit+0x576/0x1f20 kernel/exit.c:793
> > > > > > >  do_group_exit+0x161/0x2d0 kernel/exit.c:903
> > > > > > >  __do_sys_exit_group+0x13/0x20 kernel/exit.c:914
> > > > > > >  __se_sys_exit_group+0x10/0x10 kernel/exit.c:912
> > > > > > >  __x64_sys_exit_group+0x37/0x40 kernel/exit.c:912
> > > > > > >  do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
> > > > > > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > > >
> > > > > > Hard to understand what the syzbot reported because it's been there after
> > > > > > 2beaf3280e57 ("sched/core: Add function to sample state of locked-down task").
> > > > > > Why does it take a couple months to trigger if this is a routine test.
> > > > >
> > > > > I think this was already fix in linux-next commit 9e097980efe9
> > > > > ("sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled")
> > > >
> > > > That it is, but does the following alternative commit fix this problem
> > > > for you guys?
> > > >
> > > >                                                     Thanx, Paul
> > > >
> > >
> > > Thanks for your fix.
> > >
> > > > ------------------------------------------------------------------------
> > > >
> > > > commit 6ddb952343843f50d41ab42c805c1c41dfb403ed
> > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > Date:   Thu Sep 24 15:11:55 2020 -0700
> > > >
> > > >     rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled
> > > >
> > > >     The try_invoke_on_locked_down_task() function requires that
> > > >     interrupts be enabled, but it is called with interrupts disabled from
> > > >     rcu_print_task_stall(), resulting in an "IRQs not enabled as expected"
> > > >     diagnostic.  This commit therefore updates rcu_print_task_stall()
> > >
> > > It's trying to bridge the gap between what the function in question requires
> > > and the IRQ context in which it's invoked by paying more care to IRQ than
> > > thougt.
> >
> > Exactly.
> >
> > > Is there likely OTOH a simpler way for us to go in the IRQ contexts like
> > > the one syzbot reported, I mean, without IRQ considered while pringting
> > > task stall info? That may save us two or three minutes as we will have
> > > less to do.
> >
> > I will stick with the current solution until further notice, thank you!  ;-)
> 
> Paul, was this ever merged?  Has the title changed?
> syzbot still tracks this as open bug:
> https://syzkaller.appspot.com/bug?id=344259d583eabeae7ce122fa5a79fe4e8a99f535
> 
> The fix titled "rcu: Don't invoke try_invoke_on_locked_down_task()
> with irqs disabled" seems to have appeared in linux-next at some
> point. But now I can't find it anywhere...

That would be because I forgot to reset the -rcu tree's rcu/next branch,
which I just now fixed.  Thank you for spotting this!

								Thanx, Paul

> > > >     to accumulate a list of the first few tasks while holding the current
> > > >     leaf rcu_node structure's ->lock, then releases that lock and only then
> > > >     uses try_invoke_on_locked_down_task() to attempt to obtain per-task
> > > >     detailed information.  Of course, as soon as ->lock is released, the
> > > >     task might exit, so the get_task_struct() function is used to prevent
> > > >     the task structure from going away in the meantime.
> > > >
> > > >     Link: https://lore.kernel.org/lkml/000000000000903d5805ab908fc4@google.com/
> > > >     Reported-by: syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com
> > > >     Reported-by: syzbot+f04854e1c5c9e913cc27@syzkaller.appspotmail.com
> > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > >
> > > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > > index 228c55f..70d48c5 100644
> > > > --- a/kernel/rcu/tree_stall.h
> > > > +++ b/kernel/rcu/tree_stall.h
> > > > @@ -255,13 +255,16 @@ static bool check_slow_task(struct task_struct *t, void *arg)
> > > >
> > > >  /*
> > > >   * Scan the current list of tasks blocked within RCU read-side critical
> > > > - * sections, printing out the tid of each.
> > > > + * sections, printing out the tid of each of the first few of them.
> > > >   */
> > > > -static int rcu_print_task_stall(struct rcu_node *rnp)
> > > > +static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
> > > > +   __releases(rnp->lock)
> > > >  {
> > > > +   int i = 0;
> > > >     int ndetected = 0;
> > > >     struct rcu_stall_chk_rdr rscr;
> > > >     struct task_struct *t;
> > > > +   struct task_struct *ts[8];
> > > >
> > > >     if (!rcu_preempt_blocked_readers_cgp(rnp))
> > > >             return 0;
> > > > @@ -270,6 +273,14 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
> > > >     t = list_entry(rnp->gp_tasks->prev,
> > > >                    struct task_struct, rcu_node_entry);
> > > >     list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
> > > > +           get_task_struct(t);
> > > > +           ts[i++] = t;
> > > > +           if (i >= ARRAY_SIZE(ts))
> > > > +                   break;
> > > > +   }
> > > > +   raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > > +   for (i--; i; i--) {
> > > > +           t = ts[i];
> > > >             if (!try_invoke_on_locked_down_task(t, check_slow_task, &rscr))
> > > >                     pr_cont(" P%d", t->pid);
> > > >             else
> > > > @@ -279,6 +290,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
> > > >                             ".q"[rscr.rs.b.need_qs],
> > > >                             ".e"[rscr.rs.b.exp_hint],
> > > >                             ".l"[rscr.on_blkd_list]);
> > > > +           put_task_struct(t);
> > > >             ndetected++;
> > > >     }
> > > >     pr_cont("\n");
> > > > @@ -299,8 +311,9 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
> > > >   * Because preemptible RCU does not exist, we never have to check for
> > > >   * tasks blocked within RCU read-side critical sections.
> > > >   */
> > > > -static int rcu_print_task_stall(struct rcu_node *rnp)
> > > > +static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
> > > >  {
> > > > +   raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > >     return 0;
> > > >  }
> > > >  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
> > > > @@ -478,7 +491,6 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
> > > >     pr_err("INFO: %s detected stalls on CPUs/tasks:\n", rcu_state.name);
> > > >     rcu_for_each_leaf_node(rnp) {
> > > >             raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > > -           ndetected += rcu_print_task_stall(rnp);
> > > >             if (rnp->qsmask != 0) {
> > > >                     for_each_leaf_node_possible_cpu(rnp, cpu)
> > > >                             if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
> > > > @@ -486,7 +498,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
> > > >                                     ndetected++;
> > > >                             }
> > > >             }
> > > > -           raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > > +           ndetected += rcu_print_task_stall(rnp, flags); // Releases rnp->lock.
> > > >     }
> > > >
> > > >     for_each_possible_cpu(cpu)
> > > >
> > >
