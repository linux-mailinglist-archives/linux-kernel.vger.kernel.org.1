Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69AD2B530A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbgKPUoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387926AbgKPUoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:44:08 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFACCC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:06 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p22so594127wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wD+a3FpezM46vtDRvUYZ5HtVvRxQTV1ZGJA/wg4Ex98=;
        b=CePHDUN1veATU5Fbosl/2glcCRr5WzC8phqSaumNvMV+29qseMvtZ5AYULHe86VL0Y
         Fl0rKdltr3pyBfvDMv2DYbtiug1MoFDP0prQEQ8QkT6PbcqArN6MEiHuSA3PxAxCk7IY
         URLQBAJTWMpZJ1b72mXGCIC5AicuMS45rYFWJQuTvwx26dLIvMvieTi/iK/y+VGo+a03
         cbD5e/0T+nHVCXYB+UkwBwooP+59t6Xv3IvoPW5qLJMcW6BcLhslZAIzfLgjirBkAjGz
         dW4LjnXf2FVaT6dljBPU4tSL0J8oSTM4rgT+xYCiRsYqLo6+tciGHlUB1LqJbaHGdTE0
         +A1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wD+a3FpezM46vtDRvUYZ5HtVvRxQTV1ZGJA/wg4Ex98=;
        b=Y6ge3pvITwi7zOSqlam+Wq1GNdQPyEfIHjZWk0ehx+u+tsXdxZpxyxeM6s5RVAeJDC
         NM+AruoCISTfJYx1aCNTTsCAx/1ErVZXqUdP1uCxMHOP60LY0l3/dgUn5xbX1yIG1oH/
         7AtAP4BO+xswGd57VhjP7YlejJPoSek1g46QhvSHr/qQV12Mc77+HIgVZZZN3t+2TZX4
         on4/BKX7LZL8o5K+3J3CHY1NSWsFBqENCuGr0sWB/pOB2idInhOmWjBiKN810EtNw08w
         gWt8aPimg7hfC7YVYtN+o2nJFv2Aixsh6/r0Mks1j6eWaBSv7U9Tl3LrDsHzP1LbI89X
         uVHw==
X-Gm-Message-State: AOAM53288QKVlWNs0P3Ks+cahx6+w1xe/MMfYsakuxqPrGHUNq1ySpw9
        3wGy3a3AbEhQaIy9WWiyaS9a6w==
X-Google-Smtp-Source: ABdhPJzetTRH/cFVZbrbGHGqSRHTJfKqrhpUhK6CneVfklDTfCbBbV/l/O0oOWso6KYVg8ahVpsLgQ==
X-Received: by 2002:a05:600c:4147:: with SMTP id h7mr713498wmm.186.1605559445403;
        Mon, 16 Nov 2020 12:44:05 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id t5sm565383wmg.19.2020.11.16.12.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:44:04 -0800 (PST)
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
Subject: [PATCH v2 20/24] kvm: arm64: Intercept host's CPU_SUSPEND PSCI SMCs
Date:   Mon, 16 Nov 2020 20:43:14 +0000
Message-Id: <20201116204318.63987-21-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a handler of CPU_SUSPEND host PSCI SMCs. The SMC can either enter
a sleep state indistinguishable from a WFI or a deeper sleep state that
behaves like a CPU_OFF+CPU_ON.

The handler saves r0,pc of the host and makes the same call to EL3 with
the hyp CPU entry point. It either returns back to the handler and then
back to the host, or wakes up into the entry point and initializes EL2
state before dropping back to EL1.

There is a simple atomic lock around the reset state struct to protect
from races with CPU_ON. A well-behaved host should never run CPU_ON
against an already online core, and the kernel indeed does not allow
that, so if the core sees its reset state struct locked, it will return
a non-spec error code PENDING_ON. This protects the hypervisor state and
avoids the need for more complicated locking and/or tracking power state
of individual cores.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 39 +++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index 2daf52b59846..313ef42f0eab 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -121,6 +121,39 @@ static void release_reset_state(struct kvm_host_psci_state *cpu_state)
 	atomic_set_release(&cpu_state->pending_on, 0);
 }
 
+static int psci_cpu_suspend(u64 func_id, struct kvm_cpu_context *host_ctxt)
+{
+	u64 power_state = host_ctxt->regs.regs[1];
+	unsigned long pc = host_ctxt->regs.regs[2];
+	unsigned long r0 = host_ctxt->regs.regs[3];
+	struct kvm_host_psci_state *cpu_state;
+	struct kvm_nvhe_init_params *cpu_params;
+	int ret;
+
+	cpu_state = this_cpu_ptr(&kvm_host_psci_state);
+	cpu_params = this_cpu_ptr(&kvm_init_params);
+
+	/*
+	 * Lock the reset state struct. This fails if the host has concurrently
+	 * called CPU_ON with this CPU as target. The kernel keeps track of
+	 * online CPUs, so that should never happen. If it does anyway, return
+	 * a non-spec error. This avoids the need for spinlocks.
+	 */
+	if (!try_acquire_reset_state(cpu_state, pc, r0))
+		return PSCI_RET_ALREADY_ON;
+
+	/*
+	 * Will either return if shallow sleep state, or wake up into the entry
+	 * point if it is a deep sleep state.
+	 */
+	ret = psci_call(func_id, power_state,
+			__hyp_pa(hyp_symbol_addr(__kvm_hyp_cpu_entry)),
+			__hyp_pa(cpu_params));
+
+	release_reset_state(cpu_state);
+	return ret;
+}
+
 static int psci_cpu_on(u64 func_id, struct kvm_cpu_context *host_ctxt)
 {
 	u64 mpidr = host_ctxt->regs.regs[1];
@@ -178,7 +211,9 @@ asmlinkage void __noreturn __kvm_hyp_psci_cpu_entry(void)
 
 static unsigned long psci_0_1_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
 {
-	if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_OFF])
+	if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_SUSPEND])
+		return psci_cpu_suspend(func_id, host_ctxt);
+	else if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_OFF])
 		return psci_forward(host_ctxt);
 	else if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_ON])
 		return psci_cpu_on(func_id, host_ctxt);
@@ -202,6 +237,8 @@ static unsigned long psci_0_2_handler(u64 func_id, struct kvm_cpu_context *host_
 	case PSCI_0_2_FN_SYSTEM_RESET:
 		psci_forward_noreturn(host_ctxt);
 		unreachable();
+	case PSCI_0_2_FN64_CPU_SUSPEND:
+		return psci_cpu_suspend(func_id, host_ctxt);
 	case PSCI_0_2_FN64_CPU_ON:
 		return psci_cpu_on(func_id, host_ctxt);
 	default:
-- 
2.29.2.299.gdc1121823c-goog

