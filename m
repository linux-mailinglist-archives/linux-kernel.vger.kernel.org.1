Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8332A2CC5A8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389618AbgLBSnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389606AbgLBSnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:43:37 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5738FC08E85F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:41:53 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r3so5174915wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYG0eeQv/KzkRV71YTMJbmdpg/6//a3ujvezKDQIbk8=;
        b=I6qPvyU/FEX7FoJaBAPoMr8c0thpJsMeXHt3MTW4C/mlzQSsWMAIep+7zln0pouZ69
         oSIqQIHhphrOpyf9KrtyyKVpZ9ws63s0hMyFc+TmZV9P0M0reBlv34xK9/mgCDapBvZ2
         HBRTDBpFTKJ2JHroGfWfnXTwvM09Kp5Vt2NzgcNYSoe4gOQvAxueMU4QmxSgQirMH/CQ
         vfnDSWQq6MXCHPHO+j9hsFHgxgyms8RJGLjJecLRktMuO1/ofiirUVZM614qboCwTRuF
         q9kPFpqy5ZGaltgubW7eWPEk+L44OIsBifxsw8vU4w66d+3q7Z8ZlWArOrfUwJX0PPZV
         neWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYG0eeQv/KzkRV71YTMJbmdpg/6//a3ujvezKDQIbk8=;
        b=VE1/M1n6634TKd5RwLD360oCrtz10j/VQFi6h5cQ+3iSArjpguj0TNQgEQdmB/zrcj
         op0cm/vhGXe+UMnnRGwINC5WiOJxwyxYD2BUOYk9rXvWweAikyv/33EMBusZJawCaknX
         ihG5eKRaapqk4ZzXA+SF/IeInAdezt6l/K7sxAk/K0KuXO7OiChdcxZ4k/Ogto/0ZNb3
         KsPOJQTIlrYDtIbIMC3/z1sV/zpR0HCNX1dfoFdYg5Dh7BVGyq4B9YTDlgvi4y8j2DOu
         1GRU3wTAXmwY6ymBPW3gxx+W2DwPNU40SemlxBPPZo9lcf1lRRT1TcqCt0AHEoaPTpmW
         WZEw==
X-Gm-Message-State: AOAM531ttAd0d+zxOphsfi3901cHKeRFSxnhWi4wrdLplLr1aeyL3BLl
        2S9CZzIPjy1p0IxHUEPC4ssKhw==
X-Google-Smtp-Source: ABdhPJzQ4njSIdl4L+IWqJBBxyUMLi1VeNNJl71IrmZZYtKGG+ycdDeDDGy/czwUB2v1OUbzSwBadg==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr4955628wrq.379.1606934511842;
        Wed, 02 Dec 2020 10:41:51 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id l14sm2962159wmi.33.2020.12.02.10.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:41:50 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 11/26] kvm: arm64: Init MAIR/TCR_EL2 from params struct
Date:   Wed,  2 Dec 2020 18:41:07 +0000
Message-Id: <20201202184122.26046-12-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAIR_EL2 and TCR_EL2 are currently initialized from their _EL1 values.
This will not work once KVM starts intercepting PSCI ON/SUSPEND SMCs
and initializing EL2 state before EL1 state.

Obtain the EL1 values during KVM init and store them in the init params
struct. The struct will stay in memory and can be used when booting new
cores.

Take the opportunity to move copying the T0SZ value from idmap_t0sz in
KVM init rather than in .hyp.idmap.text. This avoids the need for the
idmap_t0sz symbol alias.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h   |  2 ++
 arch/arm64/kernel/asm-offsets.c    |  2 ++
 arch/arm64/kernel/image-vars.h     |  3 ---
 arch/arm64/kvm/arm.c               | 22 +++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 38 +++++++-----------------------
 5 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 1a7b91534a16..7ccf770c53d9 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -149,6 +149,8 @@ extern void *__vhe_undefined_symbol;
 #endif
 
 struct kvm_nvhe_init_params {
+	unsigned long mair_el2;
+	unsigned long tcr_el2;
 	unsigned long tpidr_el2;
 	unsigned long stack_hyp_va;
 	phys_addr_t pgd_pa;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 8d6272a01a00..ba01185ef281 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -110,6 +110,8 @@ int main(void)
   DEFINE(CPU_APGAKEYLO_EL1,	offsetof(struct kvm_cpu_context, sys_regs[APGAKEYLO_EL1]));
   DEFINE(HOST_CONTEXT_VCPU,	offsetof(struct kvm_cpu_context, __hyp_running_vcpu));
   DEFINE(HOST_DATA_CONTEXT,	offsetof(struct kvm_host_data, host_ctxt));
+  DEFINE(NVHE_INIT_MAIR_EL2,	offsetof(struct kvm_nvhe_init_params, mair_el2));
+  DEFINE(NVHE_INIT_TCR_EL2,	offsetof(struct kvm_nvhe_init_params, tcr_el2));
   DEFINE(NVHE_INIT_TPIDR_EL2,	offsetof(struct kvm_nvhe_init_params, tpidr_el2));
   DEFINE(NVHE_INIT_STACK_HYP_VA,	offsetof(struct kvm_nvhe_init_params, stack_hyp_va));
   DEFINE(NVHE_INIT_PGD_PA,	offsetof(struct kvm_nvhe_init_params, pgd_pa));
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 4b32588918d9..08e69faedf6c 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -77,9 +77,6 @@ KVM_NVHE_ALIAS(panic);
 /* Vectors installed by hyp-init on reset HVC. */
 KVM_NVHE_ALIAS(__hyp_stub_vectors);
 
-/* IDMAP TCR_EL1.T0SZ as computed by the EL1 init code */
-KVM_NVHE_ALIAS(idmap_t0sz);
-
 /* Kernel symbol used by icache_is_vpipt(). */
 KVM_NVHE_ALIAS(__icache_flags);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 93a408c00249..6c8594378865 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1387,6 +1387,7 @@ static void cpu_init_hyp_mode(void)
 {
 	struct kvm_nvhe_init_params *params = this_cpu_ptr_nvhe_sym(kvm_init_params);
 	struct arm_smccc_res res;
+	unsigned long tcr;
 
 	/* Switch from the HYP stub to our own HYP init vector */
 	__hyp_set_vectors(kvm_get_idmap_vector());
@@ -1399,6 +1400,27 @@ static void cpu_init_hyp_mode(void)
 	params->tpidr_el2 = (unsigned long)this_cpu_ptr_nvhe_sym(__per_cpu_start) -
 			    (unsigned long)kvm_ksym_ref(CHOOSE_NVHE_SYM(__per_cpu_start));
 
+	params->mair_el2 = read_sysreg(mair_el1);
+
+	/*
+	 * The ID map may be configured to use an extended virtual address
+	 * range. This is only the case if system RAM is out of range for the
+	 * currently configured page size and VA_BITS, in which case we will
+	 * also need the extended virtual range for the HYP ID map, or we won't
+	 * be able to enable the EL2 MMU.
+	 *
+	 * However, at EL2, there is only one TTBR register, and we can't switch
+	 * between translation tables *and* update TCR_EL2.T0SZ at the same
+	 * time. Bottom line: we need to use the extended range with *both* our
+	 * translation tables.
+	 *
+	 * So use the same T0SZ value we use for the ID map.
+	 */
+	tcr = (read_sysreg(tcr_el1) & TCR_EL2_MASK) | TCR_EL2_RES1;
+	tcr &= ~TCR_T0SZ_MASK;
+	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
+	params->tcr_el2 = tcr;
+
 	params->stack_hyp_va = kern_hyp_va(__this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE);
 	params->pgd_pa = kvm_mmu_get_httbr();
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index e712e317337c..712f57289357 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -71,48 +71,26 @@ __do_hyp_init:
 1:	ldr	x0, [x1, #NVHE_INIT_TPIDR_EL2]
 	msr	tpidr_el2, x0
 
+	ldr	x0, [x1, #NVHE_INIT_MAIR_EL2]
+	msr	mair_el2, x0
+
 	ldr	x0, [x1, #NVHE_INIT_STACK_HYP_VA]
 	mov	sp, x0
 
-	ldr	x1, [x1, #NVHE_INIT_PGD_PA]
-	phys_to_ttbr x0, x1
+	ldr	x0, [x1, #NVHE_INIT_PGD_PA]
+	phys_to_ttbr x2, x0
 alternative_if ARM64_HAS_CNP
-	orr	x0, x0, #TTBR_CNP_BIT
+	orr	x2, x2, #TTBR_CNP_BIT
 alternative_else_nop_endif
-	msr	ttbr0_el2, x0
-
-	mrs	x0, tcr_el1
-	mov_q	x1, TCR_EL2_MASK
-	and	x0, x0, x1
-	mov	x1, #TCR_EL2_RES1
-	orr	x0, x0, x1
-
-	/*
-	 * The ID map may be configured to use an extended virtual address
-	 * range. This is only the case if system RAM is out of range for the
-	 * currently configured page size and VA_BITS, in which case we will
-	 * also need the extended virtual range for the HYP ID map, or we won't
-	 * be able to enable the EL2 MMU.
-	 *
-	 * However, at EL2, there is only one TTBR register, and we can't switch
-	 * between translation tables *and* update TCR_EL2.T0SZ at the same
-	 * time. Bottom line: we need to use the extended range with *both* our
-	 * translation tables.
-	 *
-	 * So use the same T0SZ value we use for the ID map.
-	 */
-	ldr_l	x1, idmap_t0sz
-	bfi	x0, x1, TCR_T0SZ_OFFSET, TCR_TxSZ_WIDTH
+	msr	ttbr0_el2, x2
 
 	/*
 	 * Set the PS bits in TCR_EL2.
 	 */
+	ldr	x0, [x1, #NVHE_INIT_TCR_EL2]
 	tcr_compute_pa_size x0, #TCR_EL2_PS_SHIFT, x1, x2
-
 	msr	tcr_el2, x0
 
-	mrs	x0, mair_el1
-	msr	mair_el2, x0
 	isb
 
 	/* Invalidate the stale TLBs from Bootloader */
-- 
2.29.2.454.gaff20da3a2-goog

