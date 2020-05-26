Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269A31D4BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 12:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgEOK7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 06:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgEOK7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:59:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE89FC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:59:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w64so2161676wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/saoxLzK90JZJFKv9cA9pNeOmBHJRKCJDK5y22zbNZc=;
        b=kORIAiHIEKPrF1Kyrlm7Vftogj3IZCDUZqDv/LsKMvCHMe7gpfJeCeZ6r9AIGiOWq3
         8ONVDRsIOCg3Kfji0CcMwVU2iFxNX3WKFVKPXHCSFrB0AHDtAUiwOwvNFjqjRIaeCCcD
         L7F5zbQzmbl5QWfYfKuzXoXH2u83K7a/U8QfJY7wdOTCqYGv+dSQsAFUqPp8X8S90Q2o
         icSBcBGJ1EWEdDt/Uo4OWdCuy99B7GosMhBl2bA2oCbUQnWt6Cu7NoRpuH52INYTdMU/
         k6yCWnUhAl++Udm59+ZZCN1/nx6Xk9A/LL+hwAQIzp5rHbUPVtvH7UVy5Ehls4KzBBVe
         ijjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/saoxLzK90JZJFKv9cA9pNeOmBHJRKCJDK5y22zbNZc=;
        b=oZNPW0INkDSz13lQc0f7TYCn+6spPMaI4znZTfTcf3iEl4/ImSAl3wQxd4MDHEeXDC
         /Q0p0uC8b/Z+cwYxXS2MLpNohclMhJhUubYSQY0Ye1ACna8oF4w7HmKyyPuv9utKg22C
         BWt2JRPMrkTTj+cwcksKF1GLGx7/U9SFSWUQh0TysnV9Ix8FB+a3szcbeki23PrKSvw2
         us9bY/FL/Mf+ZE25YwT22b9H7AS/tZbikpVTDtCm8UVEg7lsDUGCmOChdsHlH+dfKJfb
         /A6OBudWbjTnV/RPEMlV/9XubnAm9m9CV4jmgGCEcRsId5UjxNfv5rU0Ed152kDRY0Xo
         UuBQ==
X-Gm-Message-State: AOAM531WVjIxmgKbN2vXJi7kLzKx5dkk18Wwz/gbW0ADiedFvM9DAAcg
        /ZTtbbCqlCtH/DtlUZGehfClhw==
X-Google-Smtp-Source: ABdhPJwwB0QO6cu9C49/M2CcaZGeJ8tiKTHqKxWYqZyiwYIjWsb3eUnN+QIM17TGSNwwkdlefEG+TA==
X-Received: by 2002:a1c:7d43:: with SMTP id y64mr3548231wmc.46.1589540343004;
        Fri, 15 May 2020 03:59:03 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d11b:f847:8002:7411])
        by smtp.gmail.com with ESMTPSA id c16sm2991865wrv.62.2020.05.15.03.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 03:59:02 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 05/14] arm64: kvm: Build hyp-entry.S separately for VHE/nVHE
Date:   Fri, 15 May 2020 11:58:32 +0100
Message-Id: <20200515105841.73532-6-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515105841.73532-1-dbrazdil@google.com>
References: <20200515105841.73532-1-dbrazdil@google.com>
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
rules. nVHE-specific host HVC handler is hidden behind __KVM_NVHE_HYPERVISOR__.

Adjust code which selects which KVM hyp vecs to install to choose the correct
VHE/nVHE symbol.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h | 25 ++++++++++++++++++++++++-
 arch/arm64/include/asm/kvm_mmu.h | 16 ++++++++++------
 arch/arm64/include/asm/mmu.h     |  7 -------
 arch/arm64/kernel/cpu_errata.c   |  4 +++-
 arch/arm64/kernel/image-vars.h   | 29 ++++++++++++++++++++++++++++-
 arch/arm64/kvm/hyp/hyp-entry.S   |  2 ++
 arch/arm64/kvm/hyp/nvhe/Makefile |  2 +-
 arch/arm64/kvm/va_layout.c       |  2 +-
 8 files changed, 69 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 7c7eeeaab9fa..01242f54c48f 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -42,6 +42,22 @@
 
 #include <linux/mm.h>
 
+/*
+ * Translate name of a symbol defined in VHE/nVHE hyp implementations
+ * to the name seen by kernel proper. All nVHE symbols are prefixed by
+ * the build system to avoid clashes with the VHE variants.
+ */
+#define __kvm_vhe_sym(sym)	sym
+#define __kvm_nvhe_sym(sym)	__kvm_nvhe_##sym
+
+/*
+ * Define a pair of symbols sharing the same name but one defined in
+ * VHE and the other in nVHE hyp implementations.
+ */
+#define DECLARE_KVM_HYP_SYM(sym)		\
+	extern char __kvm_vhe_sym(sym)[];	\
+	extern char __kvm_nvhe_sym(sym)[]
+
 /* Translate a kernel address of @sym into its equivalent linear mapping */
 #define kvm_ksym_ref(sym)						\
 	({								\
@@ -50,6 +66,8 @@
 			val = lm_alias(&sym);				\
 		val;							\
 	 })
+#define kvm_ksym_ref_vhe(sym)	kvm_ksym_ref(__kvm_vhe_sym(sym))
+#define kvm_ksym_ref_nvhe(sym)	kvm_ksym_ref(__kvm_nvhe_sym(sym))
 
 struct kvm;
 struct kvm_vcpu;
@@ -57,7 +75,12 @@ struct kvm_vcpu;
 extern char __kvm_hyp_init[];
 extern char __kvm_hyp_init_end[];
 
-extern char __kvm_hyp_vector[];
+DECLARE_KVM_HYP_SYM(__kvm_hyp_vector);
+
+#ifdef CONFIG_KVM_INDIRECT_VECTORS
+DECLARE_KVM_HYP_SYM(__bp_harden_hyp_vecs);
+extern atomic_t arm64_el2_vector_last_slot;
+#endif
 
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 30b0e8d6b895..871ef591042c 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -477,11 +477,15 @@ extern int __kvm_harden_el2_vector_slot;
 static inline void *kvm_get_hyp_vector(void)
 {
 	struct bp_hardening_data *data = arm64_get_bp_hardening_data();
-	void *vect = kern_hyp_va(kvm_ksym_ref(__kvm_hyp_vector));
 	int slot = -1;
+	void *vect = kern_hyp_va(has_vhe()
+		? kvm_ksym_ref_vhe(__kvm_hyp_vector)
+		: kvm_ksym_ref_nvhe(__kvm_hyp_vector));
 
 	if (cpus_have_const_cap(ARM64_HARDEN_BRANCH_PREDICTOR) && data->fn) {
-		vect = kern_hyp_va(kvm_ksym_ref(__bp_harden_hyp_vecs));
+		vect = kern_hyp_va(has_vhe()
+			? kvm_ksym_ref_vhe(__bp_harden_hyp_vecs)
+			: kvm_ksym_ref_nvhe(__bp_harden_hyp_vecs));
 		slot = data->hyp_vectors_slot;
 	}
 
@@ -510,12 +514,11 @@ static inline int kvm_map_vectors(void)
 	 *  HBP +  HEL2 -> use hardened vertors and use exec mapping
 	 */
 	if (cpus_have_const_cap(ARM64_HARDEN_BRANCH_PREDICTOR)) {
-		__kvm_bp_vect_base = kvm_ksym_ref(__bp_harden_hyp_vecs);
-		__kvm_bp_vect_base = kern_hyp_va(__kvm_bp_vect_base);
+		__kvm_bp_vect_base = kern_hyp_va(kvm_ksym_ref_nvhe(__bp_harden_hyp_vecs));
 	}
 
 	if (cpus_have_const_cap(ARM64_HARDEN_EL2_VECTORS)) {
-		phys_addr_t vect_pa = __pa_symbol(__bp_harden_hyp_vecs);
+		phys_addr_t vect_pa = __pa_symbol(__kvm_nvhe_sym(__bp_harden_hyp_vecs));
 		unsigned long size = __BP_HARDEN_HYP_VECS_SZ;
 
 		/*
@@ -534,7 +537,8 @@ static inline int kvm_map_vectors(void)
 #else
 static inline void *kvm_get_hyp_vector(void)
 {
-	return kern_hyp_va(kvm_ksym_ref(__kvm_hyp_vector));
+	return kern_hyp_va(has_vhe() ? kvm_ksym_ref_vhe(__kvm_hyp_vector)
+				     : kvm_ksym_ref_nvhe(__kvm_hyp_vector));
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
index a102321fc8a2..94af3af12f44 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -117,7 +117,9 @@ DEFINE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
 static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
 				const char *hyp_vecs_end)
 {
-	void *dst = lm_alias(__bp_harden_hyp_vecs + slot * SZ_2K);
+	char *vec = has_vhe() ? __kvm_vhe_sym(__bp_harden_hyp_vecs)
+			      : __kvm_nvhe_sym(__bp_harden_hyp_vecs);
+	void *dst = lm_alias(vec + slot * SZ_2K);
 	int i;
 
 	for (i = 0; i < SZ_2K; i += 0x80)
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 13850134fc28..dc9c14d91d39 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -54,13 +54,40 @@ __efistub__ctype		= _ctype;
 #ifdef CONFIG_KVM
 
 /*
- * KVM nVHE code has its own symbol namespace prefixed by __hyp_text_, to
+ * KVM nVHE code has its own symbol namespace prefixed by __kvm_nvhe_, to
  * isolate it from the kernel proper. The following symbols are legally
  * accessed by it, therefore provide aliases to make them linkable.
  * Do not include symbols which may not be safely accessed under hypervisor
  * memory mappings.
  */
 
+__kvm_nvhe___guest_exit = __guest_exit;
+__kvm_nvhe___kvm_enable_ssbs = __kvm_enable_ssbs;
+__kvm_nvhe___kvm_flush_vm_context = __kvm_flush_vm_context;
+__kvm_nvhe___kvm_get_mdcr_el2 = __kvm_get_mdcr_el2;
+__kvm_nvhe___kvm_handle_stub_hvc = __kvm_handle_stub_hvc;
+__kvm_nvhe___kvm_timer_set_cntvoff = __kvm_timer_set_cntvoff;
+__kvm_nvhe___kvm_tlb_flush_local_vmid = __kvm_tlb_flush_local_vmid;
+__kvm_nvhe___kvm_tlb_flush_vmid = __kvm_tlb_flush_vmid;
+__kvm_nvhe___kvm_tlb_flush_vmid_ipa = __kvm_tlb_flush_vmid_ipa;
+__kvm_nvhe___kvm_vcpu_run_nvhe = __kvm_vcpu_run_nvhe;
+__kvm_nvhe___vgic_v3_get_ich_vtr_el2 = __vgic_v3_get_ich_vtr_el2;
+__kvm_nvhe___vgic_v3_init_lrs = __vgic_v3_init_lrs;
+__kvm_nvhe___vgic_v3_read_vmcr = __vgic_v3_read_vmcr;
+__kvm_nvhe___vgic_v3_restore_aprs = __vgic_v3_restore_aprs;
+__kvm_nvhe___vgic_v3_save_aprs = __vgic_v3_save_aprs;
+__kvm_nvhe___vgic_v3_write_vmcr = __vgic_v3_write_vmcr;
+__kvm_nvhe_abort_guest_exit_end = abort_guest_exit_end;
+__kvm_nvhe_abort_guest_exit_start = abort_guest_exit_start;
+__kvm_nvhe_arm64_enable_wa2_handling = arm64_enable_wa2_handling;
+__kvm_nvhe_arm64_ssbd_callback_required = arm64_ssbd_callback_required;
+__kvm_nvhe_hyp_panic = hyp_panic;
+__kvm_nvhe_kimage_voffset = kimage_voffset;
+__kvm_nvhe_kvm_host_data = kvm_host_data;
+__kvm_nvhe_kvm_patch_vector_branch = kvm_patch_vector_branch;
+__kvm_nvhe_kvm_update_va_mask = kvm_update_va_mask;
+__kvm_nvhe_panic = panic;
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index ab14de8d0131..81c65fa65183 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -27,6 +27,7 @@ el1_sync:				// Guest trapped into EL2
 	ccmp	x0, #ESR_ELx_EC_HVC32, #4, ne
 	b.ne	el1_trap
 
+#ifdef __KVM_NVHE_HYPERVISOR__
 	mrs	x1, vttbr_el2		// If vttbr is valid, the guest
 	cbnz	x1, el1_hvc_guest	// called HVC
 
@@ -86,6 +87,7 @@ el1_host_invalid_hvc:
 	mov	x0, -ENOSYS
 	eret
 	sb
+#endif /* __KVM_NVHE_HYPERVISOR__ */
 
 el1_hvc_guest:
 	/*
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 7d64235dba62..c68801e24950 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -7,7 +7,7 @@ asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -fno-stack-protector \
 	     -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN)
 
-obj-y :=
+obj-y := ../hyp-entry.o
 
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index a4f48c1ac28c..157d106235f7 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -150,7 +150,7 @@ void kvm_patch_vector_branch(struct alt_instr *alt,
 	/*
 	 * Compute HYP VA by using the same computation as kern_hyp_va()
 	 */
-	addr = (uintptr_t)kvm_ksym_ref(__kvm_hyp_vector);
+	addr = (uintptr_t)kvm_ksym_ref_nvhe(__kvm_hyp_vector);
 	addr &= va_mask;
 	addr |= tag_val << tag_lsb;
 
-- 
2.26.2

