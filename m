Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C9E280BE4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 03:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbgJBBSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 21:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgJBBSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 21:18:37 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BB42207F7;
        Fri,  2 Oct 2020 01:18:36 +0000 (UTC)
Date:   Thu, 1 Oct 2020 21:18:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] tracepoint: Fix out of sync data passing by static caller
Message-ID: <20201001211834.2c62cdcf@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Naresh reported a bug discovered in linux-next that I can reliably
trigger myself. It appears to be a side effect of the static calls. It
happens when going from more than one tracepoint callback to a single
one, and removing the first callback on the list. The list of
tracepoint callbacks holds data and a function to call with the
parameters of that tracepoint and a handler to the associated data.

 old_list:
	0: func = foo; data = NULL;
	1: func = bar; data = &bar_struct;

 new_list:
	0: func = bar; data = &bar_struct;


	CPU 0				CPU 1
	-----				-----
   tp_funcs = old_list;
   tp_static_caller = tp_interator

   __DO_TRACE()
 
    data = tp_funcs[0].data = NULL;

				   tp_funcs = new_list;
				   tracepoint_update_call()
				      tp_static_caller = tp_funcs[0] = bar;
    tp_static_caller(data)
       bar(data)
         x = data->item = NULL->item

       BOOM!

Funny, I was able to reliably trigger this bug, and always on the
sched_switch tracepoint. Which does make sense, because the
sched_switch tracepoint is a utility tracepoint that is attached to
collect information about tasks when tracing is enabled (like mapping
pids to comms). And most of these utility helpers do not have a data
item attached. But the trace events that attach to tracepoints do have
a data item that is used to find state and know what tracing buffer to
write to.

The race window is probably extended by any synchronization the text
poke may do, which would cause the sched switch to be triggered at
vulnerable times.

I've seen this:

 Testing event sched_migrate_task: OK
 Testing event sched_switch:
 BUG: kernel NULL pointer dereference, address: 0000000000000048
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 4 PID: 158 Comm: kworker/4:2 Not tainted 5.9.0-rc7-test-next-20201001+ #12
 Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
 Workqueue:  0x0 (events)
 RIP: 0010:trace_event_raw_event_sched_switch+0x1d/0x160
 Code: 75 c3 e9 4e ff ff ff e8 01 bd 9f 00 90 55 48 89 e5 41 57 49 89 cf 41 56 49 89 d6 41 55 41 89 f5 41 54 49 89 fc 53 48 83 ec 40 <48> 8b 5f 48 65 48 8b 04 25 28 00 00 00 48
1 c0 f6 c7
 RSP: 0018:ffffa93680487dc8 EFLAGS: 00010082
 RAX: ffff98a053129bb0 RBX: ffff98a05ab2df98 RCX: ffff98a059a70000
 RDX: ffff98a052ce5180 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: ffffa93680487e30 R08: 0000000000000000 R09: 0000000000000001
 R10: ffff98a052ce5180 R11: 0000000000000000 R12: 0000000000000000
 R13: 0000000000000000 R14: ffff98a052ce5180 R15: ffff98a059a70000
 FS:  0000000000000000(0000) GS:ffff98a05ab00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000048 CR3: 000000003b612002 CR4: 00000000001706e0
 Call Trace:
  ? trace_event_raw_event_sched_move_numa+0x100/0x100
  __schedule+0x5dd/0xa40
  schedule+0x45/0xe0
  worker_thread+0xc6/0x3a0
  ? process_one_work+0x570/0x570
  kthread+0x128/0x170
  ? kthread_park+0x90/0x90
  ret_from_fork+0x22/0x30

And that's called directly by the static call to the sched_switch trace
event callback (not the iterator), and it triggers with the data
pointer passed as NULL.

To solve this, add a tracepoint_synchronize_unregister() between
changing tp_funcs and updating the static tracepoint, that does both a
synchronize_rcu() and synchronize_srcu(). This will ensure that when
the static call is updated to the single callback that it will be
receiving the data that it registered with.

Note, to avoid over calling the synchronization functions, it is only
needed when going from the iterator back to a single caller, and if
that single caller wasn't the first one on the list before the update.

Link: https://lore.kernel.org/linux-next/CA+G9fYvPXVRO0NV7yL=FxCmFEMYkCwdz7R=9W+_votpT824YJA@mail.gmail.com

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: d25e37d89dd2f ("tracepoint: Optimize using static_call()")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 1b4be44d1d2b..b0baec351bd7 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -221,7 +221,7 @@ static void *func_remove(struct tracepoint_func **funcs,
 	return old;
 }
 
-static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func *tp_funcs)
+static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func *tp_funcs, bool sync)
 {
 	void *func = tp->iterator;
 
@@ -229,8 +229,17 @@ static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func
 	if (!tp->static_call_key)
 		return;
 
-	if (!tp_funcs[1].func)
+	if (!tp_funcs[1].func) {
 		func = tp_funcs[0].func;
+		/*
+		 * If going from the iterator back to a single caller,
+		 * we need to synchronize with __DO_TRACE to make sure
+		 * that the data passed to the callback is the one that
+		 * belongs to that callback.
+		 */
+		if (sync)
+			tracepoint_synchronize_unregister();
+	}
 
 	__static_call_update(tp->static_call_key, tp->static_call_tramp, func);
 }
@@ -265,7 +274,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	 * include/linux/tracepoint.h using rcu_dereference_sched().
 	 */
 	rcu_assign_pointer(tp->funcs, tp_funcs);
-	tracepoint_update_call(tp, tp_funcs);
+	tracepoint_update_call(tp, tp_funcs, false);
 	static_key_enable(&tp->key);
 
 	release_probes(old);
@@ -298,7 +307,8 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 
 		static_key_disable(&tp->key);
 	} else {
-		tracepoint_update_call(tp, tp_funcs);
+		tracepoint_update_call(tp, tp_funcs,
+				       tp_funcs[0].func != old[0].func);
 	}
 
 	rcu_assign_pointer(tp->funcs, tp_funcs);
