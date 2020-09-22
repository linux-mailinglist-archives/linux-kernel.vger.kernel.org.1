Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59788274A61
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgIVUtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgIVUtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:49:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7FDC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g4so18553855wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4owpoQA0YZkU55g3xZqB0P4GXzrY6zfnXz2TqZZIyZ0=;
        b=KYMM1B96Jv7z2OSW2J1SxoT0oCmfO8gzdOG3M1m8MGUzXriMClxvjHa/SFXuKswpCm
         RXSDpcMVpydS7yQvsSinqKRB4luwMTtxl9yqngeD3k1qPCwL1tyaO6lZDQwcOBnmvohX
         u3CxFJrBb5HXhwlotYXSVREXOiEaAsCN8mVf/eDVM2sXPVh5UmS3JoU8JdJtDXU9b8y/
         yIzBCfYtb7WXokc+pb7TdoScbplDeCH0U9QuIDyYx2LfgAkMx9l7SpOD6T0AUzSp2jj0
         jPoMAfE1qHyVwF5n11jwIJ2KZ0DPEPFe37y2qMCLi5Mq5zD5r7MgYvB3/9Ocys280cNY
         VrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4owpoQA0YZkU55g3xZqB0P4GXzrY6zfnXz2TqZZIyZ0=;
        b=ZAqK9sMrwGi5hiUIigCMRmwqFBaHqlfmOkfad1rkPi7TEIPcaZV3vElVAD0RyVcCqM
         XAAII6/uM/HE5e1wrZHDVHs3yzSzr3Yb+YRyzv87EcE/HDWW7ro2sJHGj2yr9dYSUi5G
         fhZpsTGE/OiwIbaOlVyXgHEIoAWL+NutD18XAiGTaul7B3NnniUrxfxsu1w75jpPIg9M
         v2m2l78MdcWegP5RoNBlh5BWVRe7Y/HJBbVFX/3VIyMl2RHRNAMOFXoFiMr6OOy4q7/N
         R9D04qmL6dgSTD/Q2XwUrrj/nlCm1muFWHkW2NtaVKDIrWMPOWj1VW/V/Vzo5BoV18ib
         YmVQ==
X-Gm-Message-State: AOAM530DmNZOuTwESytdeNMj/sMkubQcGMq5HL9xl/kDpmFxevAcslBj
        RODXdrcb4cPlIs0Ljrc4Cw9+Jw==
X-Google-Smtp-Source: ABdhPJxX9uBzSAKnJBAmtj/fHGztbwr3USOr+K3MXcKDIWkd6igzfbo8A1qOGNiBRh7RnslToVGEkg==
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr5757666wru.163.1600807761459;
        Tue, 22 Sep 2020 13:49:21 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:1105:630f:e990:272f])
        by smtp.gmail.com with ESMTPSA id y207sm6365851wmc.17.2020.09.22.13.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:49:20 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>,
        Andrew Scull <ascull@google.com>
Subject: [PATCH v4 05/10] kvm: arm64: Remove hyp_adr/ldr_this_cpu
Date:   Tue, 22 Sep 2020 21:49:05 +0100
Message-Id: <20200922204910.7265-6-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922204910.7265-1-dbrazdil@google.com>
References: <20200922204910.7265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hyp_adr/ldr_this_cpu helpers were introduced for use in hyp code
because they always needed to use TPIDR_EL2 for base, while
adr/ldr_this_cpu from kernel proper would select between TPIDR_EL2 and
_EL1 based on VHE/nVHE.

Simplify this now that the hyp mode case can be handled using the
__KVM_VHE/NVHE_HYPERVISOR__ macros.

Acked-by: Andrew Scull <ascull@google.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/assembler.h | 29 +++++++++++++++++++----------
 arch/arm64/include/asm/kvm_asm.h   | 14 +-------------
 arch/arm64/kvm/hyp/hyp-entry.S     |  2 +-
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 54d181177656..86e0ef79a799 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -218,6 +218,23 @@ lr	.req	x30		// link register
 	str	\src, [\tmp, :lo12:\sym]
 	.endm
 
+	/*
+	 * @dst: destination register (32 or 64 bit wide)
+	 */
+#if defined(__KVM_NVHE_HYPERVISOR__) || defined(__KVM_VHE_HYPERVISOR__)
+	.macro	this_cpu_offset, dst
+	mrs	\dst, tpidr_el2
+	.endm
+#else
+	.macro	this_cpu_offset, dst
+alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
+	mrs	\dst, tpidr_el1
+alternative_else
+	mrs	\dst, tpidr_el2
+alternative_endif
+	.endm
+#endif
+
 	/*
 	 * @dst: Result of per_cpu(sym, smp_processor_id()) (can be SP)
 	 * @sym: The name of the per-cpu variable
@@ -226,11 +243,7 @@ lr	.req	x30		// link register
 	.macro adr_this_cpu, dst, sym, tmp
 	adrp	\tmp, \sym
 	add	\dst, \tmp, #:lo12:\sym
-alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
-	mrs	\tmp, tpidr_el1
-alternative_else
-	mrs	\tmp, tpidr_el2
-alternative_endif
+	this_cpu_offset \tmp
 	add	\dst, \dst, \tmp
 	.endm
 
@@ -241,11 +254,7 @@ alternative_endif
 	 */
 	.macro ldr_this_cpu dst, sym, tmp
 	adr_l	\dst, \sym
-alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
-	mrs	\tmp, tpidr_el1
-alternative_else
-	mrs	\tmp, tpidr_el2
-alternative_endif
+	this_cpu_offset \tmp
 	ldr	\dst, [\dst, \tmp]
 	.endm
 
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index c196eec25498..cf9456663289 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -173,20 +173,8 @@ extern char __smccc_workaround_1_smc[__SMCCC_WORKAROUND_1_SMC_SZ];
 
 #else /* __ASSEMBLY__ */
 
-.macro hyp_adr_this_cpu reg, sym, tmp
-	adr_l	\reg, \sym
-	mrs	\tmp, tpidr_el2
-	add	\reg, \reg, \tmp
-.endm
-
-.macro hyp_ldr_this_cpu reg, sym, tmp
-	adr_l	\reg, \sym
-	mrs	\tmp, tpidr_el2
-	ldr	\reg,  [\reg, \tmp]
-.endm
-
 .macro get_host_ctxt reg, tmp
-	hyp_adr_this_cpu \reg, kvm_host_data, \tmp
+	adr_this_cpu \reg, kvm_host_data, \tmp
 	add	\reg, \reg, #HOST_DATA_CONTEXT
 .endm
 
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 46b4dab933d0..fba91c2ab410 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -132,7 +132,7 @@ alternative_cb_end
 	str	x0, [x2, #VCPU_WORKAROUND_FLAGS]
 
 	/* Check that we actually need to perform the call */
-	hyp_ldr_this_cpu x0, arm64_ssbd_callback_required, x2
+	ldr_this_cpu x0, arm64_ssbd_callback_required, x2
 	cbz	x0, wa2_end
 
 	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_2
-- 
2.28.0.681.g6f77f65b4e-goog

