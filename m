Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA62808E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgJAU73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgJAU72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:59:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34D4C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 13:59:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 8751029D102
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 1/9] x86: events: Avoid TIF_IA32 when checking 64bit mode
Date:   Thu,  1 Oct 2020 16:58:11 -0400
Message-Id: <20201001205819.27879-2-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001205819.27879-1-krisman@collabora.com>
References: <20201001205819.27879-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove TIF_IA32, stop using it in perf events code.

Tested by running perf on 32-bit, 64-bit and x32 applications.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c      | 2 +-
 arch/x86/events/intel/ds.c  | 2 +-
 arch/x86/events/intel/lbr.c | 2 +-
 arch/x86/kernel/perf_regs.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1cbf57dc2ac8..4fe82d9d959b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2499,7 +2499,7 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	struct stack_frame_ia32 frame;
 	const struct stack_frame_ia32 __user *fp;
 
-	if (!test_thread_flag(TIF_IA32))
+	if (user_64bit_mode(regs))
 		return 0;
 
 	cs_base = get_segment_base(regs->cs);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 86848c57b55e..94bd0d3acd15 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1261,7 +1261,7 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
 		old_to = to;
 
 #ifdef CONFIG_X86_64
-		is_64bit = kernel_ip(to) || !test_thread_flag(TIF_IA32);
+		is_64bit = kernel_ip(to) || any_64bit_mode(regs);
 #endif
 		insn_init(&insn, kaddr, size, is_64bit);
 		insn_get_length(&insn);
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8961653c5dd2..1aadb253d296 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1221,7 +1221,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 	 * on 64-bit systems running 32-bit apps
 	 */
 #ifdef CONFIG_X86_64
-	is64 = kernel_ip((unsigned long)addr) || !test_thread_flag(TIF_IA32);
+	is64 = kernel_ip((unsigned long)addr) || any_64bit_mode(current_pt_regs());
 #endif
 	insn_init(&insn, addr, bytes_read, is64);
 	insn_get_opcode(&insn);
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index bb7e1132290b..9332c49a64a8 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -123,7 +123,7 @@ int perf_reg_validate(u64 mask)
 
 u64 perf_reg_abi(struct task_struct *task)
 {
-	if (test_tsk_thread_flag(task, TIF_IA32))
+	if (!user_64bit_mode(task_pt_regs(task)))
 		return PERF_SAMPLE_REGS_ABI_32;
 	else
 		return PERF_SAMPLE_REGS_ABI_64;
-- 
2.28.0

