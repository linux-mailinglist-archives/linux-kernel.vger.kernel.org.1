Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8401BFF1C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgD3OtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 10:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727906AbgD3Os4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:48:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3BEC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:48:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so2239825wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFZrtC078tm3fF3Gkx3z+NqJzWj49dM6UPrqp/cSML8=;
        b=jAFUEnzMh7rqPJib89Siw1b4XJgVDTMzP0eFtU2ZqL3yR803ik4PeS7lsveczCOlSz
         j9Scbttch+bGCZN49PEQALcgPjD+z1kYtoS1twsUuYX6HH+OWqHjDZS0F6hMc7EYooTO
         wmWBWagwicc58suxd3u+0ezGkpB5tW3WvtGKIuVZMXtSJPGfwxhpgBvLSED2BRhY0gqr
         1ecSyg3yGVHMbGrnt351h3jZBzXeAS4rYlzLDUe5h5rmMTiQ2BqZsYWx5ad1hM1WrLqN
         BITNmC5Pda5IVcW9AHtfq8hD6cyT+A6MZEmv0iE00whlLZ/qau/eTU0LQPWLUpm4KFlW
         MFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFZrtC078tm3fF3Gkx3z+NqJzWj49dM6UPrqp/cSML8=;
        b=pT2pgx2Y5j4uUvpGB/RCKJrdyuXLivZnKVznpqrDzTuBy84YDka1lXNpR4XCC6M17o
         3JXwF2qkkSkOz+bP1l6+DJG3S47axVZPLapWnBk+mriSth+i1y0Y2YealORhUTfs1u3g
         XW1LIQv6wrU0deqiOEDKK+kcjQIE1/QaoTQOaVrACdzRiWgUbzNvvPvmmyKJK/E41cMw
         x4wuD5RE/gaqaaCz5uqjJfRTT2dZk/bO0g40Mc5NCGjl+c1+1fwhRUhfIK+iY2Se44Tm
         Uo2T6m6D0K3F257Hx5HUXyU4UKprYgydfCsAlMYAawMp+SGUWqlBvSOqJZeRdXvwV+S5
         0ioQ==
X-Gm-Message-State: AGi0PuaxUOKSFWCfQPFPDS0e0UO5NR9uG7na1zkXLG4IMS/tiY8GGJ8z
        VrtZZ7chO6Z5W9qTrhk0FXxwIQ==
X-Google-Smtp-Source: APiQypIszJ+9R4DydmyddajAs7wvDnj8khQHNQBHnVsoPhp/aepPFGbE2tXMx0yhrO9Ukjry1jjaOA==
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr3213893wmj.12.1588258134243;
        Thu, 30 Apr 2020 07:48:54 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d4b6:9828:8bd2:ce6f])
        by smtp.gmail.com with ESMTPSA id n2sm4558315wrq.74.2020.04.30.07.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:48:53 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 05/15] arm64: kvm: Build hyp-entry.S separately for VHE/nVHE
Date:   Thu, 30 Apr 2020 15:48:21 +0100
Message-Id: <20200430144831.59194-6-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200430144831.59194-1-dbrazdil@google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is part of a series which builds KVM's non-VHE hyp code separately
from VHE and the rest of the kernel.

hyp-entry.S contains implementation of KVM hyp vectors. This code is mostly
shared between VHE/nVHE, therefore compile it under both VHE and nVHE build
rules, with small differences hidden behind '#ifdef __HYPERVISOR__'. These are:
  * only nVHE should handle host HVCs, VHE will now panic,
  * only nVHE needs kvm_hcall_table, so move host_hypcall.c to nvhe/,
  * __smccc_workaround_1_smc is not needed by nVHE, only cpu_errata.c in
    kernel proper.

Adjust code which selects which KVM hyp vecs to install to choose the correct
VHE/nVHE symbol.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  7 +++++
 arch/arm64/include/asm/kvm_mmu.h              | 13 +++++----
 arch/arm64/include/asm/mmu.h                  |  7 -----
 arch/arm64/kernel/cpu_errata.c                |  2 +-
 arch/arm64/kernel/image-vars.h                | 28 +++++++++++++++++++
 arch/arm64/kvm/hyp/Makefile                   |  2 +-
 arch/arm64/kvm/hyp/hyp-entry.S                | 27 ++++++++++++------
 arch/arm64/kvm/hyp/nvhe/Makefile              |  2 +-
 .../arm64/kvm/hyp/{ => nvhe}/host_hypercall.c |  0
 arch/arm64/kvm/va_layout.c                    |  2 +-
 10 files changed, 65 insertions(+), 25 deletions(-)
 rename arch/arm64/kvm/hyp/{ => nvhe}/host_hypercall.c (100%)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 99ab204519ca..cdaf3df8085d 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -71,6 +71,13 @@ extern char __kvm_hyp_init[];
 extern char __kvm_hyp_init_end[];
 
 extern char __kvm_hyp_vector[];
+extern char kvm_nvhe_sym(__kvm_hyp_vector)[];
+
+#ifdef CONFIG_KVM_INDIRECT_VECTORS
+extern char __bp_harden_hyp_vecs[];
+extern char kvm_nvhe_sym(__bp_harden_hyp_vecs)[];
+extern atomic_t arm64_el2_vector_last_slot;
+#endif
 
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 30b0e8d6b895..0a5fa033422c 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -468,7 +468,7 @@ static inline int kvm_write_guest_lock(struct kvm *kvm, gpa_t gpa,
  * VHE, as we don't have hypervisor-specific mappings. If the system
  * is VHE and yet selects this capability, it will be ignored.
  */
-#include <asm/mmu.h>
+#include <asm/kvm_asm.h>
 
 extern void *__kvm_bp_vect_base;
 extern int __kvm_harden_el2_vector_slot;
@@ -477,11 +477,11 @@ extern int __kvm_harden_el2_vector_slot;
 static inline void *kvm_get_hyp_vector(void)
 {
 	struct bp_hardening_data *data = arm64_get_bp_hardening_data();
-	void *vect = kern_hyp_va(kvm_ksym_ref(__kvm_hyp_vector));
+	void *vect = kern_hyp_va(kvm_hyp_ref(__kvm_hyp_vector));
 	int slot = -1;
 
 	if (cpus_have_const_cap(ARM64_HARDEN_BRANCH_PREDICTOR) && data->fn) {
-		vect = kern_hyp_va(kvm_ksym_ref(__bp_harden_hyp_vecs));
+		vect = kern_hyp_va(kvm_hyp_ref(__bp_harden_hyp_vecs));
 		slot = data->hyp_vectors_slot;
 	}
 
@@ -510,12 +510,13 @@ static inline int kvm_map_vectors(void)
 	 *  HBP +  HEL2 -> use hardened vertors and use exec mapping
 	 */
 	if (cpus_have_const_cap(ARM64_HARDEN_BRANCH_PREDICTOR)) {
-		__kvm_bp_vect_base = kvm_ksym_ref(__bp_harden_hyp_vecs);
+		__kvm_bp_vect_base = kvm_hyp_ref(__bp_harden_hyp_vecs);
 		__kvm_bp_vect_base = kern_hyp_va(__kvm_bp_vect_base);
 	}
 
 	if (cpus_have_const_cap(ARM64_HARDEN_EL2_VECTORS)) {
-		phys_addr_t vect_pa = __pa_symbol(__bp_harden_hyp_vecs);
+		phys_addr_t vect_pa =
+			__pa_symbol(kvm_nvhe_sym(__bp_harden_hyp_vecs));
 		unsigned long size = __BP_HARDEN_HYP_VECS_SZ;
 
 		/*
@@ -534,7 +535,7 @@ static inline int kvm_map_vectors(void)
 #else
 static inline void *kvm_get_hyp_vector(void)
 {
-	return kern_hyp_va(kvm_ksym_ref(__kvm_hyp_vector));
+	return kern_hyp_va(kvm_hyp_ref(__kvm_hyp_vector));
 }
 
 static inline int kvm_map_vectors(void)
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 68140fdd89d6..4d913f6dd366 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -42,13 +42,6 @@ struct bp_hardening_data {
 	bp_hardening_cb_t	fn;
 };
 
-#if (defined(CONFIG_HARDEN_BRANCH_PREDICTOR) ||	\
-     defined(CONFIG_HARDEN_EL2_VECTORS))
-
-extern char __bp_harden_hyp_vecs[];
-extern atomic_t arm64_el2_vector_last_slot;
-#endif  /* CONFIG_HARDEN_BRANCH_PREDICTOR || CONFIG_HARDEN_EL2_VECTORS */
-
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 DECLARE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index a102321fc8a2..b4b41552c6df 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -117,7 +117,7 @@ DEFINE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
 static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
 				const char *hyp_vecs_end)
 {
-	void *dst = lm_alias(__bp_harden_hyp_vecs + slot * SZ_2K);
+	void *dst = lm_alias(kvm_hyp_sym(__bp_harden_hyp_vecs) + slot * SZ_2K);
 	int i;
 
 	for (i = 0; i < SZ_2K; i += 0x80)
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 13850134fc28..59c53566eceb 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -61,6 +61,34 @@ __efistub__ctype		= _ctype;
  * memory mappings.
  */
 
+__hyp_text___guest_exit = __guest_exit;
+__hyp_text___kvm_enable_ssbs = __kvm_enable_ssbs;
+__hyp_text___kvm_flush_vm_context = __kvm_flush_vm_context;
+__hyp_text___kvm_get_mdcr_el2 = __kvm_get_mdcr_el2;
+__hyp_text___kvm_handle_stub_hvc = __kvm_handle_stub_hvc;
+__hyp_text___kvm_timer_set_cntvoff = __kvm_timer_set_cntvoff;
+__hyp_text___kvm_tlb_flush_local_vmid = __kvm_tlb_flush_local_vmid;
+__hyp_text___kvm_tlb_flush_vmid = __kvm_tlb_flush_vmid;
+__hyp_text___kvm_tlb_flush_vmid_ipa = __kvm_tlb_flush_vmid_ipa;
+__hyp_text___kvm_vcpu_run_nvhe = __kvm_vcpu_run_nvhe;
+__hyp_text___vgic_v3_get_ich_vtr_el2 = __vgic_v3_get_ich_vtr_el2;
+__hyp_text___vgic_v3_init_lrs = __vgic_v3_init_lrs;
+__hyp_text___vgic_v3_read_vmcr = __vgic_v3_read_vmcr;
+__hyp_text___vgic_v3_restore_aprs = __vgic_v3_restore_aprs;
+__hyp_text___vgic_v3_save_aprs = __vgic_v3_save_aprs;
+__hyp_text___vgic_v3_write_vmcr = __vgic_v3_write_vmcr;
+__hyp_text_abort_guest_exit_end = abort_guest_exit_end;
+__hyp_text_abort_guest_exit_start = abort_guest_exit_start;
+__hyp_text_arm64_enable_wa2_handling = arm64_enable_wa2_handling;
+__hyp_text_arm64_ssbd_callback_required = arm64_ssbd_callback_required;
+__hyp_text_hyp_panic = hyp_panic;
+__hyp_text_kimage_voffset = kimage_voffset;
+__hyp_text_kvm_host_data = kvm_host_data;
+__hyp_text_kvm_patch_vector_branch = kvm_patch_vector_branch;
+__hyp_text_kvm_update_va_mask = kvm_update_va_mask;
+__hyp_text_panic = panic;
+__hyp_text_physvirt_offset = physvirt_offset;
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 79bf822a484b..a6883f4fed9e 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -9,7 +9,7 @@ ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
 obj-$(CONFIG_KVM) += vhe.o nvhe/
 
 vhe-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o sysreg-sr.o \
-	 debug-sr.o entry.o switch.o fpsimd.o tlb.o host_hypercall.o hyp-entry.o
+	 debug-sr.o entry.o switch.o fpsimd.o tlb.o hyp-entry.o
 
 # KVM code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 1a51a0958504..5986e1d78d3f 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -36,12 +36,6 @@
 	ldr	lr, [sp], #16
 .endm
 
-/* kern_hyp_va(lm_alias(ksym)) */
-.macro ksym_hyp_va ksym, lm_offset
-	sub	\ksym, \ksym, \lm_offset
-	kern_hyp_va	\ksym
-.endm
-
 el1_sync:				// Guest trapped into EL2
 
 	mrs	x0, esr_el2
@@ -53,7 +47,15 @@ el1_sync:				// Guest trapped into EL2
 	mrs	x1, vttbr_el2		// If vttbr is valid, the guest
 	cbnz	x1, el1_hvc_guest	// called HVC
 
-	/* Here, we're pretty sure the host called HVC. */
+#ifdef __HYPERVISOR__
+
+/* kern_hyp_va(lm_alias(ksym)) */
+.macro ksym_hyp_va ksym, lm_offset
+	sub	\ksym, \ksym, \lm_offset
+	kern_hyp_va	\ksym
+.endm
+
+	/* nVHE: Here, we're pretty sure the host called HVC. */
 	ldp	x0, x1, [sp], #16
 
 	/* Check for a stub HVC call */
@@ -107,6 +109,13 @@ el1_sync:				// Guest trapped into EL2
 	eret
 	sb
 
+#else /* __HYPERVISOR__ */
+
+	/* VHE: Guest called HVC but vttbr is not valid. */
+	b	__hyp_panic
+
+#endif /* __HYPERVISOR__ */
+
 el1_hvc_guest:
 	/*
 	 * Fastest possible path for ARM_SMCCC_ARCH_WORKAROUND_1.
@@ -354,6 +363,7 @@ SYM_CODE_END(__bp_harden_hyp_vecs)
 
 	.popsection
 
+#ifndef __HYPERVISOR__
 SYM_CODE_START(__smccc_workaround_1_smc)
 	esb
 	sub	sp, sp, #(8 * 4)
@@ -367,4 +377,5 @@ SYM_CODE_START(__smccc_workaround_1_smc)
 1:	.org __smccc_workaround_1_smc + __SMCCC_WORKAROUND_1_SMC_SZ
 	.org 1b
 SYM_CODE_END(__smccc_workaround_1_smc)
-#endif
+#endif /* __HYPERVISOR__ */
+#endif /* CONFIG_KVM_INDIRECT_VECTORS */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 873d3ab0fd68..fa20b2723652 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -7,7 +7,7 @@ asflags-y := -D__HYPERVISOR__
 ccflags-y := -D__HYPERVISOR__ -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
 	     $(DISABLE_STACKLEAK_PLUGIN)
 
-obj-y :=
+obj-y := host_hypercall.o ../hyp-entry.o
 
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
diff --git a/arch/arm64/kvm/hyp/host_hypercall.c b/arch/arm64/kvm/hyp/nvhe/host_hypercall.c
similarity index 100%
rename from arch/arm64/kvm/hyp/host_hypercall.c
rename to arch/arm64/kvm/hyp/nvhe/host_hypercall.c
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index a4f48c1ac28c..8d941d19085d 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -150,7 +150,7 @@ void kvm_patch_vector_branch(struct alt_instr *alt,
 	/*
 	 * Compute HYP VA by using the same computation as kern_hyp_va()
 	 */
-	addr = (uintptr_t)kvm_ksym_ref(__kvm_hyp_vector);
+	addr = (uintptr_t)kvm_hyp_ref(__kvm_hyp_vector);
 	addr &= va_mask;
 	addr |= tag_val << tag_lsb;
 
-- 
2.26.1

