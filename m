Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C07F2884AE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbgJIIBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:01:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732492AbgJIIAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:00:12 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E6128CA9D00C89EF206C;
        Fri,  9 Oct 2020 16:00:09 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 9 Oct 2020 16:00:02 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux@armlinux.org.uk>, <dima@arista.com>, <will@kernel.org>,
        <jpoimboe@redhat.com>, <akpm@linux-foundation.org>,
        <christian.brauner@ubuntu.com>, <viro@zeniv.linux.org.uk>,
        <ldufour@linux.ibm.com>, <amanieu@gmail.com>, <walken@google.com>,
        <ben.dooks@codethink.co.uk>, <tglx@linutronix.de>,
        <bigeasy@linutronix.de>, <mingo@kernel.org>,
        <vincent.whitchurch@axis.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nixiaoming@huawei.com>,
        <wangle6@huawei.com>, <luohaizheng@huawei.com>
Subject: [PATCH] arm:traps: Don't print stack or raw PC/LR values in backtraces
Date:   Fri, 9 Oct 2020 15:59:57 +0800
Message-ID: <20201009075957.110017-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printing raw pointer values in backtraces has potential security
implications and are of questionable value anyway.

This patch follows x86 and arm64's lead and removes the "Exception stack:"
dump from kernel backtraces:
	commit a25ffd3a6302a6 ("arm64: traps: Don't print stack or raw
	 PC/LR values in backtraces")
	commit 0ee1dd9f5e7eae ("x86/dumpstack: Remove raw stack dump")
	commit bb5e5ce545f203 ("x86/dumpstack: Remove kernel text
	 addresses from stack dump")

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 arch/arm/kernel/process.c |  3 +--
 arch/arm/kernel/traps.c   | 12 +++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 8e6ace03e960..71c9e5597d39 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -121,8 +121,7 @@ void __show_regs(struct pt_regs *regs)
 
 	printk("PC is at %pS\n", (void *)instruction_pointer(regs));
 	printk("LR is at %pS\n", (void *)regs->ARM_lr);
-	printk("pc : [<%08lx>]    lr : [<%08lx>]    psr: %08lx\n",
-	       regs->ARM_pc, regs->ARM_lr, regs->ARM_cpsr);
+	printk("psr: %08lx\n", regs->ARM_cpsr);
 	printk("sp : %08lx  ip : %08lx  fp : %08lx\n",
 	       regs->ARM_sp, regs->ARM_ip, regs->ARM_fp);
 	printk("r10: %08lx  r9 : %08lx  r8 : %08lx\n",
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 17d5a785df28..b0b188e01070 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -60,23 +60,18 @@ static int __init user_debug_setup(char *str)
 __setup("user_debug=", user_debug_setup);
 #endif
 
-static void dump_mem(const char *, const char *, unsigned long, unsigned long);
-
 void dump_backtrace_entry(unsigned long where, unsigned long from,
 			  unsigned long frame, const char *loglvl)
 {
 	unsigned long end = frame + 4 + sizeof(struct pt_regs);
 
 #ifdef CONFIG_KALLSYMS
-	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
-		loglvl, where, (void *)where, from, (void *)from);
+	printk("%s (%ps) from (%pS)\n",
+		loglvl, (void *)where, (void *)from);
 #else
 	printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
 		loglvl, where, from);
 #endif
-
-	if (in_entry_text(from) && end <= ALIGN(frame, THREAD_SIZE))
-		dump_mem(loglvl, "Exception stack", frame + 4, end);
 }
 
 void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
@@ -125,6 +120,9 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 	mm_segment_t fs;
 	int i;
 
+	/* Do not print virtual addresses in non-reset scenarios */
+	if (!panic_on_oops)
+		return;
 	/*
 	 * We need to switch to kernel mode so that we can use __get_user
 	 * to safely read from kernel space.  Note that we now dump the
-- 
2.27.0

