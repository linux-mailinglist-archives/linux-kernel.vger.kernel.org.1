Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1602C58CB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403856AbgKZPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403847AbgKZPzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:55:11 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FC8C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:55:11 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id m6so2633397wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zOoo3Sgmv8F42l97WnsUvAdYKac9P9JfqD+cuM/Sn9g=;
        b=ZVUoTU+gAuCOCKAA0JLDhF23GWfoPMRCkpRKeYuO2EHe2Onkr6VOoTZUTexi44Rir1
         M7Vec/VJjU910zroh1GatIekcjEn1KcoZUYX6zTIR6xbl5/W+BI4ijNuriBY4wzxq6o0
         th2sQXhqNToAPL2A4a3jTYDvdhRPGxKoBR1YLOiGZat0oLUmpTjtTL5xf9QYbPo6cRaz
         LeC0zcowK1CpA5rM9SPW/xuLsByt07lyInueXKnZbfVrraPEbzK2Hp2YKnke9CJtx74L
         7eywhbuxnO+at1gvgIEjiycO99JM0jHyGOtXQzmevEWogclk6qZxfgi8ain9mePuu9R6
         wdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zOoo3Sgmv8F42l97WnsUvAdYKac9P9JfqD+cuM/Sn9g=;
        b=MHx2cw9sb1kYEDNWuTDz3n9bqJknqtGI4ALoDKlG3OybuBN1wADRAUD5X8S8td2vCj
         Q6cgw28OZ68JlLBWl+P8ExIItZnm3SkuPjQ337FMwRyuUkXj9sFLRfVXuX6ub96XRYfG
         Y7KCyDODS4K6HYc3p/gcGUg1X/P7XI1c0Yk9QHfHHr8JhVAdGwV1vaUGJIKAEDNSlSwi
         HRs+17v0/zRnu95YEcP5uNqptPyNnvlYxoo2RFLgwx5sZMJuvJBiTx5pPZDERr5t8PIi
         bsQHsOQOETYfr/r7Gd2E3LPYhSIAE+lR40LF6HspjWjJsDunSE29Z4wCsaP1zbVXkDsz
         XnUg==
X-Gm-Message-State: AOAM532ktXq6Vtel0lROWCPr4PpUYup1E+5fs0ywMt74pw8p2jXDZGNV
        S9JA2U7wjhGzCDxO4sAEsiHTVA==
X-Google-Smtp-Source: ABdhPJx7GWZaDHcnXn1i3ov34ALXy1EHh5jMhQYPSdtzUtu5jpP/ecukZb3UeFP0dVO5FD7/MCcz8A==
X-Received: by 2002:adf:82f5:: with SMTP id 108mr4670137wrc.269.1606406109770;
        Thu, 26 Nov 2020 07:55:09 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id d13sm10931063wrb.39.2020.11.26.07.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:55:08 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 20/23] kvm: arm64: Intercept host's CPU_SUSPEND PSCI SMCs
Date:   Thu, 26 Nov 2020 15:54:18 +0000
Message-Id: <20201126155421.14901-21-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a handler of CPU_SUSPEND host PSCI SMCs. The SMC can either enter
a sleep state indistinguishable from a WFI or a deeper sleep state that
behaves like a CPU_OFF+CPU_ON except that the core is still considered
online when asleep.

The handler saves r0,pc of the host and makes the same call to EL3 with
the hyp CPU entry point. It either returns back to the handler and then
back to the host, or wakes up into the entry point and initializes EL2
state before dropping back to EL1.

A core can only suspend itself but other cores can concurrently invoke
CPU_ON with this core as target. To avoid racing them for the same
boot args struct, CPU_SUSPEND uses a different struct instance and entry
point. Each entry point selects the corresponding struct to restore host
boot args from. This avoids the need for locking in CPU_SUSPEND.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-init.S   |  9 +++++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 50 +++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index ea71f653af55..fbb195851fb9 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -162,7 +162,15 @@ alternative_else_nop_endif
 	ret
 SYM_CODE_END(___kvm_hyp_init)
 
+SYM_CODE_START(__kvm_hyp_cpu_suspend_entry)
+	mov	x28, #0				// is_cpu_on = false
+	b	__kvm_hyp_cpu_common_entry
+SYM_CODE_END(__kvm_hyp_cpu_suspend_entry)
+
 SYM_CODE_START(__kvm_hyp_cpu_on_entry)
+	mov	x28, #1				// is_cpu_on = true
+
+SYM_INNER_LABEL(__kvm_hyp_cpu_common_entry, SYM_L_LOCAL)
 	msr	SPsel, #1			// We want to use SP_EL{1,2}
 
 	/* Check that the core was booted in EL2. */
@@ -188,6 +196,7 @@ SYM_CODE_START(__kvm_hyp_cpu_on_entry)
 	kimg_hyp_va x1, x2
 
 	/* Leave idmap. */
+	mov	x0, x28
 	br	x1
 SYM_CODE_END(__kvm_hyp_cpu_on_entry)
 
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index 39e507672e6e..592c11e9851c 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -17,6 +17,7 @@
 #include <nvhe/trap_handler.h>
 
 extern char __kvm_hyp_cpu_on_entry[];
+extern char __kvm_hyp_cpu_suspend_entry[];
 
 void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
 
@@ -39,6 +40,7 @@ struct cpu_boot_args {
 
 static DEFINE_PER_CPU(atomic_t, cpu_on_lock) = ATOMIC_INIT(0);
 static DEFINE_PER_CPU(struct cpu_boot_args, cpu_on_args);
+static DEFINE_PER_CPU(struct cpu_boot_args, cpu_suspend_args);
 
 static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
 {
@@ -112,6 +114,34 @@ static unsigned int find_cpu_id(u64 mpidr)
 	return INVALID_CPU_ID;
 }
 
+static int psci_cpu_suspend(u64 func_id, struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(u64, power_state, host_ctxt, 1);
+	DECLARE_REG(unsigned long, pc, host_ctxt, 2);
+	DECLARE_REG(unsigned long, r0, host_ctxt, 3);
+
+	struct cpu_boot_args *boot_args;
+	struct kvm_nvhe_init_params *init_params;
+
+	boot_args = this_cpu_ptr(hyp_symbol_addr(cpu_suspend_args));
+	init_params = this_cpu_ptr(hyp_symbol_addr(kvm_init_params));
+
+	/*
+	 * No need to acquire a lock before writing to boot_args because a core
+	 * can only suspend itself and the racy CPU_ON uses a separate struct.
+	 */
+
+	*boot_args = (struct cpu_boot_args){ .pc = pc, .r0 = r0 };
+
+	/*
+	 * Will either return if shallow sleep state, or wake up into the entry
+	 * point if it is a deep sleep state.
+	 */
+	return psci_call(func_id, power_state,
+			 __hyp_pa(hyp_symbol_addr(__kvm_hyp_cpu_suspend_entry)),
+			 __hyp_pa(init_params));
+}
+
 static __always_inline bool try_acquire_cpu_on_lock(atomic_t *l) {
 	return atomic_cmpxchg_acquire(l, CPU_UNLOCKED, CPU_LOCKED) == CPU_UNLOCKED;
 }
@@ -165,27 +195,35 @@ static int psci_cpu_on(u64 func_id, struct kvm_cpu_context *host_ctxt)
 	return ret;
 }
 
-asmlinkage void __noreturn __kvm_hyp_psci_cpu_entry(void)
+asmlinkage void __noreturn __kvm_hyp_psci_cpu_entry(bool is_cpu_on)
 {
 	atomic_t *lock;
 	struct cpu_boot_args *boot_args;
 	struct kvm_cpu_context *host_ctxt;
 
-	lock = this_cpu_ptr(hyp_symbol_addr(cpu_on_lock));
-	boot_args = this_cpu_ptr(hyp_symbol_addr(cpu_on_args));
+	if (is_cpu_on)
+		boot_args = this_cpu_ptr(hyp_symbol_addr(cpu_on_args));
+	else
+		boot_args = this_cpu_ptr(hyp_symbol_addr(cpu_suspend_args));
+
 	host_ctxt = &this_cpu_ptr(hyp_symbol_addr(kvm_host_data))->host_ctxt;
 
 	cpu_reg(host_ctxt, 0) = boot_args->r0;
 	write_sysreg_el2(boot_args->pc, SYS_ELR);
 
-	release_cpu_on_lock(lock);
+	if (is_cpu_on) {
+		lock = this_cpu_ptr(hyp_symbol_addr(cpu_on_lock));
+		release_cpu_on_lock(lock);
+	}
 
 	__host_enter(host_ctxt);
 }
 
 static unsigned long psci_0_1_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
 {
-	if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_OFF])
+	if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_SUSPEND])
+		return psci_cpu_suspend(func_id, host_ctxt);
+	else if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_OFF])
 		return psci_forward(host_ctxt);
 	else if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_ON])
 		return psci_cpu_on(func_id, host_ctxt);
@@ -209,6 +247,8 @@ static unsigned long psci_0_2_handler(u64 func_id, struct kvm_cpu_context *host_
 	case PSCI_0_2_FN_SYSTEM_RESET:
 		psci_forward_noreturn(host_ctxt);
 		unreachable();
+	case PSCI_0_2_FN64_CPU_SUSPEND:
+		return psci_cpu_suspend(func_id, host_ctxt);
 	case PSCI_0_2_FN64_CPU_ON:
 		return psci_cpu_on(func_id, host_ctxt);
 	default:
-- 
2.29.2.454.gaff20da3a2-goog

