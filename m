Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767432EF269
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbhAHMTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbhAHMRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:17:19 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11174C061249
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:16:07 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id u3so4039101wri.19
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QIpOnJAJDFYwraC0ddDqr7tOixX5GyHqc+eN2zNJpAo=;
        b=il5Ne6t9ivsIijZMruN4gBaX+EYvvCeqM4wXdD5b87Akf7GQMUT8tlcc2rbeXb7ACq
         W7SWjD+hfCBW1GKfXcme+zjutCmdrdDkjDj5gkZnYovFg7hEqVXuCt4LrZRE0D57GxY6
         jZbSgOnq3+qcZ4Dw+JxLPQAjxFDxivg8qTM4alr2Zlpvs1Qqp7TcV7961SoTi+NCFKv4
         EJFusiTj/nYe3sG8Izc+8vA0vPTM0bQ3MFtgsDM67pHpZQSPjgWpmqNfWmxC513MPx9X
         B29+4inY3oKYwuI28k+z5rC2h4J3QqMM7y9GNFIXvEv3PjLk2FMDzIH2+TuzoBoPrG9L
         a+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QIpOnJAJDFYwraC0ddDqr7tOixX5GyHqc+eN2zNJpAo=;
        b=FkbO5f4xhZVfueh1h+HpDiEm5uLSmrGsbS+FPZyacPmWrdvQEmQR6tUV/Axl1c5u7N
         dB2201wWZUexqtEW995TlcJz/vbhyMs892nTgl5sVAlyFPKFeWZ9GpLVrC45QTiIRz9u
         cDkLovOve5d0PGBwGr5ZW0hQFvXDEXzhCrM1OQr8t1z8jbLMxirSXVYUcF1LgbfT1hth
         flfIrAxniypPCPQJWiYDBLWrzpvyNIttYSzJ2bwRVJ7joQFcQMHtiQo0Z+6tWyVYDbGl
         +TV2R6ossBgJ8uWPAvYr7FSpNWt0fMP1KWQLCoOMDxyVQJCzKPMNoesaeB+3kAk5X1n2
         Z9Hw==
X-Gm-Message-State: AOAM532HniIzg7fuGyBWueWGfsbiog6gOCk1XZ2oJzw+alReK42DleZm
        UvawLfNH4ixYZ2vM5qAoC231NWVdXHtX
X-Google-Smtp-Source: ABdhPJzjWGN+5xVfhWSi3YDL8WD48Ac+Xyz9aYshsE62TB/0secJVMv8rCBBauyHDfw1ABRdMfgAQ+Xn26ZG
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c044:: with SMTP id
 u4mr1784013wmc.1.1610108165063; Fri, 08 Jan 2021 04:16:05 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:15:16 +0000
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Message-Id: <20210108121524.656872-19-qperret@google.com>
Mime-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 18/26] KVM: arm64: Use kvm_arch for stage 2 pgtable
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
use struct kvm_arch in lieu of struct kvm as the host will have the
former but not the latter.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 5 +++--
 arch/arm64/kvm/hyp/pgtable.c         | 6 +++---
 arch/arm64/kvm/mmu.c                 | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 45acc9dc6c45..8e8f1d2c5e0e 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -151,12 +151,13 @@ int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
 /**
  * kvm_pgtable_stage2_init() - Initialise a guest stage-2 page-table.
  * @pgt:	Uninitialised page-table structure to initialise.
- * @kvm:	KVM structure representing the guest virtual machine.
+ * @arch:	Arch-specific KVM structure representing the guest virtual
+ *		machine.
  * @mm_ops:	Memory management callbacks.
  *
  * Return: 0 on success, negative error code on failure.
  */
-int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm *kvm,
+int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_arch *arch,
 			    struct kvm_pgtable_mm_ops *mm_ops);
 
 /**
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 61a8a34ddfdb..96a25d0b7b6e 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -855,11 +855,11 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
 	return kvm_pgtable_walk(pgt, addr, size, &walker);
 }
 
-int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm *kvm,
+int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_arch *arch,
 			    struct kvm_pgtable_mm_ops *mm_ops)
 {
 	size_t pgd_sz;
-	u64 vtcr = kvm->arch.vtcr;
+	u64 vtcr = arch->vtcr;
 	u32 ia_bits = VTCR_EL2_IPA(vtcr);
 	u32 sl0 = FIELD_GET(VTCR_EL2_SL0_MASK, vtcr);
 	u32 start_level = VTCR_EL2_TGRAN_SL0_BASE - sl0;
@@ -872,7 +872,7 @@ int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm *kvm,
 	pgt->ia_bits		= ia_bits;
 	pgt->start_level	= start_level;
 	pgt->mm_ops		= mm_ops;
-	pgt->mmu		= &kvm->arch.mmu;
+	pgt->mmu		= &arch->mmu;
 
 	/* Ensure zeroed PGD pages are visible to the hardware walker */
 	dsb(ishst);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 9d4c9251208e..7e6263103943 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -461,7 +461,7 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 	if (!pgt)
 		return -ENOMEM;
 
-	err = kvm_pgtable_stage2_init(pgt, kvm, &kvm_s2_mm_ops);
+	err = kvm_pgtable_stage2_init(pgt, &kvm->arch, &kvm_s2_mm_ops);
 	if (err)
 		goto out_free_pgtable;
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

