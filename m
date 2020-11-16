Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D952B5305
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbgKPUn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387666AbgKPUn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:56 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763DDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:56 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k2so20320900wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dMjpiERxWdtVXkFd7Ern4M0cCd0kiv8tT2I9J/E/g7I=;
        b=U7/w3Fhf9DO5foQRW7muVXAu48l3LbirUtqZ9gJBCTgwMcBTtGFM1gJH0rYp327w0N
         cFyYfUWUW6mb5IvhOcUAOaq9RtpFcsrkyawQNbkS+/0zXCcBVj/JRDAQCvSs44nRQrTH
         /TIQgvF5AKG1qLOlN9nz99FMbmxcuTidQqlCcIh7BZx9sLiZ6Ldnp19kZSnHnecN6UYa
         47or/IhKPvtaT0ikk6q26xSnmF3tpajDvqbjS8How97682ISE5hOu7RDjW5Q/I6Ywurl
         IQqADgIEJdqKeph575DIoo6yj013/c/zrRdAtWx6/+9ezCPuauebfFn2BhbtMmaJLSuI
         VwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dMjpiERxWdtVXkFd7Ern4M0cCd0kiv8tT2I9J/E/g7I=;
        b=gdbARB9kraKRvZtvZUw6XBsQ2sWjkdx2jAyXjvQF1VRDde5ayu8f+KqT64/BCQ0Niu
         Fnle4inufGItJW2POQCGSYky0grtsTtEIZG0AWs1nB/Rb0tB0Ie8C386VTNl6ig1k3l6
         0R9EjD+C72fz/jaNUuOgy+82jC+MHYhXr3LgQiVxdlga3dCsC5SgFyaEWdX2d1Q6LdWN
         jJ3FFIQYNxdh1JS6kNkgAchMxK6vRfwVxJ3+fVDtMGAfI9edaOAHXDcInbaaGs0lOJ9r
         hLR15oAVLW46CKN+gET6nHL8mHWbNE+SoVCYNBd3KY4RMnlo7IZoZ238xrk9p8ociPH+
         xwqg==
X-Gm-Message-State: AOAM53181jllcVx36ovHd+bfUxpqwKbsCRBpNbwPU0ZKwLusbOz1eLES
        0bgSw7Kl4dP2CL0410EEr/hKIA==
X-Google-Smtp-Source: ABdhPJzQKH1yeq/oMRiNiGuPYRxFYlhWF+NTE891QE/ynOYgdpF9Ld0Hyaa8WpJD7POvyBVvcFsSkw==
X-Received: by 2002:a5d:410c:: with SMTP id l12mr21265672wrp.173.1605559434950;
        Mon, 16 Nov 2020 12:43:54 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id f13sm18795419wrq.78.2020.11.16.12.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:53 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 15/24] kvm: arm64: Extract parts of el2_setup into a macro
Date:   Mon, 16 Nov 2020 20:43:09 +0000
Message-Id: <20201116204318.63987-16-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the a CPU is booted in EL2, the kernel checks for VHE support and
initializes the CPU core accordingly. For nVHE it also installs the stub
vectors and drops down to EL1.

Once KVM gains the ability to boot cores without going through the
kernel entry point, it will need to initialize the CPU the same way.
Extract the relevant bits of el2_setup into an init_el2_state macro
with an argument specifying whether to initialize for VHE or nVHE.

No functional change. Size of el2_setup increased by 148 bytes due
to duplication.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/el2_setup.h | 185 +++++++++++++++++++++++++++++
 arch/arm64/kernel/head.S           | 144 +++-------------------
 2 files changed, 201 insertions(+), 128 deletions(-)
 create mode 100644 arch/arm64/include/asm/el2_setup.h

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
new file mode 100644
index 000000000000..e5026e0aa878
--- /dev/null
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012,2013 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#ifndef __ARM_KVM_INIT_H__
+#define __ARM_KVM_INIT_H__
+
+#ifndef __ASSEMBLY__
+#error Assembly-only header
+#endif
+
+#ifdef CONFIG_ARM_GIC_V3
+#include <linux/irqchip/arm-gic-v3.h>
+#endif
+
+#include <asm/kvm_arm.h>
+#include <asm/ptrace.h>
+#include <asm/sysreg.h>
+
+.macro __init_el2_sctlr
+	mov_q	x0, (SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
+	msr	sctlr_el2, x0
+	isb
+.endm
+
+/*
+ * Allow Non-secure EL1 and EL0 to access physical timer and counter.
+ * This is not necessary for VHE, since the host kernel runs in EL2,
+ * and EL0 accesses are configured in the later stage of boot process.
+ * Note that when HCR_EL2.E2H == 1, CNTHCTL_EL2 has the same bit layout
+ * as CNTKCTL_EL1, and CNTKCTL_EL1 accessing instructions are redefined
+ * to access CNTHCTL_EL2. This allows the kernel designed to run at EL1
+ * to transparently mess with the EL0 bits via CNTKCTL_EL1 access in
+ * EL2.
+ */
+.macro __init_el2_timers mode
+.ifeqs "\mode", "nvhe"
+	mrs	x0, cnthctl_el2
+	orr	x0, x0, #3			// Enable EL1 physical timers
+	msr	cnthctl_el2, x0
+.endif
+	msr	cntvoff_el2, xzr		// Clear virtual offset
+.endm
+
+.macro __init_el2_debug mode
+	mrs	x1, id_aa64dfr0_el1
+	sbfx	x0, x1, #ID_AA64DFR0_PMUVER_SHIFT, #4
+	cmp	x0, #1
+	b.lt	1f				// Skip if no PMU present
+	mrs	x0, pmcr_el0			// Disable debug access traps
+	ubfx	x0, x0, #11, #5			// to EL2 and allow access to
+1:
+	csel	x2, xzr, x0, lt			// all PMU counters from EL1
+
+	/* Statistical profiling */
+	ubfx	x0, x1, #ID_AA64DFR0_PMSVER_SHIFT, #4
+	cbz	x0, 3f				// Skip if SPE not present
+
+.ifeqs "\mode", "nvhe"
+	mrs_s	x0, SYS_PMBIDR_EL1              // If SPE available at EL2,
+	and	x0, x0, #(1 << SYS_PMBIDR_EL1_P_SHIFT)
+	cbnz	x0, 2f				// then permit sampling of physical
+	mov	x0, #(1 << SYS_PMSCR_EL2_PCT_SHIFT | \
+		      1 << SYS_PMSCR_EL2_PA_SHIFT)
+	msr_s	SYS_PMSCR_EL2, x0		// addresses and physical counter
+2:
+	mov	x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
+	orr	x2, x2, x0			// If we don't have VHE, then
+						// use EL1&0 translation.
+.else
+	orr	x2, x2, #MDCR_EL2_TPMS		// For VHE, use EL2 translation
+						// and disable access from EL1
+.endif
+
+3:
+	msr	mdcr_el2, x2			// Configure debug traps
+.endm
+
+/* LORegions */
+.macro __init_el2_lor
+	mrs	x1, id_aa64mmfr1_el1
+	ubfx	x0, x1, #ID_AA64MMFR1_LOR_SHIFT, 4
+	cbz	x0, 1f
+	msr_s	SYS_LORC_EL1, xzr
+1:
+.endm
+
+/* Stage-2 translation */
+.macro __init_el2_stage2
+	msr	vttbr_el2, xzr
+.endm
+
+/* GICv3 system register access */
+#ifdef CONFIG_ARM_GIC_V3
+.macro __init_el2_gicv3
+	mrs	x0, id_aa64pfr0_el1
+	ubfx	x0, x0, #ID_AA64PFR0_GIC_SHIFT, #4
+	cbz	x0, 1f
+
+	mrs_s	x0, SYS_ICC_SRE_EL2
+	orr	x0, x0, #ICC_SRE_EL2_SRE	// Set ICC_SRE_EL2.SRE==1
+	orr	x0, x0, #ICC_SRE_EL2_ENABLE	// Set ICC_SRE_EL2.Enable==1
+	msr_s	SYS_ICC_SRE_EL2, x0
+	isb					// Make sure SRE is now set
+	mrs_s	x0, SYS_ICC_SRE_EL2		// Read SRE back,
+	tbz	x0, #0, 1f			// and check that it sticks
+	msr_s	SYS_ICH_HCR_EL2, xzr		// Reset ICC_HCR_EL2 to defaults
+1:
+.endm
+#endif
+
+/* Virtual CPU ID registers */
+.macro __init_el2_nvhe_idregs
+	mrs	x0, midr_el1
+	mrs	x1, mpidr_el1
+	msr	vpidr_el2, x0
+	msr	vmpidr_el2, x1
+.endm
+
+/* Coprocessor traps */
+.macro __init_el2_nvhe_cptr
+	mov	x0, #0x33ff
+	msr	cptr_el2, x0			// Disable copro. traps to EL2
+.endm
+
+/* SVE register access */
+.macro __init_el2_nvhe_sve
+	mrs	x1, id_aa64pfr0_el1
+	ubfx	x1, x1, #ID_AA64PFR0_SVE_SHIFT, #4
+	cbz	x1, 1f
+
+	bic	x0, x0, #CPTR_EL2_TZ		// Also disable SVE traps
+	msr	cptr_el2, x0			// Disable copro. traps to EL2
+	isb
+	mov	x1, #ZCR_ELx_LEN_MASK		// SVE: Enable full vector
+	msr_s	SYS_ZCR_EL2, x1			// length for EL1.
+1:
+.endm
+
+.macro __init_el2_nvhe_spsr
+	mov	x0, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
+		      PSR_MODE_EL1h)
+	msr	spsr_el2, x0
+.endm
+
+.macro init_el2_state mode
+
+.ifnes "\mode", "vhe"
+.ifnes "\mode", "nvhe"
+.error "Invalid 'mode' argument"
+.endif
+.endif
+
+	__init_el2_sctlr
+	__init_el2_timers \mode
+	__init_el2_debug \mode
+	__init_el2_lor
+	__init_el2_stage2
+
+#ifdef CONFIG_ARM_GIC_V3
+	__init_el2_gicv3
+#endif
+
+#ifdef CONFIG_COMPAT
+	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
+#endif
+
+	/*
+	 * When VHE is not in use, early init of EL2 needs to be done here.
+	 * When VHE _is_ in use, EL1 will not be used in the host and
+	 * requires no configuration, and all non-hyp-specific EL2 setup
+	 * will be done via the _EL1 system register aliases in __cpu_setup.
+	 */
+.ifeqs "\mode", "nvhe"
+	__init_el2_nvhe_idregs
+	__init_el2_nvhe_cptr
+	__init_el2_nvhe_sve
+	__init_el2_nvhe_spsr
+.endif
+
+.endm
+
+#endif /* __ARM_KVM_INIT_H__ */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index d8d9caf02834..da913ce9e89f 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -11,7 +11,6 @@
 
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <linux/irqchip/arm-gic-v3.h>
 #include <linux/pgtable.h>
 
 #include <asm/asm_pointer_auth.h>
@@ -21,6 +20,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 #include <asm/cputype.h>
+#include <asm/el2_setup.h>
 #include <asm/elf.h>
 #include <asm/image.h>
 #include <asm/kernel-pgtable.h>
@@ -493,159 +493,47 @@ SYM_FUNC_START(el2_setup)
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
 	b.eq	1f
+
 	mov_q	x0, (SCTLR_EL1_RES1 | ENDIAN_SET_EL1)
 	msr	sctlr_el1, x0
 	mov	w0, #BOOT_CPU_MODE_EL1		// This cpu booted in EL1
 	isb
 	ret
 
-1:	mov_q	x0, (SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
-	msr	sctlr_el2, x0
-
+1:
 #ifdef CONFIG_ARM64_VHE
 	/*
-	 * Check for VHE being present. For the rest of the EL2 setup,
-	 * x2 being non-zero indicates that we do have VHE, and that the
-	 * kernel is intended to run at EL2.
+	 * Check for VHE being present. x2 being non-zero indicates that we
+	 * do have VHE, and that the kernel is intended to run at EL2.
 	 */
 	mrs	x2, id_aa64mmfr1_el1
 	ubfx	x2, x2, #ID_AA64MMFR1_VHE_SHIFT, #4
-#else
-	mov	x2, xzr
-#endif
+	cbz	x2, el2_setup_nvhe
 
-	/* Hyp configuration. */
-	mov_q	x0, HCR_HOST_NVHE_FLAGS
-	cbz	x2, set_hcr
 	mov_q	x0, HCR_HOST_VHE_FLAGS
-set_hcr:
 	msr	hcr_el2, x0
 	isb
 
-	/*
-	 * Allow Non-secure EL1 and EL0 to access physical timer and counter.
-	 * This is not necessary for VHE, since the host kernel runs in EL2,
-	 * and EL0 accesses are configured in the later stage of boot process.
-	 * Note that when HCR_EL2.E2H == 1, CNTHCTL_EL2 has the same bit layout
-	 * as CNTKCTL_EL1, and CNTKCTL_EL1 accessing instructions are redefined
-	 * to access CNTHCTL_EL2. This allows the kernel designed to run at EL1
-	 * to transparently mess with the EL0 bits via CNTKCTL_EL1 access in
-	 * EL2.
-	 */
-	cbnz	x2, 1f
-	mrs	x0, cnthctl_el2
-	orr	x0, x0, #3			// Enable EL1 physical timers
-	msr	cnthctl_el2, x0
-1:
-	msr	cntvoff_el2, xzr		// Clear virtual offset
-
-#ifdef CONFIG_ARM_GIC_V3
-	/* GICv3 system register access */
-	mrs	x0, id_aa64pfr0_el1
-	ubfx	x0, x0, #ID_AA64PFR0_GIC_SHIFT, #4
-	cbz	x0, 3f
-
-	mrs_s	x0, SYS_ICC_SRE_EL2
-	orr	x0, x0, #ICC_SRE_EL2_SRE	// Set ICC_SRE_EL2.SRE==1
-	orr	x0, x0, #ICC_SRE_EL2_ENABLE	// Set ICC_SRE_EL2.Enable==1
-	msr_s	SYS_ICC_SRE_EL2, x0
-	isb					// Make sure SRE is now set
-	mrs_s	x0, SYS_ICC_SRE_EL2		// Read SRE back,
-	tbz	x0, #0, 3f			// and check that it sticks
-	msr_s	SYS_ICH_HCR_EL2, xzr		// Reset ICC_HCR_EL2 to defaults
-
-3:
-#endif
-
-	/* Populate ID registers. */
-	mrs	x0, midr_el1
-	mrs	x1, mpidr_el1
-	msr	vpidr_el2, x0
-	msr	vmpidr_el2, x1
-
-#ifdef CONFIG_COMPAT
-	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
-#endif
-
-	/* EL2 debug */
-	mrs	x1, id_aa64dfr0_el1
-	sbfx	x0, x1, #ID_AA64DFR0_PMUVER_SHIFT, #4
-	cmp	x0, #1
-	b.lt	4f				// Skip if no PMU present
-	mrs	x0, pmcr_el0			// Disable debug access traps
-	ubfx	x0, x0, #11, #5			// to EL2 and allow access to
-4:
-	csel	x3, xzr, x0, lt			// all PMU counters from EL1
-
-	/* Statistical profiling */
-	ubfx	x0, x1, #ID_AA64DFR0_PMSVER_SHIFT, #4
-	cbz	x0, 7f				// Skip if SPE not present
-	cbnz	x2, 6f				// VHE?
-	mrs_s	x4, SYS_PMBIDR_EL1		// If SPE available at EL2,
-	and	x4, x4, #(1 << SYS_PMBIDR_EL1_P_SHIFT)
-	cbnz	x4, 5f				// then permit sampling of physical
-	mov	x4, #(1 << SYS_PMSCR_EL2_PCT_SHIFT | \
-		      1 << SYS_PMSCR_EL2_PA_SHIFT)
-	msr_s	SYS_PMSCR_EL2, x4		// addresses and physical counter
-5:
-	mov	x1, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
-	orr	x3, x3, x1			// If we don't have VHE, then
-	b	7f				// use EL1&0 translation.
-6:						// For VHE, use EL2 translation
-	orr	x3, x3, #MDCR_EL2_TPMS		// and disable access from EL1
-7:
-	msr	mdcr_el2, x3			// Configure debug traps
-
-	/* LORegions */
-	mrs	x1, id_aa64mmfr1_el1
-	ubfx	x0, x1, #ID_AA64MMFR1_LOR_SHIFT, 4
-	cbz	x0, 1f
-	msr_s	SYS_LORC_EL1, xzr
-1:
-
-	/* Stage-2 translation */
-	msr	vttbr_el2, xzr
-
-	cbz	x2, install_el2_stub
+	init_el2_state vhe
 
 	mov	w0, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
 	isb
 	ret
+#endif
 
-SYM_INNER_LABEL(install_el2_stub, SYM_L_LOCAL)
-	/*
-	 * When VHE is not in use, early init of EL2 and EL1 needs to be
-	 * done here.
-	 * When VHE _is_ in use, EL1 will not be used in the host and
-	 * requires no configuration, and all non-hyp-specific EL2 setup
-	 * will be done via the _EL1 system register aliases in __cpu_setup.
-	 */
-	mov_q	x0, (SCTLR_EL1_RES1 | ENDIAN_SET_EL1)
-	msr	sctlr_el1, x0
-
-	/* Coprocessor traps. */
-	mov	x0, #0x33ff
-	msr	cptr_el2, x0			// Disable copro. traps to EL2
-
-	/* SVE register access */
-	mrs	x1, id_aa64pfr0_el1
-	ubfx	x1, x1, #ID_AA64PFR0_SVE_SHIFT, #4
-	cbz	x1, 7f
-
-	bic	x0, x0, #CPTR_EL2_TZ		// Also disable SVE traps
-	msr	cptr_el2, x0			// Disable copro. traps to EL2
+SYM_INNER_LABEL(el2_setup_nvhe, SYM_L_LOCAL)
+	mov_q	x0, HCR_HOST_NVHE_FLAGS
+	msr	hcr_el2, x0
 	isb
-	mov	x1, #ZCR_ELx_LEN_MASK		// SVE: Enable full vector
-	msr_s	SYS_ZCR_EL2, x1			// length for EL1.
+
+	init_el2_state nvhe
 
 	/* Hypervisor stub */
-7:	adr_l	x0, __hyp_stub_vectors
+	adr_l	x0, __hyp_stub_vectors
 	msr	vbar_el2, x0
 
-	/* spsr */
-	mov	x0, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
-		      PSR_MODE_EL1h)
-	msr	spsr_el2, x0
+	mov_q	x0, (SCTLR_EL1_RES1 | ENDIAN_SET_EL1)
+	msr	sctlr_el1, x0
 	msr	elr_el2, lr
 	mov	w0, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
 	eret
-- 
2.29.2.299.gdc1121823c-goog

