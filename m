Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D8F2853A9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgJFVJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:09:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:44609 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbgJFVJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:09:21 -0400
IronPort-SDR: Rt8vZUDlXHhZTUrXPSL/nG0a4tyistUk1Gs+/tQWV5k5lYhXT3V98KzvfmT14nTzz+44CGMSWd
 VbYauSbt3oeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="161302111"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="161302111"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 14:09:19 -0700
IronPort-SDR: tRNLktAAkxN5kEBOLE0FrlER1phdfR0WPC1yfSVSmQoWIsX0rPbFYmgIi6hkcqbFdid3fFi4B4
 SSU8qYrB6IOg==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="527590613"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 14:09:19 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] x86/mce: Decode a kernel instruction to determine if it is copying from user
Date:   Tue,  6 Oct 2020 14:09:10 -0700
Message-Id: <20201006210910.21062-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20201006210910.21062-1-tony.luck@intel.com>
References: <20201005163130.GD21151@zn.tnic>
 <20201006210910.21062-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All instructions copying data between kernel and user memory
are tagged with either _ASM_EXTABLE_UA or _ASM_EXTABLE_CPY
entries in the exception table. ex_fault_handler_type() returns
EX_HANDLER_UACCESS for both of these.

Recovery is only possible when the machine check was triggered
on a read from user memory. In this case the same strategy for
recovery applies as if the user had made the access in ring3. If
the fault was in kernel memory while copying to user there is no
current recovery plan.

For MOV and MOVZ instructions a full decode of the instruction
is done to find the source address. For MOVS instructions
the source address is in the %rsi register. The function
fault_in_kernel_space() determines whether the source address is
kernel or user, upgrade it from "static" so it can be used here.

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/traps.h       |  2 ++
 arch/x86/kernel/cpu/mce/core.c     | 11 +++++--
 arch/x86/kernel/cpu/mce/severity.c | 53 +++++++++++++++++++++++++++++-
 arch/x86/mm/fault.c                |  2 +-
 4 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 714b1a30e7b0..df0b7bfc1234 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -35,6 +35,8 @@ extern int panic_on_unrecovered_nmi;
 
 void math_emulate(struct math_emu_info *);
 
+bool fault_in_kernel_space(unsigned long address);
+
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
 				      struct pt_regs *regs,
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5c423c4bab68..3d6e1bfa4f9d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1250,14 +1250,19 @@ static void kill_me_maybe(struct callback_head *cb)
 	if (!p->mce_ripv)
 		flags |= MF_MUST_KILL;
 
-	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags)) {
+	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
+	    !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 		sync_core();
 		return;
 	}
 
-	pr_err("Memory error not recovered");
-	kill_me_now(cb);
+	if (p->mce_vaddr != (void __user *)-1l) {
+		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
+	} else {
+		pr_err("Memory error not recovered");
+		kill_me_now(cb);
+	}
 }
 
 static void queue_task_work(struct mce *m, int kill_it)
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index c6494e6579c1..83df991314c5 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -13,6 +13,9 @@
 
 #include <asm/mce.h>
 #include <asm/intel-family.h>
+#include <asm/traps.h>
+#include <asm/insn.h>
+#include <asm/insn-eval.h>
 
 #include "internal.h"
 
@@ -212,6 +215,47 @@ static struct severity {
 #define mc_recoverable(mcg) (((mcg) & (MCG_STATUS_RIPV|MCG_STATUS_EIPV)) == \
 				(MCG_STATUS_RIPV|MCG_STATUS_EIPV))
 
+static bool is_copy_from_user(struct pt_regs *regs)
+{
+	u8 insn_buf[MAX_INSN_SIZE];
+	struct insn insn;
+	unsigned long addr;
+
+	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
+		return false;
+
+	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
+	insn_get_opcode(&insn);
+	if (!insn.opcode.got)
+		return false;
+
+	switch (insn.opcode.value) {
+	/* MOV mem,reg */
+	case 0x8A: case 0x8B:
+	/* MOVZ mem,reg */
+	case 0xB60F: case 0xB70F:
+		insn_get_modrm(&insn);
+		insn_get_sib(&insn);
+		if (!insn.modrm.got || !insn.sib.got)
+			return false;
+		addr = (unsigned long)insn_get_addr_ref(&insn, regs);
+		break;
+	/* REP MOVS */
+	case 0xA4: case 0xA5:
+		addr = regs->si;
+		break;
+	default:
+		return false;
+	}
+
+	if (fault_in_kernel_space(addr))
+		return false;
+
+	current->mce_vaddr = (void __user *)addr;
+
+	return true;
+}
+
 /*
  * If mcgstatus indicated that ip/cs on the stack were
  * no good, then "m->cs" will be zero and we will have
@@ -229,10 +273,17 @@ static int error_context(struct mce *m, struct pt_regs *regs)
 
 	if ((m->cs & 3) == 3)
 		return IN_USER;
+	if (!mc_recoverable(m->mcgstatus))
+		return IN_KERNEL;
 
 	t = ex_get_fault_handler_type(m->ip);
-	if (mc_recoverable(m->mcgstatus) && t == EX_HANDLER_FAULT) {
+	if (t == EX_HANDLER_FAULT) {
+		m->kflags |= MCE_IN_KERNEL_RECOV;
+		return IN_KERNEL_RECOV;
+	}
+	if (t == EX_HANDLER_UACCESS && regs && is_copy_from_user(regs)) {
 		m->kflags |= MCE_IN_KERNEL_RECOV;
+		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		return IN_KERNEL_RECOV;
 	}
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 35f1498e9832..88ae443e4e5f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1081,7 +1081,7 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
 	return 0;
 }
 
-static int fault_in_kernel_space(unsigned long address)
+bool fault_in_kernel_space(unsigned long address)
 {
 	/*
 	 * On 64-bit systems, the vsyscall page is at an address above
-- 
2.21.1

