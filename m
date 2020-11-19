Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AF22B97D9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgKSQ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgKSQ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:26:01 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7273C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:26:00 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id d18so6452598edt.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5MlXwXUoGcLbD/WCygRzjYFVebEXnf5c/lUquykfRUk=;
        b=v5R/bPXr6yxIRC4TnJkHhfGPg52KN0BTKGKdHosqzHDrdjOBD3OoLCLlGpvJ9vpZw7
         FSXShWWfwIGiDhhnTl+oinATAyoscG+OFYVmfCCL7jzESU8qE2IxvVgkmVLPG+p7Bx3R
         UHN1++6yqap4jQ2jeBeVZGOXdQq7aM0yVjNTXgCuXg6gJvlN6rsVY29Lj4/EWjZiGus5
         N7pIT1izOm/VG9jeByFsBKDqO1z2FtKo53LfYREwOu7hPbTk42Ytd61KbHMnKl3nx/Lb
         jLDGaZD/BWTfhIwijj1lfSbsElbzU4oc3GfhlicRYmkGh04JSc+aoeChsMyHNNWmj+9n
         MbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5MlXwXUoGcLbD/WCygRzjYFVebEXnf5c/lUquykfRUk=;
        b=KPIG+saoSJ4ldPDjB42nEKeMAZ/lNmTILjwVBaStsmhywAaoILqGblSwMlUNpPpTc/
         OLWm/aH1Ek/udt1Za14oz7SvRvUafRvY7d5uU+izytttvJnN3ouLQj6o00qTg9jHhEbn
         zTgCwS0fezuhzRowURI54ppWcl8O3Ne0yLu7BMbvt484sxPMATIdI7HymICpjQIVhjnf
         ASfA4I2q49YM+/Nrr1FAWYbd4VJLKnYJSvFqkJdykRzCJJIjEMkkFcBEUK3bdtaldOJ0
         ZzpjfL2OtkABFbnKHd+FXzcPW6ImxY1/S4tU/GXZipOHpKU7YZwJC4ESP1cA4diBYuJB
         J6Sw==
X-Gm-Message-State: AOAM530tJuoGfBWVjqoM7JOugI1Du0HaorrRZ1EOkrieLHZtT+S9DNjZ
        6J+g6MNQdhQyRhN87MAMURlisQ==
X-Google-Smtp-Source: ABdhPJx9s7H/MTHz69bsGrNQ0l5Py2P1/7O779gADrD4sMkOQcjiC5QVePAr1gZhJn1q2f5rE9zzyA==
X-Received: by 2002:a05:6402:19b4:: with SMTP id o20mr7995752edz.103.1605803159276;
        Thu, 19 Nov 2020 08:25:59 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9843:cd3f:f36b:d55c])
        by smtp.gmail.com with ESMTPSA id g7sm15689057edl.5.2020.11.19.08.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 08:25:58 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH 5/6] kvm: arm64: Fix constant-pool users in hyp
Date:   Thu, 19 Nov 2020 16:25:42 +0000
Message-Id: <20201119162543.78001-6-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119162543.78001-1-dbrazdil@google.com>
References: <20201119162543.78001-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyp code used to use absolute addressing via a constant pool to obtain
the kernel VA of 3 symbols - panic, __hyp_panic_string and
__kvm_handle_stub_hvc. This used to work because the kernel would
relocate the addresses in the constant pool to kernel VA at boot and hyp
would simply load them from there.

Now that relocations are fixed up to point to hyp VAs, this does not
work any longer. Rework the helpers to convert hyp VA to kernel VA / PA
as needed.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 29 +++++++++++++++++++----------
 arch/arm64/kvm/hyp/nvhe/host.S   | 29 +++++++++++++++--------------
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 8cb8974ec9cc..0676ff2105bb 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -72,9 +72,14 @@ alternative_cb kvm_update_va_mask
 alternative_cb_end
 .endm
 
+.macro hyp_pa reg, tmp
+	ldr_l	\tmp, hyp_physvirt_offset
+	add	\reg, \reg, \tmp
+.endm
+
 /*
- * Convert a kernel image address to a PA
- * reg: kernel address to be converted in place
+ * Convert a hypervisor VA to a kernel image address
+ * reg: hypervisor address to be converted in place
  * tmp: temporary register
  *
  * The actual code generation takes place in kvm_get_kimage_voffset, and
@@ -82,18 +87,22 @@ alternative_cb_end
  * perform the register allocation (kvm_get_kimage_voffset uses the
  * specific registers encoded in the instructions).
  */
-.macro kimg_pa reg, tmp
+.macro hyp_kimg reg, tmp
+	/* Convert hyp VA -> PA. */
+	hyp_pa	\reg, \tmp
+
+	/* Load kimage_voffset. */
 alternative_cb kvm_get_kimage_voffset
-       movz    \tmp, #0
-       movk    \tmp, #0, lsl #16
-       movk    \tmp, #0, lsl #32
-       movk    \tmp, #0, lsl #48
+	movz	\tmp, #0
+	movk	\tmp, #0, lsl #16
+	movk	\tmp, #0, lsl #32
+	movk	\tmp, #0, lsl #48
 alternative_cb_end
 
-       /* reg = __pa(reg) */
-       sub     \reg, \reg, \tmp
+	/* Convert PA -> kimg VA. */
+	add	\reg, \reg, \tmp
 .endm
-	 
+
 #else
 
 #include <linux/pgtable.h>
diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 596dd5ae8e77..bcb80d525d8c 100644
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
+	hyp_kimg lr, x6
 	msr	elr_el2, lr
 
-	/*
-	 * Set the panic format string and enter the host, conditionally
-	 * restoring the host context.
-	 */
+	/* Set the panic format string. Use the, now free, LR as scratch. */
+	ldr	lr, =__hyp_panic_string
+	hyp_kimg lr, x6
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
-- 
2.29.2.299.gdc1121823c-goog

