Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0762CC59B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389531AbgLBSnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389481AbgLBSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:43:19 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EDEC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:42:09 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so11092122wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qcfRU1YbBQ04ItAE6mdwMxjNOIhFl6zoGdtG5ZWWz6Y=;
        b=FHW7OMVvnhhhri9l5Ifx4Rrqhfsw/iXEfWL3Xv//E79ZdV/UcgaVz/W0r2HYbZvqeY
         y2QPeIachgJaHG+rwCcgMXEco0yfQx0/re+sBTjr6jN3QPx9IhOX1g2yZimUEhTvMoB/
         YR/6959KrrBVEVUmE+JaqtY45Jz6vNkVJSyz3+1p5vk6xN23TYB9XpSQ6p2AiooWt88K
         LQ7b0Wm6T9rpwnxpjLpJSDo0mx7Ar0oSQOh22fxFpxsurRK+osX4w8raIkJoQ8iQkpKP
         91ESox4eJ95E+WzqyGdvdpGOKHRFxTm9LL8IJqFyGSLj03VMBv6+sx3rJ2bd1jSyLpuW
         stLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qcfRU1YbBQ04ItAE6mdwMxjNOIhFl6zoGdtG5ZWWz6Y=;
        b=c4J3B4X7g7xdPDocmVMjJddKJzJwXfCGHTG97nOIIg3sCDXiFvVDxBa7Ykh5FfAbxN
         REUHDJCMbEaiau6XF8hLFO69Pa3mROG1Jax1D7ZhMJThu+IdagTmkPEUzyWDAJyavDsd
         3UFm4Aq7hJvmbET3LugmDgPxHSPONndoC24DmPYzLTuSasY7BBtSakqGzX2Y9yuunvyu
         QW/t99IUk33TJE8UMl4+EIxVDo/GP4qKSUdApTs716Lwkg6MnBhKkNHj6LOKdlclciqi
         yO7f1dnZ05RYMM6GLtq7RRdymZVBwwFbnvkHh/Bmxairm37rWr1w1CclNLW/WaXwoj2W
         iX/w==
X-Gm-Message-State: AOAM530tSbSOD+NG5WrzpZdgMpNV0YBXNrId6VzyF3VtcUJ4ozZqb2OZ
        65+8Mz3Z3TlufKh1CeNAKngnIw==
X-Google-Smtp-Source: ABdhPJz/Y9ERJYjarEvm1qv0CECj56Dlnsv6FCiSdtWlW6kjM8WK1TRApQh5Lukq91apWPC5bp6dJg==
X-Received: by 2002:a1c:bd87:: with SMTP id n129mr4533586wmf.32.1606934527867;
        Wed, 02 Dec 2020 10:42:07 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id n128sm3160473wmb.46.2020.12.02.10.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:42:06 -0800 (PST)
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
Subject: [PATCH v4 18/26] kvm: arm64: Forward safe PSCI SMCs coming from host
Date:   Wed,  2 Dec 2020 18:41:14 +0000
Message-Id: <20201202184122.26046-19-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forward the following PSCI SMCs issued by host to EL3 as they do not
require the hypervisor's intervention. This assumes that EL3 correctly
implements the PSCI specification.

Only function IDs implemented in Linux are included.

Where both 32-bit and 64-bit variants exist, it is assumed that the host
will always use the 64-bit variant.

 * SMCs that only return information about the system
   * PSCI_VERSION        - PSCI version implemented by EL3
   * PSCI_FEATURES       - optional features supported by EL3
   * AFFINITY_INFO       - power state of core/cluster
   * MIGRATE_INFO_TYPE   - whether Trusted OS can be migrated
   * MIGRATE_INFO_UP_CPU - resident core of Trusted OS
 * operations which do not affect the hypervisor
   * MIGRATE             - migrate Trusted OS to a different core
   * SET_SUSPEND_MODE    - toggle OS-initiated mode
 * system shutdown/reset
   * SYSTEM_OFF
   * SYSTEM_RESET
   * SYSTEM_RESET2

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 42 +++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index 70b42f433449..5ad56a875ffa 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -54,14 +54,50 @@ static bool is_psci_call(u64 func_id)
 	}
 }
 
+static unsigned long psci_call(unsigned long fn, unsigned long arg0,
+			       unsigned long arg1, unsigned long arg2)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_smc(fn, arg0, arg1, arg2, &res);
+	return res.a0;
+}
+
+static unsigned long psci_forward(struct kvm_cpu_context *host_ctxt)
+{
+	return psci_call(cpu_reg(host_ctxt, 0), cpu_reg(host_ctxt, 1),
+			 cpu_reg(host_ctxt, 2), cpu_reg(host_ctxt, 3));
+}
+
+static __noreturn unsigned long psci_forward_noreturn(struct kvm_cpu_context *host_ctxt)
+{
+	psci_forward(host_ctxt);
+	hyp_panic(); /* unreachable */
+}
+
 static unsigned long psci_0_1_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
 {
-	return PSCI_RET_NOT_SUPPORTED;
+	if ((func_id == kvm_host_psci_0_1_function_ids.cpu_off) ||
+	    (func_id == kvm_host_psci_0_1_function_ids.migrate))
+		return psci_forward(host_ctxt);
+	else
+		return PSCI_RET_NOT_SUPPORTED;
 }
 
 static unsigned long psci_0_2_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
 {
 	switch (func_id) {
+	case PSCI_0_2_FN_PSCI_VERSION:
+	case PSCI_0_2_FN_CPU_OFF:
+	case PSCI_0_2_FN64_AFFINITY_INFO:
+	case PSCI_0_2_FN64_MIGRATE:
+	case PSCI_0_2_FN_MIGRATE_INFO_TYPE:
+	case PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
+		return psci_forward(host_ctxt);
+	case PSCI_0_2_FN_SYSTEM_OFF:
+	case PSCI_0_2_FN_SYSTEM_RESET:
+		psci_forward_noreturn(host_ctxt);
+		unreachable();
 	default:
 		return PSCI_RET_NOT_SUPPORTED;
 	}
@@ -70,6 +106,10 @@ static unsigned long psci_0_2_handler(u64 func_id, struct kvm_cpu_context *host_
 static unsigned long psci_1_0_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
 {
 	switch (func_id) {
+	case PSCI_1_0_FN_PSCI_FEATURES:
+	case PSCI_1_0_FN_SET_SUSPEND_MODE:
+	case PSCI_1_1_FN64_SYSTEM_RESET2:
+		return psci_forward(host_ctxt);
 	default:
 		return psci_0_2_handler(func_id, host_ctxt);
 	}
-- 
2.29.2.454.gaff20da3a2-goog

