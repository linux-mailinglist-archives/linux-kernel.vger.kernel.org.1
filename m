Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C0C2A009A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgJ3JAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3JAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:00:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AB7C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XvKspDWPIMbCW5x7ARrTA/5iUKwcK0bjX4flLm9rzyg=; b=cRLW0tmaBI07Wbqwcpxpn7ufi9
        36VWHD6aPTAh4VTCUHnyMwsvWYuvWl7MhJpKjWGCSzVDwqkk+4pyto1i9tx/sIm1f2CRQsNW3YxgG
        qzrmx7r45AHNTKLrsZ+F1D+DhuBdJSsmGHhp/klVFzd0ok3Jls6jwlqr0mqTIN3Ri9uUShKKyRjyY
        edRcjL5KlmKsUiaxhzQSbRo8UkhBTGnGQUdJPJXbzHVL9vn878E/A1HofanfWJI0ShiaZKMun2nM/
        tAlNZokYp+pN0lNTRuU9pTcY0KY12wZp+C79tFn30z1BAVX2h7YGfqh7Rn3xNvuZadtzaTV0FxhZ5
        ndxuTGpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYQH1-0002HC-5y; Fri, 30 Oct 2020 09:00:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4F23300455;
        Fri, 30 Oct 2020 10:00:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E8C3203C534D; Fri, 30 Oct 2020 10:00:37 +0100 (CET)
Date:   Fri, 30 Oct 2020 10:00:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kan.liang@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [BUG] Stack overflow when running perf and function tracer
Message-ID: <20201030090037.GZ2628@hirez.programming.kicks-ass.net>
References: <20201030002722.766a22df@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030002722.766a22df@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 12:27:22AM -0400, Steven Rostedt wrote:
> I found a bug in the recursion protection that prevented function
> tracing from running in NMI context. Applying this fix to 5.9 worked
> fine (tested by running perf record and function tracing at the same
> time). But when I applied the patch to 5.10-rc1, it blew up with a
> stack overflow:

So we just blew away our NMI stack, right?

> perf: interrupt took too long (14611 > 13550), lowering kernel.perf_event_max_sample_rate to 13000
> perf: interrupt took too long (27965 > 18263), lowering kernel.perf_event_max_sample_rate to 7000
>  INFO: NMI handler (perf_event_nmi_handler) took too long to run: 0.000 msecs
>  INFO: NMI handler (perf_event_nmi_handler) took too long to run: 1.087 msecs
>  INFO: NMI handler (perf_event_nmi_handler) took too long to run: 9.082 msecs
>  perf: interrupt took too long (27965 > 18263), lowering kernel.perf_event_max_sample_rate to 7000
>  traps: PANIC: double fault, error_code: 0x0
>  double fault: 0000 [#1] PREEMPT SMP PTI
>  CPU: 1 PID: 1655 Comm: perf Not tainted 5.9.0-rc1-test+ #685
>  Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
>  RIP: 0010:__rb_reserve_next+0xb/0x450
>  Code: 4f 10 f0 ff 41 08 0f 0b 83 f8 02 0f 84 97 fb ff ff e9 a5 fc ff ff b8 04 00 00 00 eb e1 66 90 41 57 41 56 41 55 41 54 49 89 f4 <55> 48 89 fd 53 48 83 ec 08 48 8b 9f 98 00 00 00 48 89 5e 28 4c 8b
>  RSP: 0018:fffffe000003c000 EFLAGS: 00010046
>  RAX: 000000000000001c RBX: ffff928ada27b400 RCX: 0000000000000000
>  RDX: ffff928ada07b200 RSI: fffffe000003c028 RDI: ffff928ada27b400
>  RBP: ffff928ada27b4f0 R08: 0000000000000001 R09: 0000000000000000
>  R10: fffffe000003c440 R11: ffff928a7383cc60 R12: fffffe000003c028
>  R13: 00000000000003e8 R14: 0000000000000046 R15: 0000000000110001
>  FS:  00007f25d43cf780(0000) GS:ffff928adaa40000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: fffffe000003bff8 CR3: 00000000b52a8005 CR4: 00000000001707e0
>  Call Trace:
>   <NMI>
>   ring_buffer_lock_reserve+0x12c/0x380
>   ? perf_output_begin+0x4d/0x2d0
>   ? rcu_panic+0x20/0x20
>   trace_function+0x27/0x130
>   ? rcu_panic+0x20/0x20
>   ? perf_output_begin+0x4d/0x2d0
>   function_trace_call+0x133/0x180
>   0xffffffffc02a106a
>   ? __rcu_read_lock+0x5/0x20
>   __rcu_read_lock+0x5/0x20
>   perf_output_begin+0x4d/0x2d0
>   ? sched_clock+0x5/0x10
>   ? trace_clock_local+0xc/0x20
>   ? __rb_reserve_next+0x5c/0x450
>   ? sched_clock+0x5/0x10
>   ? ring_buffer_lock_reserve+0x12c/0x380
>   ? sched_clock+0x5/0x10
>   ? trace_clock_local+0xc/0x20
>   ? __rb_reserve_next+0x5c/0x450
>   ? ring_buffer_lock_reserve+0x12c/0x380
>   ? perf_log_throttle+0x9a/0x120
>   ? perf_log_throttle+0x9a/0x120
>   ? perf_output_begin_backward+0x280/0x280
>   ? trace_function+0x88/0x130
>   ? ring_buffer_unlock_commit+0x25/0x140
>   ? perf_output_begin_backward+0x280/0x280
>   ? perf_log_throttle+0x9a/0x120
>   ? function_trace_call+0x133/0x180
>   ? 0xffffffffc02a106a
>   ? perf_log_throttle+0x9a/0x120
>   ? perf_output_begin+0x5/0x2d0
>   ? __perf_event_header__init_id.isra.0+0x39/0xd0
>   ? perf_output_begin+0x5/0x2d0
>   perf_log_throttle+0x9a/0x120
>   ? trace_clock_local+0xc/0x20
>   ? __rb_reserve_next+0x5c/0x450
>   ? sched_clock+0x5/0x10
>   ? ring_buffer_lock_reserve+0x12c/0x380
>   ? sched_clock+0x5/0x10
>   ? sched_clock+0x5/0x10
>   ? sched_clock+0x5/0x10
>   ? trace_clock_local+0xc/0x20
>   ? __rb_reserve_next+0x5c/0x450
>   ? sched_clock+0x5/0x10
>   ? trace_clock_local+0xc/0x20
>   ? __rb_reserve_next+0x5c/0x450
>   ? setup_pebs_fixed_sample_data+0x365/0x3a0
>   ? setup_pebs_fixed_sample_data+0x365/0x3a0
>   ? intel_pmu_pebs_event_update_no_drain+0x70/0x70
>   ? trace_function+0x88/0x130
>   ? ring_buffer_unlock_commit+0x25/0x140
>   ? intel_pmu_pebs_event_update_no_drain+0x70/0x70
>   ? setup_pebs_fixed_sample_data+0x365/0x3a0
>   ? function_trace_call+0x133/0x180
>   ? intel_pmu_pebs_fixup_ip+0x32/0x1b0
>   ? function_trace_call+0x133/0x180
>   ? native_write_msr+0x6/0x20
>   __perf_event_account_interrupt+0xa9/0x120
>   __perf_event_overflow+0x2b/0xf0
>   __intel_pmu_pebs_event+0x2ec/0x3e0
>   ? trace_function+0x88/0x130
>   ? ring_buffer_unlock_commit+0x25/0x140
>   ? setup_pebs_adaptive_sample_data+0x3e0/0x3e0
>   ? 0xffffffffc02a106a
>   ? 0xffffffffc02a106a
>   ? generic_exec_single+0xa6/0xe0
>   ? perf_duration_warn+0x20/0x20
>   ? generic_exec_single+0xa6/0xe0
>   ? native_write_msr+0x6/0x20
>   ? ring_buffer_lock_reserve+0x1b9/0x380
>   ? ring_buffer_lock_reserve+0x12c/0x380
>   ? intel_pmu_drain_pebs_nhm+0x268/0x330
>   ? intel_pmu_drain_pebs_nhm+0x268/0x330
>   ? release_bts_buffer+0x60/0x60
>   ? trace_function+0x88/0x130
>   ? ring_buffer_unlock_commit+0x25/0x140
>   ? release_bts_buffer+0x60/0x60
>   ? intel_pmu_drain_pebs_nhm+0x268/0x330
>   ? function_trace_call+0x133/0x180
>   ? 0xffffffffc02a106a
>   ? ring_buffer_lock_reserve+0x12c/0x380
>   intel_pmu_drain_pebs_nhm+0x268/0x330
>   ? setup_pebs_adaptive_sample_data+0x3e0/0x3e0
>   handle_pmi_common+0xc2/0x2b0
>   ? __rb_reserve_next+0x5c/0x450
>   ? sched_clock+0x5/0x10
>   ? trace_clock_local+0xc/0x20
>   ? __rb_reserve_next+0x5c/0x450
>   ? ring_buffer_lock_reserve+0x12c/0x380
>   ? intel_pmu_handle_irq+0xc8/0x160
>   ? intel_pmu_ha
>  Lost 135 message(s)!

What kind of shit console is that?

Anyway, I can't seem to see any actual recursion happening, possibly due
to that loosing 135 entries. Which seems to suggest we geniuinely blew
away the NMI stack.

>  ---[ end trace ba215b7ba269800a ]---
>  RIP: 0010:__rb_reserve_next+0xb/0x450
>  Code: 4f 10 f0 ff 41 08 0f 0b 83 f8 02 0f 84 97 fb ff ff e9 a5 fc ff ff b8 04 00 00 00 eb e1 66 90 41 57 41 56 41 55 41 54 49 89 f4 <55> 48 89 fd 53 48 83 ec 08 48 8b 9f 98 00 00 00 48 89 5e 28 4c 8b
>  RSP: 0018:fffffe000003c000 EFLAGS: 00010046
>  RAX: 000000000000001c RBX: ffff928ada27b400 RCX: 0000000000000000
>  RDX: ffff928ada07b200 RSI: fffffe000003c028 RDI: ffff928ada27b400
>  RBP: ffff928ada27b4f0 R08: 0000000000000001 R09: 0000000000000000
>  R10: fffffe000003c440 R11: ffff928a7383cc60 R12: fffffe000003c028
>  R13: 00000000000003e8 R14: 0000000000000046 R15: 0000000000110001
>  FS:  00007f25d43cf780(0000) GS:ffff928adaa40000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: fffffe000003bff8 CR3: 00000000b52a8005 CR4: 00000000001707e0
>  Kernel panic - not syncing: Fatal exception in interrupt
>  Kernel Offset: 0x11000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> 
> I bisected it down to:
> 
> 35d1ce6bec133679ff16325d335217f108b84871 ("perf/x86/intel/ds: Fix
> x86_pmu_stop warning for large PEBS")
> 
> Which looks to be storing an awful lot on the stack:
> 
> static void __intel_pmu_pebs_event(struct perf_event *event,
> 				   struct pt_regs *iregs,
> 				   void *base, void *top,
> 				   int bit, int count,
> 				   void (*setup_sample)(struct perf_event *,
> 						struct pt_regs *,
> 						void *,
> 						struct perf_sample_data *,
> 						struct pt_regs *))
> {
> 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> 	struct hw_perf_event *hwc = &event->hw;
> 	struct perf_sample_data data;
> 	struct x86_perf_regs perf_regs;
> 	struct pt_regs *regs = &perf_regs.regs;
> 	void *at = get_next_pebs_record_by_bit(base, top, bit);
> 	struct pt_regs dummy_iregs;

The only thing I can come up with in a hurry is that that dummy_iregs
thing really should be static. That's 168 bytes of stack out the window
right there.

Still, this seems to suggest (barring some actual issue hidding in those
135 lost lines, we're very close to the limit on the NMI stack, which is
a single 4k page IIRC.
