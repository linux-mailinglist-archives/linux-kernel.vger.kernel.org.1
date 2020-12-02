Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B032CC5B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389653AbgLBSns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389593AbgLBSng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:43:36 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7930FC09424F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:42:18 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t4so5092648wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b4YL0IBplg+FWHBi8Rr0BRJAelmSAxlpGLG7LH6PvWI=;
        b=BhcEbJ1P8iLmvnw20r8Tmdyd3uTKIEEEWanAgbopFJTNFw5yNcdQvwTUNvQm2zbtm3
         MHgBmJr0AE5W0c6JE2xddQ5i5ab1IfU2BwArNg5njgUUrd/uVHEJKFvpIbGcawzT26rf
         x+PeIZ9V3lFFr9yp1DAwWrivqSPjV1AOPu1JJRL40OkApYw9bcUpUTCI8+LkMHe1yJ6Q
         L738ogFUJ+t8T4nMrKyXSyNTeghbSuBY23Glw9aJOAi6yklPu/qHPdvV0uiP93uNIwQ/
         8DzpeG2eJs3gxU2aNMJgi5QCywuwe+XzPUdRlq3G0kodHjpRG1cLVuBOQHoTcHxX80C5
         daBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b4YL0IBplg+FWHBi8Rr0BRJAelmSAxlpGLG7LH6PvWI=;
        b=LFxdIMg1WUuV+xKqkB5G0nrZS2CwX1E6FgDz1g0qgxVHs7SXgBzLy8VLxKZew8j/gs
         d0pLiIV8XtFUetg5t7A3UOAlDqJ6JSSUSjQOhRIy8rMKaWf9jz0LvaogXtEQTNncjFX+
         Vyqy1pEWldvV92YK6sUJ4o2ez1Nly1Fav0EZArv0tQN5ZBqHX5NJ9uMw2f7rRi/HslhY
         uaDiPRz0TipJ+/Bfj+3B4s15fYXmMElIXCvGSt1g75OadoBY9wMii5gxYIch2GhzJTTu
         e29wEK+jD33y+ukeAtUHaEKdsK5hDJJWQjMU3lGJfVgR56U9MMbVHT5+oZhaHEql7HMZ
         5PwA==
X-Gm-Message-State: AOAM532v7g1bPNNuozLsBihLuWZBGF66Xex3gag7BTDxK6a/hz9qeyKQ
        gesqoo82wQszBu1o4jNr7Og3ag==
X-Google-Smtp-Source: ABdhPJwz6THFS1yYmKpqoEbi0AmdVm+ctA2YRt55ZaPapRgb33xR8DwkQTqRsJm5wJLFpq5eL/rKSg==
X-Received: by 2002:adf:f102:: with SMTP id r2mr5065973wro.315.1606934537044;
        Wed, 02 Dec 2020 10:42:17 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id s133sm3086045wmf.38.2020.12.02.10.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:42:15 -0800 (PST)
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
Subject: [PATCH v4 22/26] kvm: arm64: Intercept host's CPU_SUSPEND PSCI SMCs
Date:   Wed,  2 Dec 2020 18:41:18 +0000
Message-Id: <20201202184122.26046-23-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a handler of CPU_SUSPEND host PSCI SMCs. The SMC can either enter
a sleep state indistinguishable from a WFI or a deeper sleep state that
behaves like a CPU_OFF+CPU_ON except that the core is still considered
online while asleep.

The handler saves r0,pc of the host and makes the same call to EL3 with
the hyp CPU entry point. It either returns back to the handler and then
back to the host, or wakes up into the entry point and initializes EL2
state before dropping back to EL1. No EL2 state needs to be
saved/restored for this purpose.

CPU_ON and CPU_SUSPEND are both implemented using struct psci_boot_args
to store the state upon powerup, with each CPU having separate structs
for CPU_ON and CPU_SUSPEND so that CPU_SUSPEND can operate locklessly
and so that a CPU_ON call targeting a CPU cannot interfere with
a concurrent CPU_SUSPEND call on that CPU.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-init.S   | 10 +++++++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 44 ++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index d07e75f8242e..0853f62b052b 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -150,6 +150,16 @@ SYM_CODE_START(kvm_hyp_cpu_entry)
 	b	__kvm_hyp_init_cpu
 SYM_CODE_END(kvm_hyp_cpu_entry)
 
+/*
+ * PSCI CPU_SUSPEND entry point
+ *
+ * x0: struct kvm_nvhe_init_params PA
+ */
+SYM_CODE_START(kvm_hyp_cpu_resume)
+	mov	x1, #0				// is_cpu_on = false
+	b	__kvm_hyp_init_cpu
+SYM_CODE_END(kvm_hyp_cpu_resume)
+
 /*
  * Common code for CPU entry points. Initializes EL2 state and
  * installs the hypervisor before handing over to a C handler.
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index 637e22ed71fc..688cf7f40d42 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -17,6 +17,7 @@
 #include <nvhe/trap_handler.h>
 
 void kvm_hyp_cpu_entry(unsigned long r0);
+void kvm_hyp_cpu_resume(unsigned long r0);
 
 void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
 
@@ -44,6 +45,7 @@ struct psci_boot_args {
 	})
 
 static DEFINE_PER_CPU(struct psci_boot_args, cpu_on_args) = PSCI_BOOT_ARGS_INIT;
+static DEFINE_PER_CPU(struct psci_boot_args, suspend_args) = PSCI_BOOT_ARGS_INIT;
 
 static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
 {
@@ -171,17 +173,51 @@ static int psci_cpu_on(u64 func_id, struct kvm_cpu_context *host_ctxt)
 	return ret;
 }
 
+static int psci_cpu_suspend(u64 func_id, struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(u64, power_state, host_ctxt, 1);
+	DECLARE_REG(unsigned long, pc, host_ctxt, 2);
+	DECLARE_REG(unsigned long, r0, host_ctxt, 3);
+
+	struct psci_boot_args *boot_args;
+	struct kvm_nvhe_init_params *init_params;
+
+	boot_args = this_cpu_ptr(hyp_symbol_addr(suspend_args));
+	init_params = this_cpu_ptr(hyp_symbol_addr(kvm_init_params));
+
+	/*
+	 * No need to acquire a lock before writing to boot_args because a core
+	 * can only suspend itself. Racy CPU_ON calls use a separate struct.
+	 */
+	boot_args->pc = pc;
+	boot_args->r0 = r0;
+
+	/*
+	 * Will either return if shallow sleep state, or wake up into the entry
+	 * point if it is a deep sleep state.
+	 */
+	return psci_call(func_id, power_state,
+			 __hyp_pa(hyp_symbol_addr(kvm_hyp_cpu_resume)),
+			 __hyp_pa(init_params));
+}
+
 asmlinkage void __noreturn kvm_host_psci_cpu_entry(bool is_cpu_on)
 {
 	struct psci_boot_args *boot_args;
 	struct kvm_cpu_context *host_ctxt;
 
 	host_ctxt = &this_cpu_ptr(hyp_symbol_addr(kvm_host_data))->host_ctxt;
-	boot_args = this_cpu_ptr(hyp_symbol_addr(cpu_on_args));
+
+	if (is_cpu_on)
+		boot_args = this_cpu_ptr(hyp_symbol_addr(cpu_on_args));
+	else
+		boot_args = this_cpu_ptr(hyp_symbol_addr(suspend_args));
 
 	cpu_reg(host_ctxt, 0) = boot_args->r0;
 	write_sysreg_el2(boot_args->pc, SYS_ELR);
-	release_boot_args(boot_args);
+
+	if (is_cpu_on)
+		release_boot_args(boot_args);
 
 	__host_enter(host_ctxt);
 }
@@ -193,6 +229,8 @@ static unsigned long psci_0_1_handler(u64 func_id, struct kvm_cpu_context *host_
 		return psci_forward(host_ctxt);
 	else if (func_id == kvm_host_psci_0_1_function_ids.cpu_on)
 		return psci_cpu_on(func_id, host_ctxt);
+	else if (func_id == kvm_host_psci_0_1_function_ids.cpu_suspend)
+		return psci_cpu_suspend(func_id, host_ctxt);
 	else
 		return PSCI_RET_NOT_SUPPORTED;
 }
@@ -211,6 +249,8 @@ static unsigned long psci_0_2_handler(u64 func_id, struct kvm_cpu_context *host_
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

