Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560AA2AB6F9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgKILdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgKILdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:12 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F14C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:33:12 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so7650331wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYieT24U6rTScU/FYH/lP2LhMsKB3zlRaCq2X67+Sqc=;
        b=aoO/o2Uc9KA/zaDyezMsH3ElIneNvZkysxVTHTgI+to/2ZlOP5teBf/B7Uy39aSVJd
         8nekb0GDqhzBKOpLgNAOmcxf9VemCTJro7xA7oGN1T8ryIwZtQB1DjZ596yDARlG375q
         oVzbpLrulf4LfKt1qjv6qm0EilG51Zd3LMpx328Xzsk02wrkPJd56lL6ZU+Quf/1TaRs
         lxpneRVblMPg/PmFsWmcItB2F8n1Ek94BmIg38YFWzHfHBlkfFH+49xa+uAgr9WDjPMu
         n5mbOstt7Fz/1HOJA6fLoR/ycQFilN0NkkvEibuFJ62hTRvGpwWeZIwjCwAxKNQvXMav
         X5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYieT24U6rTScU/FYH/lP2LhMsKB3zlRaCq2X67+Sqc=;
        b=cd8OO0/4iK+ei+0Hoe+MI1X55Nip6bqmKAxLoirJl0SsBVbGOgTlfPPTEjZU21BczO
         gDiH3OjoaEw3Wr2PX6n80/IGfFTUtcqijorlzWRVHqG3ia8S+Ktjfu1vEfACH7BSOhFd
         pn3G1CHEGUUqh2kXXfvza4MUmnVmPxilQ2wYwfIKId5Vaj+9MrjQuzr/AQhGm21yGsj6
         21YAnxlyERefIRkojckwZXcaEzQrqnRD8FoycqkdKP/MCNspyMfjANaKe/vk0dTfWd/b
         hfrDrHRaADIVQi97Z4+f3xOhbheH7qiDdMAnZvlXYH/hMzJ4pxt85y5J5mqCMPuoeLOr
         cB4Q==
X-Gm-Message-State: AOAM533SIl9Z/yjuKXdbvXY29cQ9d+VhloKtYNgtSWHvNCbAyfawqO1M
        Qni79lGZdXHIyPh48s7Th6rAvw==
X-Google-Smtp-Source: ABdhPJyz0tqLCCy6FmRE9It1sQ05a59QF/F02zSZWOuxLa+ZMTGA0uDhQdOTn7jSjPuDKoBmcQjL5g==
X-Received: by 2002:a1c:1dc1:: with SMTP id d184mr13978801wmd.169.1604921590702;
        Mon, 09 Nov 2020 03:33:10 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id k84sm12972518wmf.42.2020.11.09.03.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:33:09 -0800 (PST)
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
Subject: [PATCH v1 15/24] kvm: arm64: Bootstrap PSCI SMC handler in nVHE EL2
Date:   Mon,  9 Nov 2020 11:32:24 +0000
Message-Id: <20201109113233.9012-16-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
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
 arch/arm64/kvm/arm.c               |  13 ++++
 arch/arm64/kvm/hyp/nvhe/Makefile   |   2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c |   4 ++
 arch/arm64/kvm/hyp/nvhe/psci.c     | 102 +++++++++++++++++++++++++++++
 include/uapi/linux/psci.h          |   1 +
 6 files changed, 125 insertions(+), 1 deletion(-)
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
index 1a57b6025937..28e3bc056225 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -19,6 +19,7 @@
 #include <linux/kvm_irqfd.h>
 #include <linux/irqbypass.h>
 #include <linux/sched/stat.h>
+#include <linux/psci.h>
 #include <trace/events/kvm.h>
 
 #define CREATE_TRACE_POINTS
@@ -1498,6 +1499,17 @@ static void init_cpu_logical_map(void)
 		CHOOSE_NVHE_SYM(__cpu_logical_map)[cpu] = cpu_logical_map(cpu);
 }
 
+static void init_psci(void)
+{
+	extern u32 kvm_nvhe_sym(kvm_host_psci_version);
+	extern u32 kvm_nvhe_sym(kvm_host_psci_function_id)[PSCI_FN_MAX];
+	int i;
+
+	CHOOSE_NVHE_SYM(kvm_host_psci_version) = psci_driver_version();
+	for (i = 0; i < PSCI_FN_MAX; ++i)
+		CHOOSE_NVHE_SYM(kvm_host_psci_function_id)[i] = psci_get_function_id(i);
+}
+
 static int init_common_resources(void)
 {
 	return kvm_set_ipa_limit();
@@ -1677,6 +1689,7 @@ static int init_hyp_mode(void)
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
index 8661bc7deaa9..69f34d4f2773 100644
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
2.29.2.222.g5d2a92d10f8-goog

