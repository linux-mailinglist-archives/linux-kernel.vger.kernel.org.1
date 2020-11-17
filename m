Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EB32B6CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbgKQSRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbgKQSRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:17:03 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A18C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:17:02 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id d41so13562687qvc.23
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EZMTqnbgaQsSDAJvbG1XxJlQ79bagawpZ079qLuIDUc=;
        b=qMufXY54r9Tw35ml8YyFoPlAwDp0r3TGxMAr86L/dQTFHJDmLAygkajnXncZ6HZQ2k
         2xNFCfSX0DlCJ065rQ8Hi/6WXafc8DZpYAgTbrHNf1F1+kiPJ8hWXMEfKskS2nWCZ28N
         d6WRT972maQTo7niliiLO+H94x2r+g8fAK7s9FPaTTY/iyAoYE1MDxxbQz54qAtI0Y+m
         znuZs/tR2Yho5nq/SRXBlObO0lJOH1SQLeHUCqGq5p7mvYw44FJLW6qMUDQPvqKKmxBc
         dSxg2dX0HlCBEbRqk9LUZzg4OxnawJSbHzk/FpR0msYJGzYoMIUPRFdwMuqNJdYFlZhs
         xGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EZMTqnbgaQsSDAJvbG1XxJlQ79bagawpZ079qLuIDUc=;
        b=Kegv/U4BujjjyDRtllwz2iu/v6A23ueGvYrTjkEZpyc98giPjOfHXoQox9cc4j/VM9
         FVLy5bNA6S3ViWdZTbjbk9/S2DvReV3FB8Rezl4KMQX2eT2GValoxh1EXoRJExAW4BCO
         g16qhZ5ZlCPbHIpAHj8KCIzSU99L2gsFOdfQ0DdsjYhDJiquBjEPTTBYUXd6KzL8pTVa
         2nkpJK+HomcaeQ7zBRIXaghXCTqq+OkSFubNYBfCqdzpNIQMcO3euyJJNptGQbANBixI
         J0Isp2cRaei/Y4uiveaaCMRnVp0NmfCb7iD3A1F/dtWdTjwKVOkti2kO3pcg9EN1EWFW
         EJ8Q==
X-Gm-Message-State: AOAM531KWyPD0sSbQSRP0zLF2aXmNzlVnqCig2T4Cddk3oA5ph6ezOGV
        hcwfzuBru/dCEqzNgRQk1EidP5QkitJw
X-Google-Smtp-Source: ABdhPJxEnDzHoSiNaMlrXnG6cnHtgZaXnUxTO1bmEfh2lGjsMU/qzCf4IQGItC9HE+ZfEJGOV/17H4jHf0yD
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a05:6214:612:: with SMTP id
 z18mr817548qvw.41.1605637021225; Tue, 17 Nov 2020 10:17:01 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:15:58 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-19-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 18/27] KVM: arm64: Use kvm_arch for stage 2 pgtable
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
index 5c2e0feb9689..384f2acc0115 100644
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
2.29.2.299.gdc1121823c-goog

