Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABEC2AB738
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgKILgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbgKILdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:18 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09B4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:33:17 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so7643988wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=STxT3I0oev0DTBptKuUq67e2wlovKGTClvKfrgZni/w=;
        b=NGM9T7CgfmsasqmbWaORXlR/xBoFk5aIVmGIzm/UQUh9KDC2NVnsXrzyALlYGiluq8
         GJgsNYDUOrP5L4fORcs8BdEIG+XBni3PtySqYnhjWsUPd4AvX+Y953HDbf1nsu261T88
         oXHv9mrV7U9q9w9sAcyCrHQsjIqCmhjXWjCzHgesmo1+PF4JxxIFaOeWSDOZvBJ89grs
         XoV6ePNuO77GLT2ml6GBIr4UIKtXyvvVJk0Gz86ScJn1KCXSMqOUx4LOCkqDWVqqVFjq
         KQAjw/Eyc7XiFLROohIV3JrVJSDETxRfdgdyGay/7tMMS7RRK+oMQAH5l4bWw/pR+5/w
         VyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STxT3I0oev0DTBptKuUq67e2wlovKGTClvKfrgZni/w=;
        b=PmcQVV2QTN5Oub1dj0r/30oA8bODFhxCJjk/b6ONAk4PT+kmYPipyT4teg/2l+PrAr
         1oyQOCUr173TQ1IJG29d9Dmf+jqqBpVIG+3qA+b88tij3l31xw28fMECrZlBQPaHj8GB
         cPXMLqnaono6JCiDrMQ2kLnMbG8FukrinuSdgCLIfoxI9r3YrohsSF14JrH7c3nmEnVk
         Tf0d3p0DxDdrwMJKhgV7BfJuX4uA4O44XndzEUzV0fNYET73NZ8Y/n+A/atKFDaKMV5s
         eIA4cLEKhZxbxHcPz6aMgrBuQwZCp7Xfu9tZsreqMCKCaN7L4JZMxFlgS2x8aDQMj/SD
         tHAA==
X-Gm-Message-State: AOAM53171W47jCd5yh0j7ZThEe9vROIhuh3vGJrkuUNNKcb2NG8ME+GG
        Vs87Viig4NNfSmDpmfUEL7qCseXOUBQNEu5g
X-Google-Smtp-Source: ABdhPJxqqBns67atj2fda4ruhApA8uhNwaLMzwBAgerwaILtvzmidmLAUfyEIiuw6wHIFXtvfZHSGA==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr13871173wme.0.1604921596533;
        Mon, 09 Nov 2020 03:33:16 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id b124sm12777961wmh.13.2020.11.09.03.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:33:15 -0800 (PST)
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
Subject: [PATCH v1 18/24] kvm: arm64: Forward safe PSCI SMCs coming from host
Date:   Mon,  9 Nov 2020 11:32:27 +0000
Message-Id: <20201109113233.9012-19-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
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
 arch/arm64/kvm/hyp/nvhe/psci.c | 43 +++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c b/arch/arm64/kvm/hyp/nvhe/psci.c
index 7510b9e174e9..05a34a152069 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci.c
@@ -63,14 +63,51 @@ static bool is_psci_call(u64 func_id)
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
@@ -85,6 +122,10 @@ static unsigned long psci_1_0_handler(u64 func_id, struct kvm_cpu_context *host_
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
2.29.2.222.g5d2a92d10f8-goog

