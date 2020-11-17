Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88402B6CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgKQSRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbgKQSRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:17:01 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0444C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:59 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id h26so13086300qtm.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Px6WAgjKWF2Q0iqwF7bmFxmseAlEjtKBsgqTnzkkNWs=;
        b=NJLgqh5HBJngzvYPET5mEaPI73GpSKAf4rJXeE6y8BoRGUgdmGNL8Ri4PkROPi6FUs
         sBzLkCyeyPxVaN9jtD0MMHQlnrSA76EKS5GArc0RZ48GV2tAms/4qOC/gsJHLw+/8+kQ
         27vI8g71hHkjnRxdvbxBG/o7y4vNgVpvBctJdSyUJagWy0Y9IASIv5nV2j7SWOJJjLYx
         ZUjB4QS1y8BOo6IY5XcN9nGEmicXNxCrp2F0vmDDaqf0TxrEKEzgSOCatomjtBBlRQQH
         dyeQe39UQ4bZlvedXtUtNM6uc0v3By9WnNozWhxdarrlqjcgPQUu+l4FeYr5smA8ydts
         GIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Px6WAgjKWF2Q0iqwF7bmFxmseAlEjtKBsgqTnzkkNWs=;
        b=sDY2oghWGrZb10cOD7teWdEs3MorJdbuP05iMKnvTdoTZCz+HuoMgg1oWYqtn5vXZx
         VLGhYPWM3ewbTpOv58zvFe+LTJCu/gjpMRSKbsz0i+b8s+0qGo8YpTmKmaXymTsxkhTv
         bN2/wYo1kahiW2BLy/9DEDZylOViWRDr3vhPy3Wb2fLzfG8LTN6YmXs/r+v0TkushRQ9
         V2Ptwd3Kh/udj2+aL2bIF8ZxC2Vdm5apzISkg2UfbXKwsaSNsolXucEWhEa5qysqWxaP
         xDUrpVBjCJOmbt1uaUOmytAEUrsVMDeHqfbRhk43theWAC+Azu7J10Cv7Dcg46Q3hnZa
         HPSg==
X-Gm-Message-State: AOAM5309NNEcASgxM/iPjRSEmUR8A7fqFgHDVJsxaU4aqpd20VMKucgp
        WrXEK2/qjQDzSfngq0UNlHOsHuaqe3Xy
X-Google-Smtp-Source: ABdhPJzrKHjfNzUAFaFELqtQU9Z839XHaSsET7WjpyCI34QBLSq4T6TTN/LNOv3c8qkVPSVywbDlrFz4Lbl0
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a0c:e50a:: with SMTP id
 l10mr812333qvm.55.1605637019068; Tue, 17 Nov 2020 10:16:59 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:15:57 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-18-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 17/27] KVM: arm64: Elevate Hyp mappings creation at EL2
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        android-kvm@google.com, Quentin Perret <qperret@google.com>
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
initializing the hypervisor, but frees them right after, and flips a
static key marking the new 'protected' mode of operation.

As such, all calls to create_hyp_mappings() after kvm init has finished
turn into hypercalls, as the host now has no 'legal' way to modify the
hypevisor page tables directly.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h |  1 -
 arch/arm64/kvm/arm.c             | 51 ++++++++++++++++++++++++++++++--
 arch/arm64/kvm/mmu.c             | 34 +++++++++++++++++++++
 3 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index cb104443d8e4..bb756757b51c 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -285,6 +285,5 @@ static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
 	 */
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 }
-
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index b1e1747e4bbf..cfe5cc55b425 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1373,7 +1373,7 @@ static void cpu_prepare_hyp_mode(int cpu)
 	__flush_dcache_area(params, sizeof(*params));
 }
 
-static void cpu_init_hyp_mode(void)
+static void kvm_set_hyp_vector(void)
 {
 	struct kvm_nvhe_init_params *params;
 	struct arm_smccc_res res;
@@ -1391,6 +1391,11 @@ static void cpu_init_hyp_mode(void)
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
@@ -1433,7 +1438,10 @@ static void cpu_set_hyp_vector(void)
 	struct bp_hardening_data *data = this_cpu_ptr(&bp_hardening_data);
 	void *vector = hyp_spectre_vector_selector[data->slot];
 
-	*this_cpu_ptr_hyp_sym(kvm_hyp_vector) = (unsigned long)vector;
+	if (!is_protected_kvm_enabled())
+		*this_cpu_ptr_hyp_sym(kvm_hyp_vector) = (unsigned long)vector;
+	else
+		kvm_call_hyp_nvhe(__hyp_cpu_set_vector, data->slot);
 }
 
 static void cpu_hyp_reinit(void)
@@ -1441,13 +1449,14 @@ static void cpu_hyp_reinit(void)
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
@@ -1653,6 +1662,36 @@ static int copy_cpu_ftr_regs(void)
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
+	kvm_set_hyp_vector();
+	ret = kvm_call_hyp_nvhe(__kvm_hyp_protect, hyp_mem_base, hyp_mem_size,
+				num_possible_cpus(), kern_hyp_va(per_cpu_base));
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
@@ -1789,6 +1828,12 @@ static int init_hyp_mode(void)
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
index 3cf9397dabdb..5c2e0feb9689 100644
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
+		return kvm_call_hyp_nvhe(__hyp_create_mappings,
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
+		base = kvm_call_hyp_nvhe(__hyp_create_private_mapping,
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
2.29.2.299.gdc1121823c-goog

