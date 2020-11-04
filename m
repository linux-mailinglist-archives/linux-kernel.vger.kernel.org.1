Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C512A6CE8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbgKDSh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732566AbgKDShW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:37:22 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C90DC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:37:22 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h22so3301568wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u52kHMW+kn83ag3JaEyoWb0+pW9IMqD4BMU2psxNYnQ=;
        b=UB+tujjIDqFaIg2HCII9phSYVmB1j1zP+b/oy7LyLRa4tpi5vDWKwHeXFjBBncAnue
         t5NLaznwL2a6xMO0nB+gZ1W8lR7ASbIC/5uqmVhA4JQkT8FQVwPkHEVtrHZCcXTrelEg
         Zybm4GkCW5RvA/LoFm5TG4qJIoz2BcdeKP84kW3j4+j6F6ikYpJRGjwhjPTkgRLHOEOA
         cA6gGhLerR0LCsX7vhQgqN2GD4VTP/yLKxPGn0+VV1j/Z289/Gkvpx8lCV0Qvg7UoJaD
         DifqvbMmXizjEGf/EPyu+gGhSSM476YffGBtRUTz5V1wN96efp7x2jpSTvTq4TqipO86
         eGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u52kHMW+kn83ag3JaEyoWb0+pW9IMqD4BMU2psxNYnQ=;
        b=I4IpHYQTPcAiuBbuThRfcpriDzOmMsuf/Ax63oKtd9blw+hDMJh+SBpa02coz/bp9A
         M5lNsy8mLB8YAKkSTalKl4X/I8xfPd1qKVu3Fq6xTGSE+vhuonxmInKWPNpEngIdqQI0
         V1sMIZ24OT3ytPMe4+30gbuhXSI1aIC60OAGV+Po8CbWwzWYRBng6GrfaF3oCsDL6XrV
         aSfvoqQgnY6GNXV5kx55CtlHXAABujiex9qr4Z2R9OuR5Xw+bmdgQuTiPDNNVt6NT+v3
         YkPonUr1C/d4OzoAqvK3JAVVtQ+8DdFqBtpS5Ok1XZIw61c6H1esE6CiIiZnMBEToJxn
         L/RQ==
X-Gm-Message-State: AOAM532kplGo17PyuatKnkBxCx5/lpCcU8HLTcumgi22XjL3NvhBWn9Y
        FUFuC1KtwxJ29Y61Fr6IZPIfyg==
X-Google-Smtp-Source: ABdhPJwsJeUZZiJ/5qjoSIdAagJRDj0FAch74PF5fDj6WKHQ0ZxsPbVmvF9ETVGgMlYzKzkwDQ1P3g==
X-Received: by 2002:a1c:2842:: with SMTP id o63mr5935820wmo.59.1604515040904;
        Wed, 04 Nov 2020 10:37:20 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id t5sm4349312wrb.21.2020.11.04.10.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:37:19 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH 20/26] kvm: arm64: Add CPU entry point in nVHE hyp
Date:   Wed,  4 Nov 2020 18:36:24 +0000
Message-Id: <20201104183630.27513-21-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When nVHE hyp starts interception host's PSCI CPU_ON SMCs, it will need
to install KVM on the newly booted CPU before returning to the host. Add
an entry point which expects the same kvm_nvhe_init_params struct as the
__kvm_hyp_init HVC in the CPU_ON context argument (x0).

The entry point initializes EL2 state with the same init_el2_state macro
used by the kernel's entry point. It then initializes KVM using the same
helper function used in the __kvm_hyp_init HVC.

When done, the entry point branches to a function provided in the init
params.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h   |  1 +
 arch/arm64/kernel/asm-offsets.c    |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 30 ++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 9eecb37db6df..8350b95ce94e 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -155,6 +155,7 @@ struct kvm_nvhe_init_params {
 	unsigned long tpidr_el2;
 	unsigned long hyp_stack_ptr;
 	unsigned long vector_ptr;
+	unsigned long psci_cpu_entry_fn;
 };
 
 enum kvm_nvhe_psci_state {
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 0cbb86135c7c..ffc84e68ad97 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -114,6 +114,7 @@ int main(void)
   DEFINE(NVHE_INIT_TPIDR_EL2,	offsetof(struct kvm_nvhe_init_params, tpidr_el2));
   DEFINE(NVHE_INIT_STACK_PTR,	offsetof(struct kvm_nvhe_init_params, hyp_stack_ptr));
   DEFINE(NVHE_INIT_VECTOR_PTR,	offsetof(struct kvm_nvhe_init_params, vector_ptr));
+  DEFINE(NVHE_INIT_PSCI_CPU_ENTRY_FN,	offsetof(struct kvm_nvhe_init_params, psci_cpu_entry_fn));
 #endif
 #ifdef CONFIG_CPU_PM
   DEFINE(CPU_CTX_SP,		offsetof(struct cpu_suspend_ctx, sp));
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index 1726cc44b3ee..dd297a1a8f82 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -6,6 +6,7 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/linkage.h>
+#include <linux/irqchip/arm-gic-v3.h>
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
@@ -159,6 +160,35 @@ alternative_else_nop_endif
 	ret
 SYM_CODE_END(___kvm_hyp_init)
 
+SYM_CODE_START(__kvm_hyp_cpu_entry)
+	msr	SPsel, #1			// We want to use SP_EL{1,2}
+
+	/*
+	 * Check that the core was booted in EL2. Loop indefinitely if not
+	 * because it cannot be safely given to the host without installing KVM.
+	 */
+	mrs	x1, CurrentEL
+	cmp	x1, #CurrentEL_EL2
+	b.ne	.
+
+	/* Initialize EL2 CPU state to sane values. */
+	mov	x29, x0
+	init_el2_state nvhe
+	mov	x0, x29
+
+	/*
+	 * Load hyp VA of C entry function. Must do so before switching on the
+	 * MMU because the struct pointer is PA and not identity-mapped in hyp.
+	 */
+	ldr	x29, [x0, #NVHE_INIT_PSCI_CPU_ENTRY_FN]
+
+	/* Enable MMU, set vectors and stack. */
+	bl	___kvm_hyp_init
+
+	/* Leave idmap. */
+	br	x29
+SYM_CODE_END(__kvm_hyp_cpu_entry)
+
 SYM_CODE_START(__kvm_handle_stub_hvc)
 	cmp	x0, #HVC_SOFT_RESTART
 	b.ne	1f
-- 
2.29.1.341.ge80a0c044ae-goog

