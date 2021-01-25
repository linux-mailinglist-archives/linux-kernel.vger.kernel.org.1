Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E97B3030A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 00:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbhAYToW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731742AbhAYTV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:21:26 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B861EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:47 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id u16so4301501qvo.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iM7vyMjvp8HFtXYgFN4DAarGfV3AZjiwX6w+vbwvdyg=;
        b=cNVMTo7wVOFzkosxcDfMWZ2s1tXW6ofVvoFzZeHrw+FNJleyDydfxbhz3EfNsvpFJ/
         2s2rNi8tlVz1731hYXPPp+grZOrvK99ScwJsmxiKRan0biFSicPEerEV/fP0VD2+s3c0
         Q1CpZE03nirV+yKYJKAtAexxmsocy0Px9UBV7F6Y40euZaJWsR3luw71jBO7izoGBRQx
         6tTMZCqVvUdXzUTfrLOG5sToHBzDtqGXMuKPbC+C/uKPt/qHUepYF71bZy78jfYg1Yd2
         z1w0Pu0vk8UauVFL/7IgUBGL2IigtR4ZgVXHJa5k4bOOK6+3w66dkb66fuid43YHPtow
         s98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iM7vyMjvp8HFtXYgFN4DAarGfV3AZjiwX6w+vbwvdyg=;
        b=pZYTIt6XhLABxY7muJXtl+xdrNS2x9MwkPX504rwN/rP7NlqMQouWjnl6En3KozxiF
         lwc4+YEEscM+kgMXb80EfoUeD36uNR1Oh4HcbcO+VYxvV4ehPcsBbl2TSKmQF2NoZB/P
         Pw/OH8QyKGpGxwwRnYwRVISIqgv+5OgKIIcbIfzf72vlUNck71WKq8PI3EBqkz+0dRel
         KCC20XuvnBovT3z7JzJAGbKh437FXksqZR72TrpFKAKKhW5URznmBPS7FeU1MgXclJpD
         N6PSZMpDSkoS6BWSjNgfFoDxse3z2P9iKHEE6XLUa72bpRhqpdv/hYlMnixw+1rIIbaB
         JpTg==
X-Gm-Message-State: AOAM532IDrRHlWJqPEzcaYlRaoizLvqy++EoBJEIhk6+7GQrdexMmAjA
        SmDA3yvocsD800+gPfnzF7GQug==
X-Google-Smtp-Source: ABdhPJxSLliyq8RV2Enm412pyUsXXb9GvTpxItvdOl+cT7BuQwZg2qzmybsh1JfoC5G0oaCSxQ/2hw==
X-Received: by 2002:a0c:c38e:: with SMTP id o14mr2264022qvi.29.1611602386886;
        Mon, 25 Jan 2021 11:19:46 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:46 -0800 (PST)
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
Subject: [PATCH v10 14/18] arm64: kexec: use ld script for relocation function
Date:   Mon, 25 Jan 2021 14:19:19 -0500
Message-Id: <20210125191923.1060122-15-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, relocation code declares start and end variables
which are used to compute it size.

The better way to do this is to use ld script incited, and put relocation
function in its own section.

Soon, relocation function will share the same page with EL2 vectors. So,
proper marking is needed.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h      |  4 ++++
 arch/arm64/include/asm/sections.h   |  1 +
 arch/arm64/kernel/machine_kexec.c   | 17 ++++++++---------
 arch/arm64/kernel/relocate_kernel.S | 15 ++-------------
 arch/arm64/kernel/vmlinux.lds.S     | 19 +++++++++++++++++++
 5 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 990185744148..7f4f9abdf049 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -90,6 +90,10 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#if defined(CONFIG_KEXEC_CORE)
+extern const char arm64_relocate_new_kernel[];
+#endif
+
 /*
  * kern_reloc_arg is passed to kernel relocation function as an argument.
  * head		kimage->head, allows to traverse through relocation segments.
diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 8ff579361731..ae873eb22205 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -19,5 +19,6 @@ extern char __exittext_begin[], __exittext_end[];
 extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
+extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
 
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 679db3f1e0c5..361a4d082093 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -20,13 +20,10 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
+#include <asm/sections.h>
 
 #include "cpu-reset.h"
 
-/* Global variables for the arm64_relocate_new_kernel routine. */
-extern const unsigned char arm64_relocate_new_kernel[];
-extern const unsigned long arm64_relocate_new_kernel_size;
-
 /**
  * kexec_image_info - For debugging output.
  */
@@ -78,13 +75,15 @@ int machine_kexec_post_load(struct kimage *kimage)
 {
 	void *reloc_code = page_to_virt(kimage->control_code_page);
 	struct kern_reloc_arg *kern_reloc_arg = kexec_page_alloc(kimage);
+	long func_offset, reloc_size;
 
 	if (!kern_reloc_arg)
 		return -ENOMEM;
 
-	memcpy(reloc_code, arm64_relocate_new_kernel,
-	       arm64_relocate_new_kernel_size);
-	kimage->arch.kern_reloc = __pa(reloc_code);
+	func_offset = arm64_relocate_new_kernel - __relocate_new_kernel_start;
+	reloc_size = __relocate_new_kernel_end - __relocate_new_kernel_start;
+	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
+	kimage->arch.kern_reloc = __pa(reloc_code) + func_offset;
 	kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
 	kern_reloc_arg->head = kimage->head;
 	kern_reloc_arg->entry_addr = kimage->start;
@@ -92,9 +91,9 @@ int machine_kexec_post_load(struct kimage *kimage)
 	kexec_image_info(kimage);
 
 	/* Flush the reloc_code in preparation for its execution. */
-	__flush_dcache_area(reloc_code, arm64_relocate_new_kernel_size);
+	__flush_dcache_area(reloc_code, reloc_size);
 	flush_icache_range((uintptr_t)reloc_code, (uintptr_t)reloc_code +
-			   arm64_relocate_new_kernel_size);
+			   reloc_size);
 	__flush_dcache_area(kern_reloc_arg, sizeof(struct kern_reloc_arg));
 
 	return 0;
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index c92228aeddca..d2a4a0b0d76b 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -14,6 +14,7 @@
 #include <asm/page.h>
 #include <asm/sysreg.h>
 
+.pushsection    ".kexec_relocate.text", "ax"
 /*
  * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
  *
@@ -75,16 +76,4 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	ldr	x0, [x0, #KEXEC_KRELOC_KERN_ARG0]	/* x0 = dtb address */
 	br	x4
 SYM_CODE_END(arm64_relocate_new_kernel)
-
-.align 3	/* To keep the 64-bit values below naturally aligned. */
-
-.Lcopy_end:
-.org	KEXEC_CONTROL_PAGE_SIZE
-
-/*
- * arm64_relocate_new_kernel_size - Number of bytes to copy to the
- * control_code_page.
- */
-.globl arm64_relocate_new_kernel_size
-arm64_relocate_new_kernel_size:
-	.quad	.Lcopy_end - arm64_relocate_new_kernel
+.popsection
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 4c0b0c89ad59..33b0d3c9fd3b 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -12,6 +12,7 @@
 #include <asm/cache.h>
 #include <asm/hyp_image.h>
 #include <asm/kernel-pgtable.h>
+#include <asm/kexec.h>
 #include <asm/memory.h>
 #include <asm/page.h>
 
@@ -82,6 +83,16 @@ jiffies = jiffies_64;
 #define HIBERNATE_TEXT
 #endif
 
+#ifdef CONFIG_KEXEC_CORE
+#define KEXEC_TEXT					\
+	. = ALIGN(SZ_4K);				\
+	__relocate_new_kernel_start = .;		\
+	*(.kexec_relocate.text)				\
+	__relocate_new_kernel_end = .;
+#else
+#define KEXEC_TEXT
+#endif
+
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 #define TRAMP_TEXT					\
 	. = ALIGN(PAGE_SIZE);				\
@@ -142,6 +153,7 @@ SECTIONS
 			HYPERVISOR_TEXT
 			IDMAP_TEXT
 			HIBERNATE_TEXT
+			KEXEC_TEXT
 			TRAMP_TEXT
 			*(.fixup)
 			*(.gnu.warning)
@@ -316,3 +328,10 @@ ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) == PAGE_SIZE,
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
 ASSERT(_text == KIMAGE_VADDR, "HEAD is misaligned")
+
+#ifdef CONFIG_KEXEC_CORE
+/* kexec relocation code should fit into one KEXEC_CONTROL_PAGE_SIZE */
+ASSERT(__relocate_new_kernel_end - (__relocate_new_kernel_start & ~(SZ_4K - 1))
+	<= SZ_4K, "kexec relocation code is too big or misaligned")
+ASSERT(KEXEC_CONTROL_PAGE_SIZE >= SZ_4K, "KEXEC_CONTROL_PAGE_SIZE is brokern")
+#endif
-- 
2.25.1

