Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE7A302BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbhAYTlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731715AbhAYTVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:21:03 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2708FC0617AB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:49 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id t63so974725qkc.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lbvVstnavugORmz+7RoYwB1ceirdtrsJhtHKQ5onWhE=;
        b=IK8GwsbNp05JTiDZeLKhus1Kd2crIvvLrCxhH/bhmegAMs2Z7vCp9d9KDysrBeDIzB
         KfxvBNXH0aHs05LraLi8jmw16detVwNx9DuZtp/sIo3qMZqxfqpu59gbI149OG92xdpR
         BrFyLDIenN5JcmuFpWIbMiKc4uzG51cstbavtA7pMHPtalMM29HTadK2mLoOXJWU5BxK
         45HH6pKYIKWhfQ7huEmlUwbahY1bfK2R1z7LNKLBw4FcrzBIC5JKeyhBB9/bQJ+AHQBZ
         MQM5GrrFPz30IMgWgwFEjypPYyxfGfRD+/2oR5QMd8KQG6sPGUEoLJ4oRkCqK0gJSZZK
         orNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lbvVstnavugORmz+7RoYwB1ceirdtrsJhtHKQ5onWhE=;
        b=HcJDctHiUHxIMDGVTOhY4O0uP+ePPm8SNTslExw75sVjy6UW+1zKgeZQo1grKY640Y
         a8PaJEp6P3IM1F0CyvVNDslMf2xwyJ/rF1c1CqoZHLOB5kwd51URdtvL+rxG569FbSdf
         qOhde52QVmlzKg2XQ45XUou8vAQpkEoWAqV7peKaxvLPDnautIBvqch41U8IzekdNaYk
         Y2GIL/BE1R/T9guv+CSonPndGBY46LzTQb+GFmkbBcJ19VT2gULNx8yXyfc4Z2rQwuQf
         uns34jAjtPW1NKaPaWnLP8I7bVU6z+loa5qq6LCHoOBaCn9xEHb5NuS1ZqFnA8kFex7L
         9Sow==
X-Gm-Message-State: AOAM533zSXhBIQUA3BK6UUL8V7R/LKMM/yrBH8xOTdPQbdSuEi/m0z8x
        iex+93cnCtfxeO7AlG3i/DpQXQ==
X-Google-Smtp-Source: ABdhPJw6EjzUg6gmYM29zXvOx243XtORadzlnKH8/gi9zPCw6PpLiwryRc9t/9ZWzJPnyqYyMiOLXw==
X-Received: by 2002:ae9:dc87:: with SMTP id q129mr2285101qkf.297.1611602388372;
        Mon, 25 Jan 2021 11:19:48 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:47 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v10 15/18] arm64: kexec: kexec may require EL2 vectors
Date:   Mon, 25 Jan 2021 14:19:20 -0500
Message-Id: <20210125191923.1060122-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have a EL2 mode without VHE, the EL2 vectors are needed in order
to switch to EL2 and jump to new world with hypervisor privileges.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h      |  5 +++++
 arch/arm64/kernel/asm-offsets.c     |  1 +
 arch/arm64/kernel/machine_kexec.c   |  9 +++++++-
 arch/arm64/kernel/relocate_kernel.S | 35 +++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 7f4f9abdf049..b96d8a6aac80 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -92,6 +92,7 @@ static inline void crash_post_resume(void) {}
 
 #if defined(CONFIG_KEXEC_CORE)
 extern const char arm64_relocate_new_kernel[];
+extern const char arm64_kexec_el2_vectors[];
 #endif
 
 /*
@@ -101,6 +102,9 @@ extern const char arm64_relocate_new_kernel[];
  *		kernel, or purgatory entry address).
  * kern_arg0	first argument to kernel is its dtb address. The other
  *		arguments are currently unused, and must be set to 0
+ * el2_vector	If present means that relocation routine will go to EL1
+ *		from EL2 to do the copy, and then back to EL2 to do the jump
+ *		to new world.
  */
 struct kern_reloc_arg {
 	phys_addr_t head;
@@ -109,6 +113,7 @@ struct kern_reloc_arg {
 	phys_addr_t kern_arg1;
 	phys_addr_t kern_arg2;
 	phys_addr_t kern_arg3;
+	phys_addr_t el2_vector;
 };
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 6067a288f568..8a9475be1b62 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -159,6 +159,7 @@ int main(void)
   DEFINE(KEXEC_KRELOC_KERN_ARG1,	offsetof(struct kern_reloc_arg, kern_arg1));
   DEFINE(KEXEC_KRELOC_KERN_ARG2,	offsetof(struct kern_reloc_arg, kern_arg2));
   DEFINE(KEXEC_KRELOC_KERN_ARG3,	offsetof(struct kern_reloc_arg, kern_arg3));
+  DEFINE(KEXEC_KRELOC_EL2_VECTOR,	offsetof(struct kern_reloc_arg, el2_vector));
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 361a4d082093..41d1e3ca13f8 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -75,19 +75,26 @@ int machine_kexec_post_load(struct kimage *kimage)
 {
 	void *reloc_code = page_to_virt(kimage->control_code_page);
 	struct kern_reloc_arg *kern_reloc_arg = kexec_page_alloc(kimage);
-	long func_offset, reloc_size;
+	long func_offset, vector_offset, reloc_size;
 
 	if (!kern_reloc_arg)
 		return -ENOMEM;
 
 	func_offset = arm64_relocate_new_kernel - __relocate_new_kernel_start;
 	reloc_size = __relocate_new_kernel_end - __relocate_new_kernel_start;
+	vector_offset = arm64_kexec_el2_vectors - __relocate_new_kernel_start;
+
 	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
 	kimage->arch.kern_reloc = __pa(reloc_code) + func_offset;
 	kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
 	kern_reloc_arg->head = kimage->head;
 	kern_reloc_arg->entry_addr = kimage->start;
 	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
+
+	/* Setup vector table only when EL2 is available, but no VHE */
+	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode())
+		kern_reloc_arg->el2_vector = __pa(reloc_code) + vector_offset;
+
 	kexec_image_info(kimage);
 
 	/* Flush the reloc_code in preparation for its execution. */
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index d2a4a0b0d76b..c6178b1a4e60 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -14,6 +14,17 @@
 #include <asm/page.h>
 #include <asm/sysreg.h>
 
+.macro el1_sync_64
+	.align 7
+	br	x4			/* Jump to new world from el2 */
+.endm
+
+.macro invalid_vector label
+\label:
+	.align 7
+	b \label
+.endm
+
 .pushsection    ".kexec_relocate.text", "ax"
 /*
  * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
@@ -76,4 +87,28 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	ldr	x0, [x0, #KEXEC_KRELOC_KERN_ARG0]	/* x0 = dtb address */
 	br	x4
 SYM_CODE_END(arm64_relocate_new_kernel)
+
+/* el2 vectors - switch el2 here while we restore the memory image. */
+	.align 11
+SYM_CODE_START(arm64_kexec_el2_vectors)
+	invalid_vector el2_sync_invalid_sp0	/* Synchronous EL2t */
+	invalid_vector el2_irq_invalid_sp0	/* IRQ EL2t */
+	invalid_vector el2_fiq_invalid_sp0	/* FIQ EL2t */
+	invalid_vector el2_error_invalid_sp0	/* Error EL2t */
+
+	invalid_vector el2_sync_invalid_spx	/* Synchronous EL2h */
+	invalid_vector el2_irq_invalid_spx	/* IRQ EL2h */
+	invalid_vector el2_fiq_invalid_spx	/* FIQ EL2h */
+	invalid_vector el2_error_invalid_spx	/* Error EL2h */
+
+	el1_sync_64				/* Synchronous 64-bit EL1 */
+	invalid_vector el1_irq_invalid_64	/* IRQ 64-bit EL1 */
+	invalid_vector el1_fiq_invalid_64	/* FIQ 64-bit EL1 */
+	invalid_vector el1_error_invalid_64	/* Error 64-bit EL1 */
+
+	invalid_vector el1_sync_invalid_32	/* Synchronous 32-bit EL1 */
+	invalid_vector el1_irq_invalid_32	/* IRQ 32-bit EL1 */
+	invalid_vector el1_fiq_invalid_32	/* FIQ 32-bit EL1 */
+	invalid_vector el1_error_invalid_32	/* Error 32-bit EL1 */
+SYM_CODE_END(arm64_kexec_el2_vectors)
 .popsection
-- 
2.25.1

