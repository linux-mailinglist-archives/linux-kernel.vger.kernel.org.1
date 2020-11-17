Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A922B6CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgKQSQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbgKQSQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:16:51 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29797C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:51 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id h2so2151589wmm.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=S6cwVwNRfmqiLf8lpRu/biimRGMThpGBDpyPzm8SfcU=;
        b=Rw7RcFAXWTa9NM5eUWt9ns6PvMjCLwpQUv7zU5flYQ+vJf2W0LNCLix93I5eiPBNhd
         aSn/XNz2iCuRt7d9fob7z1iSqBYaHL4jSNIE6w7GIgsZO1tNa4nmEohpgfm+zAH0Wlw9
         DVg6qEKI+ump3dkMvgBwDMhZEox7plRC1EVURxfkurDRSnciwtlpumtvCwe1TwDJ/3uH
         PdUcYZ6f6e6G2VWWwtyBc6DSgoIsDauyd0xqvgYdPPX1RYdtzlcNTAi5Rx3h8USdW9Qj
         +XXV9dpQsp81t1EzBw5lGKS45aGWAI6aKc6lgHu35S7qhBK3hFUqeBSLNq/FTuY5Z6ci
         JNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S6cwVwNRfmqiLf8lpRu/biimRGMThpGBDpyPzm8SfcU=;
        b=jMwgiAQJcKTWhV1/ZIcC0Rz8x2YrWWTWEnQIzK8q/lIX1Wu1iUPuB5NLkObawONYd9
         iOObH7/QubC9c0BWINoyNd+1aukMIfq+OF+0WZuvXCqD3b0joR9UL4no6MNuHmKTCZYZ
         mNSwE8X/okBw9uFSizGG8Y9k0PicrrNloUbPG+iSj5CYSwdf04tZrXZUGqAAB/rj2ZVP
         DbuFS2yqBnwH8W8lIYPwSOSPF0gN+n6kMQ5iT7N9QRfkrx24P3p3PerB9sDss1EES9eQ
         rEmfVn20ldujBiVQ+fxgjG/FC8u1AFfGvX96jyocGTtfTIK5yGZWjAiEcZmzcxqfCCZj
         bk3Q==
X-Gm-Message-State: AOAM532Hb0E83YzhINjlN1Ym9k3XRlzTpmI2L9DB07+kGsP9bgFtodXr
        UYuXj9Cc5gNvJbfsfj4C2JJAq/beK5wI
X-Google-Smtp-Source: ABdhPJyBvcTlVnO9kqVOz3fMTDExVUwGTO7ddJFQeswKQ25tqqOb6DNLvzHX+R28Y8s8EBggqoaXPxIosaD/
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a7b:c195:: with SMTP id
 y21mr379137wmi.138.1605637009838; Tue, 17 Nov 2020 10:16:49 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:15:53 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-14-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 13/27] KVM: arm64: Enable access to sanitized CPU features
 at EL2
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        android-kvm@google.com, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the infrastructure in KVM enabling to copy CPU feature
registers into EL2-owned data-structures, to allow reading sanitised
values directly at EL2 in nVHE.

Given that only a subset of these features are being read by the
hypervisor, the ones that need to be copied are to be listed under
<asm/kvm_cpufeature.h> together with the name of the nVHE variable that
will hold the copy.

While at it, introduce the first user of this infrastructure by
implementing __flush_dcache_area at EL2, which needs
arm64_ftr_reg_ctrel0.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/cpufeature.h     |  1 +
 arch/arm64/include/asm/kvm_cpufeature.h | 17 ++++++++++++++
 arch/arm64/kernel/cpufeature.c          | 12 ++++++++++
 arch/arm64/kernel/image-vars.h          |  2 ++
 arch/arm64/kvm/arm.c                    | 31 +++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/Makefile        |  3 ++-
 arch/arm64/kvm/hyp/nvhe/cache.S         | 13 +++++++++++
 arch/arm64/kvm/hyp/nvhe/cpufeature.c    |  8 +++++++
 8 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/kvm_cpufeature.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/cache.S
 create mode 100644 arch/arm64/kvm/hyp/nvhe/cpufeature.c

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index da250e4741bd..3dfbd76fb647 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -600,6 +600,7 @@ void __init setup_cpu_features(void);
 void check_local_cpu_capabilities(void);
 
 u64 read_sanitised_ftr_reg(u32 id);
+int copy_ftr_reg(u32 id, struct arm64_ftr_reg *dst);
 
 static inline bool cpu_supports_mixed_endian_el0(void)
 {
diff --git a/arch/arm64/include/asm/kvm_cpufeature.h b/arch/arm64/include/asm/kvm_cpufeature.h
new file mode 100644
index 000000000000..d34f85cba358
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_cpufeature.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 - Google LLC
+ * Author: Quentin Perret <qperret@google.com>
+ */
+
+#include <asm/cpufeature.h>
+
+#ifndef KVM_HYP_CPU_FTR_REG
+#if defined(__KVM_NVHE_HYPERVISOR__)
+#define KVM_HYP_CPU_FTR_REG(id, name) extern struct arm64_ftr_reg name;
+#else
+#define KVM_HYP_CPU_FTR_REG(id, name) DECLARE_KVM_NVHE_SYM(name);
+#endif
+#endif
+
+KVM_HYP_CPU_FTR_REG(SYS_CTR_EL0, arm64_ftr_reg_ctrel0)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index dd5bc0f0cf0d..3bc86d1423f8 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1116,6 +1116,18 @@ u64 read_sanitised_ftr_reg(u32 id)
 }
 EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
 
+int copy_ftr_reg(u32 id, struct arm64_ftr_reg *dst)
+{
+	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(id);
+
+	if (!regp)
+		return -EINVAL;
+
+	memcpy(dst, regp, sizeof(*regp));
+
+	return 0;
+}
+
 #define read_sysreg_case(r)	\
 	case r:		return read_sysreg_s(r)
 
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index dd8ccc9efb6a..c35d768672eb 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -116,6 +116,8 @@ __kvm_nvhe___memcpy			= __kvm_nvhe___pi_memcpy;
 __kvm_nvhe___memset			= __kvm_nvhe___pi_memset;
 #endif
 
+_kvm_nvhe___flush_dcache_area		= __kvm_nvhe___pi___flush_dcache_area;
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 391cf6753a13..c7f8fca97202 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -34,6 +34,7 @@
 #include <asm/virt.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
+#include <asm/kvm_cpufeature.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_emulate.h>
 #include <asm/sections.h>
@@ -1636,6 +1637,29 @@ static void teardown_hyp_mode(void)
 	}
 }
 
+#undef KVM_HYP_CPU_FTR_REG
+#define KVM_HYP_CPU_FTR_REG(id, name) \
+	{ .sys_id = id, .dst = (struct arm64_ftr_reg *)&kvm_nvhe_sym(name) },
+static const struct __ftr_reg_copy_entry {
+	u32			sys_id;
+	struct arm64_ftr_reg	*dst;
+} hyp_ftr_regs[] = {
+	#include <asm/kvm_cpufeature.h>
+};
+
+static int copy_cpu_ftr_regs(void)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(hyp_ftr_regs); i++) {
+		ret = copy_ftr_reg(hyp_ftr_regs[i].sys_id, hyp_ftr_regs[i].dst);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * Inits Hyp-mode on all online CPUs
  */
@@ -1644,6 +1668,13 @@ static int init_hyp_mode(void)
 	int cpu;
 	int err = 0;
 
+	/*
+	 * Copy the required CPU feature register in their EL2 counterpart
+	 */
+	err = copy_cpu_ftr_regs();
+	if (err)
+		return err;
+
 	/*
 	 * Allocate Hyp PGD and setup Hyp identity mapping
 	 */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 9e5eacfec6ec..72cfe53f106f 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -10,7 +10,8 @@ lib-objs := clear_page.o copy_page.o memcpy.o memset.o
 lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
-	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o page_alloc.o
+	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o page_alloc.o \
+	 cache.o cpufeature.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o
 obj-y += $(lib-objs)
diff --git a/arch/arm64/kvm/hyp/nvhe/cache.S b/arch/arm64/kvm/hyp/nvhe/cache.S
new file mode 100644
index 000000000000..36cef6915428
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/cache.S
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Code copied from arch/arm64/mm/cache.S.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/alternative.h>
+
+SYM_FUNC_START_PI(__flush_dcache_area)
+	dcache_by_line_op civac, sy, x0, x1, x2, x3
+	ret
+SYM_FUNC_END_PI(__flush_dcache_area)
diff --git a/arch/arm64/kvm/hyp/nvhe/cpufeature.c b/arch/arm64/kvm/hyp/nvhe/cpufeature.c
new file mode 100644
index 000000000000..a887508f996f
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/cpufeature.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 - Google LLC
+ * Author: Quentin Perret <qperret@google.com>
+ */
+
+#define KVM_HYP_CPU_FTR_REG(id, name) struct arm64_ftr_reg name;
+#include <asm/kvm_cpufeature.h>
-- 
2.29.2.299.gdc1121823c-goog

