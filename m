Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3ED5300203
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbhAVLxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:53:05 -0500
Received: from foss.arm.com ([217.140.110.172]:41864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbhAVLKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:10:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8853A11D4;
        Fri, 22 Jan 2021 03:09:50 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87E733F719;
        Fri, 22 Jan 2021 03:09:49 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH] arm64: kprobes: Fix Uexpected kernel BRK exception at EL1
Date:   Fri, 22 Jan 2021 11:09:09 +0000
Message-Id: <20210122110909.3324607-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was hitting the below panic continuously when attaching kprobes to
scheduler functions

	[  159.045212] Unexpected kernel BRK exception at EL1
	[  159.053753] Internal error: BRK handler: f2000006 [#1] PREEMPT SMP
	[  159.059954] Modules linked in:
	[  159.063025] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.11.0-rc4-00008-g1e2a199f6ccd #56
	[rt-app] <notice> [1] Exiting.[  159.071166] Hardware name: ARM Juno development board (r2) (DT)
	[  159.079689] pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO BTYPE=--)

	[  159.085723] pc : 0xffff80001624501c
	[  159.089377] lr : attach_entity_load_avg+0x2ac/0x350
	[  159.094271] sp : ffff80001622b640
	[rt-app] <notice> [0] Exiting.[  159.097591] x29: ffff80001622b640 x28: 0000000000000001
	[  159.105515] x27: 0000000000000049 x26: ffff000800b79980

	[  159.110847] x25: ffff00097ef37840 x24: 0000000000000000
	[  159.116331] x23: 00000024eacec1ec x22: ffff00097ef12b90
	[  159.121663] x21: ffff00097ef37700 x20: ffff800010119170
	[rt-app] <notice> [11] Exiting.[  159.126995] x19: ffff00097ef37840 x18: 000000000000000e
	[  159.135003] x17: 0000000000000001 x16: 0000000000000019
	[  159.140335] x15: 0000000000000000 x14: 0000000000000000
	[  159.145666] x13: 0000000000000002 x12: 0000000000000002
	[  159.150996] x11: ffff80001592f9f0 x10: 0000000000000060
	[  159.156327] x9 : ffff8000100f6f9c x8 : be618290de0999a1
	[  159.161659] x7 : ffff80096a4b1000 x6 : 0000000000000000
	[  159.166990] x5 : ffff00097ef37840 x4 : 0000000000000000
	[  159.172321] x3 : ffff000800328948 x2 : 0000000000000000
	[  159.177652] x1 : 0000002507d52fec x0 : ffff00097ef12b90
	[  159.182983] Call trace:
	[  159.185433]  0xffff80001624501c
	[  159.188581]  update_load_avg+0x2d0/0x778
	[  159.192516]  enqueue_task_fair+0x134/0xe20
	[  159.196625]  enqueue_task+0x4c/0x2c8
	[  159.200211]  ttwu_do_activate+0x70/0x138
	[  159.204147]  sched_ttwu_pending+0xbc/0x160
	[  159.208253]  flush_smp_call_function_queue+0x16c/0x320
	[  159.213408]  generic_smp_call_function_single_interrupt+0x1c/0x28
	[  159.219521]  ipi_handler+0x1e8/0x3c8
	[  159.223106]  handle_percpu_devid_irq+0xd8/0x460
	[  159.227650]  generic_handle_irq+0x38/0x50
	[  159.231672]  __handle_domain_irq+0x6c/0xc8
	[  159.235781]  gic_handle_irq+0xcc/0xf0
	[  159.239452]  el1_irq+0xb4/0x180
	[  159.242600]  rcu_is_watching+0x28/0x70
	[  159.246359]  rcu_read_lock_held_common+0x44/0x88
	[  159.250991]  rcu_read_lock_any_held+0x30/0xc0
	[  159.255360]  kretprobe_dispatcher+0xc4/0xf0
	[  159.259555]  __kretprobe_trampoline_handler+0xc0/0x150
	[  159.264710]  trampoline_probe_handler+0x38/0x58
	[  159.269255]  kretprobe_trampoline+0x70/0xc4
	[  159.273450]  run_rebalance_domains+0x54/0x80
	[  159.277734]  __do_softirq+0x164/0x684
	[  159.281406]  irq_exit+0x198/0x1b8
	[  159.284731]  __handle_domain_irq+0x70/0xc8
	[  159.288840]  gic_handle_irq+0xb0/0xf0
	[  159.292510]  el1_irq+0xb4/0x180
	[  159.295658]  arch_cpu_idle+0x18/0x28
	[  159.299245]  default_idle_call+0x9c/0x3e8
	[  159.303265]  do_idle+0x25c/0x2a8
	[  159.306502]  cpu_startup_entry+0x2c/0x78
	[  159.310436]  secondary_start_kernel+0x160/0x198
	[  159.314984] Code: d42000c0 aa1e03e9 d42000c0 aa1e03e9 (d42000c0)

After a bit of head scratching and debugging it turned out that it is
due to kprobe handler being interrupted by a tick that causes us to go
into (I think another) kprobe handler.

The culprit was kprobe_breakpoint_ss_handler() returning DBG_HOOK_ERROR
which leads to the Unexpected kernel BRK exception.

Reverting commit ba090f9cafd5 ("arm64: kprobes: Remove redundant
kprobe_step_ctx") seemed to fix the problem for me.

Further analysis showed that kcb->kprobe_status is set to
KPROBE_REENTER when the error occurs. By teaching
kprobe_breakpoint_ss_handler() to handle this status I can no  longer
reproduce the problem.

Fixes: ba090f9cafd5 ("arm64: kprobes: Remove redundant kprobe_step_ctx")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---

Another change in behavior I noticed is that before ba090f9cafd5 ("arm64:
kprobes: Remove redundant kprobe_step_ctx") if 'cur' was NULL we wouldn't
return DBG_HOOK_ERROR, but after the change we do.

I didn't hit a problem because of that it's just something I noticed when
I realized that this commit was causing my problem.


 arch/arm64/kernel/probes/kprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 89c64ada8732..66aac2881ba8 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -352,8 +352,8 @@ kprobe_breakpoint_ss_handler(struct pt_regs *regs, unsigned int esr)
 	unsigned long addr = instruction_pointer(regs);
 	struct kprobe *cur = kprobe_running();
 
-	if (cur && (kcb->kprobe_status == KPROBE_HIT_SS)
-	    && ((unsigned long)&cur->ainsn.api.insn[1] == addr)) {
+	if (cur && (kcb->kprobe_status & (KPROBE_HIT_SS | KPROBE_REENTER)) &&
+	    ((unsigned long)&cur->ainsn.api.insn[1] == addr)) {
 		kprobes_restore_local_irqflag(kcb, regs);
 		post_kprobe_handler(cur, kcb, regs);
 
-- 
2.25.1

