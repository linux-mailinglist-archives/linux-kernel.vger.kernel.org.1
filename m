Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E15A2CC581
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgLBSmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbgLBSmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:42:19 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0848CC0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:41:33 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k14so5174384wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g69TmuIpp+vIm9gRxx12Sh909+m1H1PrZL1qc3JkdQk=;
        b=WYFmGcSaH/wz/SlleIW3Mcu5nmwmv1kNPSQebgDZz+0eL3IjEcwWqvN80s834KuWzR
         RT3hly6g09zu5fWXVEkuV1YdbuzgldYW+V/8twi8l0yx8axbff8Ape8T/NR3v99S/UFx
         UBu7/c8XKsJf4vxFX3puM6VjMfdo+TmAE6IxE4Ang8fcy12BxnfTtg1FdTdeE6rwEhoS
         YanICjQ8vrCn3rOi1TLnMIhFRy3x7EV/7Dv4MoeSNLxZ2KVazRSH0LJ7mbdhEaezvCt5
         1ytVx/ay9QHVAw3P76uQzTzAv86K6uXZ8g0VqxbV1fUq1XJEGMtJpcjaVOearI/QMSyk
         P8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g69TmuIpp+vIm9gRxx12Sh909+m1H1PrZL1qc3JkdQk=;
        b=ft/pufDioWHjsmnsNIZMvmdFIQ85P/K65mi1p+HTJ8nG7awmbfw2KGQE6mUKq22OR/
         UMiqLb8i941gUpm2Xv6RurkEVstaNalNTLEH4P8z/Zqigw9YUILKuDxnRnGrz6CXFswg
         a3sBgqHDA4MK9gq1FnKp9KxKLOdRiJUiCB7BY0WXOGlQ+KSeg8rP2qCwmcBkv8f1W9Sx
         q2tDs7D5i0cJ+sO+oTKKIDQuOhnvY2KINL8wLai5gIVBZxi1RZ7B7IcltzQuEYQzdUYj
         kLGl+eZ1Kq8wThP8PqjgKa9D3XR6YNY6xmj4rp3t7D8VUypfmbC6P+VjFrHd0A9/Umc6
         zzag==
X-Gm-Message-State: AOAM532bSW2s3/s8hJud82HVySoO9Be0NOvXV9crRop1R/TaeLfo1DOY
        x5AiJ4zmIOp+NiV54KBgp6BsXQ==
X-Google-Smtp-Source: ABdhPJxLt3JxRj6qOSsRATpU04zggeVJmgFS/y1Rt/TDhlt67MX8xTg5Vhhj21UyUIwOKHqvCPeRjQ==
X-Received: by 2002:adf:dec1:: with SMTP id i1mr4974199wrn.129.1606934491590;
        Wed, 02 Dec 2020 10:41:31 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id k205sm3004907wmk.4.2020.12.02.10.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:41:30 -0800 (PST)
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
Subject: [PATCH v4 02/26] kvm: arm64: Add ARM64_KVM_PROTECTED_MODE CPU capability
Date:   Wed,  2 Dec 2020 18:40:58 +0000
Message-Id: <20201202184122.26046-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the boolean value whether the system is running with KVM in
protected mode (nVHE + kernel param). CPU capability was selected over
a global variable to allow use in alternatives.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/cpucaps.h  |  3 ++-
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/include/asm/virt.h     |  8 ++++++++
 arch/arm64/kernel/cpufeature.c    | 22 ++++++++++++++++++++++
 arch/arm64/kvm/arm.c              |  9 ++++++++-
 5 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 162539d4c8cd..42f850718d4b 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -66,7 +66,8 @@
 #define ARM64_HAS_TLB_RANGE			56
 #define ARM64_MTE				57
 #define ARM64_WORKAROUND_1508412		58
+#define ARM64_KVM_PROTECTED_MODE		59
 
-#define ARM64_NCAPS				59
+#define ARM64_NCAPS				60
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index bca38ccade58..11beda85ee7e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -58,6 +58,7 @@ enum kvm_mode {
 	KVM_MODE_DEFAULT,
 	KVM_MODE_PROTECTED,
 };
+enum kvm_mode kvm_get_mode(void);
 
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 6069be50baf9..eb81dcc220b6 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -97,6 +97,14 @@ static __always_inline bool has_vhe(void)
 		return cpus_have_final_cap(ARM64_HAS_VIRT_HOST_EXTN);
 }
 
+static __always_inline bool is_protected_kvm_enabled(void)
+{
+	if (is_vhe_hyp_code())
+		return false;
+	else
+		return cpus_have_final_cap(ARM64_KVM_PROTECTED_MODE);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* ! __ASM__VIRT_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 280b10762f6b..5f9e557fa1f7 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -74,6 +74,7 @@
 #include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
 #include <asm/fpsimd.h>
+#include <asm/kvm_host.h>
 #include <asm/mmu_context.h>
 #include <asm/mte.h>
 #include <asm/processor.h>
@@ -1709,6 +1710,21 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 }
 #endif /* CONFIG_ARM64_MTE */
 
+#ifdef CONFIG_KVM
+static bool is_kvm_protected_mode(const struct arm64_cpu_capabilities *entry, int __unused)
+{
+	if (kvm_get_mode() != KVM_MODE_PROTECTED)
+		return false;
+
+	if (is_kernel_in_hyp_mode()) {
+		pr_warn("Protected KVM not available with VHE\n");
+		return false;
+	}
+
+	return true;
+}
+#endif /* CONFIG_KVM */
+
 /* Internal helper functions to match cpu capability type */
 static bool
 cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
@@ -1822,6 +1838,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64PFR0_EL1_SHIFT,
 		.min_field_value = ID_AA64PFR0_EL1_32BIT_64BIT,
 	},
+	{
+		.desc = "Protected KVM",
+		.capability = ARM64_KVM_PROTECTED_MODE,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = is_kvm_protected_mode,
+	},
 #endif
 	{
 		.desc = "Kernel page table isolation (KPTI)",
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 01cf6ac5b2cb..d9e8d7dc7e11 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1849,7 +1849,9 @@ int kvm_arch_init(void *opaque)
 	if (err)
 		goto out_hyp;
 
-	if (in_hyp_mode)
+	if (is_protected_kvm_enabled())
+		kvm_info("Protected nVHE mode initialized successfully\n");
+	else if (in_hyp_mode)
 		kvm_info("VHE mode initialized successfully\n");
 	else
 		kvm_info("Hyp mode initialized successfully\n");
@@ -1884,6 +1886,11 @@ static int __init early_kvm_mode_cfg(char *arg)
 }
 early_param("kvm-arm.mode", early_kvm_mode_cfg);
 
+enum kvm_mode kvm_get_mode(void)
+{
+	return kvm_mode;
+}
+
 static int arm_init(void)
 {
 	int rc = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
-- 
2.29.2.454.gaff20da3a2-goog

