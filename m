Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021AB2AB73A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgKILgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbgKILdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:08 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23920C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:33:08 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id j7so1053885wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gwTDypgwUf3rqkSua5uxQzTJijirOP4lU9f1S+usZSk=;
        b=jrUqYCAxKbMftvyv6EO+CyG7nRBWv1N9ciXM0WTM22HN8ijzC7yryR2lqJGhSbRuOG
         iwtZf64B+wSe1RFqDZKWDqB/cZ0sAqey2anS57mqhoAJ20bblxIJNt8SlhnR/l4hsN63
         vs2yLQ6INp6gpfIL+5SmE6i36GQASly/+2LS6TLFeqqRgjqgsOBKxrRqqkh7Iw1AgMwh
         HHGaSM3jxkADdB1M0xeCQ9TlxT8iW3y0dO7RzbJY3SeffWP8ZsWfb2PPOUsAGn7hI9rP
         tJ7M3hRhPTfE06JkGh3e6zEHRr9fFR/9o/IuwJqCwI8nZd6lIb7JeKWU5ISX7viZgUlB
         9IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwTDypgwUf3rqkSua5uxQzTJijirOP4lU9f1S+usZSk=;
        b=iTXq6PCcMEH+a4zQ9YU736d4sjyptYiP+0EwzRDe0mGFr0r6gSRnI+4KS1LiG5k69u
         Y2FdT9fvU0D1+vkwBT6nmsD40fU5hc+lv0da72iiJdCucHxW8IIZuVCPfCrqfYT203fR
         0wplpQNpNVQpKWsIoi5xeFq2YwtzTSgWG55vl61tLgAitA58ZXYZVj05CbeA/P4EGOGh
         n9SMARembJ/+Dcmrl9CVktjQH0kVcJ5odTZgeeOqiyE3HZWmmzt5sG05eEuUCeVN/rIV
         Eg93TV/UQ9CZ+QF62rleWEGC+M02HrdPZAOPSPmrLMCx96ZD206YLvA9dLJNIyNHB99i
         Ri/w==
X-Gm-Message-State: AOAM532eFaCTgOR0ArQsefXaSyDupgOgTISQyIFGoO6Dbevgu0MeAK3P
        FAkK0R4mSvJBUbAy9x+0FQA+1A==
X-Google-Smtp-Source: ABdhPJzFLULK2SSOyOQsTmDu18P2ApF4H82covw7VmzC9kWedcZrYGtm7jY72SGBGNtESQ3aE2thsQ==
X-Received: by 2002:adf:db4a:: with SMTP id f10mr2709289wrj.420.1604921586733;
        Mon, 09 Nov 2020 03:33:06 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id n22sm11769101wmk.40.2020.11.09.03.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:33:05 -0800 (PST)
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
Subject: [PATCH v1 13/24] kvm: arm64: Add CPU entry point in nVHE hyp
Date:   Mon,  9 Nov 2020 11:32:22 +0000
Message-Id: <20201109113233.9012-14-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
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
index 893327d1e449..efb4872bb29f 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -155,6 +155,7 @@ struct kvm_nvhe_init_params {
 	unsigned long tpidr_el2;
 	unsigned long hyp_stack_ptr;
 	unsigned long vector_ptr;
+	unsigned long psci_cpu_entry_fn;
 };
 
 /* Translate a kernel address @ptr into its equivalent linear mapping */
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
index 1697d25756e9..f999a35b2c8c 100644
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
2.29.2.222.g5d2a92d10f8-goog

