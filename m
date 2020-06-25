Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5EF209F86
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 15:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405108AbgFYNPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 09:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404906AbgFYNOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:14:37 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FD1C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u26so6720566wmn.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQxENEuAescQgQ8YuHkNsxMwzrXVSxiQxJcx1FvZ0wM=;
        b=tQ4ZmYlnqW7fi6o8bfqxO70zKw3I/nJyKtMaVlg9YYB3X0BOc7Q/7CVjKbJz8MjbVf
         a4ZXJ/+2xDfQTDs7Ky1ylHAWtWxK324RvBqfIkrQlYSpuOrNQN5v2su1FTddE53LeDPm
         FuL3IQ9TtyKkCNa3WZBlgh4MdZOwNM7p4dTpzagBUn04tmTHGlBEbN1f6sCMH7z00F6V
         GnTeK4eMgjUXBeY4oIkaGr1MKrqueJQSrQKtmB2oU3vskinIaa1kVmCKbs/h7XFqeh5X
         igbho2CpXrJvdORofq0uLMDZlMNyrL8gBpgOaDuBHKm3uktiaCdFUZdUq3oZutQa3vd/
         M8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQxENEuAescQgQ8YuHkNsxMwzrXVSxiQxJcx1FvZ0wM=;
        b=TYz1HQah7Oygdf1Go4OUVU/EWwWcasDAs9W8TkhRRw8GUOjYa2P+/gACPZBHWF+/ah
         EnOwdek2ZBhNLGSaHpP10iZ1y0HUfTi6la55TYpZA8ZSSRWX6pkuyWG5YLC0W+UG+DlQ
         wz8Xv29nqSfRll2La4dU7wqBj1S3C4PiXAd+x2uE5kN/y6XGEAp2808tCbeCvznc5czx
         tykwThUr9w016XtKTJH6tzkvAh6eOcY0yFpevCbFJSAAV/W7Uo5ul1d1Eoq/mBMfX3QH
         jeMCqNawlsBtMlk9uDyTwfXh20p8iqXI3dpUm94SEL2glCE2Qj4HG8v08D6jjgaEwVPJ
         fzvA==
X-Gm-Message-State: AOAM530qvWfZQOlSpeLmKtuci7njFZCR6QTzKmFXGqjEEH9Ov8/y7Lrw
        h+f8b7ITMeobMjLnz42kPtvpVw==
X-Google-Smtp-Source: ABdhPJwDVXwLp+zGH+Az2IG7TV+GAawyV9fczge8t20gtdchvcYZjE+3zXDlTgAFnjoJwKMED2vcDQ==
X-Received: by 2002:a1c:449:: with SMTP id 70mr3165637wme.149.1593090875315;
        Thu, 25 Jun 2020 06:14:35 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c126:6748:7a9d:2d])
        by smtp.gmail.com with ESMTPSA id e4sm5332598wrt.97.2020.06.25.06.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 06:14:34 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 06/15] arm64: kvm: Build hyp-entry.S separately for VHE/nVHE
Date:   Thu, 25 Jun 2020 14:14:11 +0100
Message-Id: <20200625131420.71444-7-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625131420.71444-1-dbrazdil@google.com>
References: <20200625131420.71444-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hyp-entry.S contains implementation of KVM hyp vectors. This code is mostly
shared between VHE/nVHE, therefore compile it under both VHE and nVHE build
rules. nVHE-specific host HVC handler is hidden behind __KVM_NVHE_HYPERVISOR__.

Adjust code which selects which KVM hyp vecs to install to choose the correct
VHE/nVHE symbol.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h | 22 +++++++++++++++++-----
 arch/arm64/include/asm/mmu.h     |  7 -------
 arch/arm64/kernel/image-vars.h   | 24 ++++++++++++++++++++++++
 arch/arm64/kvm/arm.c             |  2 +-
 arch/arm64/kvm/hyp/Makefile      |  4 ++--
 arch/arm64/kvm/hyp/hyp-entry.S   |  2 ++
 arch/arm64/kvm/hyp/nvhe/Makefile |  2 +-
 arch/arm64/kvm/hyp/vhe/Makefile  |  2 +-
 8 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 6a682d66a640..6026cbd204ae 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -60,12 +60,17 @@
 	DECLARE_KVM_VHE_SYM(sym);		\
 	DECLARE_KVM_NVHE_SYM(sym)
 
-/* Translate a kernel address of @sym into its equivalent linear mapping */
-#define kvm_ksym_ref(sym)						\
+#define CHOOSE_VHE_SYM(sym)	sym
+#define CHOOSE_NVHE_SYM(sym)	kvm_nvhe_sym(sym)
+#define CHOOSE_HYP_SYM(sym)	(has_vhe() ? CHOOSE_VHE_SYM(sym) \
+					   : CHOOSE_NVHE_SYM(sym))
+
+/* Translate a kernel address @ptr into its equivalent linear mapping */
+#define kvm_ksym_ref(ptr)						\
 	({								\
-		void *val = &sym;					\
+		void *val = (ptr);					\
 		if (!is_kernel_in_hyp_mode())				\
-			val = lm_alias(&sym);				\
+			val = lm_alias((ptr));				\
 		val;							\
 	 })
 #define kvm_ksym_ref_nvhe(sym)	kvm_ksym_ref(kvm_nvhe_sym(sym))
@@ -76,7 +81,14 @@ struct kvm_vcpu;
 extern char __kvm_hyp_init[];
 extern char __kvm_hyp_init_end[];
 
-extern char __kvm_hyp_vector[];
+DECLARE_KVM_HYP_SYM(__kvm_hyp_vector);
+#define __kvm_hyp_vector	CHOOSE_HYP_SYM(__kvm_hyp_vector)
+
+#ifdef CONFIG_KVM_INDIRECT_VECTORS
+extern atomic_t arm64_el2_vector_last_slot;
+DECLARE_KVM_HYP_SYM(__bp_harden_hyp_vecs);
+#define __bp_harden_hyp_vecs	CHOOSE_HYP_SYM(__bp_harden_hyp_vecs)
+#endif
 
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
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
 
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 36444bac6a05..f28da486b75a 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -66,8 +66,17 @@ __efistub__ctype		= _ctype;
 /* Symbols defined in debug-sr.c (not yet compiled with nVHE build rules). */
 KVM_NVHE_ALIAS(__kvm_get_mdcr_el2);
 
+/* Symbols defined in entry.S (not yet compiled with nVHE build rules). */
+KVM_NVHE_ALIAS(__guest_exit);
+KVM_NVHE_ALIAS(abort_guest_exit_end);
+KVM_NVHE_ALIAS(abort_guest_exit_start);
+
+/* Symbols defined in hyp-init.S (not yet compiled with nVHE build rules). */
+KVM_NVHE_ALIAS(__kvm_handle_stub_hvc);
+
 /* Symbols defined in switch.c (not yet compiled with nVHE build rules). */
 KVM_NVHE_ALIAS(__kvm_vcpu_run_nvhe);
+KVM_NVHE_ALIAS(hyp_panic);
 
 /* Symbols defined in sysreg-sr.c (not yet compiled with nVHE build rules). */
 KVM_NVHE_ALIAS(__kvm_enable_ssbs);
@@ -89,6 +98,21 @@ KVM_NVHE_ALIAS(__vgic_v3_restore_aprs);
 KVM_NVHE_ALIAS(__vgic_v3_save_aprs);
 KVM_NVHE_ALIAS(__vgic_v3_write_vmcr);
 
+/* Alternative callbacks for init-time patching of nVHE hyp code. */
+KVM_NVHE_ALIAS(arm64_enable_wa2_handling);
+KVM_NVHE_ALIAS(kvm_patch_vector_branch);
+KVM_NVHE_ALIAS(kvm_update_va_mask);
+
+/* Global kernel state accessed by nVHE hyp code. */
+KVM_NVHE_ALIAS(arm64_ssbd_callback_required);
+KVM_NVHE_ALIAS(kvm_host_data);
+
+/* Kernel constant needed to compute idmap addresses. */
+KVM_NVHE_ALIAS(kimage_voffset);
+
+/* Kernel symbols used to call panic() from nVHE hyp code (via ERET). */
+KVM_NVHE_ALIAS(panic);
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 90cb90561446..34b551385153 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1285,7 +1285,7 @@ static void cpu_init_hyp_mode(void)
 	 * so that we can use adr_l to access per-cpu variables in EL2.
 	 */
 	tpidr_el2 = ((unsigned long)this_cpu_ptr(&kvm_host_data) -
-		     (unsigned long)kvm_ksym_ref(kvm_host_data));
+		     (unsigned long)kvm_ksym_ref(&kvm_host_data));
 
 	pgd_ptr = kvm_mmu_get_httbr();
 	hyp_stack_ptr = __this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE;
diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 9c5dfe6ff80b..8b0cf85080b5 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -10,11 +10,11 @@ subdir-ccflags-y := -I$(incdir)				\
 		    -DDISABLE_BRANCH_PROFILING		\
 		    $(DISABLE_STACKLEAK_PLUGIN)
 
-obj-$(CONFIG_KVM) += hyp.o nvhe/
+obj-$(CONFIG_KVM) += hyp.o vhe/ nvhe/
 obj-$(CONFIG_KVM_INDIRECT_VECTORS) += smccc_wa.o
 
 hyp-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o sysreg-sr.o \
-	 debug-sr.o entry.o switch.o fpsimd.o tlb.o hyp-entry.o
+	 debug-sr.o entry.o switch.o fpsimd.o tlb.o
 
 # KVM code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index d362fad97cc8..7e3c72fa634f 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -40,6 +40,7 @@ el1_sync:				// Guest trapped into EL2
 	ccmp	x0, #ESR_ELx_EC_HVC32, #4, ne
 	b.ne	el1_trap
 
+#ifdef __KVM_NVHE_HYPERVISOR__
 	mrs	x1, vttbr_el2		// If vttbr is valid, the guest
 	cbnz	x1, el1_hvc_guest	// called HVC
 
@@ -74,6 +75,7 @@ el1_sync:				// Guest trapped into EL2
 
 	eret
 	sb
+#endif /* __KVM_NVHE_HYPERVISOR__ */
 
 el1_hvc_guest:
 	/*
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 955f4188e00f..79eb8eed96a1 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -6,7 +6,7 @@
 asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__
 
-obj-y :=
+obj-y := ../hyp-entry.o
 
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
diff --git a/arch/arm64/kvm/hyp/vhe/Makefile b/arch/arm64/kvm/hyp/vhe/Makefile
index e04375546081..323029e02b4e 100644
--- a/arch/arm64/kvm/hyp/vhe/Makefile
+++ b/arch/arm64/kvm/hyp/vhe/Makefile
@@ -6,7 +6,7 @@
 asflags-y := -D__KVM_VHE_HYPERVISOR__
 ccflags-y := -D__KVM_VHE_HYPERVISOR__
 
-obj-y :=
+obj-y := ../hyp-entry.o
 
 # KVM code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
-- 
2.27.0

