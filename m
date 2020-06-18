Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADF61FF1AC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 14:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgFRM14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 08:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgFRMZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:25:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2C6C0613EF
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:25:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d128so5447696wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D60Z34SZFzunDrVnRRvupIcqGYHycsZaSexa8Z/NEcc=;
        b=R5wOZrowNvymOhII5Vo3wuKlNlmIIa7ZuV7agZTTgZFUH3aAoFADrBAriFs36Lux4i
         u0oPXIAbolsLV5fsikLjn1CtZzdJFyM63oIkCXmc+Wcdowa1DxkLq5384FP92ewvLiYd
         cM6TPbBZx2bDn+wrPbd0wlqEJ3h73VM/Lc+WXvNTURLaJ/VNY+XvDWAdVLmGHRfY7q84
         RtvzKZUpk4XQOMw9IRyDxmly045+stSxNhnjPFGC9awWJp2xAiWx+E79XB0vLsXaydg4
         WM+2CBz7tNeqcvb3ML1e25FabZNYr0irIsvvtnyDR4YyZF6begqoWk07LoEGxWViiHEQ
         nNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D60Z34SZFzunDrVnRRvupIcqGYHycsZaSexa8Z/NEcc=;
        b=sOdzzkKSu2qqp80dIQoiKq48aRBQAJZHGAJYM7j3g9d9js10KAjiSVLJJO9StwXrBF
         rIYklKd7apGGF1PFU/1KkPtSZfoNcV5I4IwpO88KwHhOWDSA3pxc8eGxdUVnAVaZqHQ/
         csJ1zRJLbS/AMBXZUK79iPRCavryHpZRo1mGaHytqBWFDKiYtpBpFvVW7LxZ5AKND7wZ
         eDxKUeJHJGVGpGatlmCRfbstUlsL+ckkhyaDgHEYi9vtdZ46Vc4eya6n8rgWURI1DOpw
         nLqeZi2ed2Rp7qYYwpeb/nTt/Ie6jB6eQTT1rjBuKPjq31h625v+SFLqjzPN7cr7DBc0
         8r9Q==
X-Gm-Message-State: AOAM532c3ztbsqiKX9y6WKbphLHjKh2y8/i2U51cKMeU1gAdfBHgvXZH
        lpYZ7tJa8xSN/l2TtbNO++uShA==
X-Google-Smtp-Source: ABdhPJyqgv2iExydIc+UmgLZxFWWeg4P2dcwrwIeBrX8vM7l/xXUXy2CvIqw9oAusrkmQ0YvNplT6w==
X-Received: by 2002:a1c:3881:: with SMTP id f123mr3770820wma.178.1592483155742;
        Thu, 18 Jun 2020 05:25:55 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c1af:c724:158a:e200])
        by smtp.gmail.com with ESMTPSA id c206sm3629346wmf.36.2020.06.18.05.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 05:25:55 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, Andrew Scull <ascull@google.com>,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 04/15] arm64: kvm: Handle calls to prefixed hyp functions
Date:   Thu, 18 Jun 2020 13:25:26 +0100
Message-Id: <20200618122537.9625-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618122537.9625-1-dbrazdil@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Scull <ascull@google.com>

This patch is part of a series which builds KVM's non-VHE hyp code separately
from VHE and the rest of the kernel.

Once hyp functions are moved to a hyp object, they will have prefixed symbols.
This change declares and gets the address of the prefixed version for calls to
the hyp functions.

To aid migration, the hyp functions that have not yet moved have their prefixed
versions aliased to their non-prefixed version. This begins with all the hyp
functions being listed and will reduce to none of them once the migration is
complete.

Signed-off-by: Andrew Scull <ascull@google.com>

Extracted kvm_call_hyp nVHE branches into own helper macros.
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h  | 19 +++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h | 19 ++++++++++++++++---
 arch/arm64/kernel/image-vars.h    | 15 +++++++++++++++
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 352aaebf4198..6a682d66a640 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -42,6 +42,24 @@
 
 #include <linux/mm.h>
 
+/*
+ * Translate name of a symbol defined in nVHE hyp to the name seen
+ * by kernel proper. All nVHE symbols are prefixed by the build system
+ * to avoid clashes with the VHE variants.
+ */
+#define kvm_nvhe_sym(sym)	__kvm_nvhe_##sym
+
+#define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
+#define DECLARE_KVM_NVHE_SYM(sym)	extern char kvm_nvhe_sym(sym)[]
+
+/*
+ * Define a pair of symbols sharing the same name but one defined in
+ * VHE and the other in nVHE hyp implementations.
+ */
+#define DECLARE_KVM_HYP_SYM(sym)		\
+	DECLARE_KVM_VHE_SYM(sym);		\
+	DECLARE_KVM_NVHE_SYM(sym)
+
 /* Translate a kernel address of @sym into its equivalent linear mapping */
 #define kvm_ksym_ref(sym)						\
 	({								\
@@ -50,6 +68,7 @@
 			val = lm_alias(&sym);				\
 		val;							\
 	 })
+#define kvm_ksym_ref_nvhe(sym)	kvm_ksym_ref(kvm_nvhe_sym(sym))
 
 struct kvm;
 struct kvm_vcpu;
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index c3e6fcc664b1..e782f98243d3 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -448,6 +448,20 @@ void kvm_arm_resume_guest(struct kvm *kvm);
 
 u64 __kvm_call_hyp(void *hypfn, ...);
 
+#define kvm_call_hyp_nvhe(f, ...)					\
+	do {								\
+		DECLARE_KVM_NVHE_SYM(f);				\
+		__kvm_call_hyp(kvm_ksym_ref_nvhe(f), ##__VA_ARGS__);	\
+	} while(0)
+
+#define kvm_call_hyp_nvhe_ret(f, ...)					\
+	({								\
+		DECLARE_KVM_NVHE_SYM(f);				\
+		typeof(f(__VA_ARGS__)) ret;				\
+		ret = __kvm_call_hyp(kvm_ksym_ref_nvhe(f),		\
+				     ##__VA_ARGS__);			\
+	})
+
 /*
  * The couple of isb() below are there to guarantee the same behaviour
  * on VHE as on !VHE, where the eret to EL1 acts as a context
@@ -459,7 +473,7 @@ u64 __kvm_call_hyp(void *hypfn, ...);
 			f(__VA_ARGS__);					\
 			isb();						\
 		} else {						\
-			__kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__); \
+			kvm_call_hyp_nvhe(f, ##__VA_ARGS__);		\
 		}							\
 	} while(0)
 
@@ -471,8 +485,7 @@ u64 __kvm_call_hyp(void *hypfn, ...);
 			ret = f(__VA_ARGS__);				\
 			isb();						\
 		} else {						\
-			ret = __kvm_call_hyp(kvm_ksym_ref(f),		\
-					     ##__VA_ARGS__);		\
+			ret = kvm_call_hyp_nvhe_ret(f, ##__VA_ARGS__);	\
 		}							\
 									\
 		ret;							\
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index f32b406e90c0..89affa38b143 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -61,6 +61,21 @@ __efistub__ctype		= _ctype;
  * memory mappings.
  */
 
+__kvm_nvhe___kvm_enable_ssbs = __kvm_enable_ssbs;
+__kvm_nvhe___kvm_flush_vm_context = __kvm_flush_vm_context;
+__kvm_nvhe___kvm_get_mdcr_el2 = __kvm_get_mdcr_el2;
+__kvm_nvhe___kvm_timer_set_cntvoff = __kvm_timer_set_cntvoff;
+__kvm_nvhe___kvm_tlb_flush_local_vmid = __kvm_tlb_flush_local_vmid;
+__kvm_nvhe___kvm_tlb_flush_vmid = __kvm_tlb_flush_vmid;
+__kvm_nvhe___kvm_tlb_flush_vmid_ipa = __kvm_tlb_flush_vmid_ipa;
+__kvm_nvhe___kvm_vcpu_run_nvhe = __kvm_vcpu_run_nvhe;
+__kvm_nvhe___vgic_v3_get_ich_vtr_el2 = __vgic_v3_get_ich_vtr_el2;
+__kvm_nvhe___vgic_v3_init_lrs = __vgic_v3_init_lrs;
+__kvm_nvhe___vgic_v3_read_vmcr = __vgic_v3_read_vmcr;
+__kvm_nvhe___vgic_v3_restore_aprs = __vgic_v3_restore_aprs;
+__kvm_nvhe___vgic_v3_save_aprs = __vgic_v3_save_aprs;
+__kvm_nvhe___vgic_v3_write_vmcr = __vgic_v3_write_vmcr;
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
-- 
2.27.0

