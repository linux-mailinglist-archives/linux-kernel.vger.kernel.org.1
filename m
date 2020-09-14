Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1542691F8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgINQpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:45:34 -0400
Received: from foss.arm.com ([217.140.110.172]:39596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgINPKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:10:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0574F11B3;
        Mon, 14 Sep 2020 08:10:36 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F61B3F718;
        Mon, 14 Sep 2020 08:10:34 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.indradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/14] arm64: Allow passing fault address to fixup handlers
Date:   Mon, 14 Sep 2020 15:09:45 +0000
Message-Id: <20200914150958.2200-2-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914150958.2200-1-oli.swede@arm.com>
References: <20200914150958.2200-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Tebbs <sam.tebbs@arm.com>

Extend fixup_exception() to optionally place the faulting address in a
register when returning to a fixup handler. Since A64 instructions must
be 4-byte-aligned, we can mimic the IA-64 implementation and encode a
flag in the lower bits of the offset field to indicate handlers which
expect an address. This will allow us to use more efficient offset
addressing modes in usercopy routines, rather than updating the base
register on every access just for the sake of inferring where a fault
occurred in order to compute the return value upon failure.

The choice of x15 is somewhat arbitrary, but with the consideration that
as the highest-numbered temporary register with no possible 'special'
role in the ABI, it is most likely not used by hand-written assembly
code, and thus a minimally-invasive option for imported routines.

Signed-off-by: Sam Tebbs <sam.tebbs@arm.com>
[ rm: split into separate patch, use UL(), expand commit message ]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[ os: move insertion to condition block for rebase onto bpf changes]
Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/include/asm/assembler.h |  9 +++++++++
 arch/arm64/include/asm/extable.h   | 11 ++++++++++-
 arch/arm64/mm/extable.c            | 27 +++++++++++++++++----------
 arch/arm64/mm/fault.c              |  2 +-
 4 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 54d181177656..438382a277c8 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -18,6 +18,7 @@
 #include <asm/cpufeature.h>
 #include <asm/cputype.h>
 #include <asm/debug-monitors.h>
+#include <asm/extable.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
@@ -129,6 +130,14 @@ alternative_endif
 	.popsection
 	.endm
 
+/*
+ * Emit an entry into the exception table.
+ * The fixup handler will receive the faulting address in x15
+ */
+	.macro		_asm_extable_faultaddr, from, to
+	_asm_extable	\from, \to + FIXUP_WITH_ADDR
+	.endm
+
 #define USER(l, x...)				\
 9999:	x;					\
 	_asm_extable	9999b, l
diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
index 840a35ed92ec..2cfb3dce9a10 100644
--- a/arch/arm64/include/asm/extable.h
+++ b/arch/arm64/include/asm/extable.h
@@ -2,6 +2,12 @@
 #ifndef __ASM_EXTABLE_H
 #define __ASM_EXTABLE_H
 
+#include <linux/const.h>
+
+#define FIXUP_WITH_ADDR UL(1)
+
+#ifndef __ASSEMBLY__
+
 /*
  * The exception table consists of pairs of relative offsets: the first
  * is the relative offset to an instruction that is allowed to fault,
@@ -34,5 +40,8 @@ int arm64_bpf_fixup_exception(const struct exception_table_entry *ex,
 }
 #endif /* !CONFIG_BPF_JIT */
 
-extern int fixup_exception(struct pt_regs *regs);
+extern int fixup_exception(struct pt_regs *regs, unsigned long addr);
+
+#endif
+
 #endif
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index eee1732ab6cd..97802e1f178d 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -6,19 +6,26 @@
 #include <linux/extable.h>
 #include <linux/uaccess.h>
 
-int fixup_exception(struct pt_regs *regs)
+int fixup_exception(struct pt_regs *regs, unsigned long addr)
 {
 	const struct exception_table_entry *fixup;
 
 	fixup = search_exception_tables(instruction_pointer(regs));
-	if (!fixup)
-		return 0;
 
-	if (IS_ENABLED(CONFIG_BPF_JIT) &&
-	    regs->pc >= BPF_JIT_REGION_START &&
-	    regs->pc < BPF_JIT_REGION_END)
-		return arm64_bpf_fixup_exception(fixup, regs);
-
-	regs->pc = (unsigned long)&fixup->fixup + fixup->fixup;
-	return 1;
+	if (fixup) {
+		if (IS_ENABLED(CONFIG_BPF_JIT) &&
+		    regs->pc >= BPF_JIT_REGION_START &&
+		    regs->pc < BPF_JIT_REGION_END) {
+			return arm64_bpf_fixup_exception(fixup, regs);
+		} else {
+			unsigned long offset = fixup->fixup;
+			if (offset & FIXUP_WITH_ADDR) {
+				regs->regs[15] = addr;
+				offset &= ~FIXUP_WITH_ADDR;
+			}
+			regs->pc = (unsigned long)&fixup->fixup + offset;
+			return 1;
+		}
+	}
+	return 0;
 }
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f07333e86c2f..b9c263d18510 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -303,7 +303,7 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 	 * Are we prepared to handle this kernel fault?
 	 * We are almost certainly not prepared to handle instruction faults.
 	 */
-	if (!is_el1_instruction_abort(esr) && fixup_exception(regs))
+	if (!is_el1_instruction_abort(esr) && fixup_exception(regs, addr))
 		return;
 
 	if (WARN_RATELIMIT(is_spurious_el1_translation_fault(addr, esr, regs),
-- 
2.17.1

