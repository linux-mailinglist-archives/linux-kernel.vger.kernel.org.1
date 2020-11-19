Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60A02B97D8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgKSQZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgKSQZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:25:59 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913CDC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:25:58 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id a16so8774360ejj.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U1Lcn6Bd4XfPJVZpg/iAgt9bwB62SK3e+mkMsQgmis4=;
        b=k1mkH5VpRWxoRHM6/4uXMQ+2mNIrTpI3bzeVzL4Eq+TBVCrAhI6WY51UNkvUnkHkok
         sU1uyk5P398N4LFdkxWjG7dsnqAwLumIjARIWorBlisj1MlNzwfrmNTts90+aLS7JKNz
         gkZ4bewA7vI4XC511gEy5PnX1QNLEy7PS6q/z/rKoQaldCgOX6wvAVrbAbahJmo8YtOi
         7rJ+ZrpdENaqoIX1FUtGI5xUs7CVKoKAwZVWRcS8BfsPSovMOfZ1/GCNrbvtGVCB/yN9
         makp3oDRXdUvcItXGaXJW+Iw9jX+yej1cJsMThWyp+lSPCdh0JdW4i3W3QkO9Hpy6vdY
         nE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U1Lcn6Bd4XfPJVZpg/iAgt9bwB62SK3e+mkMsQgmis4=;
        b=XePojLrONxN1Y97nIbOu8W2wZZ0O6NnpH7Qz3F+oLevDN081w9dYQIws1WFo8oXeNP
         EX+V12AotScFxLoiZD4ydk5gtQ6dSp8L/K7FPsckK0zwQPBVvjg3JrNLlt7EcWaqctdY
         6D2apvVh7ORqKmaLnXFOCclF+Ew42vEMB3ke5lGT4oUUcDP5K1u2CYvJkN5Y0LCk77Ti
         wKFGkirKq8FEPc3RvQo/Me7Tpx5GkWZXcN/p3xjeZih5WG9DkKGG+LlFBb7sVBsCi3r8
         ujlkuenIecmGHTHjtGsOy0R6DEEiOnWMBSj6cK7Zpxqc8EGS5yiXb4e9Ivi8zwO/2k9u
         ooWw==
X-Gm-Message-State: AOAM533fTdySCfCO5lO/KAJtqnRqKitrZwOsVuBXTnYvHj54WLRSerNG
        F5FTlz9tdmVG4YZZuSJ2CRr9M2noAJfyYQ==
X-Google-Smtp-Source: ABdhPJzsWcD3nhXsO2UcH2+U86idS8BWqbdQMCqEdUgqzp7r5etX5V0OtmywF0Avo8pCoOQSclM4yw==
X-Received: by 2002:a17:906:ad85:: with SMTP id la5mr30963406ejb.423.1605803157084;
        Thu, 19 Nov 2020 08:25:57 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9843:cd3f:f36b:d55c])
        by smtp.gmail.com with ESMTPSA id jw7sm72123ejb.54.2020.11.19.08.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 08:25:56 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH 4/6] kvm: arm64: Remove patching of fn pointers in hyp
Date:   Thu, 19 Nov 2020 16:25:41 +0000
Message-Id: <20201119162543.78001-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119162543.78001-1-dbrazdil@google.com>
References: <20201119162543.78001-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taking a function pointer will now generate a R_AARCH64_RELATIVE that is
fixed up at early boot. Remove the alternative-based mechanism for
converting the address from a kernel VA.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h   | 18 ------------------
 arch/arm64/kernel/image-vars.h     |  1 -
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 11 ++++-------
 arch/arm64/kvm/va_layout.c         |  6 ------
 4 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index e5226f7e4732..8cb8974ec9cc 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -121,24 +121,6 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 
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
index 8539f34d7538..6379721236cf 100644
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
index b3db5f4eea27..7998eff5f0a2 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -110,9 +110,9 @@ static void handle___vgic_v3_restore_aprs(struct kvm_cpu_context *host_ctxt)
 
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
-#define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = kimg_fn_ptr(handle_##x)
+#define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
 
-static const hcall_t *host_hcall[] = {
+static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
 	HANDLE_FUNC(__kvm_tlb_flush_vmid_ipa),
@@ -132,7 +132,6 @@ static const hcall_t *host_hcall[] = {
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(unsigned long, id, host_ctxt, 0);
-	const hcall_t *kfn;
 	hcall_t hfn;
 
 	id -= KVM_HOST_SMCCC_ID(0);
@@ -140,13 +139,11 @@ static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
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
index 7f45a98eacfd..0494315f71f2 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -373,12 +373,6 @@ static void generate_mov_q(u64 val, __le32 *origptr, __le32 *updptr, int nr_inst
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
2.29.2.299.gdc1121823c-goog

