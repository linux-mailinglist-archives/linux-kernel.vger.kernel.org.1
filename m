Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C94326CA84
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgIPUER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgIPRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E334BC06178B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:34:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o5so7706597wrn.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bb8x+HFH0B/5AJF/3eHINfl7a3Qa0+GTsxwxT6ItzrA=;
        b=M2E0n8qJMz1MSrSfqdhktCcaOa3AQGk1vmL6Kdjan+YvnN4Uq1JyhmWHaYif2qseKo
         7MBBvjOhBg96grbm9ZP7di/5Ks/FE2YU5A0RILohThIR4aygnTZpnOQeqCylD42bNDyZ
         /GHnv4SVspVP2I7UqGWfOnLnq5PZJXg+7LmAU0usi0LcCoKhWVg20JXWk1gD7Dx9jJ2h
         urT8MmXA1a4IPXVtGsD2MRKI6+46OC9ZsTGpnmm2FO5qccUyI+KkWdAiMgPH10nR7JU0
         V4lLP2rS82e7Q3ZSw1KO5ix3ERwkqgea+/sU+waTdQCUBZqwD4luhpsk5LacwlUFA16t
         6RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bb8x+HFH0B/5AJF/3eHINfl7a3Qa0+GTsxwxT6ItzrA=;
        b=HijCkEgWO7WPHK8qjaDWvxuGWuYdihj6aUqsWP+pPQZAPeG2mJ2wFvWdes1tu/nG1N
         KT+ki/Rbz/NoPrg6P5BqYVqcsjrJsfkrKOFIVN6Gm6+G2cdiEJulMOHdPhktr0PNU8SX
         cZYM2HTUHkwKhUfj9GfLchW67Hbf2WUf++kRmNgzE8HWOZF/j3Vex2vhjP+8vMSGIJjO
         2RsDREwZy0frST+t18HOx7FKPOyjGcAivYKl6jpQndmR/YGRR3Pw5Zq9hfoATL2GWnZQ
         ndPnE2DSL30m9M4CbJDF8U3+oegKgMoj9rzxkNziZa5NxJeCqZdtFn6LFEuhFiH5vyZ2
         cYTg==
X-Gm-Message-State: AOAM530jrcdCY9sOpckycyzwuSwkIZ6aWGhdxMwLBAwbE9MG+nNat1TA
        15bwetG+DAW2a+TQkbxLekP4ng==
X-Google-Smtp-Source: ABdhPJyyusmPWRRPVeBCNm47H5a0PGpw8keKMBDtnH6wTG9FWTwQc0RSofvNwO/KVylWvPlmtAdRqQ==
X-Received: by 2002:adf:8162:: with SMTP id 89mr28955370wrm.237.1600277689224;
        Wed, 16 Sep 2020 10:34:49 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
        by smtp.gmail.com with ESMTPSA id d19sm3530522wmd.0.2020.09.16.10.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 10:34:48 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 02/11] kvm: arm64: Move nVHE hyp namespace macros to hyp_image.h
Date:   Wed, 16 Sep 2020 18:34:30 +0100
Message-Id: <20200916173439.32265-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916173439.32265-1-dbrazdil@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup to move all macros related to prefixing nVHE hyp section
and symbol names into one place: hyp_image.h.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/hyp_image.h | 12 ++++++++++++
 arch/arm64/include/asm/kvm_asm.h   |  8 +-------
 arch/arm64/kernel/image-vars.h     |  2 --
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
index 5b1e3b9ef376..9848de588238 100644
--- a/arch/arm64/include/asm/hyp_image.h
+++ b/arch/arm64/include/asm/hyp_image.h
@@ -7,6 +7,12 @@
 #ifndef __ARM64_HYP_IMAGE_H__
 #define __ARM64_HYP_IMAGE_H__
 
+/*
+ * KVM nVHE code has its own symbol namespace prefixed with __kvm_nvhe_,
+ * to separate it from the kernel proper.
+ */
+#define kvm_nvhe_sym(sym)	__kvm_nvhe_##sym
+
 #ifdef LINKER_SCRIPT
 
 /*
@@ -19,6 +25,12 @@
 #define HYP_SECTION(NAME) \
 	HYP_SECTION_NAME(NAME) : { *(NAME NAME##.[0-9a-zA-Z_]*) }
 
+/*
+ * Defines a linker script alias of a kernel-proper symbol referenced by
+ * KVM nVHE hyp code.
+ */
+#define KVM_NVHE_ALIAS(sym)	kvm_nvhe_sym(sym) = sym;
+
 #endif /* LINKER_SCRIPT */
 
 #endif /* __ARM64_HYP_IMAGE_H__ */
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 6f98fbd0ac81..c085032e2e3e 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -7,6 +7,7 @@
 #ifndef __ARM_KVM_ASM_H__
 #define __ARM_KVM_ASM_H__
 
+#include <asm/hyp_image.h>
 #include <asm/virt.h>
 
 #define	VCPU_WORKAROUND_2_FLAG_SHIFT	0
@@ -42,13 +43,6 @@
 
 #include <linux/mm.h>
 
-/*
- * Translate name of a symbol defined in nVHE hyp to the name seen
- * by kernel proper. All nVHE symbols are prefixed by the build system
- * to avoid clashes with the VHE variants.
- */
-#define kvm_nvhe_sym(sym)	__kvm_nvhe_##sym
-
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
 #define DECLARE_KVM_NVHE_SYM(sym)	extern char kvm_nvhe_sym(sym)[]
 
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 8982b68289b7..76da2ad1010c 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -61,8 +61,6 @@ __efistub__ctype		= _ctype;
  * memory mappings.
  */
 
-#define KVM_NVHE_ALIAS(sym) __kvm_nvhe_##sym = sym;
-
 /* Alternative callbacks for init-time patching of nVHE hyp code. */
 KVM_NVHE_ALIAS(arm64_enable_wa2_handling);
 KVM_NVHE_ALIAS(kvm_patch_vector_branch);
-- 
2.28.0.618.gf4bc123cb7-goog

