Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603B52F9CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388810AbhARKKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389244AbhARJqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:46:44 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEE342245C;
        Mon, 18 Jan 2021 09:46:03 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l1R6n-008RhD-SJ; Mon, 18 Jan 2021 09:46:02 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: [PATCH v4 03/21] arm64: Turn the MMU-on sequence into a macro
Date:   Mon, 18 Jan 2021 09:45:15 +0000
Message-Id: <20210118094533.2874082-4-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118094533.2874082-1-maz@kernel.org>
References: <20210118094533.2874082-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turning the MMU on is a popular sport in the arm64 kernel, and
we do it more than once, or even twice. As we are about to add
even more, let's turn it into a macro.

No expected functional change.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/assembler.h | 17 +++++++++++++++++
 arch/arm64/kernel/head.S           | 19 ++++---------------
 arch/arm64/mm/proc.S               | 12 +-----------
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index bf125c591116..8cded93f99c3 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -675,6 +675,23 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	.endif
 	.endm
 
+/*
+ * Set SCTLR_EL1 to the passed value, and invalidate the local icache
+ * in the process. This is called when setting the MMU on.
+ */
+.macro set_sctlr_el1, reg
+	msr	sctlr_el1, \reg
+	isb
+	/*
+	 * Invalidate the local I-cache so that any instructions fetched
+	 * speculatively from the PoC are discarded, since they may have
+	 * been dynamically patched at the PoU.
+	 */
+	ic	iallu
+	dsb	nsh
+	isb
+.endm
+
 /*
  * Check whether to yield to another runnable task from kernel mode NEON code
  * (which runs with preemption disabled).
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index a0dc987724ed..28e9735302df 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -703,16 +703,9 @@ SYM_FUNC_START(__enable_mmu)
 	offset_ttbr1 x1, x3
 	msr	ttbr1_el1, x1			// load TTBR1
 	isb
-	msr	sctlr_el1, x0
-	isb
-	/*
-	 * Invalidate the local I-cache so that any instructions fetched
-	 * speculatively from the PoC are discarded, since they may have
-	 * been dynamically patched at the PoU.
-	 */
-	ic	iallu
-	dsb	nsh
-	isb
+
+	set_sctlr_el1	x0
+
 	ret
 SYM_FUNC_END(__enable_mmu)
 
@@ -883,11 +876,7 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	tlbi	vmalle1				// Remove any stale TLB entries
 	dsb	nsh
 
-	msr	sctlr_el1, x19			// re-enable the MMU
-	isb
-	ic	iallu				// flush instructions fetched
-	dsb	nsh				// via old mapping
-	isb
+	set_sctlr_el1	x19			// re-enable the MMU
 
 	bl	__relocate_kernel
 #endif
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index ece785477bdc..c967bfd30d2b 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -291,17 +291,7 @@ skip_pgd:
 	/* We're done: fire up the MMU again */
 	mrs	x17, sctlr_el1
 	orr	x17, x17, #SCTLR_ELx_M
-	msr	sctlr_el1, x17
-	isb
-
-	/*
-	 * Invalidate the local I-cache so that any instructions fetched
-	 * speculatively from the PoC are discarded, since they may have
-	 * been dynamically patched at the PoU.
-	 */
-	ic	iallu
-	dsb	nsh
-	isb
+	set_sctlr_el1	x17
 
 	/* Set the flag to zero to indicate that we're all done */
 	str	wzr, [flag_ptr]
-- 
2.29.2

