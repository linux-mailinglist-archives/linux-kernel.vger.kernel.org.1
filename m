Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0738B2B5304
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbgKPUn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387727AbgKPUny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:54 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32121C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:54 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so20291932wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBVm/LArO1AVdRcZ+q3L0QCd8OGhOWzJGyI1ZWbTM+k=;
        b=jgslmvmt8eyl07t0cwWGpbSH4YO9VXaPfVOOgDE4ZLJZdfxC1arFjcoVmUcA8bERW2
         LpjgCO2IomJfdN5wcTNCxzu6/ACvAMfzfYR1xDcg4JV+U7+/rACINJhLTnv+gQRMMAR9
         RlXzbFg91geSG4d9QWPIcsQaZNBXxpYjN0bCuwZ5BV9hehTkUFB6WcQUXfoai6so36ba
         yMn6V4g6VBYFjP3+86GJBswJ3YdqydvCyHRKvrjkBRwNOxyFTnJ62T9rZXoOuF8STe5D
         QYSvT0l3RZ3uwSF/C8Z3t696VxTLaxi7R84OUo8LqD1GgrIT4HEgDr9/yqhcYuVXiZsA
         mBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBVm/LArO1AVdRcZ+q3L0QCd8OGhOWzJGyI1ZWbTM+k=;
        b=FIwt2I7oX7E81pB9PiGNcJYbKuXkeiSlBVdG/TglY/f8WgHv8RYyHARqML0ENy0Xgi
         W9b0/IZm4BreBwTi8HJZOmEU76STHpwF8Od1oSJuM9OrqNp3y26xA/6hEcXl7wsTFL9O
         awpAAFfhSrPG75rviMXZco2c+Vn5au/fckmdisaiB6e06zNSJwA79BCw2VRz3ArwA0IJ
         x+vx6B2FKALWjA98H7r2AelUSdigswJzK6sYgDMYlwd0V05tA+zbC3dnVslfbUY8Duwd
         s3DpNYdjUSl1k3Lf+fP+roOJ5+7T4ZkPcrSE9KV7FUs4M47SlXmxouq11RGDRCjofyG6
         tNnw==
X-Gm-Message-State: AOAM530zpr6ngDZo3jSVIcTh6fh5UpQox0sQkTT8G1Pgoa1XpnGpcGx0
        jBhNLgkDeIfH12Ci+IKmC18EkA==
X-Google-Smtp-Source: ABdhPJythO6pSCGfoIJ6apcHHCt92vwA+uoll4DlQLlq+cpg7CP8mgV1V4M4lg/fFUf6xY15WUHrSQ==
X-Received: by 2002:a5d:6688:: with SMTP id l8mr22511702wru.360.1605559432765;
        Mon, 16 Nov 2020 12:43:52 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id 60sm21908566wrs.69.2020.11.16.12.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:51 -0800 (PST)
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
Subject: [PATCH v2 14/24] kvm: arm64: Forward safe PSCI SMCs coming from host
Date:   Mon, 16 Nov 2020 20:43:08 +0000
Message-Id: <20201116204318.63987-15-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
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
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 43 +++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index 1583b63322c4..7542de8bd679 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -55,14 +55,51 @@ static bool is_psci_call(u64 func_id)
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
+	if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_OFF])
+		return psci_forward(host_ctxt);
+	else if (func_id == kvm_host_psci_function_id[PSCI_FN_MIGRATE])
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
@@ -71,6 +108,10 @@ static unsigned long psci_0_2_handler(u64 func_id, struct kvm_cpu_context *host_
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
2.29.2.299.gdc1121823c-goog

