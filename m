Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36342EB210
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbhAESGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730763AbhAESGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:06:49 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C8EC0617A3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:06:08 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a12so83196wrv.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OlWNLkvu8os23nlNxmSq9Bz5E02cEWRlXUgN8SoW4qc=;
        b=uiGccgbHmkHVH03l7PPlPzjM6OCn3VXs3LK6H2v5YAw7NErN+XLJ0zgvL0csQdRbxO
         FOeRF9Usq9Ounr5UGTBl9EzTu0+3L43bAAQ14gaoCHgEZPMAlNUXD4tIX0OoWrLXfEgG
         3u4q+cNrF1+912qcOlxkOUSvn1fW4O7wckI8e5TWOTdaQvPmFP57yZek27rVgMXOlaRr
         rLybTGpLps9RgQxfGEuoguGngesdC5Zn7LmA9HmYjnpEJGFVMnDqM/i+qbfrzGCBdlEo
         JdhpfkJyS4oT718a0VEuaP6A3JGDWLymHtHCCXhwjCABJpXapeQRhTYfAM0/uBdjbzAJ
         E5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OlWNLkvu8os23nlNxmSq9Bz5E02cEWRlXUgN8SoW4qc=;
        b=EFDSWJANbgKWnsVA4/sybAVdPc0W0Ba5BoKwdmeq8nGQQfyrDTEsKS0aFvtGQ0Byux
         pGlZV+ee9w9jml6ajornSqKngoZPYH7+mwDOIdor/OsKfUySePvQPWgoV0qIXtquA5zb
         wPU4Jt4czT3vlNYb8DsRV/70/xjdY2/mXZMDqKkbrtBeE2ImkdYLIRHOnVE84/ogaxhM
         tkqsdDaUtytmPOAA7gf6L8in+NTjTcCGQVW2sbpksmOOJz5iNGPnI0fw3Ofi0WglgDWu
         SEah+vcq0eclTpbejhTyWMmT2BMaoLbQltRlUf7wphziWBJrqln0dLoKyYNi5szDzTq+
         I9dg==
X-Gm-Message-State: AOAM5322z0t8VCZSiCzfZV3GldIMwKAfIWOxOvLMRYaqGCiLesLsvkzN
        7N8pP1RVu8ctRmfys2E7fHA6/w==
X-Google-Smtp-Source: ABdhPJykPPGsPRvk5u16vzyumU8tD6czDOMIVrv06NmGFJ/zY/dEqModqSIRO58GD2prw5nLx9w35A==
X-Received: by 2002:adf:94c7:: with SMTP id 65mr685725wrr.423.1609869967382;
        Tue, 05 Jan 2021 10:06:07 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:4957:71a5:7b5c:c94f])
        by smtp.gmail.com with ESMTPSA id r82sm354256wma.18.2021.01.05.10.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 10:06:06 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 7/8] KVM: arm64: Remove patching of fn pointers in hyp
Date:   Tue,  5 Jan 2021 18:05:40 +0000
Message-Id: <20210105180541.65031-8-dbrazdil@google.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105180541.65031-1-dbrazdil@google.com>
References: <20210105180541.65031-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Storing a function pointer in hyp now generates relocation information
used at early boot to convert the address to hyp VA. The existing
alternative-based conversion mechanism is therefore obsolete. Remove it
and simplify its users.

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h   | 18 ------------------
 arch/arm64/kernel/image-vars.h     |  1 -
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 11 ++++-------
 arch/arm64/kvm/va_layout.c         |  6 ------
 4 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index adadc468cc71..90873851f677 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -135,24 +135,6 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 
 #define kern_hyp_va(v) 	((typeof(v))(__kern_hyp_va((unsigned long)(v))))
 
-static __always_inline unsigned long __kimg_hyp_va(unsigned long v)
-{
-	unsigned long offset;
-
-	asm volatile(ALTERNATIVE_CB("movz %0, #0\n"
-				    "movk %0, #0, lsl #16\n"
-				    "movk %0, #0, lsl #32\n"
-				    "movk %0, #0, lsl #48\n",
-				    kvm_update_kimg_phys_offset)
-		     : "=r" (offset));
-
-	return __kern_hyp_va((v - offset) | PAGE_OFFSET);
-}
-
-#define kimg_fn_hyp_va(v) 	((typeof(*v))(__kimg_hyp_va((unsigned long)(v))))
-
-#define kimg_fn_ptr(x)	(typeof(x) **)(x)
-
 /*
  * We currently support using a VM-specified IPA size. For backward
  * compatibility, the default IPA size is fixed to 40bits.
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index f676243abac6..23f1a557bd9f 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -64,7 +64,6 @@ __efistub__ctype		= _ctype;
 /* Alternative callbacks for init-time patching of nVHE hyp code. */
 KVM_NVHE_ALIAS(kvm_patch_vector_branch);
 KVM_NVHE_ALIAS(kvm_update_va_mask);
-KVM_NVHE_ALIAS(kvm_update_kimg_phys_offset);
 KVM_NVHE_ALIAS(kvm_get_kimage_voffset);
 
 /* Global kernel state accessed by nVHE hyp code. */
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index a906f9e2ff34..f012f8665ecc 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -108,9 +108,9 @@ static void handle___vgic_v3_restore_aprs(struct kvm_cpu_context *host_ctxt)
 
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
-#define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = kimg_fn_ptr(handle_##x)
+#define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
 
-static const hcall_t *host_hcall[] = {
+static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
 	HANDLE_FUNC(__kvm_tlb_flush_vmid_ipa),
@@ -130,7 +130,6 @@ static const hcall_t *host_hcall[] = {
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(unsigned long, id, host_ctxt, 0);
-	const hcall_t *kfn;
 	hcall_t hfn;
 
 	id -= KVM_HOST_SMCCC_ID(0);
@@ -138,13 +137,11 @@ static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
 	if (unlikely(id >= ARRAY_SIZE(host_hcall)))
 		goto inval;
 
-	kfn = host_hcall[id];
-	if (unlikely(!kfn))
+	hfn = host_hcall[id];
+	if (unlikely(!hfn))
 		goto inval;
 
 	cpu_reg(host_ctxt, 0) = SMCCC_RET_SUCCESS;
-
-	hfn = kimg_fn_hyp_va(kfn);
 	hfn(host_ctxt);
 
 	return;
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index fee7dcd95d73..978301392d67 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -283,12 +283,6 @@ static void generate_mov_q(u64 val, __le32 *origptr, __le32 *updptr, int nr_inst
 	*updptr++ = cpu_to_le32(insn);
 }
 
-void kvm_update_kimg_phys_offset(struct alt_instr *alt,
-				 __le32 *origptr, __le32 *updptr, int nr_inst)
-{
-	generate_mov_q(kimage_voffset + PHYS_OFFSET, origptr, updptr, nr_inst);
-}
-
 void kvm_get_kimage_voffset(struct alt_instr *alt,
 			    __le32 *origptr, __le32 *updptr, int nr_inst)
 {
-- 
2.29.2.729.g45daf8777d-goog

