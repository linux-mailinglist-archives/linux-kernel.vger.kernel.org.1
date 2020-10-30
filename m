Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D367D29FCAE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 05:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJ3E12 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Oct 2020 00:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgJ3E11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 00:27:27 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25DE2206DD;
        Fri, 30 Oct 2020 04:27:25 +0000 (UTC)
Date:   Fri, 30 Oct 2020 00:27:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kan.liang@linux.intel.com,
        like.xu@linux.intel.com
Subject: [BUG] Stack overflow when running perf and function tracer
Message-ID: <20201030002722.766a22df@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found a bug in the recursion protection that prevented function
tracing from running in NMI context. Applying this fix to 5.9 worked
fine (tested by running perf record and function tracing at the same
time). But when I applied the patch to 5.10-rc1, it blew up with a
stack overflow:

perf: interrupt took too long (14611 > 13550), lowering kernel.perf_event_max_sample_rate to 13000
perf: interrupt took too long (27965 > 18263), lowering kernel.perf_event_max_sample_rate to 7000
 INFO: NMI handler (perf_event_nmi_handler) took too long to run: 0.000 msecs
 INFO: NMI handler (perf_event_nmi_handler) took too long to run: 1.087 msecs
 INFO: NMI handler (perf_event_nmi_handler) took too long to run: 9.082 msecs
 perf: interrupt took too long (27965 > 18263), lowering kernel.perf_event_max_sample_rate to 7000
 traps: PANIC: double fault, error_code: 0x0
 double fault: 0000 [#1] PREEMPT SMP PTI
 CPU: 1 PID: 1655 Comm: perf Not tainted 5.9.0-rc1-test+ #685
 Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
 RIP: 0010:__rb_reserve_next+0xb/0x450
 Code: 4f 10 f0 ff 41 08 0f 0b 83 f8 02 0f 84 97 fb ff ff e9 a5 fc ff ff b8 04 00 00 00 eb e1 66 90 41 57 41 56 41 55 41 54 49 89 f4 <55> 48 89 fd 53 48 83 ec 08 48 8b 9f 98 00 00 00 48 89 5e 28 4c 8b
 RSP: 0018:fffffe000003c000 EFLAGS: 00010046
 RAX: 000000000000001c RBX: ffff928ada27b400 RCX: 0000000000000000
 RDX: ffff928ada07b200 RSI: fffffe000003c028 RDI: ffff928ada27b400
 RBP: ffff928ada27b4f0 R08: 0000000000000001 R09: 0000000000000000
 R10: fffffe000003c440 R11: ffff928a7383cc60 R12: fffffe000003c028
 R13: 00000000000003e8 R14: 0000000000000046 R15: 0000000000110001
 FS:  00007f25d43cf780(0000) GS:ffff928adaa40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: fffffe000003bff8 CR3: 00000000b52a8005 CR4: 00000000001707e0
 Call Trace:
  <NMI>
  ring_buffer_lock_reserve+0x12c/0x380
  ? perf_output_begin+0x4d/0x2d0
  ? rcu_panic+0x20/0x20
  trace_function+0x27/0x130
  ? rcu_panic+0x20/0x20
  ? perf_output_begin+0x4d/0x2d0
  function_trace_call+0x133/0x180
  0xffffffffc02a106a
  ? __rcu_read_lock+0x5/0x20
  __rcu_read_lock+0x5/0x20
  perf_output_begin+0x4d/0x2d0
  ? sched_clock+0x5/0x10
  ? trace_clock_local+0xc/0x20
  ? __rb_reserve_next+0x5c/0x450
  ? sched_clock+0x5/0x10
  ? ring_buffer_lock_reserve+0x12c/0x380
  ? sched_clock+0x5/0x10
  ? trace_clock_local+0xc/0x20
  ? __rb_reserve_next+0x5c/0x450
  ? ring_buffer_lock_reserve+0x12c/0x380
  ? perf_log_throttle+0x9a/0x120
  ? perf_log_throttle+0x9a/0x120
  ? perf_output_begin_backward+0x280/0x280
  ? trace_function+0x88/0x130
  ? ring_buffer_unlock_commit+0x25/0x140
  ? perf_output_begin_backward+0x280/0x280
  ? perf_log_throttle+0x9a/0x120
  ? function_trace_call+0x133/0x180
  ? 0xffffffffc02a106a
  ? perf_log_throttle+0x9a/0x120
  ? perf_output_begin+0x5/0x2d0
  ? __perf_event_header__init_id.isra.0+0x39/0xd0
  ? perf_output_begin+0x5/0x2d0
  perf_log_throttle+0x9a/0x120
  ? trace_clock_local+0xc/0x20
  ? __rb_reserve_next+0x5c/0x450
  ? sched_clock+0x5/0x10
  ? ring_buffer_lock_reserve+0x12c/0x380
  ? sched_clock+0x5/0x10
  ? sched_clock+0x5/0x10
  ? sched_clock+0x5/0x10
  ? trace_clock_local+0xc/0x20
  ? __rb_reserve_next+0x5c/0x450
  ? sched_clock+0x5/0x10
  ? trace_clock_local+0xc/0x20
  ? __rb_reserve_next+0x5c/0x450
  ? setup_pebs_fixed_sample_data+0x365/0x3a0
  ? setup_pebs_fixed_sample_data+0x365/0x3a0
  ? intel_pmu_pebs_event_update_no_drain+0x70/0x70
  ? trace_function+0x88/0x130
  ? ring_buffer_unlock_commit+0x25/0x140
  ? intel_pmu_pebs_event_update_no_drain+0x70/0x70
  ? setup_pebs_fixed_sample_data+0x365/0x3a0
  ? function_trace_call+0x133/0x180
  ? intel_pmu_pebs_fixup_ip+0x32/0x1b0
  ? function_trace_call+0x133/0x180
  ? native_write_msr+0x6/0x20
  __perf_event_account_interrupt+0xa9/0x120
  __perf_event_overflow+0x2b/0xf0
  __intel_pmu_pebs_event+0x2ec/0x3e0
  ? trace_function+0x88/0x130
  ? ring_buffer_unlock_commit+0x25/0x140
  ? setup_pebs_adaptive_sample_data+0x3e0/0x3e0
  ? 0xffffffffc02a106a
  ? 0xffffffffc02a106a
  ? generic_exec_single+0xa6/0xe0
  ? perf_duration_warn+0x20/0x20
  ? generic_exec_single+0xa6/0xe0
  ? native_write_msr+0x6/0x20
  ? ring_buffer_lock_reserve+0x1b9/0x380
  ? ring_buffer_lock_reserve+0x12c/0x380
  ? intel_pmu_drain_pebs_nhm+0x268/0x330
  ? intel_pmu_drain_pebs_nhm+0x268/0x330
  ? release_bts_buffer+0x60/0x60
  ? trace_function+0x88/0x130
  ? ring_buffer_unlock_commit+0x25/0x140
  ? release_bts_buffer+0x60/0x60
  ? intel_pmu_drain_pebs_nhm+0x268/0x330
  ? function_trace_call+0x133/0x180
  ? 0xffffffffc02a106a
  ? ring_buffer_lock_reserve+0x12c/0x380
  intel_pmu_drain_pebs_nhm+0x268/0x330
  ? setup_pebs_adaptive_sample_data+0x3e0/0x3e0
  handle_pmi_common+0xc2/0x2b0
  ? __rb_reserve_next+0x5c/0x450
  ? sched_clock+0x5/0x10
  ? trace_clock_local+0xc/0x20
  ? __rb_reserve_next+0x5c/0x450
  ? ring_buffer_lock_reserve+0x12c/0x380
  ? intel_pmu_handle_irq+0xc8/0x160
  ? intel_pmu_ha
 Lost 135 message(s)!
 ---[ end trace ba215b7ba269800a ]---
 RIP: 0010:__rb_reserve_next+0xb/0x450
 Code: 4f 10 f0 ff 41 08 0f 0b 83 f8 02 0f 84 97 fb ff ff e9 a5 fc ff ff b8 04 00 00 00 eb e1 66 90 41 57 41 56 41 55 41 54 49 89 f4 <55> 48 89 fd 53 48 83 ec 08 48 8b 9f 98 00 00 00 48 89 5e 28 4c 8b
 RSP: 0018:fffffe000003c000 EFLAGS: 00010046
 RAX: 000000000000001c RBX: ffff928ada27b400 RCX: 0000000000000000
 RDX: ffff928ada07b200 RSI: fffffe000003c028 RDI: ffff928ada27b400
 RBP: ffff928ada27b4f0 R08: 0000000000000001 R09: 0000000000000000
 R10: fffffe000003c440 R11: ffff928a7383cc60 R12: fffffe000003c028
 R13: 00000000000003e8 R14: 0000000000000046 R15: 0000000000110001
 FS:  00007f25d43cf780(0000) GS:ffff928adaa40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: fffffe000003bff8 CR3: 00000000b52a8005 CR4: 00000000001707e0
 Kernel panic - not syncing: Fatal exception in interrupt
 Kernel Offset: 0x11000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)


I bisected it down to:

35d1ce6bec133679ff16325d335217f108b84871 ("perf/x86/intel/ds: Fix
x86_pmu_stop warning for large PEBS")

Which looks to be storing an awful lot on the stack:

static void __intel_pmu_pebs_event(struct perf_event *event,
				   struct pt_regs *iregs,
				   void *base, void *top,
				   int bit, int count,
				   void (*setup_sample)(struct perf_event *,
						struct pt_regs *,
						void *,
						struct perf_sample_data *,
						struct pt_regs *))
{
	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
	struct hw_perf_event *hwc = &event->hw;
	struct perf_sample_data data;
	struct x86_perf_regs perf_regs;
	struct pt_regs *regs = &perf_regs.regs;
	void *at = get_next_pebs_record_by_bit(base, top, bit);
	struct pt_regs dummy_iregs;

Reverting this patch from 5.10-rc1 makes makes the crash go away.

-- Steve

PS. here's the patch to fix nmi function tracing:

From c1c8a30be7c138a5c3519c12c8ef3b80288d5514 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Thu, 29 Oct 2020 17:31:45 -0400
Subject: [PATCH] ftrace: Fix recursion check for NMI test

The code that checks recursion will work to only do the recursion check once
if there's nested checks. The top one will do the check, the other nested
checks will see recursion was already checked and return zero for its "bit".
On the return side, nothing will be done if the "bit" is zero.

The problem is that zero is returned for the "good" bit when in NMI context.
This will set the bit for NMIs making it look like *all* NMI tracing is
recursing, and prevent tracing of anything in NMI context!

The simple fix is to return "bit + 1" and subtract that bit on the end to
get the real bit.

Cc: stable@vger.kernel.org
Fixes: edc15cafcbfa3 ("tracing: Avoid unnecessary multiple recursion checks")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f3f5e77123ad..fee535a89560 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -698,7 +698,7 @@ static __always_inline int trace_test_and_set_recursion(int start, int max)
 	current->trace_recursion = val;
 	barrier();
 
-	return bit;
+	return bit + 1;
 }
 
 static __always_inline void trace_clear_recursion(int bit)
@@ -708,6 +708,7 @@ static __always_inline void trace_clear_recursion(int bit)
 	if (!bit)
 		return;
 
+	bit--;
 	bit = 1 << bit;
 	val &= ~bit;
 
-- 
2.25.4

