Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3872C2A6CE5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbgKDShQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730946AbgKDShJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:37:09 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2EDC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:37:09 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c9so3346331wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9j0VMjjA6zCDdyx35vluqon5elvOXnResZEBXNSr1X0=;
        b=RUE++rKQXhZNCONaCTR19/HxXtVIIi3oRNevbUdThFpb7lSGOWgZt53CvjYIojGFXp
         bjoAX5PN9KRdcmvSZhoOooosMjRsjhO3yOCLuFsmXBnGqzHK6fNjiqbiboERhaoR7c65
         AMmH+DGH/eYH/7R0jg5d77ub+nd4XbwPgg1O4y2VRz3/Jr8HAi516eAnsOUKhoFimz+U
         Rygz++/YusK5YxpHxDmVPdIlb5tTRErFbiYlp8wV57FtQTu49uSxeIyuOdoBt1iNhtHe
         b+NAvqUVRGyEdVlL/l8GZB8iHlSVM8gpAPm9CXxsZbVe2yoe6fVtsZ6ddqmVgU3IIcVq
         w77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9j0VMjjA6zCDdyx35vluqon5elvOXnResZEBXNSr1X0=;
        b=cM4Dz07mQwsXNKussz+tGo7QeErZGvx2poYKIDMmy1O5U0XZgPLQUKICKAlPsbI3W5
         olR9XmisXJXOLuvTk7jEcV5YAFZn9i+MV5zbvZICqJklmpF6jkGUVRgursL8b0CoL07p
         bYf1BCPhQxy62h+tb/kfvoOuLsk/lQYQqswYWk9AvIA7yGfJyT6+o9q5iU3+ySiy3k7Z
         3VS7wqCD3oZEk/uJo34pyTx7X3k45nUeSHmulUE1LwA53t2+fDWHyZ9xBvqHUsZeoJYV
         bWBZck9OgsAD+4ly9hX2oc4K5xtPcIMFAtWiBMHsAfJj/ai9UHJRB6nM9uh2Lu5CmKJU
         64Ug==
X-Gm-Message-State: AOAM532BtxWTLsxqcYYC1HWNIje/qkYRhNvJIlj4qlmaNQC6fyA+4vb0
        Kut6WIiBBIWVhPfYK6UZzTNdyA==
X-Google-Smtp-Source: ABdhPJzlA4HqRs854B2x+X/0kGzJzOL2QkOaSVtVknIKK6zQbS8XLXIwWdn8f9VXnZzMY6cgY+W9ng==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr6056505wmk.32.1604515028016;
        Wed, 04 Nov 2020 10:37:08 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id 90sm3934768wrl.30.2020.11.04.10.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:37:06 -0800 (PST)
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
Subject: [RFC PATCH 14/26] kvm: arm64: Forward safe PSCI SMCs coming from host
Date:   Wed,  4 Nov 2020 18:36:18 +0000
Message-Id: <20201104183630.27513-15-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
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
 arch/arm64/kvm/hyp/nvhe/psci.c | 40 +++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c b/arch/arm64/kvm/hyp/nvhe/psci.c
index 82d3b2c89658..8f779560ab6f 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci.c
@@ -50,14 +50,48 @@ static bool is_psci_call(u64 func_id)
 		return is_psci_0_2_fn_call(func_id);
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
+	return psci_call(host_ctxt->regs.regs[0], host_ctxt->regs.regs[1],
+			 host_ctxt->regs.regs[2], host_ctxt->regs.regs[3]);
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
+	if (func_id == kvm_host_psci_function_id[PSCI_FN_MIGRATE])
+		return psci_forward(host_ctxt);
+	else
+		return PSCI_RET_NOT_SUPPORTED;
 }
 
 static unsigned long psci_0_2_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
 {
 	switch (func_id) {
+	case PSCI_0_2_FN_PSCI_VERSION:
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
@@ -72,6 +106,10 @@ static unsigned long psci_1_0_handler(u64 func_id, struct kvm_cpu_context *host_
 		return ret;
 
 	switch (func_id) {
+	case PSCI_1_0_FN_PSCI_FEATURES:
+	case PSCI_1_0_FN_SET_SUSPEND_MODE:
+	case PSCI_1_1_FN64_SYSTEM_RESET2:
+		return psci_forward(host_ctxt);
 	default:
 		return PSCI_RET_NOT_SUPPORTED;
 	}
-- 
2.29.1.341.ge80a0c044ae-goog

