Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FAA2C58B6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391440AbgKZPyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391428AbgKZPyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:54:45 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06833C061A47
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:45 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u12so2663670wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=utPvkzoqy6/nIv7yirT7WFlgfKz1OWQA6qiMqU5NSCo=;
        b=L83CDnryQMuuOUO42YEM1Fei9cFaqRJ6AxwBerQHFEt9tWXMW0lNOkPpS2bejSW/iu
         tEbbm0lx868wYcgllszhwgBocoNjjhpRethBq4ewq1j2wlI0/ZkmNjLzjNhb/T5wDs0L
         uE8FlKRHQVHKYNpJJmKdt8Oqd7WY7PiRrcKTAyrLPIZe14wtKCPqpe0/nA/ozRQN8zVy
         prbEpoF0/+E0KBzkxM79MvkufhuPbIS5u0EoQplVHSL8Zj8YC8wXXkPWfHECdf9KcpuD
         LGOTL0W9oT4TEWa0ylv9yro0tguEgWkdJ6sWfhkDrJ4ahom5TB2nKKtsgMzPLBwm/SDX
         ZG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=utPvkzoqy6/nIv7yirT7WFlgfKz1OWQA6qiMqU5NSCo=;
        b=GLrHb8Rvd84wY11euH/yaivBzmdcHmY/EuufzQ/XJDbChTkRaIcItIfj2N/FWEhTGm
         Z0hayG9xS29waG6rFiTnTGhtPeJTpVHAMb8a+Km9yP3WR+CBp2SMGWU/QP2AVgTI6Xpa
         ajlAphRU9tRUwSndyy4iLBJ1xi5btzNBQtlcrvLQRA74Od8ys1iX87hheOk4mjcXKHZJ
         dKABaIeah5yatKcTz0Mu63R/mpdm9CL3xuQPkUQAfhIi63Qos6VyMHiiYDXAuKlNfrFu
         c9MYzrIcujNUJrmZFanMTMxjSLzey8PDE2yawATdLro0tgcnG/IYNwbZRsKFeHTemcK/
         rZkA==
X-Gm-Message-State: AOAM533DoWtc69Aw7WTvtU+PAyCAs8THI3UdWFXnhOu2YLCzjYqltuBW
        NTGdcqd3q885jrBl3aCbxB+JlA==
X-Google-Smtp-Source: ABdhPJxbpHUEbEI7H8KyDN6Qt9yHuAuJ3eZuUVlv4sN6UGfKQTpLTnLejNgi4Q50yjIL+OaOhuCKIw==
X-Received: by 2002:a5d:6191:: with SMTP id j17mr4556274wru.299.1606406083603;
        Thu, 26 Nov 2020 07:54:43 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id j8sm9486504wrx.11.2020.11.26.07.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:54:42 -0800 (PST)
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
Subject: [PATCH v3 08/23] kvm: arm64: Remove vector_ptr param of hyp-init
Date:   Thu, 26 Nov 2020 15:54:06 +0000
Message-Id: <20201126155421.14901-9-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM precomputes the hyp VA of __kvm_hyp_host_vector, essentially a
constant (minus ASLR), before passing it to __kvm_hyp_init.
Now that we have alternatives for converting kimg VA to hyp VA, replace
this with computing the constant inside __kvm_hyp_init, thus removing
the need for an argument.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h   |  2 --
 arch/arm64/include/asm/kvm_mmu.h   | 26 +++++++++++++++++++++++++-
 arch/arm64/kvm/arm.c               |  4 +---
 arch/arm64/kvm/hyp/nvhe/hyp-init.S |  9 ++++++---
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 4a6a77d8d13e..531f9d04eefd 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -163,10 +163,8 @@ struct kvm_vcpu;
 struct kvm_s2_mmu;
 
 DECLARE_KVM_NVHE_SYM(__kvm_hyp_init);
-DECLARE_KVM_NVHE_SYM(__kvm_hyp_host_vector);
 DECLARE_KVM_HYP_SYM(__kvm_hyp_vector);
 #define __kvm_hyp_init		CHOOSE_NVHE_SYM(__kvm_hyp_init)
-#define __kvm_hyp_host_vector	CHOOSE_NVHE_SYM(__kvm_hyp_host_vector)
 #define __kvm_hyp_vector	CHOOSE_HYP_SYM(__kvm_hyp_vector)
 
 extern unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 5168a0c516ae..6945faeb68ac 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -93,7 +93,31 @@ alternative_cb_end
        /* reg = __pa(reg) */
        sub     \reg, \reg, \tmp
 .endm
-	 
+
+/*
+ * Convert a kernel image address to a hyp VA
+ * reg: kernel address to be converted in place
+ * tmp: temporary register
+ *
+ * The actual code generation takes place in kvm_get_kimage_voffset, and
+ * the instructions below are only there to reserve the space and
+ * perform the register allocation (kvm_get_kimage_voffset uses the
+ * specific registers encoded in the instructions).
+ */
+.macro kimg_hyp_va reg, tmp
+alternative_cb kvm_update_kimg_phys_offset
+	movz	\tmp, #0
+	movk	\tmp, #0, lsl #16
+	movk	\tmp, #0, lsl #32
+	movk	\tmp, #0, lsl #48
+alternative_cb_end
+
+	sub	\reg, \reg, \tmp
+	mov_q	\tmp, PAGE_OFFSET
+	orr	\reg, \reg, \tmp
+	kern_hyp_va \reg
+.endm
+
 #else
 
 #include <linux/pgtable.h>
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index b25035dc0478..cd6e5dec203f 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1355,7 +1355,6 @@ static void cpu_init_hyp_mode(void)
 {
 	phys_addr_t pgd_ptr;
 	unsigned long hyp_stack_ptr;
-	unsigned long vector_ptr;
 	unsigned long tpidr_el2;
 	struct arm_smccc_res res;
 
@@ -1373,7 +1372,6 @@ static void cpu_init_hyp_mode(void)
 	pgd_ptr = kvm_mmu_get_httbr();
 	hyp_stack_ptr = __this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE;
 	hyp_stack_ptr = kern_hyp_va(hyp_stack_ptr);
-	vector_ptr = (unsigned long)kern_hyp_va(kvm_ksym_ref(__kvm_hyp_host_vector));
 
 	/*
 	 * Call initialization code, and switch to the full blown HYP code.
@@ -1383,7 +1381,7 @@ static void cpu_init_hyp_mode(void)
 	 */
 	BUG_ON(!system_capabilities_finalized());
 	arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(__kvm_hyp_init),
-			  pgd_ptr, tpidr_el2, hyp_stack_ptr, vector_ptr, &res);
+			  pgd_ptr, tpidr_el2, hyp_stack_ptr, &res);
 	WARN_ON(res.a0 != SMCCC_RET_SUCCESS);
 
 	/*
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index 17b58dbc3a2f..b3492a3c4232 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -50,7 +50,6 @@ __invalid:
 	 * x1: HYP pgd
 	 * x2: per-CPU offset
 	 * x3: HYP stack
-	 * x4: HYP vectors
 	 */
 __do_hyp_init:
 	/* Check for a stub HVC call */
@@ -134,9 +133,13 @@ alternative_else_nop_endif
 	msr	sctlr_el2, x0
 	isb
 
-	/* Set the stack and new vectors */
+	/* Set the stack */
 	mov	sp, x3
-	msr	vbar_el2, x4
+
+	/* Set the host vector */
+	ldr	x0, =__kvm_hyp_host_vector
+	kimg_hyp_va x0, x1
+	msr	vbar_el2, x0
 
 	/* Hello, World! */
 	mov	x0, #SMCCC_RET_SUCCESS
-- 
2.29.2.454.gaff20da3a2-goog

