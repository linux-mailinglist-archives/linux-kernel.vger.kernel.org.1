Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BF62B5310
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbgKPUoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387938AbgKPUoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:44:11 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:08 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m6so3098105wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/b5jsmdQhqUsP3iV70g55rFSHyU2Npcyd/L9vacP6Sc=;
        b=oc+9V2ypjwDCQSX2JHTAUt2BRrwLY8+/3AfQMXK5Z0Iol0FtYMP/CKLPK8bKmUQZvh
         n5+acER6e/irmEd8g0uLmW/xNvXzj2WKzpiGA6jYjSymV14pdrfyLbEz3ZtYAii8wShj
         /dXq9ek07rghShp0XHB9LewTzzK1hhaoXzzrI8TkJ1lGuFccEL7OaE7MpK2oYK+/aaPK
         lOCRmbOU+0u/88UkaXdx99xG6hhInjJ/FzGNatUi9toC1gXeLTKGJIAslARrRveo8IYQ
         gyTuw2WWOgwRC8imlFRYSfNuXhxZ53O6BGCOSj9FHkFq5jDJP1SbHqYFU2rQlKoJCBQw
         pM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/b5jsmdQhqUsP3iV70g55rFSHyU2Npcyd/L9vacP6Sc=;
        b=gjul+Y2xP4/r+kv7HNh+OwRtQhfX+t7hIOTtHlEMDUmyaGvUrpRGVbk/9S5Vk7/Ew2
         FrKnIrJekW/o5+K5q9YNHFJDM7di2CIrKC3RXhqNqHs1Gjn5gZpzyrOW+ziuK0qwNTcK
         gWMeWV3HsNQEyqfZpsF0FGcAFzpB/wR4QVihO+Ar7dL0S1432Kt+m3sWvUFDkoUq4Fle
         kc/1zZ9lhQPTGXBdgSu5UwWyguuUpssymuzitLXsZFGGI8pD1+NYPaBqCNRLc+CQtAqV
         J3kIrHkRMEFmQvOVObtDJRFCHnM9WrLb2cHagLWm2UMjDIn/4hKfIcVcbCECZmDqYxZS
         E9NQ==
X-Gm-Message-State: AOAM530PL6xWVsiIwdjgKvS9iBbQzYpZA++Kh6LiijQB6oC5DpVDp1sA
        gvKgZ18yiY6TLVUmD5OkIw3oow==
X-Google-Smtp-Source: ABdhPJwioNxTaew/6UynUWUqW3NRa5PGrRoMP1SYBFly6NWT6QRM6TZUt8ZXOODPLV9EiV/5CLUuBQ==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr21177611wrv.258.1605559447503;
        Mon, 16 Nov 2020 12:44:07 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id c2sm26308586wrf.68.2020.11.16.12.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:44:06 -0800 (PST)
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
Subject: [PATCH v2 21/24] kvm: arm64: Add kvm-arm.protected early kernel parameter
Date:   Mon, 16 Nov 2020 20:43:15 +0000
Message-Id: <20201116204318.63987-22-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an early parameter that allows users to opt into protected KVM mode
when using the nVHE hypervisor. In this mode, guest state will be kept
private from the host. This will primarily involve enabling stage-2
address translation for the host, restricting DMA to host memory, and
filtering host SMCs.

Capability ARM64_PROTECTED_KVM is set if the param is passed, CONFIG_KVM
is enabled and the kernel was not booted with VHE.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/include/asm/virt.h    |  8 ++++++++
 arch/arm64/kernel/cpufeature.c   | 29 +++++++++++++++++++++++++++++
 arch/arm64/kvm/arm.c             | 10 +++++++++-
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index e7d98997c09c..ac075f70b2e4 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -66,7 +66,8 @@
 #define ARM64_HAS_TLB_RANGE			56
 #define ARM64_MTE				57
 #define ARM64_WORKAROUND_1508412		58
+#define ARM64_PROTECTED_KVM			59
 
-#define ARM64_NCAPS				59
+#define ARM64_NCAPS				60
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 6069be50baf9..2fde1186b962 100644
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
+		return cpus_have_final_cap(ARM64_PROTECTED_KVM);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* ! __ASM__VIRT_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6f36c4f62f69..dd5bc0f0cf0d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1709,6 +1709,29 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 }
 #endif /* CONFIG_ARM64_MTE */
 
+#ifdef CONFIG_KVM
+static bool enable_protected_kvm;
+
+static bool has_protected_kvm(const struct arm64_cpu_capabilities *entry, int __unused)
+{
+	if (!enable_protected_kvm)
+		return false;
+
+	if (is_kernel_in_hyp_mode()) {
+		pr_warn("Protected KVM not available with VHE\n");
+		return false;
+	}
+
+	return true;
+}
+
+static int __init early_protected_kvm_cfg(char *buf)
+{
+	return strtobool(buf, &enable_protected_kvm);
+}
+early_param("kvm-arm.protected", early_protected_kvm_cfg);
+#endif /* CONFIG_KVM */
+
 /* Internal helper functions to match cpu capability type */
 static bool
 cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
@@ -1822,6 +1845,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64PFR0_EL1_SHIFT,
 		.min_field_value = ID_AA64PFR0_EL1_32BIT_64BIT,
 	},
+	{
+		.desc = "Protected KVM",
+		.capability = ARM64_PROTECTED_KVM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_protected_kvm,
+	},
 #endif
 	{
 		.desc = "Kernel page table isolation (KPTI)",
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c76a8e5bd19c..49d2474f2a80 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1796,6 +1796,12 @@ int kvm_arch_init(void *opaque)
 		return -ENODEV;
 	}
 
+	/* The PROTECTED_KVM cap should not have been enabled for VHE. */
+	if (in_hyp_mode && is_protected_kvm_enabled()) {
+		kvm_pr_unimpl("VHE protected mode unsupported, not initializing\n");
+		return -ENODEV;
+	}
+
 	if (cpus_have_final_cap(ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE) ||
 	    cpus_have_final_cap(ARM64_WORKAROUND_1508412))
 		kvm_info("Guests without required CPU erratum workarounds can deadlock system!\n" \
@@ -1827,7 +1833,9 @@ int kvm_arch_init(void *opaque)
 	if (err)
 		goto out_hyp;
 
-	if (in_hyp_mode)
+	if (is_protected_kvm_enabled())
+		kvm_info("Protected nVHE mode initialized successfully\n");
+	else if (in_hyp_mode)
 		kvm_info("VHE mode initialized successfully\n");
 	else
 		kvm_info("Hyp mode initialized successfully\n");
-- 
2.29.2.299.gdc1121823c-goog

