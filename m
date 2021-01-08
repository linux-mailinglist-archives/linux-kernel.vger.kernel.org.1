Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226382EF266
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbhAHMTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbhAHMRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:17:24 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F588C061251
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:16:11 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id s130so3165251wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rB56z3mGpxUuTHn/Xak6xMo1bLRSjWgNwLW9Odgs7SE=;
        b=sZ9lz6KMm/awvK/FUyTBV6gbtoAj9u+t5wqR7EyJZaYQJYs1DgmJhAN9guL76b5AqX
         QrxnXL3TMkZnxaVdtGkrkFZ/Gror/3uSLgG2nFKVL5rA7QnIaNSQb7EX57CAMFLeHOBl
         rmIbib7QdTe/xFex0JoDhO2k5ITo1JbrYwQkhGCkHYGI8BAJEEo6g5/YTCGccge+QdAl
         CRwtB9ejkWhG9X7XdM2TAD7cn1oLDobKGPPwlabY6hqmcuwTfyjNjmFLttVJsLF/m9qK
         A3XmppIclwW8skmL/2C+GvmYDiqnOMiU/EzjsQkQ+NRBgWf+YV7qsLfYg4XgXIhLuUvy
         /AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rB56z3mGpxUuTHn/Xak6xMo1bLRSjWgNwLW9Odgs7SE=;
        b=p1Ok3CMkLasgLsSixsSqOteTlfDizN/BXEcmJGcNjD+J2HRUDlh7/Qhal+7QPetqdt
         ZBvuervXbrIfHcbchwzlOPo+fNpsa8XofFDGbVcq6cst1OLe2HoiTgQZhgCu7farvvlE
         CVskowH+xqT/hEmybF7Erhha3TMgvc9e2QQx+A4EGgFAEGUnDyXn/3FFtjjlRvZNSUTS
         sXvAbhelHypSv7t8yLeb0Y9G+MPwcPuDBKH4kyb4PjQ/ZhryMzD+vXJv2SuuKgOBnwX+
         6Cu9JwrTPsv/EDhm+ljXIMmbZFhWG5DrfrHmCZrfkHKbFeOmBhANN+RGCmNOezrjoimT
         ZG0w==
X-Gm-Message-State: AOAM530FVLtjzwYorFLkYc64KBeRH8+MOfAwR6buuIS2iuCRfHgcxWoZ
        a+BtbmUeIp6pKp4/jWfmTjYtdq5qrL1j
X-Google-Smtp-Source: ABdhPJxmrOhRm41THdsIbrnj6ypbcYm9MJwmDBYKYq5S39H6WEBJ74SHvp6aXE7vK44XdtRutbNDxGyXjPZs
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:adf:f0d0:: with SMTP id
 x16mr3485427wro.162.1610108169879; Fri, 08 Jan 2021 04:16:09 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:15:18 +0000
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Message-Id: <20210108121524.656872-21-qperret@google.com>
Mime-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 20/26] KVM: arm64: Set host stage 2 using kvm_nvhe_init_params
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

Move the registers relevant to host stage 2 enablement to
kvm_nvhe_init_params to prepare the ground for enabling it in later
patches.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h   | 3 +++
 arch/arm64/kernel/asm-offsets.c    | 3 +++
 arch/arm64/kvm/arm.c               | 5 +++++
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 9 +++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c   | 5 +----
 5 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 4fc27ac08836..5354b05eb9e2 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -158,6 +158,9 @@ struct kvm_nvhe_init_params {
 	unsigned long tpidr_el2;
 	unsigned long stack_hyp_va;
 	phys_addr_t pgd_pa;
+	unsigned long hcr_el2;
+	unsigned long vttbr;
+	unsigned long vtcr;
 };
 
 /* Translate a kernel address @ptr into its equivalent linear mapping */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 5e82488f1b82..9cf7736e31db 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -114,6 +114,9 @@ int main(void)
   DEFINE(NVHE_INIT_TPIDR_EL2,	offsetof(struct kvm_nvhe_init_params, tpidr_el2));
   DEFINE(NVHE_INIT_STACK_HYP_VA,	offsetof(struct kvm_nvhe_init_params, stack_hyp_va));
   DEFINE(NVHE_INIT_PGD_PA,	offsetof(struct kvm_nvhe_init_params, pgd_pa));
+  DEFINE(NVHE_INIT_HCR_EL2,	offsetof(struct kvm_nvhe_init_params, hcr_el2));
+  DEFINE(NVHE_INIT_VTTBR,	offsetof(struct kvm_nvhe_init_params, vttbr));
+  DEFINE(NVHE_INIT_VTCR,	offsetof(struct kvm_nvhe_init_params, vtcr));
 #endif
 #ifdef CONFIG_CPU_PM
   DEFINE(CPU_CTX_SP,		offsetof(struct cpu_suspend_ctx, sp));
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e524682c2ccf..00cee4489cd7 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1413,6 +1413,11 @@ static void cpu_prepare_hyp_mode(int cpu)
 
 	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
 	params->pgd_pa = kvm_mmu_get_httbr();
+	if (is_protected_kvm_enabled())
+		params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
+	else
+		params->hcr_el2 = HCR_HOST_NVHE_FLAGS;
+	params->vttbr = params->vtcr = 0;
 
 	/*
 	 * Flush the init params from the data cache because the struct will
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index ad943966c39f..b1341bb4b453 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -102,6 +102,15 @@ alternative_else_nop_endif
 	ldr	x1, [x0, #NVHE_INIT_MAIR_EL2]
 	msr	mair_el2, x1
 
+	ldr	x1, [x0, #NVHE_INIT_HCR_EL2]
+	msr	hcr_el2, x1
+
+	ldr	x1, [x0, #NVHE_INIT_VTTBR]
+	msr	vttbr_el2, x1
+
+	ldr	x1, [x0, #NVHE_INIT_VTCR]
+	msr	vtcr_el2, x1
+
 	ldr	x1, [x0, #NVHE_INIT_PGD_PA]
 	phys_to_ttbr x2, x1
 alternative_if ARM64_HAS_CNP
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index f3d0e9eca56c..979a76cdf9fb 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -97,10 +97,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 	mdcr_el2 |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
 
 	write_sysreg(mdcr_el2, mdcr_el2);
-	if (is_protected_kvm_enabled())
-		write_sysreg(HCR_HOST_NVHE_PROTECTED_FLAGS, hcr_el2);
-	else
-		write_sysreg(HCR_HOST_NVHE_FLAGS, hcr_el2);
+	write_sysreg(this_cpu_ptr(&kvm_init_params)->hcr_el2, hcr_el2);
 	write_sysreg(CPTR_EL2_DEFAULT, cptr_el2);
 	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
 }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

