Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A6B27F5F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbgI3X0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:26:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:25939 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732253AbgI3X0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:26:24 -0400
IronPort-SDR: ms9kvPLwJHErIlSHwLisnUHQiHxBeGXUI2l1Y5iGM8ACTAIMJ/5djkdCm7p94ZsyjOwi5j7dVP
 mxaPW7RV+WSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="159975257"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="159975257"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:26:19 -0700
IronPort-SDR: g4ygN77aY6UVwVSKe0IMiKfW1uMZYlYTN/3rTv6TobTOLtKWl32Ds1IHKox3opr66LvHDZwvm7
 F0Zxec/mgSTw==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="457857986"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:26:19 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] x86/mce: Decode a kernel instruction to determine if it is copying from user
Date:   Wed, 30 Sep 2020 16:26:11 -0700
Message-Id: <20200930232611.15355-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200930232611.15355-1-tony.luck@intel.com>
References: <20200921113144.GD5901@zn.tnic>
 <20200930232611.15355-1-tony.luck@intel.com>
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
the fault was in kernel memory while copying to user we do not
currently have a recovery plan.

For MOV and MOVZ instructions a full decode of the instruction
is done to find the source address. For MOVS instructions
the source address is in the %rsi register. The function
fault_in_kernel_space() determines whether the source address is
kernel or user.

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c     | 11 +++++--
 arch/x86/kernel/cpu/mce/severity.c | 51 +++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9713825e6745..60bacf6e0501 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1236,14 +1236,19 @@ static void kill_me_maybe(struct callback_head *cb)
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
+	if (p->mce_vaddr != (void __user *)~0ul) {
+		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
+	} else {
+		pr_err("Memory error not recovered");
+		kill_me_now(cb);
+	}
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 8517cbf7b184..6e8b38cf52d9 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -10,6 +10,9 @@
 #include <linux/init.h>
 #include <linux/debugfs.h>
 #include <asm/mce.h>
+#include <asm/traps.h>
+#include <asm/insn.h>
+#include <asm/insn-eval.h>
 #include <linux/uaccess.h>
 
 #include "internal.h"
@@ -198,6 +201,45 @@ static struct severity {
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
@@ -215,10 +257,17 @@ static int error_context(struct mce *m, struct pt_regs *regs)
 
 	if ((m->cs & 3) == 3)
 		return IN_USER;
+	if (!mc_recoverable(m->mcgstatus))
+		return IN_KERNEL;
 
 	t = ex_fault_handler_type(m->ip);
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
 
-- 
2.21.1

