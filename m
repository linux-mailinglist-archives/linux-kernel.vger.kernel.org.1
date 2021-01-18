Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8752F9C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbhARKAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389242AbhARJqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:46:44 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 348B922475;
        Mon, 18 Jan 2021 09:46:02 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l1R6m-008RhD-EQ; Mon, 18 Jan 2021 09:46:00 +0000
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
Subject: [PATCH v4 01/21] arm64: Fix labels in el2_setup macros
Date:   Mon, 18 Jan 2021 09:45:13 +0000
Message-Id: <20210118094533.2874082-2-maz@kernel.org>
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

If someone happens to write the following code:

	b	1f
	init_el2_state	vhe
1:
	[...]

they will be in for a long debugging session, as the label "1f"
will be resolved *inside* the init_el2_state macro instead of
after it. Not really what one expects.

Instead, rewite the EL2 setup macros to use unambiguous labels,
thanks to the usual macro counter trick.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/el2_setup.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index a7f5a1bbc8ac..540116de80bf 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -45,24 +45,24 @@
 	mrs	x1, id_aa64dfr0_el1
 	sbfx	x0, x1, #ID_AA64DFR0_PMUVER_SHIFT, #4
 	cmp	x0, #1
-	b.lt	1f				// Skip if no PMU present
+	b.lt	.Lskip_pmu_\@			// Skip if no PMU present
 	mrs	x0, pmcr_el0			// Disable debug access traps
 	ubfx	x0, x0, #11, #5			// to EL2 and allow access to
-1:
+.Lskip_pmu_\@:
 	csel	x2, xzr, x0, lt			// all PMU counters from EL1
 
 	/* Statistical profiling */
 	ubfx	x0, x1, #ID_AA64DFR0_PMSVER_SHIFT, #4
-	cbz	x0, 3f				// Skip if SPE not present
+	cbz	x0, .Lskip_spe_\@		// Skip if SPE not present
 
 .ifeqs "\mode", "nvhe"
 	mrs_s	x0, SYS_PMBIDR_EL1              // If SPE available at EL2,
 	and	x0, x0, #(1 << SYS_PMBIDR_EL1_P_SHIFT)
-	cbnz	x0, 2f				// then permit sampling of physical
+	cbnz	x0, .Lskip_spe_el2_\@		// then permit sampling of physical
 	mov	x0, #(1 << SYS_PMSCR_EL2_PCT_SHIFT | \
 		      1 << SYS_PMSCR_EL2_PA_SHIFT)
 	msr_s	SYS_PMSCR_EL2, x0		// addresses and physical counter
-2:
+.Lskip_spe_el2_\@:
 	mov	x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
 	orr	x2, x2, x0			// If we don't have VHE, then
 						// use EL1&0 translation.
@@ -71,7 +71,7 @@
 						// and disable access from EL1
 .endif
 
-3:
+.Lskip_spe_\@:
 	msr	mdcr_el2, x2			// Configure debug traps
 .endm
 
@@ -79,9 +79,9 @@
 .macro __init_el2_lor
 	mrs	x1, id_aa64mmfr1_el1
 	ubfx	x0, x1, #ID_AA64MMFR1_LOR_SHIFT, 4
-	cbz	x0, 1f
+	cbz	x0, .Lskip_lor_\@
 	msr_s	SYS_LORC_EL1, xzr
-1:
+.Lskip_lor_\@:
 .endm
 
 /* Stage-2 translation */
@@ -93,7 +93,7 @@
 .macro __init_el2_gicv3
 	mrs	x0, id_aa64pfr0_el1
 	ubfx	x0, x0, #ID_AA64PFR0_GIC_SHIFT, #4
-	cbz	x0, 1f
+	cbz	x0, .Lskip_gicv3_\@
 
 	mrs_s	x0, SYS_ICC_SRE_EL2
 	orr	x0, x0, #ICC_SRE_EL2_SRE	// Set ICC_SRE_EL2.SRE==1
@@ -103,7 +103,7 @@
 	mrs_s	x0, SYS_ICC_SRE_EL2		// Read SRE back,
 	tbz	x0, #0, 1f			// and check that it sticks
 	msr_s	SYS_ICH_HCR_EL2, xzr		// Reset ICC_HCR_EL2 to defaults
-1:
+.Lskip_gicv3_\@:
 .endm
 
 .macro __init_el2_hstr
@@ -128,14 +128,14 @@
 .macro __init_el2_nvhe_sve
 	mrs	x1, id_aa64pfr0_el1
 	ubfx	x1, x1, #ID_AA64PFR0_SVE_SHIFT, #4
-	cbz	x1, 1f
+	cbz	x1, .Lskip_sve_\@
 
 	bic	x0, x0, #CPTR_EL2_TZ		// Also disable SVE traps
 	msr	cptr_el2, x0			// Disable copro. traps to EL2
 	isb
 	mov	x1, #ZCR_ELx_LEN_MASK		// SVE: Enable full vector
 	msr_s	SYS_ZCR_EL2, x1			// length for EL1.
-1:
+.Lskip_sve_\@:
 .endm
 
 .macro __init_el2_nvhe_prepare_eret
-- 
2.29.2

