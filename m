Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0705E2FD1DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390026AbhATNbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:31:21 -0500
Received: from mout.gmx.net ([212.227.15.19]:43833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389442AbhATN3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611149252;
        bh=+KSPF4GnD3omtIIe3i7Lyq2tvVwNmWhc6oOtmKZfGzI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KJzOtRUFT18y2AVIMk9S6/yu70+QHv0r/ogOgKean1mhF0becZVTWGEV4P4exoKWx
         SFAESIw1iZe6xrEa4tQx193Hrl30IFHYa5lbOJgBiiNhqfGWQ4ww3Eqnr+BaOG0CNQ
         YgO46ghmOefmqNrkRdAWYV93RdFdnXTVxNhQM+kg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.204.192.78]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MA7GS-1l9K0M2Kew-00BZJF; Wed, 20 Jan 2021 14:27:32 +0100
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>
Subject: [RFC PATCH 1/7] arm64: kernel: FIQ support
Date:   Wed, 20 Jan 2021 14:27:11 +0100
Message-Id: <20210120132717.395873-2-mohamed.mediouni@caramail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ml5n3z6MXBeROYCSnnYCVIFLVuy9eVuLxApHlTE8E1RE4GX2lBM
 EvZAjrVErqyUftDvvUykHP8m3molE9GngFEsNtZgjmFmH90S1gY9mWf0b7cJw0X43NNbw9N
 LYhpMiKOB+BUDSWIB5XVGOmMrvbAHLpKIizsVp+S5WLVYma1rgSvka3479KcBTEYRDItj39
 eYtYg1q/s4hjVPoDrZe+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IAwlBG7G2XI=:2PrThCIAHOadCl8DTx4NYV
 GSvF3eIcNCVLR4VWUjTbu5cayqQ1Ol9DwLWW1M7u8n7WpRqKeQSYt9osUpzH0v3JcnYkhfqOm
 2QtqK1ZAemHf1YEMi0MWknoxKN3QdsGpb13KY3q5pQZKWUKRJVfuPF82Z16u8Q8Kv3BbYTQw7
 kDJiDyBcgS+DRZyhDsw2wuowTPiDJ80HlzFG1teOqZAe80I8I7xTYQmiDhlIYU3v/OkXLhPmi
 kW3eUxkrvkhv2rxMZmlmH9odP1UEBarUpHQW/ZO4P22Dy1pIJEADz0gcr/99EbrNAXDjfp6i/
 cP50nDB4vNuEBBOwUwMdS1MpzfMgdPyS+9cdMuRZv45x7kq+yNOYmtdwIxL3hXJoWoyG0ftx6
 uXqhP5Qc/na536WGIQdnqGZjklDMrqRLk8gSZRb+ePkBenH8T2Em5pXwqdHfE3cdEKtbiQ+By
 jegpx8s5tLB8WS92MmcDhiaMniIyFFeFd4fAmbXJs6ewinriHjG1ueX9/J5RR0c/aAWxIWK0+
 MN0xhfj5+Crx3ZRCSkUkdqK/3fao9sVg7EQJnk/04gvWvVkCG9JsGwjERSfqbjgqDkNGFSkcZ
 zKjkdcT1KBmn5P04+kRnl5LdmUWbH1LbD4mIezlOHSsIFclaub2CpEjobBYU5BqPkKXl2A/F/
 U8u7SitzkwbvK8Sj5CBAOuF2L3s2aS1zidY9aHkuKLevhtxCX5KkieptLeyQ1KNtDBlLLXHfH
 HWvES2f4Wlf9A6eEvmic7TDtTWPIAOmqjFJPWSBDAvylJG+s2K2zQiWkn+UskNO3vfpxelxyX
 73wXiTqBYiPUwGB7cpxlicS2LmvGSdnxRNdBZo+SbO/yNdVWN2FEkltGkFE/tvvirxu70ELil
 cYzODvv1tIC1fb9JHZmhrkaJEiwOXtq8YjZopgbKA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stan Skowronek <stan@corellium.com>

On Apple processors, the timer is wired through FIQ.
As such, add FIQ support to the kernel.

Signed-off-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
=2D--
 arch/arm64/include/asm/arch_gicv3.h |  2 +-
 arch/arm64/include/asm/assembler.h  |  8 ++--
 arch/arm64/include/asm/daifflags.h  |  4 +-
 arch/arm64/include/asm/irq.h        |  4 ++
 arch/arm64/include/asm/irqflags.h   |  6 +--
 arch/arm64/kernel/entry.S           | 74 ++++++++++++++++++++++++++---
 arch/arm64/kernel/irq.c             | 14 ++++++
 arch/arm64/kernel/process.c         |  2 +-
 8 files changed, 97 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/=
arch_gicv3.h
index 880b9054d75c..934b9be582d2 100644
=2D-- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -173,7 +173,7 @@ static inline void gic_pmr_mask_irqs(void)

 static inline void gic_arch_enable_irqs(void)
 {
-	asm volatile ("msr daifclr, #2" : : : "memory");
+	asm volatile ("msr daifclr, #3" : : : "memory");
 }

 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/a=
ssembler.h
index bf125c591116..6fe55713dfe0 100644
=2D-- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -40,9 +40,9 @@
 	msr	daif, \flags
 	.endm

-	/* IRQ is the lowest priority flag, unconditionally unmask the rest. */
-	.macro enable_da_f
-	msr	daifclr, #(8 | 4 | 1)
+	/* IRQ/FIQ is the lowest priority flag, unconditionally unmask the rest.=
 */
+	.macro enable_da
+	msr	daifclr, #(8 | 4)
 	.endm

 /*
@@ -50,7 +50,7 @@
  */
 	.macro	save_and_disable_irq, flags
 	mrs	\flags, daif
-	msr	daifset, #2
+	msr	daifset, #3
 	.endm

 	.macro	restore_irq, flags
diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/d=
aifflags.h
index 1c26d7baa67f..44de96c7fb1a 100644
=2D-- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -13,8 +13,8 @@
 #include <asm/ptrace.h>

 #define DAIF_PROCCTX		0
-#define DAIF_PROCCTX_NOIRQ	PSR_I_BIT
-#define DAIF_ERRCTX		(PSR_I_BIT | PSR_A_BIT)
+#define DAIF_PROCCTX_NOIRQ	(PSR_I_BIT | PSR_F_BIT)
+#define DAIF_ERRCTX		(PSR_I_BIT | PSR_F_BIT | PSR_A_BIT)
 #define DAIF_MASK		(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)


diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index b2b0c6405eb0..2d1537d3a245 100644
=2D-- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -13,5 +13,9 @@ static inline int nr_legacy_irqs(void)
 	return 0;
 }

+int set_handle_fiq(void (*handle_fiq)(struct pt_regs *));
+
+extern void (*handle_arch_fiq)(struct pt_regs *) __ro_after_init;
+
 #endif /* !__ASSEMBLER__ */
 #endif
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/ir=
qflags.h
index ff328e5bbb75..26d7f378113e 100644
=2D-- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -35,7 +35,7 @@ static inline void arch_local_irq_enable(void)
 	}

 	asm volatile(ALTERNATIVE(
-		"msr	daifclr, #2		// arch_local_irq_enable",
+		"msr	daifclr, #3		// arch_local_irq_enable",
 		__msr_s(SYS_ICC_PMR_EL1, "%0"),
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
@@ -54,7 +54,7 @@ static inline void arch_local_irq_disable(void)
 	}

 	asm volatile(ALTERNATIVE(
-		"msr	daifset, #2		// arch_local_irq_disable",
+		"msr	daifset, #3		// arch_local_irq_disable",
 		__msr_s(SYS_ICC_PMR_EL1, "%0"),
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
@@ -85,7 +85,7 @@ static inline int arch_irqs_disabled_flags(unsigned long=
 flags)
 	int res;

 	asm volatile(ALTERNATIVE(
-		"and	%w0, %w1, #" __stringify(PSR_I_BIT),
+		"and	%w0, %w1, #" __stringify(PSR_I_BIT | PSR_F_BIT),
 		"eor	%w0, %w1, #" __stringify(GIC_PRIO_IRQON),
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		: "=3D&r" (res)
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index c9bae73f2621..abcca0db0736 100644
=2D-- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -499,6 +499,14 @@ tsk	.req	x28		// current thread_info
 	irq_stack_exit
 	.endm

+	.macro	fiq_handler
+	ldr_l	x1, handle_arch_fiq
+	mov	x0, sp
+	irq_stack_entry
+	blr	x1
+	irq_stack_exit
+	.endm
+
 #ifdef CONFIG_ARM64_PSEUDO_NMI
 	/*
 	 * Set res to 0 if irqs were unmasked in interrupted context.
@@ -547,18 +555,18 @@ SYM_CODE_START(vectors)

 	kernel_ventry	1, sync				// Synchronous EL1h
 	kernel_ventry	1, irq				// IRQ EL1h
-	kernel_ventry	1, fiq_invalid			// FIQ EL1h
+	kernel_ventry	1, fiq				// FIQ EL1h
 	kernel_ventry	1, error			// Error EL1h

 	kernel_ventry	0, sync				// Synchronous 64-bit EL0
 	kernel_ventry	0, irq				// IRQ 64-bit EL0
-	kernel_ventry	0, fiq_invalid			// FIQ 64-bit EL0
+	kernel_ventry	0, fiq				// FIQ 64-bit EL0
 	kernel_ventry	0, error			// Error 64-bit EL0

 #ifdef CONFIG_COMPAT
 	kernel_ventry	0, sync_compat, 32		// Synchronous 32-bit EL0
 	kernel_ventry	0, irq_compat, 32		// IRQ 32-bit EL0
-	kernel_ventry	0, fiq_invalid_compat, 32	// FIQ 32-bit EL0
+	kernel_ventry	0, fiq_compat, 32		// FIQ 32-bit EL0
 	kernel_ventry	0, error_compat, 32		// Error 32-bit EL0
 #else
 	kernel_ventry	0, sync_invalid, 32		// Synchronous 32-bit EL0
@@ -661,7 +669,7 @@ SYM_CODE_END(el1_sync)
 SYM_CODE_START_LOCAL_NOALIGN(el1_irq)
 	kernel_entry 1
 	gic_prio_irq_setup pmr=3Dx20, tmp=3Dx1
-	enable_da_f
+	enable_da

 	mov	x0, sp
 	bl	enter_el1_irq_or_nmi
@@ -689,6 +697,38 @@ alternative_else_nop_endif
 	kernel_exit 1
 SYM_CODE_END(el1_irq)

+	.align	6
+SYM_CODE_START_LOCAL_NOALIGN(el1_fiq)
+	kernel_entry 1
+	gic_prio_irq_setup pmr=3Dx20, tmp=3Dx1
+	enable_da
+
+	mov	x0, sp
+	bl	enter_el1_irq_or_nmi
+
+	fiq_handler
+
+#ifdef CONFIG_PREEMPTION
+	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	/*
+	 * DA_F were cleared at start of handling. If anything is set in DAIF,
+	 * we come back from an NMI, so skip preemption
+	 */
+	mrs	x0, daif
+	orr	x24, x24, x0
+alternative_else_nop_endif
+	cbnz	x24, 1f				// preempt count !=3D 0 || NMI return path
+	bl	arm64_preempt_schedule_irq	// irq en/disable is done inside
+1:
+#endif
+
+	mov	x0, sp
+	bl	exit_el1_irq_or_nmi
+
+	kernel_exit 1
+SYM_CODE_END(el1_fiq)
+
 /*
  * EL0 mode handlers.
  */
@@ -715,6 +755,12 @@ SYM_CODE_START_LOCAL_NOALIGN(el0_irq_compat)
 	b	el0_irq_naked
 SYM_CODE_END(el0_irq_compat)

+	.align	6
+SYM_CODE_START_LOCAL_NOALIGN(el0_fiq_compat)
+	kernel_entry 0, 32
+	b	el0_fiq_naked
+SYM_CODE_END(el0_fiq_compat)
+
 SYM_CODE_START_LOCAL_NOALIGN(el0_error_compat)
 	kernel_entry 0, 32
 	b	el0_error_naked
@@ -727,7 +773,7 @@ SYM_CODE_START_LOCAL_NOALIGN(el0_irq)
 el0_irq_naked:
 	gic_prio_irq_setup pmr=3Dx20, tmp=3Dx0
 	user_exit_irqoff
-	enable_da_f
+	enable_da

 	tbz	x22, #55, 1f
 	bl	do_el0_irq_bp_hardening
@@ -737,6 +783,22 @@ el0_irq_naked:
 	b	ret_to_user
 SYM_CODE_END(el0_irq)

+	.align	6
+SYM_CODE_START_LOCAL_NOALIGN(el0_fiq)
+	kernel_entry 0
+el0_fiq_naked:
+	gic_prio_irq_setup pmr=3Dx20, tmp=3Dx0
+	user_exit_irqoff
+	enable_da
+
+	tbz	x22, #55, 1f
+	bl	do_el0_irq_bp_hardening
+1:
+	fiq_handler
+
+	b	ret_to_user
+SYM_CODE_END(el0_fiq)
+
 SYM_CODE_START_LOCAL(el1_error)
 	kernel_entry 1
 	mrs	x1, esr_el1
@@ -757,7 +819,7 @@ el0_error_naked:
 	mov	x0, sp
 	mov	x1, x25
 	bl	do_serror
-	enable_da_f
+	enable_da
 	b	ret_to_user
 SYM_CODE_END(el0_error)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index dfb1feab867d..4d7a9fb41d93 100644
=2D-- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -88,3 +88,17 @@ void __init init_IRQ(void)
 		local_daif_restore(DAIF_PROCCTX_NOIRQ);
 	}
 }
+
+/*
+ * Analogous to the generic handle_arch_irq / set_handle_irq
+ */
+void (*handle_arch_fiq)(struct pt_regs *) __ro_after_init;
+
+int __init set_handle_fiq(void (*handle_fiq)(struct pt_regs *))
+{
+	if (handle_arch_fiq)
+		return -EBUSY;
+
+	handle_arch_fiq =3D handle_fiq;
+	return 0;
+}
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6616486a58fe..34ec400288d0 100644
=2D-- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -84,7 +84,7 @@ static void noinstr __cpu_do_idle_irqprio(void)
 	unsigned long daif_bits;

 	daif_bits =3D read_sysreg(daif);
-	write_sysreg(daif_bits | PSR_I_BIT, daif);
+	write_sysreg(daif_bits | PSR_I_BIT | PSR_F_BIT, daif);

 	/*
 	 * Unmask PMR before going idle to make sure interrupts can
=2D-
2.29.2

