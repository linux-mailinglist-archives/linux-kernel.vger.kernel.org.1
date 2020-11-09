Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6331A2AB6EA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgKILdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgKILcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:32:55 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948F6C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:32:53 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k2so4914580wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dD+HnXjMAuT9iIEK7PkEi17VFy6Rjc2aSGW4eJxjMmM=;
        b=Fxm0HnjlRiCRvpWF4beee7iVOFjv2Qaw21ps+7x79tMQJfT6FNyrr/xGavtNXDvjzu
         51epSIouMwzseNia68qwSyOMPyRzHL19sFirCC43Fe46MjxglK6FJFd2wjudNtt66VqM
         fqRYVtTi1izaLS10Y7ZO7h9NUmWfNxugf1n4K4XyYxKI2IroTZspHZ1hPfaDveiwV3gm
         f7cvO8HiWxy9KjAjrDe1t3eEsZVK6myBeucm4XXZRqEt2JVMbmx9fVH2tOSCzu49n3b/
         3JpiFHlpxlH2iezie9R07ceB4ujU4fqscWcxxngFZE19BU6OFayYXr3n0Vc/3iiOSvgg
         A4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dD+HnXjMAuT9iIEK7PkEi17VFy6Rjc2aSGW4eJxjMmM=;
        b=clPbvOd6YAfImzgGWOmxw43UG/IILKDfnNcpgn0MTZlmPXA9eQaaBt1Yc8xhWYEGf2
         SJcCB1SCFXx4qXrZD+g8JST3NXRwgPUEWM8klc0gBIVS6I9K45fF6/Y6+DFhxXw5s44d
         GvAIeTBigVVfB71R5SQ7+z4sw8TjhUvVijDElBYkur1btksFPpVNYgzsB1he/dUXSqXV
         1OJFUgT7qLa1YU4W0dhNktSvnC3V5Ttr+4b2Sj/73KBx0U7uDqpUB4ipiJnZXo1kjnEI
         OFE3jgcEO5mRqMQkl/4LIZ//45JukHoBDu7gzlq2tpYvHM8hszBCayeaCX2ML2xCWfIb
         yPOw==
X-Gm-Message-State: AOAM533J+JAEz6yXiEyMRU0NlrpkJEYtpAl8X9M0G+qPnOId00rSrq/d
        ECod7NAkvgnhGYJHydRu9q8i9w==
X-Google-Smtp-Source: ABdhPJz41ehkFfXRIlLvAsM/Z4zHvUymv8X3f2L/Q8G9Xp+RnyzjpOnflk7vt/regvRGdeQ9p7LFgA==
X-Received: by 2002:adf:ea47:: with SMTP id j7mr17229972wrn.126.1604921572143;
        Mon, 09 Nov 2020 03:32:52 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id p4sm12907274wrm.51.2020.11.09.03.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:32:51 -0800 (PST)
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
Subject: [PATCH v1 06/24] kvm: arm64: Support per_cpu_ptr in nVHE hyp code
Date:   Mon,  9 Nov 2020 11:32:15 +0000
Message-Id: <20201109113233.9012-7-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
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
 arch/arm64/include/asm/percpu.h  |  6 ++++++
 arch/arm64/kernel/image-vars.h   |  3 +++
 arch/arm64/kvm/hyp/nvhe/Makefile |  3 ++-
 arch/arm64/kvm/hyp/nvhe/percpu.c | 22 ++++++++++++++++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/percpu.c

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
index ddde15fe85f2..c45f440cce51 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -6,7 +6,8 @@
 asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__
 
-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o hyp-main.o
+obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
+	 hyp-main.o percpu.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o
 
diff --git a/arch/arm64/kvm/hyp/nvhe/percpu.c b/arch/arm64/kvm/hyp/nvhe/percpu.c
new file mode 100644
index 000000000000..5fd0c5696907
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/percpu.c
@@ -0,0 +1,22 @@
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
+
+	if (cpu >= ARRAY_SIZE(kvm_arm_hyp_percpu_base))
+		hyp_panic();
+
+	cpu_base_array = kern_hyp_va(&kvm_arm_hyp_percpu_base[0]);
+	this_cpu_base = kern_hyp_va(cpu_base_array[cpu]);
+	return this_cpu_base - (unsigned long)&__per_cpu_start;
+}
-- 
2.29.2.222.g5d2a92d10f8-goog

