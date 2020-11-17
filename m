Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669742B6CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbgKQSRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgKQSRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:17:09 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3737C061A47
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:17:08 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id z68so14751099qkc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YRRsngS9OD6tBnxQxVeL/idwsF6yEfmuwUZwYdjr4cI=;
        b=u6eskt9lKKmGSunnDChD5nx9UAFs54CCl+3VWgy6MyEcVVg8OeGSLy6w+3jrAgg5wo
         lIQFdYhOvLApYwomcOOT904ylp69grlIlOZX+z4g49TOTxv58iJt30YEMMbaDkgokaiV
         +kDh/6I2WkKdw1mI/OeSLV7yoQu8bc9QP/M3gsk0AO2v4897Wo4N8zHFREx6/Mmrycej
         FaBnrvSuEuIl+wMhPSOrswKNQVY/YQYHpDnZtnmHTfXn3RryY102vNLKNzxLh5JQxvcA
         ikQQMFvZGh6oA+q0po5wCBIIFKVotM758kswEkO/JkHpisi3Q+W2jTRHPSKvegIXFjFe
         7iFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YRRsngS9OD6tBnxQxVeL/idwsF6yEfmuwUZwYdjr4cI=;
        b=RZjHa657vg3e7tY33PzxSqI5Z1QpC3DJHYROjhp4Usnpnb4rRj4xureG4p4YDJWwpU
         AweongRI3BgqJ6K7CnT2Bxd3SQr5mHBDsJe6avU0KC0JS1fpgn3dQCwm8erT2Hhj2EkU
         1k7JQA5DAhyULcqZ5vIj1tDcSrnwRuHBFl1TuAEFi+DcqtEicMFs34dueW2zsgISzEND
         j8jVrM7n64zIMyd+a1jaPz7xXgdtnO1+QFVotWCNxWlKVPrNL7vMK0A2MX9PJiPJjtKi
         xbYcPML0oRCRfLpplkZuUAi9/Yi+Ph4qDfm7AibM3G0ywni8rJsMVJHWW2WKUTMS3mY9
         Hsjg==
X-Gm-Message-State: AOAM532mVsaCJthWoMzb6eLf2ORRJHW3wJn3MWuN0Hm05hE9E0uPW1oo
        s0MnRLWGkrSPDQu8W9lv5Gdb7KCvOfEO
X-Google-Smtp-Source: ABdhPJx5Z5F0VDtWsI/mKAVXvn+oRTGzalsg8aLfqcFVm74qRo8wjQOMWj3cl7sUTCwGro5vT2NLftM2aBIV
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a0c:e443:: with SMTP id
 d3mr975170qvm.18.1605637028048; Tue, 17 Nov 2020 10:17:08 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:16:01 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-22-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 21/27] KVM: arm64: Refactor kvm_arm_setup_stage2()
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

In order to re-use some of the stage 2 setup at EL2, factor parts of
kvm_arm_setup_stage2() out into static inline functions.

No functional change intended.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 48 ++++++++++++++++++++++++++++++++
 arch/arm64/kvm/reset.c           | 42 +++-------------------------
 2 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 714357ebd278..5a76358e8c7a 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -256,6 +256,54 @@ static inline int kvm_write_guest_lock(struct kvm *kvm, gpa_t gpa,
 	return ret;
 }
 
+static inline u64 kvm_get_parange(u64 mmfr0)
+{
+	u64 parange = cpuid_feature_extract_unsigned_field(mmfr0,
+				ID_AA64MMFR0_PARANGE_SHIFT);
+	if (parange > ID_AA64MMFR0_PARANGE_MAX)
+		parange = ID_AA64MMFR0_PARANGE_MAX;
+
+	return parange;
+}
+
+/*
+ * The VTCR value is common across all the physical CPUs on the system.
+ * We use system wide sanitised values to fill in different fields,
+ * except for Hardware Management of Access Flags. HA Flag is set
+ * unconditionally on all CPUs, as it is safe to run with or without
+ * the feature and the bit is RES0 on CPUs that don't support it.
+ */
+static inline u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
+{
+	u64 vtcr = VTCR_EL2_FLAGS;
+	u8 lvls;
+
+	vtcr |= kvm_get_parange(mmfr0) << VTCR_EL2_PS_SHIFT;
+	vtcr |= VTCR_EL2_T0SZ(phys_shift);
+	/*
+	 * Use a minimum 2 level page table to prevent splitting
+	 * host PMD huge pages at stage2.
+	 */
+	lvls = stage2_pgtable_levels(phys_shift);
+	if (lvls < 2)
+		lvls = 2;
+	vtcr |= VTCR_EL2_LVLS_TO_SL0(lvls);
+
+	/*
+	 * Enable the Hardware Access Flag management, unconditionally
+	 * on all CPUs. The features is RES0 on CPUs without the support
+	 * and must be ignored by the CPUs.
+	 */
+	vtcr |= VTCR_EL2_HA;
+
+	/* Set the vmid bits */
+	vtcr |= (get_vmid_bits(mmfr1) == 16) ?
+		VTCR_EL2_VS_16BIT :
+		VTCR_EL2_VS_8BIT;
+
+	return vtcr;
+}
+
 #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
 
 static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 3e772ea4e066..074b39dbe539 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -384,19 +384,10 @@ int kvm_set_ipa_limit(void)
 	return 0;
 }
 
-/*
- * Configure the VTCR_EL2 for this VM. The VTCR value is common
- * across all the physical CPUs on the system. We use system wide
- * sanitised values to fill in different fields, except for Hardware
- * Management of Access Flags. HA Flag is set unconditionally on
- * all CPUs, as it is safe to run with or without the feature and
- * the bit is RES0 on CPUs that don't support it.
- */
 int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 {
-	u64 vtcr = VTCR_EL2_FLAGS, mmfr0;
-	u32 parange, phys_shift;
-	u8 lvls;
+	u64 mmfr0, mmfr1;
+	u32 phys_shift;
 
 	if (type & ~KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
 		return -EINVAL;
@@ -411,33 +402,8 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 	}
 
 	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
-	parange = cpuid_feature_extract_unsigned_field(mmfr0,
-				ID_AA64MMFR0_PARANGE_SHIFT);
-	if (parange > ID_AA64MMFR0_PARANGE_MAX)
-		parange = ID_AA64MMFR0_PARANGE_MAX;
-	vtcr |= parange << VTCR_EL2_PS_SHIFT;
-
-	vtcr |= VTCR_EL2_T0SZ(phys_shift);
-	/*
-	 * Use a minimum 2 level page table to prevent splitting
-	 * host PMD huge pages at stage2.
-	 */
-	lvls = stage2_pgtable_levels(phys_shift);
-	if (lvls < 2)
-		lvls = 2;
-	vtcr |= VTCR_EL2_LVLS_TO_SL0(lvls);
-
-	/*
-	 * Enable the Hardware Access Flag management, unconditionally
-	 * on all CPUs. The features is RES0 on CPUs without the support
-	 * and must be ignored by the CPUs.
-	 */
-	vtcr |= VTCR_EL2_HA;
+	mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
+	kvm->arch.vtcr = kvm_get_vtcr(mmfr0, mmfr1, phys_shift);
 
-	/* Set the vmid bits */
-	vtcr |= (kvm_get_vmid_bits() == 16) ?
-		VTCR_EL2_VS_16BIT :
-		VTCR_EL2_VS_8BIT;
-	kvm->arch.vtcr = vtcr;
 	return 0;
 }
-- 
2.29.2.299.gdc1121823c-goog

