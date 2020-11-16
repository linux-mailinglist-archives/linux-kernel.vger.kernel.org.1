Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF92B52FE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbgKPUnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733259AbgKPUnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:41 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E282C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:41 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so593334wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhNNUDRNWLolF9X/BNiqAa9sQtbg1yNfQgpeLP8CpL8=;
        b=AjQCgpzwB7upMi2bhD5FEdm5oBzMrdG1EqiZA29adsCIyhJ5kg2kBmwLY9kTrIU5Y9
         Cvskk/ELHGvgyg0p3Z81q1cUnW6e5owkv8bTXqRXAdakh3ydKT4uyUIZlbKYq988lYVb
         4e+T3m4CKr7dHF0Z0mGi2QceuVtfQ0eezmaW3ww4QSXAcg6JsFBSRes4WJCKwimfbrxT
         thYGudU6wwJ3Mi/6ymuWAFcM7/xBWSR/sUmtHzlTDWEgG9mH1H+Xr6UFV6cnRBy1DrIY
         bJWgfAVKFE2Y4i9x+qzdKpj/it9JPSW1/wYkZ3LfTSq4DYrWec5bLCtVLqJ5tNqcjWwq
         oImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhNNUDRNWLolF9X/BNiqAa9sQtbg1yNfQgpeLP8CpL8=;
        b=reMd14kF09ytALN7E2D2DU2hODp5X4OoAo3CUhFnHBU3P23kYZhiAu63UO8c8MKMA2
         hKl4O9sVpmrNsfFkku2lSzK+DXa6X0ZhMvhiKAkmbqY2gzSc5SBZfPItxjQvO5Iv+60e
         R4scjUWkuD/Pqs17f8+vEH1hkY7BrCd/XyI6wu+cwMW7qf5w6Qt9HGycTXLq/mOcbTwy
         z8IyOCMZjn4Lrp8/PNCim3+5NtDyVbQXxu+D6IIFhMn8h/zilQUWEPuALLEDfpNH638j
         WqWF2OeyEpsVArzwmEPpaJEch9YKZycm1CcJmd10Q0UDdjmdzJhgZ48E1Mazd3efo+8+
         bkdw==
X-Gm-Message-State: AOAM532AguBFAd3X0Ypb9uDsjLVPuRnhYuwQZKj91qCdGSKtF1vTVMOk
        nY5v1BWQ1cjauRER0N1JRqblFA==
X-Google-Smtp-Source: ABdhPJx/ACVuZVlLM8jprNldFukYuBbBqcWgl8oJWqwhavCewWZd3bKxh25HsPT4zSX+nPVpBpe87g==
X-Received: by 2002:a1c:e442:: with SMTP id b63mr790926wmh.10.1605559420043;
        Mon, 16 Nov 2020 12:43:40 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id b14sm24646282wrx.35.2020.11.16.12.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:39 -0800 (PST)
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
Subject: [PATCH v2 08/24] kvm: arm64: Add SMC handler in nVHE EL2
Date:   Mon, 16 Nov 2020 20:43:02 +0000
Message-Id: <20201116204318.63987-9-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add handler of host SMCs in KVM nVHE trap handler. Forward all SMCs to
EL3 and propagate the result back to EL1. This is done in preparation
for validating host SMCs in KVM nVHE protected mode.

The implementation assumes that firmware uses SMCCC v1.2 or older. That
means x0-x17 can be used both for arguments and results, other GPRs are
preserved.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/host.S     | 38 ++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 26 ++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index ed27f06a31ba..52dae5cd5a28 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -183,3 +183,41 @@ SYM_CODE_START(__kvm_hyp_host_vector)
 	invalid_host_el1_vect			// FIQ 32-bit EL1
 	invalid_host_el1_vect			// Error 32-bit EL1
 SYM_CODE_END(__kvm_hyp_host_vector)
+
+/*
+ * Forward SMC with arguments in struct kvm_cpu_context, and
+ * store the result into the same struct. Assumes SMCCC 1.2 or older.
+ *
+ * x0: struct kvm_cpu_context*
+ */
+SYM_CODE_START(__kvm_hyp_host_forward_smc)
+	/*
+	 * Use x18 to keep a pointer to the host context because x18
+	 * is callee-saved SMCCC but not in AAPCS64.
+	 */
+	mov	x18, x0
+
+	ldp	x0, x1,   [x18, #CPU_XREG_OFFSET(0)]
+	ldp	x2, x3,   [x18, #CPU_XREG_OFFSET(2)]
+	ldp	x4, x5,   [x18, #CPU_XREG_OFFSET(4)]
+	ldp	x6, x7,   [x18, #CPU_XREG_OFFSET(6)]
+	ldp	x8, x9,   [x18, #CPU_XREG_OFFSET(8)]
+	ldp	x10, x11, [x18, #CPU_XREG_OFFSET(10)]
+	ldp	x12, x13, [x18, #CPU_XREG_OFFSET(12)]
+	ldp	x14, x15, [x18, #CPU_XREG_OFFSET(14)]
+	ldp	x16, x17, [x18, #CPU_XREG_OFFSET(16)]
+
+	smc	#0
+
+	stp	x0, x1,   [x18, #CPU_XREG_OFFSET(0)]
+	stp	x2, x3,   [x18, #CPU_XREG_OFFSET(2)]
+	stp	x4, x5,   [x18, #CPU_XREG_OFFSET(4)]
+	stp	x6, x7,   [x18, #CPU_XREG_OFFSET(6)]
+	stp	x8, x9,   [x18, #CPU_XREG_OFFSET(8)]
+	stp	x10, x11, [x18, #CPU_XREG_OFFSET(10)]
+	stp	x12, x13, [x18, #CPU_XREG_OFFSET(12)]
+	stp	x14, x15, [x18, #CPU_XREG_OFFSET(14)]
+	stp	x16, x17, [x18, #CPU_XREG_OFFSET(16)]
+
+	ret
+SYM_CODE_END(__kvm_hyp_host_forward_smc)
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 19332c20fcde..71a17af05953 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -16,6 +16,8 @@
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
+extern void __kvm_hyp_host_forward_smc(struct kvm_cpu_context *host_ctxt);
+
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
 {
 	unsigned long func_id = host_ctxt->regs.regs[0];
@@ -106,6 +108,27 @@ static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
 	host_ctxt->regs.regs[1] = ret;
 }
 
+static void default_host_smc_handler(struct kvm_cpu_context *host_ctxt)
+{
+	__kvm_hyp_host_forward_smc(host_ctxt);
+}
+
+static void skip_host_instruction(void)
+{
+	write_sysreg_el2(read_sysreg_el2(SYS_ELR) + 4, SYS_ELR);
+}
+
+static void handle_host_smc(struct kvm_cpu_context *host_ctxt)
+{
+	default_host_smc_handler(host_ctxt);
+
+	/*
+	 * Unlike HVC, the return address of an SMC is the instruction's PC.
+	 * Move the return address past the instruction.
+	 */
+	skip_host_instruction();
+}
+
 void handle_trap(struct kvm_cpu_context *host_ctxt)
 {
 	u64 esr = read_sysreg_el2(SYS_ESR);
@@ -114,6 +137,9 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 	case ESR_ELx_EC_HVC64:
 		handle_host_hcall(host_ctxt);
 		break;
+	case ESR_ELx_EC_SMC64:
+		handle_host_smc(host_ctxt);
+		break;
 	default:
 		hyp_panic();
 	}
-- 
2.29.2.299.gdc1121823c-goog

