Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575DA2C0F28
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733310AbgKWPk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728822AbgKWPky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:40:54 -0500
Received: from localhost.localdomain (unknown [42.120.72.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14C8220719;
        Mon, 23 Nov 2020 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606146054;
        bh=Hcdyfk0kYZsv3hI9btjRLhXcU3rfrTM3E8RHn/I8BW8=;
        h=From:To:Cc:Subject:Date:From;
        b=Awgx4kyYENeoi1NYuacQXc+hhbiVF1VZs+iiqWoPyJ94EHr3CJZtVF0eMkqpW0Sq6
         MZ1Gu2tIiz9bm2IVkekd7Wsu8KjPDhNNU3fJYw9oxWoTLGGHfGrVuceTclBYibHXM/
         +UdB5YgHG6XdaM0NRPF8FiLWZFK61SxgIl4kJCIA=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        atish.patra@wdc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH 1/2] riscv: Fixup do_page_fault warning in uprobe_xol
Date:   Mon, 23 Nov 2020 15:39:39 +0000
Message-Id: <1606145980-5153-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

[  670.922295] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1491
[  670.930853] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 96, name: hello
[  670.938446] CPU: 0 PID: 96 Comm: hello Tainted: G        W         5.9.3-00875-gaf1498803464-dirty #31
[  670.947775] Call Trace:
[  670.950236] [<ffffffe000203dc8>] walk_stackframe+0x0/0xc2
[  670.955650] [<ffffffe000204078>] show_stack+0x46/0x52
[  670.960716] [<ffffffe0005a3fce>] dump_stack+0x90/0xb6
[  670.965783] [<ffffffe0002336b2>] ___might_sleep+0xf8/0x10c
[  670.971284] [<ffffffe000233716>] __might_sleep+0x50/0x7e
[  670.976613] [<ffffffe000a71498>] down_read+0x32/0xe0
[  670.981592] [<ffffffe000207798>] do_page_fault+0xf0/0x3d8
[  670.987006] [<ffffffe000201de8>] ret_from_exception+0x0/0x14

When CONFIG_DEBUG_ATOMIC_SLEEP is enabled:
mmap_read_lock()->down_read()->might_sleep->___might_sleep() will
check irqs_disabled() is 0 or Not. If irqs disabled, kernel prints
the BUG warning.

Uprobe need prepare a xol_slot to emulate single-step the instruction
for uprobe with irqs-off in user context. So it's the only case for
us to meet a irqs-off user context situation.

Second:

/* Enable interrupts if they were enabled in the parent context. */
if (likely(regs->status & SR_PIE))
	local_irq_enable();

It's duplicate with the patch by Vincent commit: c82dd6d078a2 ("
riscv: Avoid interrupts being erroneously enabled in
handle_exception()")

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/mm/fault.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index e889e65..a9d1f12 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -55,10 +55,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	if (unlikely((addr >= VMALLOC_START) && (addr <= VMALLOC_END)))
 		goto vmalloc_fault;
 
-	/* Enable interrupts if they were enabled in the parent context. */
-	if (likely(regs->status & SR_PIE))
-		local_irq_enable();
-
 	/*
 	 * If we're in an interrupt, have no user context, or are running
 	 * in an atomic region, then we must not take the fault.
@@ -71,6 +67,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
+	/* Enable interrupts for user context. */
+	local_irq_enable();
 retry:
 	mmap_read_lock(mm);
 	vma = find_vma(mm, addr);
-- 
2.7.4

