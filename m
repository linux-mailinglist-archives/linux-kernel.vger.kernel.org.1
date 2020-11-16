Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364B02B5300
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbgKPUns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733259AbgKPUnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:46 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5DDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:45 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c9so585282wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5iQEQpIF1PXpAPkqqqPgQKLoiJmzjddJihqJJIArDJs=;
        b=MsbOd6taJGyK7f3jVg4pvaqVWGnW7Ka7tJiSpJC8dVUX7bTtwSrQOovl2aoY1bj0Zj
         XuC35VxDT9lGVdsuJHVD3S0e2rK8bi5lOSoiacc2caS8/5OG+cjsVpRLq3kzUFDkaSft
         vA9Dem9PsCnpO2FcF6gwgDyVnvjikI1mOdLD+prS9wMd9YDiYXuM+QdeXNXXj1i9ul7o
         ZOItW+FR33UhFib8M98gFdn3XR1ZxUK+JpKX0FO7pABd/x5x+EI1UujZzO/N4ibNfYDA
         2ioJ/gwpHpWGrSZ5RQxGJXYujKD7yYwzuGGQEl8cUuA5ZItet1KCDXPJfd/yQof2EYw8
         NNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5iQEQpIF1PXpAPkqqqPgQKLoiJmzjddJihqJJIArDJs=;
        b=bwMEXMgTFwaJ7uPlc4EsynVFwvLZQdg4wAVo7IhUFdYEjCLyNeMfDlBa6/UIVh7Ket
         F5Uw5uQFYqAfRSSkt8+ILsVCNl+AhC+t4svlPq8gIeMXttxuBjX8FvBZBqkPURx9lMM7
         BPgO+sUe5EQTHmcWcjXjdMQARUfokc8x1o13itTExBu1GaFSQnQc4CJruV9bnvF84qs2
         ZBQzi4GHNUOQ+XxT+adWKSGPbA9MLTL3GLXw1Yk8LUwi8Bptc89BAjmU6GbCXUab8MMz
         QygGpYjnKCs+kTVsG3BQtBDEr0tTKmUjjkXj8p3C6DNMVz75llBxeK7SxH4fRT2GYqDm
         gejg==
X-Gm-Message-State: AOAM530X4UFssmqt2tM+rB/PJ3Lv8/5J7OWd7e4lLWIkT4qUPC9x5pfT
        PKGVcrIDSbl6IqFqzm5PwFdjMA==
X-Google-Smtp-Source: ABdhPJyClWfGvHmjKoEyhOBm6/DvdXlpi5pEWhsc2qE/0XWt+4yi0pu0Mpj5dpRYtOW/TA+NM3pRGA==
X-Received: by 2002:a1c:2384:: with SMTP id j126mr745260wmj.116.1605559424454;
        Mon, 16 Nov 2020 12:43:44 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id t23sm538884wmn.4.2020.11.16.12.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:43 -0800 (PST)
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
Subject: [PATCH v2 10/24] kvm: arm64: Support per_cpu_ptr in nVHE hyp code
Date:   Mon, 16 Nov 2020 20:43:04 +0000
Message-Id: <20201116204318.63987-11-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with __KVM_NVHE_HYPERVISOR__ redefine per_cpu_offset() to
__hyp_per_cpu_offset() which looks up the base of the nVHE per-CPU
region of the given cpu and computes its offset from the
.hyp.data..percpu section.

This enables use of per_cpu_ptr() helpers in nVHE hyp code. Until now
only this_cpu_ptr() was supported by setting TPIDR_EL2.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/percpu.h   |  6 ++++++
 arch/arm64/kernel/image-vars.h    |  3 +++
 arch/arm64/kvm/hyp/nvhe/Makefile  |  3 ++-
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c | 24 ++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/hyp-smp.c

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 1599e17379d8..8f1661603b78 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -239,6 +239,12 @@ PERCPU_RET_OP(add, add, ldadd)
 #define this_cpu_cmpxchg_8(pcp, o, n)	\
 	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
 
+#ifdef __KVM_NVHE_HYPERVISOR__
+extern unsigned long __hyp_per_cpu_offset(unsigned int cpu);
+#define __per_cpu_offset
+#define per_cpu_offset(cpu)	__hyp_per_cpu_offset((cpu))
+#endif
+
 #include <asm-generic/percpu.h>
 
 /* Redefine macros for nVHE hyp under DEBUG_PREEMPT to avoid its dependencies. */
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index c615b285ff5b..78a42a7cdb72 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -103,6 +103,9 @@ KVM_NVHE_ALIAS(gic_nonsecure_priorities);
 KVM_NVHE_ALIAS(__start___kvm_ex_table);
 KVM_NVHE_ALIAS(__stop___kvm_ex_table);
 
+/* Array containing bases of nVHE per-CPU memory regions. */
+KVM_NVHE_ALIAS(kvm_arm_hyp_percpu_base);
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index ddde15fe85f2..2d842e009a40 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -6,7 +6,8 @@
 asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__
 
-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o hyp-main.o
+obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
+	 hyp-main.o hyp-smp.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
new file mode 100644
index 000000000000..7b0363b4857f
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 - Google LLC
+ * Author: David Brazdil <dbrazdil@google.com>
+ */
+
+#include <asm/kvm_asm.h>
+#include <asm/kvm_hyp.h>
+#include <asm/kvm_mmu.h>
+
+unsigned long __hyp_per_cpu_offset(unsigned int cpu)
+{
+	unsigned long *cpu_base_array;
+	unsigned long this_cpu_base;
+	unsigned long elf_base;
+
+	if (cpu >= ARRAY_SIZE(kvm_arm_hyp_percpu_base))
+		hyp_panic();
+
+	cpu_base_array = (unsigned long *)hyp_symbol_addr(kvm_arm_hyp_percpu_base);
+	this_cpu_base = kern_hyp_va(cpu_base_array[cpu]);
+	elf_base = (unsigned long)hyp_symbol_addr(__per_cpu_start);
+	return this_cpu_base - elf_base;
+}
-- 
2.29.2.299.gdc1121823c-goog

