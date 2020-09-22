Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F36E274A58
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgIVUt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgIVUtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:49:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F53BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so4781946wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G5BfnFkypsuHsKqXP8ErB3dblSM7o7zNnaIIUEU0OA0=;
        b=Gfzg4P+M99Bj/VtLtlR9Zz8hjgewl+m03sGyf+iYOQSkZuuD1eRIT8lKkTXEUOlNfF
         3sRjsiA6PBiXhZhH4K7Bcw+c4CEnvgm3qVXwpEc0zd0q04ClqeTTRZctkjh01CJqdAZF
         6GD8VZbLGdPfk5oba/NYPG61bDYC0Nspajts+8YrqL928+k2k6LBKN+/AdzMfGExl82Q
         DdZ6qSVClY53bOt0vGXyERkMAcgy2o4ekChXFhBjMGckD/39T/kxgaEpCupOkK3p2rqQ
         KTLKSbQN9WgIFPJA4/wrinBvgCrCp1pvhhQM0AensXRhLOqFc+6tnUnri0rV6WYjK544
         T0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5BfnFkypsuHsKqXP8ErB3dblSM7o7zNnaIIUEU0OA0=;
        b=XtgZKGqoszzpNJFOeiMrxr7wN4TH9TluOHLOsnRDqs2zGLB0vtRQNpiU7HQITXdJyq
         Lf7MWoOeHRn5I6Z0nvin6Lo7pShzhx7rlftNoL4kMyc6/Keh61GIEVPPCmNAIWP3uT+P
         pz1uQJlhaHbpVBFsxDr3DqGLIdrVsVZnjk0Qv0Nc8VJ6XJjvWV/0zhxas3Q6TGiAPRt+
         zpssY10mHXWs1qAKMnbjO6ssKD/Ff2K72Q9q1FqfHNcI1RDTx2Pr1CHQq2ZLzGyDTSfk
         Zg/AdFyiNKAD7vDYzWkyI6De2MkhDxkpWm4lq4Q6ZVZ3UppaW3SbfvM2201sHzLCvvXL
         Hqjw==
X-Gm-Message-State: AOAM5326RGzPmtF4RSGtB3bPeIpasH2ajWG21tr3F8voMwbecSE3SnXw
        ODbusS+6r5GjR2286u09AjpgFQ==
X-Google-Smtp-Source: ABdhPJx96GCqe8z3nLYveSuFwaQckNQT2LOdtuxNKpBFNIwBcIpsN1AbPYzRuZczVtssKfExWT1+Kg==
X-Received: by 2002:a1c:6187:: with SMTP id v129mr2840724wmb.35.1600807759424;
        Tue, 22 Sep 2020 13:49:19 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:1105:630f:e990:272f])
        by smtp.gmail.com with ESMTPSA id l17sm5799200wme.11.2020.09.22.13.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:49:18 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>,
        Andrew Scull <ascull@google.com>
Subject: [PATCH v4 04/10] kvm: arm64: Remove __hyp_this_cpu_read
Date:   Tue, 22 Sep 2020 21:49:04 +0100
Message-Id: <20200922204910.7265-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922204910.7265-1-dbrazdil@google.com>
References: <20200922204910.7265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this_cpu_ptr is meant for use in kernel proper because it selects between
TPIDR_EL1/2 based on nVHE/VHE. __hyp_this_cpu_ptr was used in hyp to always
select TPIDR_EL2. Unify all users behind this_cpu_ptr and friends by
selecting _EL2 register under __KVM_NVHE_HYPERVISOR__. VHE continues
selecting the register using alternatives.

Under CONFIG_DEBUG_PREEMPT, the kernel helpers perform a preemption check
which is omitted by the hyp helpers. Preserve the behavior for nVHE by
overriding the corresponding macros under __KVM_NVHE_HYPERVISOR__. Extend
the checks into VHE hyp code.

Acked-by: Andrew Scull <ascull@google.com>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h          | 20 ----------------
 arch/arm64/include/asm/percpu.h           | 28 +++++++++++++++++++++--
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h |  4 ++--
 arch/arm64/kvm/hyp/include/hyp/switch.h   |  8 +++----
 arch/arm64/kvm/hyp/nvhe/switch.c          |  2 +-
 arch/arm64/kvm/hyp/vhe/switch.c           |  2 +-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c        |  4 ++--
 7 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index c085032e2e3e..c196eec25498 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -143,26 +143,6 @@ extern char __smccc_workaround_1_smc[__SMCCC_WORKAROUND_1_SMC_SZ];
 		addr;							\
 	})
 
-/*
- * Home-grown __this_cpu_{ptr,read} variants that always work at HYP,
- * provided that sym is really a *symbol* and not a pointer obtained from
- * a data structure. As for SHIFT_PERCPU_PTR(), the creative casting keeps
- * sparse quiet.
- */
-#define __hyp_this_cpu_ptr(sym)						\
-	({								\
-		void *__ptr;						\
-		__verify_pcpu_ptr(&sym);				\
-		__ptr = hyp_symbol_addr(sym);				\
-		__ptr += read_sysreg(tpidr_el2);			\
-		(typeof(sym) __kernel __force *)__ptr;			\
-	 })
-
-#define __hyp_this_cpu_read(sym)					\
-	({								\
-		*__hyp_this_cpu_ptr(sym);				\
-	 })
-
 #define __KVM_EXTABLE(from, to)						\
 	"	.pushsection	__kvm_ex_table, \"a\"\n"		\
 	"	.align		3\n"					\
diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 0b6409b89e5e..1599e17379d8 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -19,7 +19,16 @@ static inline void set_my_cpu_offset(unsigned long off)
 			:: "r" (off) : "memory");
 }
 
-static inline unsigned long __my_cpu_offset(void)
+static inline unsigned long __hyp_my_cpu_offset(void)
+{
+	/*
+	 * Non-VHE hyp code runs with preemption disabled. No need to hazard
+	 * the register access against barrier() as in __kern_my_cpu_offset.
+	 */
+	return read_sysreg(tpidr_el2);
+}
+
+static inline unsigned long __kern_my_cpu_offset(void)
 {
 	unsigned long off;
 
@@ -35,7 +44,12 @@ static inline unsigned long __my_cpu_offset(void)
 
 	return off;
 }
-#define __my_cpu_offset __my_cpu_offset()
+
+#ifdef __KVM_NVHE_HYPERVISOR__
+#define __my_cpu_offset __hyp_my_cpu_offset()
+#else
+#define __my_cpu_offset __kern_my_cpu_offset()
+#endif
 
 #define PERCPU_RW_OPS(sz)						\
 static inline unsigned long __percpu_read_##sz(void *ptr)		\
@@ -227,4 +241,14 @@ PERCPU_RET_OP(add, add, ldadd)
 
 #include <asm-generic/percpu.h>
 
+/* Redefine macros for nVHE hyp under DEBUG_PREEMPT to avoid its dependencies. */
+#if defined(__KVM_NVHE_HYPERVISOR__) && defined(CONFIG_DEBUG_PREEMPT)
+#undef	this_cpu_ptr
+#define	this_cpu_ptr		raw_cpu_ptr
+#undef	__this_cpu_read
+#define	__this_cpu_read		raw_cpu_read
+#undef	__this_cpu_write
+#define	__this_cpu_write	raw_cpu_write
+#endif
+
 #endif /* __ASM_PERCPU_H */
diff --git a/arch/arm64/kvm/hyp/include/hyp/debug-sr.h b/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
index 5e28ea6aa097..4ebe9f558f3a 100644
--- a/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
@@ -135,7 +135,7 @@ static inline void __debug_switch_to_guest_common(struct kvm_vcpu *vcpu)
 	if (!(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY))
 		return;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	guest_ctxt = &vcpu->arch.ctxt;
 	host_dbg = &vcpu->arch.host_debug_state.regs;
 	guest_dbg = kern_hyp_va(vcpu->arch.debug_ptr);
@@ -154,7 +154,7 @@ static inline void __debug_switch_to_host_common(struct kvm_vcpu *vcpu)
 	if (!(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY))
 		return;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	guest_ctxt = &vcpu->arch.ctxt;
 	host_dbg = &vcpu->arch.host_debug_state.regs;
 	guest_dbg = kern_hyp_va(vcpu->arch.debug_ptr);
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 5b6b8fa00f0a..f150407fa798 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -386,7 +386,7 @@ static inline bool __hyp_handle_ptrauth(struct kvm_vcpu *vcpu)
 	    !esr_is_ptrauth_trap(kvm_vcpu_get_esr(vcpu)))
 		return false;
 
-	ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	__ptrauth_save_key(ctxt, APIA);
 	__ptrauth_save_key(ctxt, APIB);
 	__ptrauth_save_key(ctxt, APDA);
@@ -495,7 +495,7 @@ static inline void __set_guest_arch_workaround_state(struct kvm_vcpu *vcpu)
 	 * guest wants it disabled, so be it...
 	 */
 	if (__needs_ssbd_off(vcpu) &&
-	    __hyp_this_cpu_read(arm64_ssbd_callback_required))
+	    __this_cpu_read(arm64_ssbd_callback_required))
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_2, 0, NULL);
 #endif
 }
@@ -507,7 +507,7 @@ static inline void __set_host_arch_workaround_state(struct kvm_vcpu *vcpu)
 	 * If the guest has disabled the workaround, bring it back on.
 	 */
 	if (__needs_ssbd_off(vcpu) &&
-	    __hyp_this_cpu_read(arm64_ssbd_callback_required))
+	    __this_cpu_read(arm64_ssbd_callback_required))
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_2, 1, NULL);
 #endif
 }
@@ -521,7 +521,7 @@ static inline void __kvm_unexpected_el2_exception(void)
 
 	entry = hyp_symbol_addr(__start___kvm_ex_table);
 	end = hyp_symbol_addr(__stop___kvm_ex_table);
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 
 	while (entry < end) {
 		addr = (unsigned long)&entry->insn + entry->insn;
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 0970442d2dbc..cc4f8e790fb3 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -175,7 +175,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	vcpu = kern_hyp_va(vcpu);
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	host_ctxt->__hyp_running_vcpu = vcpu;
 	guest_ctxt = &vcpu->arch.ctxt;
 
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index c1da4f86ccac..575e8054f116 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -108,7 +108,7 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *guest_ctxt;
 	u64 exit_code;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	host_ctxt->__hyp_running_vcpu = vcpu;
 	guest_ctxt = &vcpu->arch.ctxt;
 
diff --git a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
index 996471e4c138..2a0b8c88d74f 100644
--- a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
@@ -66,7 +66,7 @@ void kvm_vcpu_load_sysregs_vhe(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *guest_ctxt = &vcpu->arch.ctxt;
 	struct kvm_cpu_context *host_ctxt;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	__sysreg_save_user_state(host_ctxt);
 
 	/*
@@ -100,7 +100,7 @@ void kvm_vcpu_put_sysregs_vhe(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *guest_ctxt = &vcpu->arch.ctxt;
 	struct kvm_cpu_context *host_ctxt;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	deactivate_traps_vhe_put();
 
 	__sysreg_save_el1_state(guest_ctxt);
-- 
2.28.0.681.g6f77f65b4e-goog

