Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCBD2EF248
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbhAHMR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbhAHMRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:17:22 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED41C06124F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:16:08 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id p13so9119857qki.14
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nKYca+zoHB0t45wLrBkHrNQpUNeGtZirqsjOZxYQKRc=;
        b=uVpDd/3VfWS2V7FGE50eztJxNR1ht1Ks8QHyta0jW0cbETpRaiuIqOgG8rkHGWCOzT
         JmHycgDR4rQNFgkKhMlILcE66rK1B9k5VcfpE+41k0cv9eKsiAi6WcO0xIhMnsHLoQgb
         KSEkDnla82gwCfzIowWilKmwq+TBzQCeYRYyLkPqNthTa3k+4HGBALGomeHe8ZijxITU
         PTKIZoqS4Fay2EqTjmfiyHsykrjJUQIrkFBp4P0OPbuTw26tPhbu1LjbW9wfW5r7i035
         RFWm/qFvslI2WWe8I+xjZuOPZkaQlRo4TgA97lsSS6NBc6/ElS5yVWGph53wegZaNTH0
         xlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nKYca+zoHB0t45wLrBkHrNQpUNeGtZirqsjOZxYQKRc=;
        b=hDjMSENEb41sV3XKbEy1T+tgWkmDJ9F+PjoGPY2sh3kXbdbGI1hrcWCQZXvhdRACGN
         BViniZgMVkpUPnVAT3cVLmY32aWAAeqMj8qyNLB5BgaLP7B6jdc4mjQrc5TjTKiLRYiv
         ZF4QGKDZUA9D2faClQ4WIC2oOoAlSbG3t298mCVi6CXqUmqNXFJVt18jMxUyyaDY8uiK
         1r4fPSuzEbvr+JC0coHrqkdbat68WXvC3ER5GHtA7DgmmSS5OwNt8f3ndLxatl1rO68+
         Cz80oxbqHQYsPg4st9WD5hWe50AV+VmdX6UILMZqmrMNvGYHaf+7ECeyck883XoYFgsv
         VqaQ==
X-Gm-Message-State: AOAM530hN0a0TzKBUNGRtu2QCJv6krUeC/GzgXK+dmE627INChwTWUMc
        4tASlLCU1m5bUhbYSta1nl5QJfM5NtMP
X-Google-Smtp-Source: ABdhPJxuBC038pFa20wlRkuieyMtPechQYnpLRIU4yj6S+nFgAVEI8gwmWfmtgdSLWI0LLH4YOmFUS0oLP0Y
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:5ba7:: with SMTP id
 7mr3081256qvq.31.1610108167604; Fri, 08 Jan 2021 04:16:07 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:15:17 +0000
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Message-Id: <20210108121524.656872-20-qperret@google.com>
Mime-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 19/26] KVM: arm64: Use kvm_arch in kvm_s2_mmu
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

In order to make use of the stage 2 pgtable code for the host stage 2,
change kvm_s2_mmu to use a kvm_arch pointer in lieu of the kvm pointer,
as the host will have the former but not the latter.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/arm64/include/asm/kvm_mmu.h  | 7 ++++++-
 arch/arm64/kvm/mmu.c              | 8 ++++----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 9a2feb83eea0..9d59bebcc5ef 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -95,7 +95,7 @@ struct kvm_s2_mmu {
 	/* The last vcpu id that ran on each physical CPU */
 	int __percpu *last_vcpu_ran;
 
-	struct kvm *kvm;
+	struct kvm_arch *arch;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 6c8466a042a9..662f0415344e 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -299,7 +299,7 @@ static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
  */
 static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
 {
-	write_sysreg(kern_hyp_va(mmu->kvm)->arch.vtcr, vtcr_el2);
+	write_sysreg(kern_hyp_va(mmu->arch)->vtcr, vtcr_el2);
 	write_sysreg(kvm_get_vttbr(mmu), vttbr_el2);
 
 	/*
@@ -309,5 +309,10 @@ static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
 	 */
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 }
+
+static inline struct kvm *kvm_s2_mmu_to_kvm(struct kvm_s2_mmu *mmu)
+{
+	return container_of(mmu->arch, struct kvm, arch);
+}
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 7e6263103943..6f9bf71722bd 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -169,7 +169,7 @@ static void *kvm_host_va(phys_addr_t phys)
 static void __unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64 size,
 				 bool may_block)
 {
-	struct kvm *kvm = mmu->kvm;
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
 	phys_addr_t end = start + size;
 
 	assert_spin_locked(&kvm->mmu_lock);
@@ -474,7 +474,7 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 	for_each_possible_cpu(cpu)
 		*per_cpu_ptr(mmu->last_vcpu_ran, cpu) = -1;
 
-	mmu->kvm = kvm;
+	mmu->arch = &kvm->arch;
 	mmu->pgt = pgt;
 	mmu->pgd_phys = __pa(pgt->pgd);
 	mmu->vmid.vmid_gen = 0;
@@ -556,7 +556,7 @@ void stage2_unmap_vm(struct kvm *kvm)
 
 void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
 {
-	struct kvm *kvm = mmu->kvm;
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
 	struct kvm_pgtable *pgt = NULL;
 
 	spin_lock(&kvm->mmu_lock);
@@ -625,7 +625,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
  */
 static void stage2_wp_range(struct kvm_s2_mmu *mmu, phys_addr_t addr, phys_addr_t end)
 {
-	struct kvm *kvm = mmu->kvm;
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
 	stage2_apply_range_resched(kvm, addr, end, kvm_pgtable_stage2_wrprotect);
 }
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

