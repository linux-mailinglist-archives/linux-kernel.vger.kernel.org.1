Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619D92B6D09
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbgKQSRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731026AbgKQSRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:17:08 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7654BC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:17:06 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id dp12so7862071qvb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uWTirSBGllb/UnC1/gfuRUGVZCQysfGVvtfYpfqhwps=;
        b=QOvLP7+8rJSTpw6cIxRDKU37M+xX2BsqlE+SSoroXw4nil7j3KIE5nlZL9QPhOUnV2
         neKN1A7pQ+x+SQWyzb6lI+RG4t3CdSbNFNKbHjPSf/y2Cy7OdeGY+IEdNMjcuceKN2L0
         T1sJRvfMBIkD++hzeifuRpVg7u3ErEumK8vjo1uj0nq8BIvfiQAko56WeOPhqZZMID8+
         SHUSt/rtqPXiPAZnsC7EX97B/GMHUi2XVojFSZHDFVU95enBs0xE3vp9oc+pprUh9dxA
         0RVD59xrq8RJdccXUEgST+e87cFbujgI/4HZeyYKmtJHEk87BTRvkL+2Jbca91yf6Bx+
         Bx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uWTirSBGllb/UnC1/gfuRUGVZCQysfGVvtfYpfqhwps=;
        b=uXL38/i4/UebdC3KBOPLthfeBePPNA6uhqbPBvOnv3C4gwTzy98uJC71vBQSlV7xfW
         zIP+4wKf0urInAthoLB/y2tBvGQDye8OqAZcI2lK9c4E+mh3LtDAdm6xYGRyEUu+t1ks
         68WNiIkDljPHUf/hqGFq8hGeq8aruZzE0izUdb+k04Bhm3u82E7FMg6QTxn++YHFsNFf
         7XfyF93JoJxVzZg+2n2UPSf6/RWox8/V9kphVy35m+B94hDox5nw+cIdtKnZJ8cLLLJB
         5ye5F0K3xlAOGF7fDXW4svEvOFjhyRkm92AJEgF5Nh3g05Rs1XJ64Oe8bmHarfD80xu4
         9EOw==
X-Gm-Message-State: AOAM532/8nxlsEqUXhe9aqAV8CTTU+Z3PJz1wvoJnXGOZpOl3DkdzShW
        QON+ktLEXWYPOfoNn6C4OJ1QcTDrrZnO
X-Google-Smtp-Source: ABdhPJwdF2Gg54bc1EmlvAWDzl41GijC84V6agc2skK4FVwntGHb1cSvCccXppxqfrsHcQ1LZjG1wvbDZQfU
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a0c:db11:: with SMTP id
 d17mr513281qvk.39.1605637025659; Tue, 17 Nov 2020 10:17:05 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:16:00 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-21-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 20/27] KVM: arm64: Set host stage 2 using kvm_nvhe_init_params
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
index 9266b17f8ba9..089eea6e54fc 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -158,6 +158,9 @@ struct kvm_nvhe_init_params {
 	unsigned long stack_hyp_va;
 	unsigned long entry_hyp_va;
 	phys_addr_t pgd_pa;
+	unsigned long hcr_el2;
+	unsigned long vttbr;
+	unsigned long vtcr;
 };
 
 /* Translate a kernel address @ptr into its equivalent linear mapping */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 9752100bf01f..2c3813bff6ea 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -115,6 +115,9 @@ int main(void)
   DEFINE(NVHE_INIT_STACK_HYP_VA,	offsetof(struct kvm_nvhe_init_params, stack_hyp_va));
   DEFINE(NVHE_INIT_ENTRY_HYP_VA,	offsetof(struct kvm_nvhe_init_params, entry_hyp_va));
   DEFINE(NVHE_INIT_PGD_PA,	offsetof(struct kvm_nvhe_init_params, pgd_pa));
+  DEFINE(NVHE_INIT_HCR_EL2,	offsetof(struct kvm_nvhe_init_params, hcr_el2));
+  DEFINE(NVHE_INIT_VTTBR,	offsetof(struct kvm_nvhe_init_params, vttbr));
+  DEFINE(NVHE_INIT_VTCR,	offsetof(struct kvm_nvhe_init_params, vtcr));
 #endif
 #ifdef CONFIG_CPU_PM
   DEFINE(CPU_CTX_SP,		offsetof(struct cpu_suspend_ctx, sp));
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index cfe5cc55b425..e06c95a10dba 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1365,6 +1365,11 @@ static void cpu_prepare_hyp_mode(int cpu)
 	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
 	params->entry_hyp_va = kern_hyp_va((unsigned long)kvm_ksym_ref_nvhe(__kvm_hyp_psci_cpu_entry));
 	params->pgd_pa = kvm_mmu_get_httbr();
+	if (is_protected_kvm_enabled())
+		params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
+	else
+		params->hcr_el2 = HCR_HOST_NVHE_FLAGS;
+	params->vttbr = params->vtcr = 0;
 
 	/*
 	 * Flush the init params from the data cache because the struct will
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index e2d62297edfe..9f3f3098670a 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -103,6 +103,15 @@ alternative_else_nop_endif
 	ldr	x1, [x0, #NVHE_INIT_STACK_HYP_VA]
 	mov	sp, x1
 
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
 	phys_to_ttbr x0, x1
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
2.29.2.299.gdc1121823c-goog

