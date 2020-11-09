Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE932AB737
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgKILg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbgKILdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:21 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F041CC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:33:19 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so7598523wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eIPzqWWvoyC1T2Ize/AiBNyKuifBGsiVG/BWmnihIUI=;
        b=NVcoU71TcOXi+xrccDK4ORJ1XxJud61kwAqEcrw+mKVuuRPSz96rLOU7Rs5J/XlycZ
         bmA82cj+kSA1l6LEUFBJjag3o/f9IyAjrAs5lROJn1DnQq8z756hTfeq9ZDgt8cq0Ecs
         UgS7IX95+tSBFFEbB1A/5+JvnUUMB+6YnXY1xu62/kq2kLNQST8ZwhSbY0J3p7Fifb0N
         PbAuBnxlFROdf6k/iECCqeNAwu5VAcl4N6j3kjSersr/JcpvMFzU5eA4CjPHQXpo8acz
         9AwFynmkRGILR7WovTBh2zHbWiJ6CLQSnQk62PLnVNHgedzdzuV9GAIcl7JeYMRt9gAR
         5oaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eIPzqWWvoyC1T2Ize/AiBNyKuifBGsiVG/BWmnihIUI=;
        b=IG7bTJF5cRLRPoloGxdoMyHXuJC8CFgSMH58mWL0SIMxYUTNzBxzTZxo1FB1lIkqfd
         xEZTGIlSRl+8Yi837b78o+ta+4F4YyZaA40VUAd43750bkl9GH+6rKVipT4kLbxMUYTi
         wlEqvYiPZ2peD0T4Li/ftsN++MhOPRrUTeleILbwTzpFIZdGgbJ0ZulA3wkIma0Xvwcz
         hD0Vmbv4bgS0EwQwHZ3Eg5FWlY9OGD2TzjV6kfk/jvSGahC5XO/gqTm0RGKV5GyR5VCl
         815aVVFCZYS1TafjbotNu1wFeCEZ5tmz3ZpchQsc57SR5rtSO7MFrgO97WfnLlXe0hIm
         m+tA==
X-Gm-Message-State: AOAM530LzENqUIWxQ6i5bns5Cv0BS85U4krTTG5BNoEkwC6NKjVFDfks
        lltYFjiP84chMmhPYBdanfPIGA==
X-Google-Smtp-Source: ABdhPJzw1/5+3rYfGSAwPztavLKJ35xgxeILzkxgCtOIdqLLm+KGIqdkWJP31e5XmDobTShOwnGR2Q==
X-Received: by 2002:a1c:790b:: with SMTP id l11mr14534188wme.53.1604921598563;
        Mon, 09 Nov 2020 03:33:18 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id m14sm12999471wro.43.2020.11.09.03.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:33:17 -0800 (PST)
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
Subject: [PATCH v1 19/24] kvm: arm64: Intercept host's PSCI_CPU_ON SMCs
Date:   Mon,  9 Nov 2020 11:32:28 +0000
Message-Id: <20201109113233.9012-20-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a handler of the CPU_ON PSCI call from host. When invoked, it looks
up the logical CPU ID corresponding to the provided MPIDR and populates
the state struct of the target CPU with the provided x0, pc. It then
calls CPU_ON itself, with an entry point in hyp that initializes EL2
state before returning ERET to the provided PC in EL1.

There is a simple atomic lock around the reset state struct. If it is
already locked, CPU_ON will return PENDING_ON error code.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_hyp.h |  1 +
 arch/arm64/kvm/arm.c             |  3 +
 arch/arm64/kvm/hyp/nvhe/psci.c   | 98 ++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 95a2bbbcc7e1..4586fae36184 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -97,6 +97,7 @@ void deactivate_traps_vhe_put(void);
 u64 __guest_enter(struct kvm_vcpu *vcpu);
 
 #ifdef __KVM_NVHE_HYPERVISOR__
+asmlinkage void __noreturn kvm_host_psci_cpu_entry(void);
 bool kvm_host_psci_handler(struct kvm_cpu_context *host_ctxt);
 #endif
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index dc7d43d7785a..a931253ebb61 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1333,6 +1333,7 @@ static int kvm_map_vectors(void)
 
 static void cpu_init_hyp_mode(void)
 {
+	DECLARE_KVM_NVHE_SYM(kvm_host_psci_cpu_entry);
 	struct kvm_nvhe_init_params *params = this_cpu_ptr_nvhe_sym(kvm_init_params);
 	struct arm_smccc_res res;
 
@@ -1350,6 +1351,8 @@ static void cpu_init_hyp_mode(void)
 	params->pgd_ptr = kvm_mmu_get_httbr();
 	params->vector_ptr = (unsigned long)kern_hyp_va(kvm_ksym_ref(__kvm_hyp_host_vector));
 	params->hyp_stack_ptr = kern_hyp_va(__this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE);
+	params->psci_cpu_entry_fn = (unsigned long)kern_hyp_va(
+		kvm_ksym_ref(CHOOSE_NVHE_SYM(kvm_host_psci_cpu_entry)));
 
 	/*
 	 * Flush the init params from the data cache because the struct will
diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c b/arch/arm64/kvm/hyp/nvhe/psci.c
index 05a34a152069..f9b82a87bf44 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci.c
@@ -9,10 +9,13 @@
 #include <asm/kvm_mmu.h>
 #include <kvm/arm_hypercalls.h>
 #include <linux/arm-smccc.h>
+#include <linux/kvm_host.h>
 #include <linux/psci.h>
 #include <kvm/arm_psci.h>
 #include <uapi/linux/psci.h>
 
+#define INVALID_CPU_ID UINT_MAX
+
 /* Config options set by the host. */
 u32 kvm_host_psci_version = PSCI_VERSION(0, 0);
 u32 kvm_host_psci_function_id[PSCI_FN_MAX];
@@ -30,6 +33,14 @@ s64 hyp_physvirt_offset;
 		kern_va - kimage_voffset;			\
 	})
 
+struct kvm_host_psci_state {
+	atomic_t pending_on;
+	unsigned long pc;
+	unsigned long r0;
+};
+
+static DEFINE_PER_CPU(struct kvm_host_psci_state, kvm_host_psci_state);
+
 static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
 {
 	return host_ctxt->regs.regs[0];
@@ -84,10 +95,95 @@ static __noreturn unsigned long psci_forward_noreturn(struct kvm_cpu_context *ho
 	hyp_panic(); /* unreachable */
 }
 
+static unsigned int find_cpu_id(u64 mpidr)
+{
+	int i;
+
+	if (mpidr != INVALID_HWID) {
+		for (i = 0; i < NR_CPUS; i++) {
+			if (cpu_logical_map(i) == mpidr)
+				return i;
+		}
+	}
+
+	return INVALID_CPU_ID;
+}
+
+static bool try_acquire_reset_state(struct kvm_host_psci_state *cpu_state,
+				    unsigned long pc, unsigned long r0)
+{
+	if (atomic_cmpxchg_acquire(&cpu_state->pending_on, 0, 1) != 0)
+		return false;
+
+	cpu_state->pc = pc;
+	cpu_state->r0 = r0;
+	wmb();
+
+	return true;
+}
+
+static void release_reset_state(struct kvm_host_psci_state *cpu_state)
+{
+	atomic_set_release(&cpu_state->pending_on, 0);
+}
+
+static int psci_cpu_on(u64 func_id, struct kvm_cpu_context *host_ctxt)
+{
+	u64 mpidr = host_ctxt->regs.regs[1];
+	unsigned long pc = host_ctxt->regs.regs[2];
+	unsigned long r0 = host_ctxt->regs.regs[3];
+	unsigned int cpu_id;
+	struct kvm_host_psci_state *cpu_state;
+	struct kvm_nvhe_init_params *cpu_params;
+	int ret;
+
+	/*
+	 * Find the logical CPU ID for the given MPIDR. The search set is
+	 * the set of CPUs that were online at the point of KVM initialization.
+	 * Booting other CPUs is rejected because their cpufeatures were not
+	 * checked against the finalized capabilities. This could be relaxed
+	 * by doing the feature checks in hyp.
+	 */
+	cpu_id = find_cpu_id(mpidr);
+	if (cpu_id == INVALID_CPU_ID)
+		return PSCI_RET_INVALID_PARAMS;
+
+	cpu_state = per_cpu_ptr(&kvm_host_psci_state, cpu_id);
+	cpu_params = per_cpu_ptr(&kvm_init_params, cpu_id);
+
+	if (!try_acquire_reset_state(cpu_state, pc, r0))
+		return PSCI_RET_ALREADY_ON;
+
+	ret = psci_call(func_id, mpidr,
+			__hyp_pa_symbol(__kvm_hyp_cpu_entry),
+			__hyp_pa(cpu_params));
+
+	if (ret != PSCI_RET_SUCCESS)
+		release_reset_state(cpu_state);
+	return ret;
+}
+
+void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
+
+asmlinkage void __noreturn kvm_host_psci_cpu_entry(void)
+{
+	struct kvm_host_psci_state *cpu_state = this_cpu_ptr(&kvm_host_psci_state);
+	struct kvm_cpu_context *host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
+
+	host_ctxt->regs.regs[0] = cpu_state->r0;
+	write_sysreg_el2(cpu_state->pc, SYS_ELR);
+
+	release_reset_state(cpu_state);
+
+	__host_enter(host_ctxt);
+}
+
 static unsigned long psci_0_1_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
 {
 	if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_OFF])
 		return psci_forward(host_ctxt);
+	else if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_ON])
+		return psci_cpu_on(func_id, host_ctxt);
 	else if (func_id == kvm_host_psci_function_id[PSCI_FN_MIGRATE])
 		return psci_forward(host_ctxt);
 	else
@@ -108,6 +204,8 @@ static unsigned long psci_0_2_handler(u64 func_id, struct kvm_cpu_context *host_
 	case PSCI_0_2_FN_SYSTEM_RESET:
 		psci_forward_noreturn(host_ctxt);
 		unreachable();
+	case PSCI_0_2_FN64_CPU_ON:
+		return psci_cpu_on(func_id, host_ctxt);
 	default:
 		return PSCI_RET_NOT_SUPPORTED;
 	}
-- 
2.29.2.222.g5d2a92d10f8-goog

