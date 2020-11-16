Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F762B5306
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbgKPUoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387503AbgKPUoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:44:01 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB61C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:00 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k2so20321053wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vh/ZyQWPccQlBaf9TiRx0Z2M+/9lMwlUGC5PwlE2iA=;
        b=lYaecYgiUsVh5Y29T3TA+aUzv2MBsym263hl7v7/lCIsYy/caQZPdpdPDwRun3GkVQ
         TibEno2QAgL5uGVeuMPYrhhkkwr03mY7fPYSeVkbxTaUfzAqdhHPmokaNPXImivnNQCH
         1e4MxfRd8KuJ8d9Rh83Mg1aQHNrCYYGSVoLDsZw0m+gnmtehTXh21pCK7K8z2USUdjyr
         eIAVkt9IfAXZl4ZRzVlgVQwmVP+MxCSvApzQmWgu5Fmjn/Mdv4Nf2cIZW+x88Q8FRESy
         1iTTnAUdmQzvgQHuJ/g6EZ7YT5cIPjXxfJnpaTBHkUaxmCGS1kVEKvD4sc6GjQ6h/ZFj
         lTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vh/ZyQWPccQlBaf9TiRx0Z2M+/9lMwlUGC5PwlE2iA=;
        b=f2Qhh7AIBLQcENu8c46huAtvV2rZRyoT5Eowln4j9jd3AmYzu33rz2p2M0hhRnCA+o
         6VrR+Q3YlqqT8tPPqFmeETfO7168HX7zUkdElXUyGh5N6/MO/oeO5TUBq+Xwym6SGhIv
         EsED++epI4RaDeNOyLFkNwJdEh0IhfMi8jl5QL+/5xP69Xm2HxqZHR93zEG/DZ/EK9OO
         qKl1tCFs9XaIPQ51eGPGCqdVdOfaHSTJvlaulA5VXYyNpA8arWy/Vis0lgiDDGrDWMEh
         CwdrJzZUe9Cg2toGIsHybM9w+AjsTRLF32IXmwc48Pqqhscf3fyMqzOOTmQs2huwrCuw
         59Bg==
X-Gm-Message-State: AOAM533r9exqRZpJdemGmp5L7CDHtjDqbWZHxoTMMrqxiCQ9c4KbkZeW
        i/PkxovME8ySBkS5nsxQwCQy6g==
X-Google-Smtp-Source: ABdhPJz+z6lHUZHhLRo8hPqDD5egPFyYy5Oa9Q7KVNb2Md2cVBffXmyb9o9Xy5q1uJzaghGQ8wBNnw==
X-Received: by 2002:adf:8366:: with SMTP id 93mr21195149wrd.321.1605559439365;
        Mon, 16 Nov 2020 12:43:59 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id u14sm21439797wrq.93.2020.11.16.12.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:58 -0800 (PST)
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
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 17/24] kvm: arm64: Add CPU entry point in nVHE hyp
Date:   Mon, 16 Nov 2020 20:43:11 +0000
Message-Id: <20201116204318.63987-18-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
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
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 32 ++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 01904e88cead..109867fb76f6 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -154,6 +154,7 @@ struct kvm_nvhe_init_params {
 	unsigned long tpidr_el2;
 	unsigned long vector_hyp_va;
 	unsigned long stack_hyp_va;
+	unsigned long entry_hyp_va;
 	phys_addr_t pgd_pa;
 };
 
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 4435ad8be938..9752100bf01f 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -113,6 +113,7 @@ int main(void)
   DEFINE(NVHE_INIT_TPIDR_EL2,	offsetof(struct kvm_nvhe_init_params, tpidr_el2));
   DEFINE(NVHE_INIT_VECTOR_HYP_VA,	offsetof(struct kvm_nvhe_init_params, vector_hyp_va));
   DEFINE(NVHE_INIT_STACK_HYP_VA,	offsetof(struct kvm_nvhe_init_params, stack_hyp_va));
+  DEFINE(NVHE_INIT_ENTRY_HYP_VA,	offsetof(struct kvm_nvhe_init_params, entry_hyp_va));
   DEFINE(NVHE_INIT_PGD_PA,	offsetof(struct kvm_nvhe_init_params, pgd_pa));
 #endif
 #ifdef CONFIG_CPU_PM
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index d4a71ac34254..6d8202d2bdfb 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -9,6 +9,7 @@
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
+#include <asm/el2_setup.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
@@ -159,6 +160,37 @@ alternative_else_nop_endif
 	ret
 SYM_CODE_END(___kvm_hyp_init)
 
+SYM_CODE_START(__kvm_hyp_cpu_entry)
+	msr	SPsel, #1			// We want to use SP_EL{1,2}
+
+	/* Check that the core was booted in EL2. */
+	mrs	x1, CurrentEL
+	cmp	x1, #CurrentEL_EL2
+	b.eq	2f
+
+	/* The core booted in EL1. KVM cannot be initialized on it. */
+1:	wfe
+	wfi
+	b	1b
+
+	/* Initialize EL2 CPU state to sane values. */
+2:	mov	x29, x0
+	init_el2_state nvhe
+	mov	x0, x29
+
+	/*
+	 * Load hyp VA of C entry function. Must do so before switching on the
+	 * MMU because the struct pointer is PA and not identity-mapped in hyp.
+	 */
+	ldr	x29, [x0, #NVHE_INIT_ENTRY_HYP_VA]
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
2.29.2.299.gdc1121823c-goog

