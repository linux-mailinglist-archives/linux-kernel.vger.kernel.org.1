Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE102AB6FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgKILde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729650AbgKILdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:23 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FEFC0613D4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:33:22 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h62so7598648wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NS+1ZuglZo9Zn7yUnAclLe5esR1R1/5yk9FHSFQ7d8k=;
        b=q9g/yH0WIaLvx219DqcXDw1PkbjnU9PKjXT0aixjKFwDfVrboe09k14qFs5wzeSKNF
         jz414gJie7cGqI6l1RvEB3fXslz27Oht8VEEZXRaVSWglOGKUTV41SgHoKBSRvdEnW4h
         fPWQ2mIpmCCFyeMkXcBodWBvtonybukFkMho8gtFiz2xo6Yh2v0wNIqODsV1Bd90W+V6
         qJFDd3M2lmQC6Q8J9RJ6UNKXZ51/wOhOyXnoOAgBEpp1F/ciYNUFSuwpZETWHgIy4vbe
         gqowPqSa+VdGf44IWcD9TzZ9HOW6Oy9XZsuOdaLKHChTP7J75C7a+tVq7gn6DgFmOQDQ
         T0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NS+1ZuglZo9Zn7yUnAclLe5esR1R1/5yk9FHSFQ7d8k=;
        b=ZyhAVlfJz3jXES2xjdPT5VVKysExZCTS/9qlbmes9LJRXp9Q2+PiXuMWpH02UpPkeM
         M97XsyUov6JTyK8LNn2jRxp/HGRT9+86pahOkeA0G4P+p+FfgYmJDJNitmEaVnsCUhEw
         1XQiBocGkCXZH8cDAa+KiBPjKx817GnT/fqGmsUfEZ/JJ9laus3u2XqOoc8+qEsdm+4n
         Y5Gm81XwYFf3XWELQJl4J/vUOTKO1OKoLO8SKLv4JzMO3DFtCmczry2YoMSNSmdXJw+m
         pqc4RGWvrTsz0HIkNUhp64y4Ql5Pi8Nx4dAc2pI4DOewUuDA4lIvJhm3mfKWvPENlWOV
         kCFQ==
X-Gm-Message-State: AOAM531nbIj0Pxw0jBl82bTYdDNxD+QLVJBT1k1GrIrKHPCYoRCejhdg
        pFT5rYLk5a/XxEyY0cYr9949CktOBW60Usic
X-Google-Smtp-Source: ABdhPJw+z6E2az4tGXEKJ+aoSJh6Li+u4guKF5JI2ND/5xzgqTGZfkNsdEo5CHTN+G3OtJpOjMODLA==
X-Received: by 2002:a1c:6456:: with SMTP id y83mr14727428wmb.59.1604921600616;
        Mon, 09 Nov 2020 03:33:20 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id n128sm5063892wmb.46.2020.11.09.03.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:33:19 -0800 (PST)
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
Subject: [PATCH v1 20/24] kvm: arm64: Intercept host's CPU_SUSPEND PSCI SMCs
Date:   Mon,  9 Nov 2020 11:32:29 +0000
Message-Id: <20201109113233.9012-21-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
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
 arch/arm64/kvm/hyp/nvhe/psci.c | 39 +++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c b/arch/arm64/kvm/hyp/nvhe/psci.c
index f9b82a87bf44..ec00036a1613 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci.c
@@ -127,6 +127,39 @@ static void release_reset_state(struct kvm_host_psci_state *cpu_state)
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
+			__hyp_pa_symbol(__kvm_hyp_cpu_entry),
+			__hyp_pa(cpu_params));
+
+	release_reset_state(cpu_state);
+	return ret;
+}
+
 static int psci_cpu_on(u64 func_id, struct kvm_cpu_context *host_ctxt)
 {
 	u64 mpidr = host_ctxt->regs.regs[1];
@@ -180,7 +213,9 @@ asmlinkage void __noreturn kvm_host_psci_cpu_entry(void)
 
 static unsigned long psci_0_1_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
 {
-	if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_OFF])
+	if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_SUSPEND])
+		return psci_cpu_suspend(func_id, host_ctxt);
+	else if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_OFF])
 		return psci_forward(host_ctxt);
 	else if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_ON])
 		return psci_cpu_on(func_id, host_ctxt);
@@ -204,6 +239,8 @@ static unsigned long psci_0_2_handler(u64 func_id, struct kvm_cpu_context *host_
 	case PSCI_0_2_FN_SYSTEM_RESET:
 		psci_forward_noreturn(host_ctxt);
 		unreachable();
+	case PSCI_0_2_FN64_CPU_SUSPEND:
+		return psci_cpu_suspend(func_id, host_ctxt);
 	case PSCI_0_2_FN64_CPU_ON:
 		return psci_cpu_on(func_id, host_ctxt);
 	default:
-- 
2.29.2.222.g5d2a92d10f8-goog

