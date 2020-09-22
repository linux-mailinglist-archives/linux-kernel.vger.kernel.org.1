Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEE0274A56
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIVUtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgIVUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:49:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD0FC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so18567461wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgWGlE2IBAlgCGkRWqoEQwRpT6/N3qd1Q+BRhcwZDZc=;
        b=b4hrojdQte8QWeYLCiPSNSABZw4R7mloaUzWFqKdtEwXnDHSrp6nbwKdmyu8HK98o6
         vPD8drmTTIg5ifxhTwMCmoHLD7hzPwIlFTDYOQk6cF6TVWmxz9jpMH1T0jYa60fQs9OS
         bH08OtNrvCR3ATTNf1AQQBBfgX6GWOqg9o0+CkUbVV5U+OAqayr9kzVgamtFvpCoLWeU
         fmZZe4HhaYMMFGDD6wFT4bv5KFDYUOymBK3OTeXXRCvb3VnUvf2dMCpAYEVOJsKM4L+G
         4aYOyaVxESzEoNF2pZBGWBsUFCdN1xyc2AHOYj+OmDmIzGaJQLBX8gDaXmFvUy2BMWvD
         m12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgWGlE2IBAlgCGkRWqoEQwRpT6/N3qd1Q+BRhcwZDZc=;
        b=CgmKL0onjbUenk89QuPD5aop+k7KekQwiSRAXPs5XeTMHn0jguVpGw1knNWw7gH0ne
         yhThR4v0qII1rtJVJ9IdYEdlctiycAB0hJ1wxdEfDQIhU2cg+bHi/Eo36VmA2XdNaNHP
         hiTtx0XkjkapVBPXsEWfq5ipjTWp+HUI4oh3HUStCYkamUlGStAeBrdOsQ0R7wIyhNbD
         o8nXA0J9j1Hs5mJfpQFo/sbX486+FfeADXKZxZ42Xf+QhQ0MLRZ1MykdPPFD7mhlxuEI
         0QGFa1MfYHjFW+ZswmF/PWTkB1aCXwQWuYLMBUqwoTAiV9ULr/DcZIKxwDaaW/5XUmBi
         g2mA==
X-Gm-Message-State: AOAM530YSuaV7rTlZ3yVBUU3FRDfkMZUnWn6IuH/Z7CAu/evvpnjj4fA
        zWW1w8rzjbovadI2p5NqH7D+zA==
X-Google-Smtp-Source: ABdhPJwQOkTmORTiH0kGK9fq+pg0w2lWJEG8QjDiGw0F0wP+anozS8vVGWhXnKQJuGWHRjKKKiXLmw==
X-Received: by 2002:adf:dbc3:: with SMTP id e3mr7415703wrj.1.1600807756554;
        Tue, 22 Sep 2020 13:49:16 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:1105:630f:e990:272f])
        by smtp.gmail.com with ESMTPSA id 92sm29084887wra.19.2020.09.22.13.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:49:15 -0700 (PDT)
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
Subject: [PATCH v4 02/10] kvm: arm64: Move nVHE hyp namespace macros to hyp_image.h
Date:   Tue, 22 Sep 2020 21:49:02 +0100
Message-Id: <20200922204910.7265-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922204910.7265-1-dbrazdil@google.com>
References: <20200922204910.7265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup to move all macros related to prefixing nVHE hyp section
and symbol names into one place: hyp_image.h.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/hyp_image.h | 12 ++++++++++++
 arch/arm64/include/asm/kvm_asm.h   |  8 +-------
 arch/arm64/kernel/image-vars.h     |  2 --
 arch/arm64/kernel/vmlinux.lds.S    |  1 +
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
index 2e38fcda02fc..daa1a1da539e 100644
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
 	HYP_SECTION_NAME(NAME) : { *(NAME NAME##.*) }
 
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
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 7cba7623fcec..fbb13f38d0c5 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -9,6 +9,7 @@
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
+#include <asm/hyp_image.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/memory.h>
 #include <asm/page.h>
-- 
2.28.0.681.g6f77f65b4e-goog

