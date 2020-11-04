Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55152A6CE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbgKDShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732515AbgKDShI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:37:08 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7650DC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:37:07 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h2so729158wmm.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3d+QzOWawlq1O6qWW0gNBz2FTnwOmMHRq4HC+NVGn4=;
        b=bnzTyIjlyJiHyVe/d6fBeFTtZRk669wctKitVdZxL5eKRvHxekGaYaGcRkjMCnl+DJ
         NjrSTTKOO9SW5Up/qmMYqUnzUmpQTjhj/sMMMz8AhJTotYOXxVNy93wWdmv+JUht97Ao
         HNiPunbAncmDK5pB2s19mi4k1gFA/znMfI+oF77UIpwdETFox1QsQrbACiN6Wf3osi+v
         tzt2Pv3lRAYXItcD5VHXEh88CFzwhr65Oex5GMhkAIEzdLdD8yqxL6kdqk6I1wGuNgt5
         VXhuHizaJ1OH4LXIlE74pCuUSg4sl7s20qWpBYUEqQTHorjOPMWW2ioRSnfrkL4Sj5WB
         na9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3d+QzOWawlq1O6qWW0gNBz2FTnwOmMHRq4HC+NVGn4=;
        b=H4nHsplQwHgcbzo72EJRP6GBfTUJUIQ7Oj81s3ubzxmJjA6EkaZS7r87JYrZsHxudi
         r8SRQaICZOBotQwXorzc/lOorOx5R3RmySsjJeCCWXvYEeHgiHbvSGBjqDiYt20Jzcjv
         jZ/CujvOwXZTugaV9eEhYxodXehiA8krFXjthWJHdqrDer2HaSPDKmwKQRvLmHZVncyy
         FLUmy/sQtJLvGCvvCwv630kZMMlpPA/Cu6OXQdJYrvvaXaKCbwMtc67slPXwOIfttxDX
         YzMNzmGCaXJJDbaSlCqj9XRzrIooK1J6zpQvKtL8nC/gCoKPf9Od33syTPvDUFFqLuTz
         8+dw==
X-Gm-Message-State: AOAM53214cZYMOPPWN224n8+lWdqgksZQbHcEhADZ0GdL05lCGUhWI+R
        /YyXhF6MGzoWY3teUcRvTKoVgg==
X-Google-Smtp-Source: ABdhPJxVS5jWFGrlmaTy+L20ANnS0eCOXwmlYOy6SIM8Ix3vFBWONSxQVU6NleEARPZn0hYfOxSTpw==
X-Received: by 2002:a05:600c:22d7:: with SMTP id 23mr6155656wmg.67.1604515025991;
        Wed, 04 Nov 2020 10:37:05 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id v6sm3660726wrs.39.2020.11.04.10.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:37:05 -0800 (PST)
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
Subject: [RFC PATCH 13/26] kvm: arm64: Bootstrap PSCI SMC handler in nVHE EL2
Date:   Wed,  4 Nov 2020 18:36:17 +0000
Message-Id: <20201104183630.27513-14-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a handler of PSCI SMCs in nVHE hyp code. The handler is initialized
with the version used by the host's PSCI driver and the function IDs it
was configured with. If the SMC function ID matches one of the
configured PSCI calls (for v0.1) or falls into the PSCI function ID
range (for v0.2+), the SMC is handled by the PSCI handler. For now, all
SMCs return PSCI_RET_NOT_SUPPORTED.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_hyp.h   |   4 ++
 arch/arm64/kvm/arm.c               |  12 ++++
 arch/arm64/kvm/hyp/nvhe/Makefile   |   2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c |   4 ++
 arch/arm64/kvm/hyp/nvhe/psci.c     | 102 +++++++++++++++++++++++++++++
 include/uapi/linux/psci.h          |   1 +
 6 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/psci.c

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index a3289071f3d8..95a2bbbcc7e1 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -96,6 +96,10 @@ void deactivate_traps_vhe_put(void);
 
 u64 __guest_enter(struct kvm_vcpu *vcpu);
 
+#ifdef __KVM_NVHE_HYPERVISOR__
+bool kvm_host_psci_handler(struct kvm_cpu_context *host_ctxt);
+#endif
+
 void __noreturn hyp_panic(void);
 #ifdef __KVM_NVHE_HYPERVISOR__
 void __noreturn __hyp_do_panic(bool restore_host, u64 spsr, u64 elr, u64 par);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index ff200fc8d653..cedec793da64 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -19,6 +19,7 @@
 #include <linux/kvm_irqfd.h>
 #include <linux/irqbypass.h>
 #include <linux/sched/stat.h>
+#include <linux/psci.h>
 #include <trace/events/kvm.h>
 
 #define CREATE_TRACE_POINTS
@@ -1498,6 +1499,16 @@ static void init_cpu_logical_map(void)
 		CHOOSE_NVHE_SYM(__cpu_logical_map)[cpu] = cpu_logical_map(cpu);
 }
 
+static void init_psci(void)
+{
+	extern u32 kvm_nvhe_sym(kvm_host_psci_version);
+	extern u32 kvm_nvhe_sym(kvm_host_psci_function_id)[PSCI_FN_MAX];
+
+	kvm_nvhe_sym(kvm_host_psci_version) = psci_driver_version;
+	memcpy(kvm_nvhe_sym(kvm_host_psci_function_id),
+		psci_function_id, sizeof(psci_function_id));
+}
+
 static int init_common_resources(void)
 {
 	return kvm_set_ipa_limit();
@@ -1676,6 +1687,7 @@ static int init_hyp_mode(void)
 	}
 
 	init_cpu_logical_map();
+	init_psci();
 
 	return 0;
 
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index c45f440cce51..647b63337a51 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -7,7 +7,7 @@ asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
-	 hyp-main.o percpu.o
+	 hyp-main.o percpu.o psci.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index fffc2dc09a1f..aa54db514550 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -134,6 +134,10 @@ static void handle_host_smc(struct kvm_cpu_context *host_ctxt)
 	 */
 	skip_host_instruction();
 
+	/* Try to handle host's PSCI SMCs. */
+	if (kvm_host_psci_handler(host_ctxt))
+		return;
+
 	/* Forward SMC not handled in EL2 to EL3. */
 	forward_host_smc(host_ctxt);
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c b/arch/arm64/kvm/hyp/nvhe/psci.c
new file mode 100644
index 000000000000..82d3b2c89658
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/psci.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 - Google LLC
+ * Author: David Brazdil <dbrazdil@google.com>
+ */
+
+#include <asm/kvm_asm.h>
+#include <asm/kvm_hyp.h>
+#include <asm/kvm_mmu.h>
+#include <kvm/arm_hypercalls.h>
+#include <linux/arm-smccc.h>
+#include <linux/psci.h>
+#include <kvm/arm_psci.h>
+#include <uapi/linux/psci.h>
+
+/* Config options set by the host. */
+u32 kvm_host_psci_version = PSCI_VERSION(0, 0);
+u32 kvm_host_psci_function_id[PSCI_FN_MAX];
+
+static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
+{
+	return host_ctxt->regs.regs[0];
+}
+
+static bool is_psci_0_1_call(u64 func_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(kvm_host_psci_function_id); ++i) {
+		if (func_id == kvm_host_psci_function_id[i])
+			return true;
+	}
+	return false;
+}
+
+static bool is_psci_0_2_fn_call(u64 func_id)
+{
+	u64 base = func_id & ~PSCI_0_2_FN_ID_MASK;
+
+	return base == PSCI_0_2_FN_BASE || base == PSCI_0_2_FN64_BASE;
+}
+
+static bool is_psci_call(u64 func_id)
+{
+	if (kvm_host_psci_version == PSCI_VERSION(0, 0))
+		return false;
+	else if (kvm_host_psci_version == PSCI_VERSION(0, 1))
+		return is_psci_0_1_call(func_id);
+	else
+		return is_psci_0_2_fn_call(func_id);
+}
+
+static unsigned long psci_0_1_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
+{
+	return PSCI_RET_NOT_SUPPORTED;
+}
+
+static unsigned long psci_0_2_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
+{
+	switch (func_id) {
+	default:
+		return PSCI_RET_NOT_SUPPORTED;
+	}
+}
+
+static unsigned long psci_1_0_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
+{
+	int ret;
+
+	ret = psci_0_2_handler(func_id, host_ctxt);
+	if (ret != PSCI_RET_NOT_SUPPORTED)
+		return ret;
+
+	switch (func_id) {
+	default:
+		return PSCI_RET_NOT_SUPPORTED;
+	}
+}
+
+bool kvm_host_psci_handler(struct kvm_cpu_context *host_ctxt)
+{
+	u64 func_id = get_psci_func_id(host_ctxt);
+	unsigned long ret;
+
+	if (!is_psci_call(func_id))
+		return false;
+
+	if (kvm_host_psci_version == PSCI_VERSION(0, 1))
+		ret = psci_0_1_handler(func_id, host_ctxt);
+	else if (kvm_host_psci_version == PSCI_VERSION(0, 2))
+		ret = psci_0_2_handler(func_id, host_ctxt);
+	else if (PSCI_VERSION_MAJOR(kvm_host_psci_version) >= 1)
+		ret = psci_1_0_handler(func_id, host_ctxt);
+	else
+		ret = PSCI_RET_NOT_SUPPORTED;
+
+	host_ctxt->regs.regs[0] = ret;
+	host_ctxt->regs.regs[1] = 0;
+	host_ctxt->regs.regs[2] = 0;
+	host_ctxt->regs.regs[3] = 0;
+	return true;
+}
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index 2fcad1dd0b0e..0d52b8dbe8c2 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -29,6 +29,7 @@
 #define PSCI_0_2_FN64_BASE			\
 					(PSCI_0_2_FN_BASE + PSCI_0_2_64BIT)
 #define PSCI_0_2_FN64(n)			(PSCI_0_2_FN64_BASE + (n))
+#define PSCI_0_2_FN_ID_MASK			0xffff
 
 #define PSCI_0_2_FN_PSCI_VERSION		PSCI_0_2_FN(0)
 #define PSCI_0_2_FN_CPU_SUSPEND			PSCI_0_2_FN(1)
-- 
2.29.1.341.ge80a0c044ae-goog

