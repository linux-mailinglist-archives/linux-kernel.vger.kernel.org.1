Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43761209F87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405118AbgFYNPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 09:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404834AbgFYNOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:14:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0464FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so5878250wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kuR4zqn460ZfDvOPRZLBdbatU3Tl1+GK/DM2MsbbDYE=;
        b=L6GN/yTULlibROyq7dwxJEpfOR9idYf2tNFIPd390S+//8i/sDzyXWY8L8ngX0BmtE
         hsHNfixR1RZPoTZ7O9ndXAOPxn8W1w3/3yqWVLMiA5/YairtLVWSHu8z5MYKAcehYrs+
         Ny5pOzpitZGzdjf638XktPBLh0AY0ZGsAy9BPdt/Z9qH4GLDuRjLci4fhTMBsvjyKplw
         bGwJKNeKMZ8zPUozt8P/Mbalws29i6cej9OyrXJq27LEgMdSuKwLHsfgPwe2xUquGlDU
         mp9ZBtC0j+EdYEede1FCz/AqN4V5MzQILFML0M5BASdZ6/qaRxRs2QZc+9HH8xG7EGSV
         KMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kuR4zqn460ZfDvOPRZLBdbatU3Tl1+GK/DM2MsbbDYE=;
        b=Ru6aeaSmix7fTLiWWLMzWA3seztvj+098f/HlIgMjnMllhsLN8ygqRpQpNfuHZNSWh
         +6QSSznnjEjeudhje5v58rPYF+bvGjfSoqWEMP4ijuQw1+T92MxFphodsT71AYS0qFsG
         lieIeMKzeupuieigd9kIyoBImIX/Ufd8s9hxKYgeBa01xeeo8kO7MjFGUG/mle4EDDr7
         UdS6FgKBdc8vTrV8IGXxxGlB/OweRnIHoqA1nXKmm/uY3jHK/1JQsa0O2XkV2mt/PYoM
         DKZUBFv13c6KAGOTe34HdsMkYkMkrrGwsRyzwIGwNBownBqLGcbOJfskdjv13tfW9ffL
         cwRw==
X-Gm-Message-State: AOAM531LOWXtz3G7zxqRkAvSVOpIJOngQHnR3qqd1jutgm1dqZc/oAPd
        1enLGKXLBzdR7l781CvziZTTEg==
X-Google-Smtp-Source: ABdhPJzjfkKDfkUwAkvXXlxbiBPTEw+5nTG7FyH0H8W76y+Lt4gtAq38QOX0jPlZdLDTDKE6B2VYeA==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr3158785wmi.7.1593090873533;
        Thu, 25 Jun 2020 06:14:33 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c126:6748:7a9d:2d])
        by smtp.gmail.com with ESMTPSA id t16sm9874525wru.9.2020.06.25.06.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 06:14:32 -0700 (PDT)
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
Subject: [PATCH v4 05/15] arm64: kvm: Handle calls to prefixed hyp functions
Date:   Thu, 25 Jun 2020 14:14:10 +0100
Message-Id: <20200625131420.71444-6-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625131420.71444-1-dbrazdil@google.com>
References: <20200625131420.71444-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Scull <ascull@google.com>

Once hyp functions are moved to a hyp object, they will have prefixed symbols.
This change declares and gets the address of the prefixed version for calls to
the hyp functions.

To aid migration, the hyp functions that have not yet moved have their prefixed
versions aliased to their non-prefixed version. This begins with all the hyp
functions being listed and will reduce to none of them once the migration is
complete.

Signed-off-by: Andrew Scull <ascull@google.com>

[David: Extracted kvm_call_hyp nVHE branches into own helper macros, added
        comments around symbol aliases.]
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h  | 19 +++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h | 17 ++++++++++++++---
 arch/arm64/kernel/image-vars.h    | 26 ++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 3 deletions(-)

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
index c3e6fcc664b1..49d1a5cd8f8f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -448,6 +448,18 @@ void kvm_arm_resume_guest(struct kvm *kvm);
 
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
+		__kvm_call_hyp(kvm_ksym_ref_nvhe(f), ##__VA_ARGS__);	\
+	})
+
 /*
  * The couple of isb() below are there to guarantee the same behaviour
  * on VHE as on !VHE, where the eret to EL1 acts as a context
@@ -459,7 +471,7 @@ u64 __kvm_call_hyp(void *hypfn, ...);
 			f(__VA_ARGS__);					\
 			isb();						\
 		} else {						\
-			__kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__); \
+			kvm_call_hyp_nvhe(f, ##__VA_ARGS__);		\
 		}							\
 	} while(0)
 
@@ -471,8 +483,7 @@ u64 __kvm_call_hyp(void *hypfn, ...);
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
index 3dc27da47712..36444bac6a05 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -63,6 +63,32 @@ __efistub__ctype		= _ctype;
 
 #define KVM_NVHE_ALIAS(sym) __kvm_nvhe_##sym = sym;
 
+/* Symbols defined in debug-sr.c (not yet compiled with nVHE build rules). */
+KVM_NVHE_ALIAS(__kvm_get_mdcr_el2);
+
+/* Symbols defined in switch.c (not yet compiled with nVHE build rules). */
+KVM_NVHE_ALIAS(__kvm_vcpu_run_nvhe);
+
+/* Symbols defined in sysreg-sr.c (not yet compiled with nVHE build rules). */
+KVM_NVHE_ALIAS(__kvm_enable_ssbs);
+
+/* Symbols defined in timer-sr.c (not yet compiled with nVHE build rules). */
+KVM_NVHE_ALIAS(__kvm_timer_set_cntvoff);
+
+/* Symbols defined in tlb.c (not yet compiled with nVHE build rules). */
+KVM_NVHE_ALIAS(__kvm_flush_vm_context);
+KVM_NVHE_ALIAS(__kvm_tlb_flush_local_vmid);
+KVM_NVHE_ALIAS(__kvm_tlb_flush_vmid);
+KVM_NVHE_ALIAS(__kvm_tlb_flush_vmid_ipa);
+
+/* Symbols defined in vgic-v3-sr.c (not yet compiled with nVHE build rules). */
+KVM_NVHE_ALIAS(__vgic_v3_get_ich_vtr_el2);
+KVM_NVHE_ALIAS(__vgic_v3_init_lrs);
+KVM_NVHE_ALIAS(__vgic_v3_read_vmcr);
+KVM_NVHE_ALIAS(__vgic_v3_restore_aprs);
+KVM_NVHE_ALIAS(__vgic_v3_save_aprs);
+KVM_NVHE_ALIAS(__vgic_v3_write_vmcr);
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
-- 
2.27.0

