Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A461BFF15
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgD3Osv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 10:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726381AbgD3Ost (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:48:49 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363FDC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:48:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u127so2252722wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Et31WmaEF3NVxQ9iRAHtWhBYsTOVasFwLzjZZ8UNgn4=;
        b=bC+mz6GfvrnkOnQEz/hwR9vsyG+MUq+E6dxIarhu6iYRLAXwYKw8e+g6X+D4R8l+IH
         sMOa5WsbPR2Njm/N5hvCsmHXp/J4/8BJatuBqFCFWe/11sj222cqDm5wvQ9XR0qHNVTp
         xKMnub7wYILsLr3ZVeu1u/oCCj2JcM5eNtGB9cdY4cRE8BBuoQzQA/57yVi+JqWiP8hk
         rvvSkBeHxyV4lQ5NKFuZm+q1W0ypfO7AjdnUek1NcCC7RhCM7G1EuxLxmFxCd20l/UcP
         e9Wu+aLysGBDvEg/WmqNk/ZVA+zl0fTKNaWy25DymyTsz7nJtrx62FMqKsazcbtU+yQg
         z02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Et31WmaEF3NVxQ9iRAHtWhBYsTOVasFwLzjZZ8UNgn4=;
        b=tBc0vLG2ajUDFnwQw7/xcuEuIN+sA1yTqGOGOdGGCL5mgFXo0OQi7oC5zZOJfU8xlo
         TnCOeAyMgpNGHlH90FkniQg3ZJjcr2beW9NyZMnsft40VBSx84Xr9wjv7Oi5CqZse7Nc
         IAUd+xGhWReZ5/IZ/NYa17MOMg9z+ZuLCUm/lniHcD6EEZbroQ9Iccxtpa9MAMz9QPX/
         KMu7YE0NwwivDoOl/cYb90qfLW7SEehPeUfpiDgx8NinmJfszvv5Dohp6ZtybUjXG8GB
         dF8S7EDwDQhmFMkryZROSi9KBdx6vBStrHFq86G4mAmRzdXgwvImjsRFFXTd6EBS1AwT
         BXPQ==
X-Gm-Message-State: AGi0PuZMNBWLtrRg2wOaGr8BYGfZm+xquSVoSzRGQErhr0jOaPLNQXsK
        WxsrIhV0o524EANDiieIyqan7w==
X-Google-Smtp-Source: APiQypLUgdRp550jRZBba6fEHIWQDJiuFtrLkN9twyuprE+II7yxmPIaRskKBXyR0JgZ3TtglMgvqw==
X-Received: by 2002:a1c:9cca:: with SMTP id f193mr3308452wme.71.1588258127525;
        Thu, 30 Apr 2020 07:48:47 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d4b6:9828:8bd2:ce6f])
        by smtp.gmail.com with ESMTPSA id v19sm4450674wra.57.2020.04.30.07.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:48:46 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH 02/15] arm64: kvm: Formalize host-hyp hypcall ABI
Date:   Thu, 30 Apr 2020 15:48:18 +0100
Message-Id: <20200430144831.59194-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200430144831.59194-1-dbrazdil@google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Perret <qperret@google.com>

In preparation for removing the hyp code from the TCB, convert the current
EL1 - EL2 KVM ABI to use hypercall numbers in lieu of direct function pointers.
While this in itself does not provide any isolation, it is a first step towards
having a properly defined EL2 ABI.

The implementation is based on a kvm_hcall_table which holds function pointers
to the hyp_text functions corresponding to each hypercall. This is highly
inspired from the arm64 sys_call_table, the main difference being the lack of
hcall wrappers at this stage.

Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_host.h            | 20 ++++++-
 arch/arm64/include/asm/kvm_host_hypercalls.h | 62 ++++++++++++++++++++
 arch/arm64/kvm/hyp/Makefile                  |  2 +-
 arch/arm64/kvm/hyp/host_hypercall.c          | 22 +++++++
 arch/arm64/kvm/hyp/hyp-entry.S               | 36 +++++++++++-
 5 files changed, 137 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_host_hypercalls.h
 create mode 100644 arch/arm64/kvm/hyp/host_hypercall.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e61143d6602d..5dec3b06f2b7 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -24,6 +24,7 @@
 #include <asm/fpsimd.h>
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
+#include <asm/kvm_host_hypercalls.h>
 #include <asm/thread_info.h>
 #include <asm/virt.h>
 
@@ -447,10 +448,25 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
-#define kvm_call_hyp_nvhe(hypfn, ...) \
-	__kvm_call_hyp((unsigned long)kvm_ksym_ref(hypfn), ##__VA_ARGS__)
+/*
+ * Call the hypervisor via HVC. The hcall parameter must be the name of
+ * a hypercall as defined in <asm/kvm_host_hypercall.h>.
+ *
+ * Hypercalls take at most 6 parameters.
+ */
+#define kvm_call_hyp_nvhe(hcall, ...) \
+	__kvm_call_hyp(KVM_HOST_HCALL_NR(hcall), ##__VA_ARGS__)
 
 /*
+ * u64 kvm_call_hyp(hcall, ...);
+ *
+ * Call the hypervisor. The hcall parameter must be the name of a hypercall
+ * defined in <asm/kvm_host_hypercall.h>. In the VHE case, this will be
+ * translated into a direct function call.
+ *
+ * A hcall value of less than 0xfff has a special meaning and is used to
+ * implement hyp stubs in the same way as in arch/arm64/kernel/hyp_stub.S.
+ *
  * The couple of isb() below are there to guarantee the same behaviour
  * on VHE as on !VHE, where the eret to EL1 acts as a context
  * synchronization event.
diff --git a/arch/arm64/include/asm/kvm_host_hypercalls.h b/arch/arm64/include/asm/kvm_host_hypercalls.h
new file mode 100644
index 000000000000..af8ad505d816
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_host_hypercalls.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Google, inc
+ */
+
+#ifndef __KVM_HOST_HCALL
+#define __KVM_HOST_HCALL(x)
+#endif
+
+#define __KVM_HOST_HCALL_TABLE_IDX___kvm_enable_ssbs		0
+__KVM_HOST_HCALL(__kvm_enable_ssbs)
+
+#define __KVM_HOST_HCALL_TABLE_IDX___kvm_get_mdcr_el2		1
+__KVM_HOST_HCALL(__kvm_get_mdcr_el2)
+
+#define __KVM_HOST_HCALL_TABLE_IDX___kvm_timer_set_cntvoff	2
+__KVM_HOST_HCALL(__kvm_timer_set_cntvoff)
+
+#define __KVM_HOST_HCALL_TABLE_IDX___kvm_tlb_flush_local_vmid	3
+__KVM_HOST_HCALL(__kvm_tlb_flush_local_vmid)
+
+#define __KVM_HOST_HCALL_TABLE_IDX___kvm_flush_vm_context	4
+__KVM_HOST_HCALL(__kvm_flush_vm_context)
+
+#define __KVM_HOST_HCALL_TABLE_IDX___kvm_vcpu_run_nvhe		5
+__KVM_HOST_HCALL(__kvm_vcpu_run_nvhe)
+
+#define __KVM_HOST_HCALL_TABLE_IDX___kvm_tlb_flush_vmid		6
+__KVM_HOST_HCALL(__kvm_tlb_flush_vmid)
+
+#define __KVM_HOST_HCALL_TABLE_IDX___kvm_tlb_flush_vmid_ipa	7
+__KVM_HOST_HCALL(__kvm_tlb_flush_vmid_ipa)
+
+#define __KVM_HOST_HCALL_TABLE_IDX___vgic_v3_init_lrs		8
+__KVM_HOST_HCALL(__vgic_v3_init_lrs)
+
+#define __KVM_HOST_HCALL_TABLE_IDX___vgic_v3_get_ich_vtr_el2	9
+__KVM_HOST_HCALL(__vgic_v3_get_ich_vtr_el2)
+
+#define __KVM_HOST_HCALL_TABLE_IDX___vgic_v3_write_vmcr		10
+__KVM_HOST_HCALL(__vgic_v3_write_vmcr)
+
+#define __KVM_HOST_HCALL_TABLE_IDX___vgic_v3_restore_aprs	11
+__KVM_HOST_HCALL(__vgic_v3_restore_aprs)
+
+#define __KVM_HOST_HCALL_TABLE_IDX___vgic_v3_read_vmcr		12
+__KVM_HOST_HCALL(__vgic_v3_read_vmcr)
+
+#define __KVM_HOST_HCALL_TABLE_IDX___vgic_v3_save_aprs		13
+__KVM_HOST_HCALL(__vgic_v3_save_aprs)
+
+#define __KVM_HOST_HCALL_TABLE_IDX_SIZE				14
+
+/* XXX - Arbitrary offset for KVM-related hypercalls */
+#define __KVM_HOST_HCALL_BASE_SHIFT 8
+#define __KVM_HOST_HCALL_BASE (1ULL << __KVM_HOST_HCALL_BASE_SHIFT)
+#define __KVM_HOST_HCALL_END (__KVM_HOST_HCALL_BASE + \
+			      __KVM_HOST_HCALL_TABLE_IDX_SIZE)
+
+/* Hypercall number = kvm offset + table idx */
+#define KVM_HOST_HCALL_NR(name) (__KVM_HOST_HCALL_TABLE_IDX_##name + \
+				 __KVM_HOST_HCALL_BASE)
diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 8c9880783839..29e2b2cd2fbc 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -9,7 +9,7 @@ ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
 obj-$(CONFIG_KVM) += hyp.o
 
 hyp-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o sysreg-sr.o \
-	 debug-sr.o entry.o switch.o fpsimd.o tlb.o hyp-entry.o
+	 debug-sr.o entry.o switch.o fpsimd.o tlb.o host_hypercall.o hyp-entry.o
 
 # KVM code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
diff --git a/arch/arm64/kvm/hyp/host_hypercall.c b/arch/arm64/kvm/hyp/host_hypercall.c
new file mode 100644
index 000000000000..6b31310f36a8
--- /dev/null
+++ b/arch/arm64/kvm/hyp/host_hypercall.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Google, inc
+ */
+
+#include <asm/kvm_hyp.h>
+
+typedef long (*kvm_hcall_fn_t)(void);
+
+static long __hyp_text kvm_hc_ni(void)
+{
+       return -ENOSYS;
+}
+
+#undef __KVM_HOST_HCALL
+#define __KVM_HOST_HCALL(name) \
+	[__KVM_HOST_HCALL_TABLE_IDX_##name] = (long (*)(void))name,
+
+const kvm_hcall_fn_t kvm_hcall_table[__KVM_HOST_HCALL_TABLE_IDX_SIZE] = {
+	[0 ... __KVM_HOST_HCALL_TABLE_IDX_SIZE-1] = kvm_hc_ni,
+#include <asm/kvm_host_hypercalls.h>
+};
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index c2a13ab3c471..1a51a0958504 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -13,6 +13,7 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_host_hypercalls.h>
 #include <asm/mmu.h>
 
 	.text
@@ -21,17 +22,26 @@
 .macro do_el2_call
 	/*
 	 * Shuffle the parameters before calling the function
-	 * pointed to in x0. Assumes parameters in x[1,2,3].
+	 * pointed to in x0. Assumes parameters in x[1,2,3,4,5,6].
 	 */
 	str	lr, [sp, #-16]!
 	mov	lr, x0
 	mov	x0, x1
 	mov	x1, x2
 	mov	x2, x3
+	mov	x3, x4
+	mov	x4, x5
+	mov	x5, x6
 	blr	lr
 	ldr	lr, [sp], #16
 .endm
 
+/* kern_hyp_va(lm_alias(ksym)) */
+.macro ksym_hyp_va ksym, lm_offset
+	sub	\ksym, \ksym, \lm_offset
+	kern_hyp_va	\ksym
+.endm
+
 el1_sync:				// Guest trapped into EL2
 
 	mrs	x0, esr_el2
@@ -66,10 +76,32 @@ el1_sync:				// Guest trapped into EL2
 	br	x5
 
 1:
+	/* Check if the hcall number is valid */
+	cmp	x0, #__KVM_HOST_HCALL_BASE
+	b.lt	2f
+	cmp	x0, #__KVM_HOST_HCALL_END
+	b.lt	3f
+2:
+	mov	x0, -ENOSYS
+	eret
+
+3:
+	/* Compute lm_alias() offset in x9 */
+	ldr_l	x9, kimage_voffset
+	ldr_l	x10, physvirt_offset
+	add	x9, x9, x10
+
+	/* Find hcall function pointer in the table */
+	ldr	x10, =kvm_hcall_table
+	ksym_hyp_va	x10, x9
+	sub	x0, x0, #__KVM_HOST_HCALL_BASE
+	add	x0, x10, x0, lsl 3
+	ldr	x0, [x0]
+	ksym_hyp_va	x0, x9
+
 	/*
 	 * Perform the EL2 call
 	 */
-	kern_hyp_va	x0
 	do_el2_call
 
 	eret
-- 
2.26.1

