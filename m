Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D752EF246
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbhAHMRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbhAHMRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:17:19 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98804C061247
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:16:03 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id 12so8075602qvk.23
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/oJOiodTmUn3adVtPGhw7M8zv8JCp37BW1nUJ/LMPTQ=;
        b=pU/9SM07gIQWUokQHD3qTj/NffUXCMLsM8TsFEn4oVEVeZPwQv+BFOZFalEFokXz6m
         kebX9OWnC7Ufx8YeV5eb2zUbyi2hDbPPOsnyH+9qSOApc6p+Wl1Na1hoVzx/LRIXJ52f
         U2FNQrVVHJgMRVlcsycw6jGoo8I4B3KKr584MmnydYCeH/D3TXeZB9nzMvXB8+cJ6FEP
         vooAmBFoUQci3tycOUbChjhEypy8Yifjabxebh2m5fIDJQ7vigXwCb38PZk6kKpVK90X
         cqGoUojnqYzUoItkHpdGgVO16Rafonm42FcVi46NZNkrSW5TPUtN7G880l7qgTpGuXAB
         Ns6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/oJOiodTmUn3adVtPGhw7M8zv8JCp37BW1nUJ/LMPTQ=;
        b=IP846EFhQn7QoVqn5twDJ6J/xPQ8dqiBbh3BtvSBT5qzQ97FAshA8HCB/T04tj0X1I
         W+fmn+dLi/DzHXhnHaooKBd4ECsVHtSZmIjQaudv7gKJPnnVPJwdktZZOIDfQRFifKPd
         sOvkL/SyOyBrcDVrxYbmyW+6MTqZ9NSu2udkBCkjw9raEAVosoUbPHhpngCghWWp3Ak7
         Vn6yxIeYX4HdhOmPU0ikFpsYCtCnPYbzLgP0J+adohAHlx6V3DUsv6DqopQU52xO6g7E
         ltoTstx+mnU7aMFXQBGv0+49rLVGRDoancRCLfpH1FF1YPd/Azl81K1NwYqsEYp8Rgl0
         hEww==
X-Gm-Message-State: AOAM530Dky3By0gjFlav3HFLsicmlOPAU/3Zh4aY+7AYjxxwt0SP92Fq
        suF3/Ni3lf6bacMoM5S35Um8VrvzNH/P
X-Google-Smtp-Source: ABdhPJzgKPDINojiI0dbVwoX+0TC5gHxTs7z5Z+8Zygu+vvUzA255jllaF6UbGDN3Gp4kXcFpUe67wJWaUvz
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:da07:: with SMTP id
 x7mr6289768qvj.39.1610108162797; Fri, 08 Jan 2021 04:16:02 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:15:15 +0000
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Message-Id: <20210108121524.656872-18-qperret@google.com>
Mime-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 17/26] KVM: arm64: Elevate Hyp mappings creation at EL2
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous commits have introduced infrastructure at EL2 to enable the Hyp
code to manage its own memory, and more specifically its stage 1 page
tables. However, this was preliminary work, and none of it is currently
in use.

Put all of this together by elevating the hyp mappings creation at EL2
when memory protection is enabled. In this case, the host kernel running
at EL1 still creates _temporary_ Hyp mappings, only used while
initializing the hypervisor, but frees them right after.

As such, all calls to create_hyp_mappings() after kvm init has finished
turn into hypercalls, as the host now has no 'legal' way to modify the
hypevisor page tables directly.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h |  1 -
 arch/arm64/kvm/arm.c             | 62 +++++++++++++++++++++++++++++---
 arch/arm64/kvm/mmu.c             | 34 ++++++++++++++++++
 3 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index d7ebd73ec86f..6c8466a042a9 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -309,6 +309,5 @@ static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
 	 */
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 }
-
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6af9204bcd5b..e524682c2ccf 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1421,7 +1421,7 @@ static void cpu_prepare_hyp_mode(int cpu)
 	kvm_flush_dcache_to_poc(params, sizeof(*params));
 }
 
-static void cpu_init_hyp_mode(void)
+static void kvm_set_hyp_vector(void)
 {
 	struct kvm_nvhe_init_params *params;
 	struct arm_smccc_res res;
@@ -1439,6 +1439,11 @@ static void cpu_init_hyp_mode(void)
 	params = this_cpu_ptr_nvhe_sym(kvm_init_params);
 	arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(__kvm_hyp_init), virt_to_phys(params), &res);
 	WARN_ON(res.a0 != SMCCC_RET_SUCCESS);
+}
+
+static void cpu_init_hyp_mode(void)
+{
+	kvm_set_hyp_vector();
 
 	/*
 	 * Disabling SSBD on a non-VHE system requires us to enable SSBS
@@ -1481,7 +1486,10 @@ static void cpu_set_hyp_vector(void)
 	struct bp_hardening_data *data = this_cpu_ptr(&bp_hardening_data);
 	void *vector = hyp_spectre_vector_selector[data->slot];
 
-	*this_cpu_ptr_hyp_sym(kvm_hyp_vector) = (unsigned long)vector;
+	if (!is_protected_kvm_enabled())
+		*this_cpu_ptr_hyp_sym(kvm_hyp_vector) = (unsigned long)vector;
+	else
+		kvm_call_hyp_nvhe(__pkvm_cpu_set_vector, data->slot);
 }
 
 static void cpu_hyp_reinit(void)
@@ -1489,13 +1497,14 @@ static void cpu_hyp_reinit(void)
 	kvm_init_host_cpu_context(&this_cpu_ptr_hyp_sym(kvm_host_data)->host_ctxt);
 
 	cpu_hyp_reset();
-	cpu_set_hyp_vector();
 
 	if (is_kernel_in_hyp_mode())
 		kvm_timer_init_vhe();
 	else
 		cpu_init_hyp_mode();
 
+	cpu_set_hyp_vector();
+
 	kvm_arm_init_debug();
 
 	if (vgic_present)
@@ -1714,13 +1723,52 @@ static int copy_cpu_ftr_regs(void)
 	return 0;
 }
 
+static int kvm_hyp_enable_protection(void)
+{
+	void *per_cpu_base = kvm_ksym_ref(kvm_arm_hyp_percpu_base);
+	int ret, cpu;
+	void *addr;
+
+	if (!is_protected_kvm_enabled())
+		return 0;
+
+	if (!hyp_mem_base)
+		return -ENOMEM;
+
+	addr = phys_to_virt(hyp_mem_base);
+	ret = create_hyp_mappings(addr, addr + hyp_mem_size - 1, PAGE_HYP);
+	if (ret)
+		return ret;
+
+	preempt_disable();
+	kvm_set_hyp_vector();
+	ret = kvm_call_hyp_nvhe(__pkvm_init, hyp_mem_base, hyp_mem_size,
+				num_possible_cpus(), kern_hyp_va(per_cpu_base));
+	preempt_enable();
+	if (ret)
+		return ret;
+
+	free_hyp_pgds();
+	for_each_possible_cpu(cpu)
+		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
+
+	return 0;
+}
+
 /**
  * Inits Hyp-mode on all online CPUs
  */
 static int init_hyp_mode(void)
 {
 	int cpu;
-	int err = 0;
+	int err = -ENOMEM;
+
+	/*
+	 * The protected Hyp-mode cannot be initialized if the memory pool
+	 * allocation has failed.
+	 */
+	if (is_protected_kvm_enabled() && !hyp_mem_base)
+		return err;
 
 	/*
 	 * Copy the required CPU feature register in their EL2 counterpart
@@ -1854,6 +1902,12 @@ static int init_hyp_mode(void)
 	for_each_possible_cpu(cpu)
 		cpu_prepare_hyp_mode(cpu);
 
+	err = kvm_hyp_enable_protection();
+	if (err) {
+		kvm_err("Failed to enable hyp memory protection: %d\n", err);
+		goto out_err;
+	}
+
 	return 0;
 
 out_err:
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 3cf9397dabdb..9d4c9251208e 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -225,15 +225,39 @@ void free_hyp_pgds(void)
 	if (hyp_pgtable) {
 		kvm_pgtable_hyp_destroy(hyp_pgtable);
 		kfree(hyp_pgtable);
+		hyp_pgtable = NULL;
 	}
 	mutex_unlock(&kvm_hyp_pgd_mutex);
 }
 
+static bool kvm_host_owns_hyp_mappings(void)
+{
+	if (static_branch_likely(&kvm_protected_mode_initialized))
+		return false;
+
+	/*
+	 * This can happen at boot time when __create_hyp_mappings() is called
+	 * after the hyp protection has been enabled, but the static key has
+	 * not been flipped yet.
+	 */
+	if (!hyp_pgtable && is_protected_kvm_enabled())
+		return false;
+
+	BUG_ON(!hyp_pgtable);
+
+	return true;
+}
+
 static int __create_hyp_mappings(unsigned long start, unsigned long size,
 				 unsigned long phys, enum kvm_pgtable_prot prot)
 {
 	int err;
 
+	if (!kvm_host_owns_hyp_mappings()) {
+		return kvm_call_hyp_nvhe(__pkvm_create_mappings,
+					 start, size, phys, prot);
+	}
+
 	mutex_lock(&kvm_hyp_pgd_mutex);
 	err = kvm_pgtable_hyp_map(hyp_pgtable, start, size, phys, prot);
 	mutex_unlock(&kvm_hyp_pgd_mutex);
@@ -295,6 +319,16 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
 	unsigned long base;
 	int ret = 0;
 
+	if (!kvm_host_owns_hyp_mappings()) {
+		base = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
+					 phys_addr, size, prot);
+		if (!base)
+			return -ENOMEM;
+		*haddr = base;
+
+		return 0;
+	}
+
 	mutex_lock(&kvm_hyp_pgd_mutex);
 
 	/*
-- 
2.30.0.284.gd98b1dd5eaa7-goog

