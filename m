Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA2C2A6CDF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbgKDSg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732449AbgKDSgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:36:55 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF75C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:36:54 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c9so3345718wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Qa/ORiTczGU+wzc7d9QZzh5/niq1xeS+URCXTTt4r4=;
        b=Nx93E9yyY//kvChBV3KCeNqvnYwrNO2ZgDrCYTrU0G3sLsnpH5B+kY1/8elaSaHdfw
         HzA05rPUsQd+1O936ysg9hDnB+m7qGA0yA/fCbDjMEC24foxz3qejCDvvP/ogU38u4JJ
         U6iOV2bgUjnGUl0/kwdbTGln1yZ07j3+9EkIC1wznpT5C9dGNpaUL7flUrUywhoeJxep
         Wzq+coBb4Jkt0eRYX55seXPFpVc8OJBmMM9eXV/Na0tuwDnZ9llo+xBd+yflExNcQ+aW
         KL1CYXtO82nsOaaPC8oRLdp3PKxgmvCy1VlOydEjqSsUUncvVeg2+lmyb57UYZffXHjz
         fhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Qa/ORiTczGU+wzc7d9QZzh5/niq1xeS+URCXTTt4r4=;
        b=GY2Cs33W26gz9sBmYJNrNpFhi+hq/v901fcuQGEFzDE2lSUWyvmuemutOIZXl2vfiy
         nhtShdrtxoy996/zbVx5Jivfh22a5gD85GseQ3VrzSxBbYlt1hoxMfnUY+GYhgJZlfRN
         VurmXBRC7tAwempSIh5eThZlPzf50tvIhd9/Qo27eqooaAwAxVGeeReFJ5pyoEEHRFvJ
         /3XrDfaND/SbNCrnOEc+iG7IyFsnlCnq0LyVnp7wrC/fiPg7rFhHk4FREKLaarCZZMui
         vRHfgiZ0llC2rz9otOg6LEyfwunJDkd5aufoIAwWvYdh6opjh9qqlqv4GAlGb+nMKlHZ
         uDFA==
X-Gm-Message-State: AOAM531HX5Q0PqkqRysJLYL+OXa7wNpxaIePeduNYinJytupMbM4ngPk
        iCXNCVadKxh8DvDO0T3xUh91PA==
X-Google-Smtp-Source: ABdhPJwP0oSnvZLNGQUvlE/1pKvC6M7nrsCqZGLWPZQiLMwgoxQ84TyR2rJEK0iBP/DF19+A8Bwokg==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr5889073wmi.131.1604515013329;
        Wed, 04 Nov 2020 10:36:53 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id e7sm4290328wrm.6.2020.11.04.10.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:36:52 -0800 (PST)
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
Subject: [RFC PATCH 07/26] kvm: arm64: Support per_cpu_ptr in nVHE hyp code
Date:   Wed,  4 Nov 2020 18:36:11 +0000
Message-Id: <20201104183630.27513-8-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
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
2.29.1.341.ge80a0c044ae-goog

