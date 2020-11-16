Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515A82B52FC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbgKPUni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbgKPUnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:37 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3053FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:37 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so571122wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cifZGqu4hzHdEoTKK2NvZG8LzXvyLtXfM4MN8vu/UxQ=;
        b=YXixReoMUjs9oZEiRiU/bJ/aRmub/jXydDN0HcVtJt64vL0uLqo1nJJ5tCohdy995P
         10BsZFjArhfjK8JE1UEsI6+mr6Dq1oAZ/0Y5gvaCyy0mqYYiMAmleu7imxGe+eHqZV/v
         GXYHIO+HOJ43U6TDoCdTpiE3tvHr0ALKj632yV+XU3ly01anAo1kQncLGRitRly97iHg
         MOFnHyDQcHRFjTNDEWjhMkGKIQLYbwrpbSosq3vgCS71pYspAvR27tQqyCKOmiSvMNHn
         eTpod4PrV5Lxx0mEwTyiL1+7EW9u91qCiaK3AHG8geOmWMXKvhfRIs+BgSuYzXHctRnf
         JwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cifZGqu4hzHdEoTKK2NvZG8LzXvyLtXfM4MN8vu/UxQ=;
        b=i09i5HF5XndVJ7chH21QExd2Unp+b+6aN23prG1tE5WS6kgGp2cHhI8nnNsUZ7KFSg
         Uzw06mPWFPtDO7aMFeuA1bRQGF62JRcoMJZDPhzfILYmluBhQf68HgMGGo1qvT/c30UT
         4ctJym+x69ybeIz1oA/ppFKk7IdUZMGehUziIPGbkrV4tWEqwPNNqf8QIBAW0Wszsus2
         NVdU/5E6t+lwL9+GI9Ns5lzn6GxEMke9xuYPVzJbhADwlE0V2UTnBcsZXvP6rLiVxC9D
         OuwVYqvCMSSbHqXv3iRRa79zkDX1TUllJgezQHkv77ai5HM58FcHTRSJOrPrr88WvgyN
         dTfQ==
X-Gm-Message-State: AOAM531jco8Nrlm/m2LvTtbR6Oeu5bUyNPh0kexWLhAuj6y3j2AKFQqL
        VgU6a0ARPSqiAQ9MRpnDLOLvJw==
X-Google-Smtp-Source: ABdhPJw738vB0tVd+jrHsnKKdAN2nKcL4eZx5yd/ja7gzFxlq89wTIVPIeZtMY/V8vWx8FmRd4M3XA==
X-Received: by 2002:a1c:2d93:: with SMTP id t141mr733212wmt.104.1605559415737;
        Mon, 16 Nov 2020 12:43:35 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id s188sm530517wmf.45.2020.11.16.12.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:34 -0800 (PST)
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
Subject: [PATCH v2 06/24] kvm: arm64: Move hyp-init params to a per-CPU struct
Date:   Mon, 16 Nov 2020 20:43:00 +0000
Message-Id: <20201116204318.63987-7-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we start initializing KVM on newly booted cores before the rest of
the kernel, parameters to __do_hyp_init will need to be provided by EL2
rather than EL1. At that point it will not be possible to pass its four
arguments directly because PSCI_CPU_ON only supports one context
argument.

Refactor __do_hyp_init to accept its parameters in a struct. This
prepares the code for KVM booting cores as well as removes any limits on
the number of __do_hyp_init arguments.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h   |  7 +++++++
 arch/arm64/include/asm/kvm_hyp.h   |  4 ++++
 arch/arm64/kernel/asm-offsets.c    |  4 ++++
 arch/arm64/kvm/arm.c               | 26 ++++++++++++++------------
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 21 ++++++++++-----------
 arch/arm64/kvm/hyp/nvhe/hyp-main.c |  2 ++
 6 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 54387ccd1ab2..01904e88cead 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -150,6 +150,13 @@ extern void *__vhe_undefined_symbol;
 
 #endif
 
+struct kvm_nvhe_init_params {
+	unsigned long tpidr_el2;
+	unsigned long vector_hyp_va;
+	unsigned long stack_hyp_va;
+	phys_addr_t pgd_pa;
+};
+
 /* Translate a kernel address @ptr into its equivalent linear mapping */
 #define kvm_ksym_ref(ptr)						\
 	({								\
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 6b664de5ec1f..a3289071f3d8 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -15,6 +15,10 @@
 DECLARE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
 DECLARE_PER_CPU(unsigned long, kvm_hyp_vector);
 
+#ifdef __KVM_NVHE_HYPERVISOR__
+DECLARE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
+#endif
+
 #define read_sysreg_elx(r,nvh,vh)					\
 	({								\
 		u64 reg;						\
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 7d32fc959b1a..4435ad8be938 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -110,6 +110,10 @@ int main(void)
   DEFINE(CPU_APGAKEYLO_EL1,	offsetof(struct kvm_cpu_context, sys_regs[APGAKEYLO_EL1]));
   DEFINE(HOST_CONTEXT_VCPU,	offsetof(struct kvm_cpu_context, __hyp_running_vcpu));
   DEFINE(HOST_DATA_CONTEXT,	offsetof(struct kvm_host_data, host_ctxt));
+  DEFINE(NVHE_INIT_TPIDR_EL2,	offsetof(struct kvm_nvhe_init_params, tpidr_el2));
+  DEFINE(NVHE_INIT_VECTOR_HYP_VA,	offsetof(struct kvm_nvhe_init_params, vector_hyp_va));
+  DEFINE(NVHE_INIT_STACK_HYP_VA,	offsetof(struct kvm_nvhe_init_params, stack_hyp_va));
+  DEFINE(NVHE_INIT_PGD_PA,	offsetof(struct kvm_nvhe_init_params, pgd_pa));
 #endif
 #ifdef CONFIG_CPU_PM
   DEFINE(CPU_CTX_SP,		offsetof(struct cpu_suspend_ctx, sp));
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c0ffb019ca8b..4838556920fb 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -50,6 +50,7 @@ DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
+DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
 /* The VMID used in the VTTBR */
 static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
@@ -1347,10 +1348,7 @@ static int kvm_map_vectors(void)
 
 static void cpu_init_hyp_mode(void)
 {
-	phys_addr_t pgd_ptr;
-	unsigned long hyp_stack_ptr;
-	unsigned long vector_ptr;
-	unsigned long tpidr_el2;
+	struct kvm_nvhe_init_params *params = this_cpu_ptr_nvhe_sym(kvm_init_params);
 	struct arm_smccc_res res;
 
 	/* Switch from the HYP stub to our own HYP init vector */
@@ -1361,13 +1359,18 @@ static void cpu_init_hyp_mode(void)
 	 * kernel's mapping to the linear mapping, and store it in tpidr_el2
 	 * so that we can use adr_l to access per-cpu variables in EL2.
 	 */
-	tpidr_el2 = (unsigned long)this_cpu_ptr_nvhe_sym(__per_cpu_start) -
-		    (unsigned long)kvm_ksym_ref(CHOOSE_NVHE_SYM(__per_cpu_start));
+	params->tpidr_el2 = (unsigned long)this_cpu_ptr_nvhe_sym(__per_cpu_start) -
+			    (unsigned long)kvm_ksym_ref(CHOOSE_NVHE_SYM(__per_cpu_start));
 
-	pgd_ptr = kvm_mmu_get_httbr();
-	hyp_stack_ptr = __this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE;
-	hyp_stack_ptr = kern_hyp_va(hyp_stack_ptr);
-	vector_ptr = (unsigned long)kern_hyp_va(kvm_ksym_ref(__kvm_hyp_host_vector));
+	params->vector_hyp_va = (unsigned long)kern_hyp_va(kvm_ksym_ref(__kvm_hyp_host_vector));
+	params->stack_hyp_va = kern_hyp_va(__this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE);
+	params->pgd_pa = kvm_mmu_get_httbr();
+
+	/*
+	 * Flush the init params from the data cache because the struct will
+	 * be read while the MMU is off.
+	 */
+	__flush_dcache_area(params, sizeof(*params));
 
 	/*
 	 * Call initialization code, and switch to the full blown HYP code.
@@ -1376,8 +1379,7 @@ static void cpu_init_hyp_mode(void)
 	 * cpus_have_const_cap() wrapper.
 	 */
 	BUG_ON(!system_capabilities_finalized());
-	arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(__kvm_hyp_init),
-			  pgd_ptr, tpidr_el2, hyp_stack_ptr, vector_ptr, &res);
+	arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(__kvm_hyp_init), virt_to_phys(params), &res);
 	WARN_ON(res.a0 != SMCCC_RET_SUCCESS);
 
 	/*
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index 17b58dbc3a2f..67342cc9930f 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -47,10 +47,7 @@ __invalid:
 
 	/*
 	 * x0: SMCCC function ID
-	 * x1: HYP pgd
-	 * x2: per-CPU offset
-	 * x3: HYP stack
-	 * x4: HYP vectors
+	 * x1: struct kvm_nvhe_init_params PA
 	 */
 __do_hyp_init:
 	/* Check for a stub HVC call */
@@ -71,10 +68,16 @@ __do_hyp_init:
 	mov	x0, #SMCCC_RET_NOT_SUPPORTED
 	eret
 
-1:
-	/* Set tpidr_el2 for use by HYP to free a register */
-	msr	tpidr_el2, x2
+1:	ldr	x0, [x1, #NVHE_INIT_TPIDR_EL2]
+	msr	tpidr_el2, x0
 
+	ldr	x0, [x1, #NVHE_INIT_VECTOR_HYP_VA]
+	msr	vbar_el2, x0
+
+	ldr	x0, [x1, #NVHE_INIT_STACK_HYP_VA]
+	mov	sp, x0
+
+	ldr	x1, [x1, #NVHE_INIT_PGD_PA]
 	phys_to_ttbr x0, x1
 alternative_if ARM64_HAS_CNP
 	orr	x0, x0, #TTBR_CNP_BIT
@@ -134,10 +137,6 @@ alternative_else_nop_endif
 	msr	sctlr_el2, x0
 	isb
 
-	/* Set the stack and new vectors */
-	mov	sp, x3
-	msr	vbar_el2, x4
-
 	/* Hello, World! */
 	mov	x0, #SMCCC_RET_SUCCESS
 	eret
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index e2eafe2c93af..411b0f652417 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -14,6 +14,8 @@
 
 #include <kvm/arm_hypercalls.h>
 
+DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
+
 static void handle_host_hcall(unsigned long func_id,
 			      struct kvm_cpu_context *host_ctxt)
 {
-- 
2.29.2.299.gdc1121823c-goog

