Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A07C2D431B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbgLINTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732251AbgLINTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:19:19 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715A9C06138C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:18:08 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 91so1705617wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=epDnqaqaZseNBctE5f6pG2jQivwHl0Mc5pVZrVSTknc=;
        b=vMZTrkYojozaS4K0jVCmBqRNU23vVXRN02oEMfrHJs+eTcblucPsYLIWc3Vynrw+mn
         mznHBDBHtGjXdR8iqBA6OGh8SbXDKjYnPobJKkjxEf50OjacfCEa2rGjfuQQ2H4H9sQJ
         5huM2YXJ2VUEtYLttFKHif/j0m1y/kX0dp9/ySWEbQUDoNDnOQoOQi9Wk67kT9gYy+hO
         nu9q8KpDQW49sVES3PmG8NmnSn+TFu/aqzjglEBXHVBANm2olkYlmLHucLxVnRFxPQAj
         LHy2Ipd8nHoWiHjEDUHhwskIoTDUqmBEm8BYh+e/w3HriGC821g+MSWWqpEJBJSufmNz
         fHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=epDnqaqaZseNBctE5f6pG2jQivwHl0Mc5pVZrVSTknc=;
        b=coGH8IzQ4/TY208hilsbCjgpp6hcqwvnm2r9Adqv3hRaeSYY/kRnwriPdfaEn0SbuI
         3JCsPyxBxobUyqQHn+DDHHPdd2LpfzkUFsvLsb/fW/wc8MdAiOWQKwrSJKaBHGYuMKhl
         ipFH1G9rVEgay6WZte0VH6SeVGMWT/qiUYzclgHoKi9xopf94Ry9gVs4pE5LI9dcuDpP
         QdXj4zHhNsShwQnpPzVMF9hlKtpFEZ/Om0rIQkb0Q3dinuMC96n58YuP4BxCyubkC64h
         f+ASdk91Yy02lcLa3r7Gtinzhe1LU1tFN3KrgGIuQuE9ItAohDt2U0SJDe44sPNZBOUS
         DwWw==
X-Gm-Message-State: AOAM5338L2P0RkZcOd/CFdZ3xc06zi/DfFc34+Vd2X2CNRfytZETR2k8
        N3Ws8hOOie2JMHpDQpAEuSnzsQ==
X-Google-Smtp-Source: ABdhPJxW/XmoEaKVme8L2Gku0Ug7u+SX6ybe+SCrh0vpKo7yHlnDZJnDPITz8Rh8FhHshHxxfEtGIg==
X-Received: by 2002:adf:f84b:: with SMTP id d11mr2693844wrq.216.1607519887099;
        Wed, 09 Dec 2020 05:18:07 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9d1b:d0eb:db43:6cd2])
        by smtp.gmail.com with ESMTPSA id f16sm3285407wmh.7.2020.12.09.05.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 05:18:06 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 8/9] KVM: arm64: Remove patching of fn pointers in hyp
Date:   Wed,  9 Dec 2020 13:17:45 +0000
Message-Id: <20201209131746.85622-9-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209131746.85622-1-dbrazdil@google.com>
References: <20201209131746.85622-1-dbrazdil@google.com>
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
index 39289d75118d..3242502f45fa 100644
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
index bde658d51404..0cf4b750a090 100644
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
index fb2ca02b7270..e0021ba960b5 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -284,12 +284,6 @@ static void generate_mov_q(u64 val, __le32 *origptr, __le32 *updptr, int nr_inst
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
2.29.2.576.ga3fc446d84-goog

