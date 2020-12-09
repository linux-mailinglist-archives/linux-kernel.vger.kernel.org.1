Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B262D431A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbgLINTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732253AbgLINTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:19:19 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6F5C0617B0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:18:06 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e25so1651202wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ka29+EvLzBVuz3fav1ANCIbzhqqYwi6Q4TnNct9LPkw=;
        b=GPfaJhmZTf789tZ6o4bBL5H00oWtl28s03PNuYmXtEC0DzS7vZ6fCi2db4iIw/YC+D
         r1dM6gMfsFzU6WDlWzCNMeBoWmQ6xEjz4kIgTDVNATNmHG75fJQfbXu4jdZRTiYfpq2H
         Dk7CPz33RuE6JEDrNdDlpREIanGgLVvYaQOeaOn7XWPvQhziehz3AmfI5oRiyyTn9dq3
         fp9/AM3vLnDDsyE4sfNiz56C2yhMp2bG0rme7rq1sxMIRb+AKEbJR/j4/FDFGAYqX6/s
         Ea/eQzy86guK9WGUt9pl73Ymd5MjC7fLdWmrNJ6fYcgqmjk/jIFL+8NHWrD6BljBKy/S
         kH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ka29+EvLzBVuz3fav1ANCIbzhqqYwi6Q4TnNct9LPkw=;
        b=OZsMxJUcYyIqeS9pHabLHOrmOV7G54T5J4OtTlj1VUja272TbO6s8qBjvRHXJoNNGG
         UMsvk4JuBoyChvcEfVSs6DiWIXEQXICFa8Ojzb0tsdDfcLpQdtNrQfyR65YgesJDsQUS
         nigADpAH0ikiu/MYXLUQkzr6MzF+XCNsBG8rT0CG5FGxxUgGVgldb2BLDB0yqDrpCJUk
         qiLqjYWlEzPPEWYutoT+XAGQ6ZQ1u5hzEgBMHkuQlL9579HSyXPjT7brD4BBkFPvuz0M
         8bQ/X7hCsfUKwqEbbX+mvvqSks6OTpY0MDdk+9OIB5r7MYBUw8hS3tDxdfMgGSjz5xlX
         3mlg==
X-Gm-Message-State: AOAM530KbwD37Haiv6qjPnmseCpfG6YBnbEFY6iAhzgj9/So7M3H/dMh
        Wwbuhxci8r6N47BpXQwtaqdctg==
X-Google-Smtp-Source: ABdhPJxUH+7Om8LR7fdHJ1zEhtXybe8x1ZcwYnq6Mf5JFSkMDCTGF7hQ7t2De1RstIBLw7B9PuXGCg==
X-Received: by 2002:a1c:e1c6:: with SMTP id y189mr2689110wmg.172.1607519884763;
        Wed, 09 Dec 2020 05:18:04 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9d1b:d0eb:db43:6cd2])
        by smtp.gmail.com with ESMTPSA id z64sm3240255wme.10.2020.12.09.05.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 05:18:03 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 7/9] KVM: arm64: Fix constant-pool users in hyp
Date:   Wed,  9 Dec 2020 13:17:44 +0000
Message-Id: <20201209131746.85622-8-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209131746.85622-1-dbrazdil@google.com>
References: <20201209131746.85622-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyp code uses absolute addressing to obtain a kimg VA of a small number
of kernel symbols. Since the kernel now converts constant pool addresses
to hyp VAs, this trick does not work anymore.

Change the helpers to convert from hyp VA back to kimg VA or PA, as
needed and rework the callers accordingly.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h   | 42 ++++++++++++------------------
 arch/arm64/kvm/hyp/nvhe/host.S     | 29 +++++++++++----------
 arch/arm64/kvm/hyp/nvhe/hyp-init.S |  2 --
 3 files changed, 31 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 6bbb44011c84..adadc468cc71 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -73,49 +73,39 @@ alternative_cb_end
 .endm
 
 /*
- * Convert a kernel image address to a PA
- * reg: kernel address to be converted in place
+ * Convert a hypervisor VA to a PA
+ * reg: hypervisor address to be converted in place
  * tmp: temporary register
- *
- * The actual code generation takes place in kvm_get_kimage_voffset, and
- * the instructions below are only there to reserve the space and
- * perform the register allocation (kvm_get_kimage_voffset uses the
- * specific registers encoded in the instructions).
  */
-.macro kimg_pa reg, tmp
-alternative_cb kvm_get_kimage_voffset
-	movz	\tmp, #0
-	movk	\tmp, #0, lsl #16
-	movk	\tmp, #0, lsl #32
-	movk	\tmp, #0, lsl #48
-alternative_cb_end
-
-	/* reg = __pa(reg) */
-	sub	\reg, \reg, \tmp
+.macro hyp_pa reg, tmp
+	ldr_l	\tmp, hyp_physvirt_offset
+	add	\reg, \reg, \tmp
 .endm
 
 /*
- * Convert a kernel image address to a hyp VA
- * reg: kernel address to be converted in place
+ * Convert a hypervisor VA to a kernel image address
+ * reg: hypervisor address to be converted in place
  * tmp: temporary register
  *
  * The actual code generation takes place in kvm_get_kimage_voffset, and
  * the instructions below are only there to reserve the space and
- * perform the register allocation (kvm_update_kimg_phys_offset uses the
+ * perform the register allocation (kvm_get_kimage_voffset uses the
  * specific registers encoded in the instructions).
  */
-.macro kimg_hyp_va reg, tmp
-alternative_cb kvm_update_kimg_phys_offset
+.macro hyp_kimg_va reg, tmp
+	/* Convert hyp VA -> PA. */
+	hyp_pa	\reg, \tmp
+
+	/* Load kimage_voffset. */
+alternative_cb kvm_get_kimage_voffset
 	movz	\tmp, #0
 	movk	\tmp, #0, lsl #16
 	movk	\tmp, #0, lsl #32
 	movk	\tmp, #0, lsl #48
 alternative_cb_end
 
-	sub	\reg, \reg, \tmp
-	mov_q	\tmp, PAGE_OFFSET
-	orr	\reg, \reg, \tmp
-	kern_hyp_va \reg
+	/* Convert PA -> kimg VA. */
+	add	\reg, \reg, \tmp
 .endm
 
 #else
diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index a820dfdc9c25..6585a7cbbc56 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -74,27 +74,28 @@ SYM_FUNC_END(__host_enter)
  * void __noreturn __hyp_do_panic(bool restore_host, u64 spsr, u64 elr, u64 par);
  */
 SYM_FUNC_START(__hyp_do_panic)
-	/* Load the format arguments into x1-7 */
-	mov	x6, x3
-	get_vcpu_ptr x7, x3
-
-	mrs	x3, esr_el2
-	mrs	x4, far_el2
-	mrs	x5, hpfar_el2
-
 	/* Prepare and exit to the host's panic funciton. */
 	mov	lr, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
 		      PSR_MODE_EL1h)
 	msr	spsr_el2, lr
 	ldr	lr, =panic
+	hyp_kimg_va lr, x6
 	msr	elr_el2, lr
 
-	/*
-	 * Set the panic format string and enter the host, conditionally
-	 * restoring the host context.
-	 */
+	/* Set the panic format string. Use the, now free, LR as scratch. */
+	ldr	lr, =__hyp_panic_string
+	hyp_kimg_va lr, x6
+
+	/* Load the format arguments into x1-7. */
+	mov	x6, x3
+	get_vcpu_ptr x7, x3
+	mrs	x3, esr_el2
+	mrs	x4, far_el2
+	mrs	x5, hpfar_el2
+
+	/* Enter the host, conditionally restoring the host context. */
 	cmp	x0, xzr
-	ldr	x0, =__hyp_panic_string
+	mov	x0, lr
 	b.eq	__host_enter_without_restoring
 	b	__host_enter_for_panic
 SYM_FUNC_END(__hyp_do_panic)
@@ -124,7 +125,7 @@ SYM_FUNC_END(__hyp_do_panic)
 	 * Preserve x0-x4, which may contain stub parameters.
 	 */
 	ldr	x5, =__kvm_handle_stub_hvc
-	kimg_pa x5, x6
+	hyp_pa	x5, x6
 	br	x5
 .L__vect_end\@:
 .if ((.L__vect_end\@ - .L__vect_start\@) > 0x80)
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index 68fd64f2313e..99b408fe09ee 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -139,7 +139,6 @@ alternative_else_nop_endif
 
 	/* Set the host vector */
 	ldr	x0, =__kvm_hyp_host_vector
-	kimg_hyp_va x0, x1
 	msr	vbar_el2, x0
 
 	ret
@@ -198,7 +197,6 @@ SYM_CODE_START_LOCAL(__kvm_hyp_init_cpu)
 	/* Leave idmap. */
 	mov	x0, x29
 	ldr	x1, =kvm_host_psci_cpu_entry
-	kimg_hyp_va x1, x2
 	br	x1
 SYM_CODE_END(__kvm_hyp_init_cpu)
 
-- 
2.29.2.576.ga3fc446d84-goog

