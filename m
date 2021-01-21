Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403A62FE460
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbhAUHvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:51:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbhAUG6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:58:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45B83239CF;
        Thu, 21 Jan 2021 06:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212223;
        bh=Te/08c0yJuznK3RJxaiKkAdmx5Vpyk/PoeNFyleg9Bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADw4fD++7ggp+njW8xd0F894B+IaSMTZI9gvcjpTUSX+ub2jTdmhsrvfsxA6rsliA
         zXt0CNF/PMxvFqdAZJqK2bA2RChwt1VkiDMNScvEBXlmZuGB9vzDOfFOXXysvHhibt
         N6Z77uzpJOLHXjX0nHBSR9LuSCHz/gMhARSmtKoOG6DHuR/N3tU78hCfqcFO5rfvF1
         SzCzEVMr73MYF3BDMj6WgNoI8xQv1xqav3EQ6MluWGWT/8eoreLDKReslG4RrjXZmI
         1jbXjBNEvsVAod6PbelHGpzePsp9E70Ef8YlG44yqeLhkFbbm1jO3A0gIMTdMeNNkh
         DdOyYEBBuwgGg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 13/29] csky: Add show_tlb for CPU_CK860 debug
Date:   Thu, 21 Jan 2021 14:53:33 +0800
Message-Id: <20210121065349.3188251-13-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Print all 1024 jtlb entries and 16 iutlb entries and 16 dutlb
entries in show_regs.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/kernel/ptrace.c | 121 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index e5bd4e01b861..417b759fab6c 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -22,6 +22,7 @@
 #include <asm/asm-offsets.h>
 
 #include <abi/regdef.h>
+#include <abi/ckmmu.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -343,6 +344,124 @@ asmlinkage void syscall_trace_exit(struct pt_regs *regs)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 }
 
+#ifdef CONFIG_CPU_CK860
+static void show_iutlb(void)
+{
+	int entry, i;
+	unsigned long flags;
+	unsigned long oldpid;
+	unsigned long entryhi[16], entrylo0[16], entrylo1[16];
+
+	oldpid = read_mmu_entryhi();
+
+	entry = 0x8000;
+
+	local_irq_save(flags);
+
+	for (i = 0; i < 16; i++) {
+		write_mmu_index(entry);
+		tlb_read();
+		entryhi[i]  = read_mmu_entryhi();
+		entrylo0[i] = read_mmu_entrylo0();
+		entrylo1[i] = read_mmu_entrylo1();
+
+		entry++;
+	}
+
+	local_irq_restore(flags);
+
+	write_mmu_entryhi(oldpid);
+
+	printk("\n\n\n");
+	for (i = 0; i < 16; i++)
+		printk("iutlb[%d]:	entryhi - 0x%lx;	entrylo0 - 0x%lx;"
+		       "	entrylo1 - 0x%lx\n",
+			 i, entryhi[i], entrylo0[i], entrylo1[i]);
+	printk("\n\n\n");
+}
+
+static void show_dutlb(void)
+{
+	int entry, i;
+	unsigned long flags;
+	unsigned long oldpid;
+	unsigned long entryhi[16], entrylo0[16], entrylo1[16];
+
+	oldpid = read_mmu_entryhi();
+
+	entry = 0x4000;
+
+	local_irq_save(flags);
+
+	for (i = 0; i < 16; i++) {
+		write_mmu_index(entry);
+		tlb_read();
+		entryhi[i]  = read_mmu_entryhi();
+		entrylo0[i] = read_mmu_entrylo0();
+		entrylo1[i] = read_mmu_entrylo1();
+
+		entry++;
+	}
+
+	local_irq_restore(flags);
+
+	write_mmu_entryhi(oldpid);
+
+	printk("\n\n\n");
+	for (i = 0; i < 16; i++)
+		printk("dutlb[%d]:	entryhi - 0x%lx;	entrylo0 - 0x%lx;"
+		       "	entrylo1 - 0x%lx\n",
+			 i, entryhi[i], entrylo0[i], entrylo1[i]);
+	printk("\n\n\n");
+}
+
+static unsigned long entryhi[1024], entrylo0[1024], entrylo1[1024];
+static void show_jtlb(void)
+{
+	int entry;
+	unsigned long flags;
+	unsigned long oldpid;
+
+	oldpid = read_mmu_entryhi();
+
+	entry = 0;
+
+	local_irq_save(flags);
+	while (entry < 1024) {
+		write_mmu_index(entry);
+		tlb_read();
+		entryhi[entry]  = read_mmu_entryhi();
+		entrylo0[entry] = read_mmu_entrylo0();
+		entrylo1[entry] = read_mmu_entrylo1();
+
+		entry++;
+	}
+	local_irq_restore(flags);
+
+	write_mmu_entryhi(oldpid);
+
+	printk("\n\n\n");
+
+	for (entry = 0; entry < 1024; entry++)
+		printk("jtlb[%x]:	entryhi - 0x%lx;	entrylo0 - 0x%lx;"
+		       "	entrylo1 - 0x%lx\n",
+			 entry, entryhi[entry], entrylo0[entry], entrylo1[entry]);
+	printk("\n\n\n");
+}
+
+static void show_tlb(void)
+{
+	show_iutlb();
+	show_dutlb();
+	show_jtlb();
+}
+#else
+static void show_tlb(void)
+{
+	return;
+}
+#endif
+
 void show_regs(struct pt_regs *fp)
 {
 	pr_info("\nCURRENT PROCESS:\n\n");
@@ -396,5 +515,7 @@ void show_regs(struct pt_regs *fp)
 		fp->regs[8], fp->regs[9]);
 #endif
 
+	show_tlb();
+
 	return;
 }
-- 
2.17.1

