Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0627A2AB72B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgKILdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbgKILdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:24 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D810C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:33:24 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so7504392wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p42rRkCPYWoJ8F/zuYYtS8myDLEcghdypmEMJwmGPuM=;
        b=dKdv3AFVKNz2TvbhuhQkVsFgrhEhdWpmA59RmYXb77rE0FCbJb/j5vpMfMW43tImW7
         nwhBJx0rjj5/lc2OcC5nwslciSR0hKuNAZr2T72xTUwkIclTmg564tL3F31GwRFhKPR7
         Itxsk2XYH/HTOdKO4Q27CV0q+y4uGbSCoG071/20ox9dRRYOm0g8Iwvlhie2sKdvUFw4
         +5Ok5Sj7CoWCGK9NJIONc4pfJZrnObcg3Wupi7pVmeXf0F/fwx2p3/XAbWIuOtk972jW
         Tg6kgBygp+akhSDRD4/0L7CUDrp61OUjLbHuI/WEu6Mj7vh5QYBq4UYeumYwqZmeIHS1
         4ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p42rRkCPYWoJ8F/zuYYtS8myDLEcghdypmEMJwmGPuM=;
        b=svjMb7xgOS/JgBZ10IvvW790WqKdUCiSbcihV+wKyZFa95DM+3/qf9GZrEfNPFv8XO
         KpZG+EQ/cp1dWvmBNxYDNQZN4FlFWJg64Wbo/utqVNLFCEwxggzmnz/llbz0OJEahhnL
         4FyYoU/D88gstIO1jupOBxpT1FYZFGQt4lzDSsJUp3rJLxu7/QVIkojjExFG3SnMHbr2
         tdTbY6oSXo5y7WsTELqILLv15OTuv59l7W+HCIVpe1CKQo2jevycDgVy6JDLcvgaM0RJ
         VzBpQmL/BpJIQvXNeu5SgJEKNUHVvFvBqotWekRynwJE15mVoITszHGIe12l1fWv1eNB
         Mz2w==
X-Gm-Message-State: AOAM530WckZh4oqi1fEF91i1ZCgYmJOeK5F5A6DFXZCt5tmQPS1AKh6T
        jlGhuCBa20eXdQHefGzpohux5g==
X-Google-Smtp-Source: ABdhPJyxgdjvEUnFGKqjP6pt6kqP/0XM/at3rDogZRjLUzJLV7kTcwVriYMD+vgSsOaDAx+Ws5AFWw==
X-Received: by 2002:a5d:4ec4:: with SMTP id s4mr3533343wrv.31.1604921602589;
        Mon, 09 Nov 2020 03:33:22 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id s202sm12526094wme.39.2020.11.09.03.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:33:21 -0800 (PST)
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
Subject: [PATCH v1 21/24] kvm: arm64: Add kvm-arm.protected early kernel parameter
Date:   Mon,  9 Nov 2020 11:32:30 +0000
Message-Id: <20201109113233.9012-22-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
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

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/virt.h |  9 +++++++++
 arch/arm64/kvm/arm.c          | 23 ++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 6069be50baf9..2c3124512c00 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -65,6 +65,8 @@ extern u32 __boot_cpu_mode[2];
 void __hyp_set_vectors(phys_addr_t phys_vector_base);
 void __hyp_reset_vectors(void);
 
+DECLARE_STATIC_KEY_FALSE(kvm_protected_mode);
+
 /* Reports the availability of HYP mode */
 static inline bool is_hyp_mode_available(void)
 {
@@ -97,6 +99,13 @@ static __always_inline bool has_vhe(void)
 		return cpus_have_final_cap(ARM64_HAS_VIRT_HOST_EXTN);
 }
 
+static __always_inline bool is_kvm_protected_mode(void)
+{
+	return IS_ENABLED(CONFIG_KVM) &&
+	       (is_nvhe_hyp_code() || !is_kernel_in_hyp_mode()) &&
+	       static_branch_likely(&kvm_protected_mode);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* ! __ASM__VIRT_H */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a931253ebb61..452a01afaf33 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -47,6 +47,8 @@
 __asm__(".arch_extension	virt");
 #endif
 
+DEFINE_STATIC_KEY_FALSE(kvm_protected_mode);
+
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
@@ -1796,6 +1798,11 @@ int kvm_arch_init(void *opaque)
 		return -ENODEV;
 	}
 
+	if (in_hyp_mode && static_branch_unlikely(&kvm_protected_mode)) {
+		kvm_pr_unimpl("VHE protected mode unsupported, not initializing\n");
+		return -ENODEV;
+	}
+
 	if (cpus_have_final_cap(ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE) ||
 	    cpus_have_final_cap(ARM64_WORKAROUND_1508412))
 		kvm_info("Guests without required CPU erratum workarounds can deadlock system!\n" \
@@ -1827,7 +1834,9 @@ int kvm_arch_init(void *opaque)
 	if (err)
 		goto out_hyp;
 
-	if (in_hyp_mode)
+	if (is_kvm_protected_mode())
+		kvm_info("Protected nVHE mode initialized successfully\n");
+	else if (in_hyp_mode)
 		kvm_info("VHE mode initialized successfully\n");
 	else
 		kvm_info("Hyp mode initialized successfully\n");
@@ -1848,6 +1857,18 @@ void kvm_arch_exit(void)
 	kvm_perf_teardown();
 }
 
+static int __init early_kvm_protected_cfg(char *buf)
+{
+	bool val;
+	int err;
+
+	err = strtobool(buf, &val);
+	if (!err && val)
+		static_branch_enable(&kvm_protected_mode);
+	return err;
+}
+early_param("kvm-arm.protected", early_kvm_protected_cfg);
+
 static int arm_init(void)
 {
 	int rc = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
-- 
2.29.2.222.g5d2a92d10f8-goog

