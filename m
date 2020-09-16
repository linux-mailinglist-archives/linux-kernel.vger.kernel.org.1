Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2086C26CA77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgIPUBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgIPRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD32C061355
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:34:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so3913569wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9sgzGfpFFC64RJRg+974gui8xymUAlAMqzcpem+/CSY=;
        b=qMakas/EqU8sthwlgBLnrwvnZRAraVI8Sv8JwWPnUfgEnVzZJSdrtVHvMt1ezF7z7H
         A/CJWmbIe4J9dCW8b0LTLe7Heh9CPHI643HmQCBrpkULf8M+cEXiyc0+aQbcTDAsf1v2
         +n07zinh1/QDVCzCcP9y2XRmwPgdEs1CXndG+Zomxw2gl8eA2cp9tt2bxanJ+/59hf2A
         /m/n28TEXQlZYX3OIhG9T3Sixf56usD+TjQZ/+zNIZJNqfbTjzC6ijgK3F9kXhjOrOS3
         4yT1Toi0Q6lOvmlLPznvI5ROFnBl/KAiCFVY5WND4p3AsI8mQUEIZDynexktrozfT8Lx
         0RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9sgzGfpFFC64RJRg+974gui8xymUAlAMqzcpem+/CSY=;
        b=sJwUhzNHDA7SvFVbF1Kybd6NxXLxVsvyofwamPsHDAmiC35l87sngViT/psw70R0xY
         GfraOM2R1jqbmat+r7JTofA3gGgBDrsSzhZQ8Grh9JcqfzBNVuy/DBd54KTt2PAfMUAQ
         BcnpXLjxTA+64FeoRBg+zonuCf81qCY7dml7FedwqvxaiDEdE6+M09zYgtv5PwdM3poP
         JkOL+tpB0PkA2ZSv6VebWDd3NVOm3ttYD94xlrwjI/YY3sw5tYxzwwh+9qN9BKoD5DKA
         cEqL8OmscfGoNhYSowFMGt1Dsr2ntOBq2yuSv0sVR1AnFAy20q40ZmBOdPciCee9g2Cj
         i83g==
X-Gm-Message-State: AOAM533dzzNrXDm9yp+F+F7eDvEJ7JCV4dtHah/xBprij1J+WubE1EJW
        adrpIIPJcnZiqDbvNzPdnzgZBg==
X-Google-Smtp-Source: ABdhPJxFj6X/hCuUE/N+733RQjEZLOd7n2vySf2bWA+cMRMhZxuMBy1BHCIG9TmmZ1mKvjjqjdC8yA==
X-Received: by 2002:a7b:c192:: with SMTP id y18mr5703981wmi.108.1600277695176;
        Wed, 16 Sep 2020 10:34:55 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
        by smtp.gmail.com with ESMTPSA id m1sm6108804wmc.28.2020.09.16.10.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 10:34:54 -0700 (PDT)
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
Subject: [PATCH v3 05/11] kvm: arm64: Remove hyp_adr/ldr_this_cpu
Date:   Wed, 16 Sep 2020 18:34:33 +0100
Message-Id: <20200916173439.32265-6-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916173439.32265-1-dbrazdil@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/assembler.h | 27 +++++++++++++++++----------
 arch/arm64/include/asm/kvm_asm.h   | 14 +-------------
 arch/arm64/kvm/hyp/hyp-entry.S     |  2 +-
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 54d181177656..f79231a0f949 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -218,6 +218,21 @@ lr	.req	x30		// link register
 	str	\src, [\tmp, :lo12:\sym]
 	.endm
 
+	/*
+	 * @dst: destination register (32 or 64 bit wide)
+	 */
+	.macro	this_cpu_offset, dst
+#if defined(__KVM_NVHE_HYPERVISOR__) || defined(__KVM_VHE_HYPERVISOR__)
+	mrs	\dst, tpidr_el2
+#else
+alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
+	mrs	\dst, tpidr_el1
+alternative_else
+	mrs	\dst, tpidr_el2
+alternative_endif
+#endif
+	.endm
+
 	/*
 	 * @dst: Result of per_cpu(sym, smp_processor_id()) (can be SP)
 	 * @sym: The name of the per-cpu variable
@@ -226,11 +241,7 @@ lr	.req	x30		// link register
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
 
@@ -241,11 +252,7 @@ alternative_endif
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
2.28.0.618.gf4bc123cb7-goog

