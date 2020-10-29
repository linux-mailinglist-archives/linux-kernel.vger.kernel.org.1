Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF8E29F11D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgJ2QTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:19:07 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:43739 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgJ2QTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:19:06 -0400
Received: by mail-il1-f169.google.com with SMTP id k1so3597393ilc.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnkHWYi/mB+cyNeFBjJA4fKnzQnG8J70PhnBP+2bv8U=;
        b=hEjAOiyGw71yChPa+IAlmu1+8KknAivi6jw2aicEoY1dxTmdgCrkhTR1RoyYMS/T2c
         SmQTAi2+wzbaldNxMCtcels0P/qDTJXhS1qh8WyZ5Nv2UJRR7BvpdD/LzZWv8Ivq5cfd
         9qmh4AtILGyrs6nVa5KIrlc96C/2/uVUDCpg40tDf2UVssOJWg1Gd9SoooSCHkeiWGrt
         1kcRp8xi+QUMDDXf+XwQJrxIKj3iBjBsAUHjpz0+3VBZrAj0ggDeNVAR0+ISZme3w2dJ
         U30jLxvvgnmIkLWtmlYBKD8g67w0atH9AhHI/VbaRl1w/Wdpx/FdbZzYgISQI4I6nSx3
         9vyQ==
X-Gm-Message-State: AOAM530txRXWbc4pzre9CsF5EnmvpyTKC2dBNENHmjga01kZaGl/zW1n
        bq9O7tnH8+FaO3qqFS6wIuP0o9oMmarrGA==
X-Google-Smtp-Source: ABdhPJwec3b9HHO+5povOHpBLfQB4LYKeEYyIzfIp6PD2Jlh3cr8oZtr/RivxZJ+P2BjIQS4gusbog==
X-Received: by 2002:a92:650d:: with SMTP id z13mr3973212ilb.23.1603988345087;
        Thu, 29 Oct 2020 09:19:05 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y3sm2695711ilc.49.2020.10.29.09.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:19:04 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/build: Fix vmlinux size check on 64-bit
Date:   Thu, 29 Oct 2020 12:19:03 -0400
Message-Id: <20201029161903.2553528-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201028204549.GA2231038@rani.riverdale.lan>
References: <20201028204549.GA2231038@rani.riverdale.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b4e0409a36f4 ("x86: check vmlinux limits, 64-bit") added a check
that the size of the 64-bit kernel is less than KERNEL_IMAGE_SIZE.

The check uses (_end - _text), but this is not enough. The initial PMD
used in startup_64() (level2_kernel_pgt) can only map upto
KERNEL_IMAGE_SIZE from __START_KERNEL_map, not from _text, and the
modules area (MODULES_VADDR) starts at KERNEL_IMAGE_SIZE.

The correct check is what is currently done for 32-bit, since
LOAD_OFFSET is defined appropriately for the two architectures. Just
check (_end - LOAD_OFFSET) against KERNEL_IMAGE_SIZE unconditionally.

Note that on 32-bit, the limit is not strict: KERNEL_IMAGE_SIZE is not
really used by the main kernel. The higher the kernel is located, the
less the space available for the vmalloc area. However, it is used by
KASLR in the compressed stub to limit the maximum address of the kernel
to a safe value.

Clean up various comments to clarify that despite the name,
KERNEL_IMAGE_SIZE is not a limit on the size of the kernel image, but a
limit on the maximum virtual address that the image can occupy.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/include/asm/page_32_types.h |  8 +++++++-
 arch/x86/include/asm/page_64_types.h |  6 ++++--
 arch/x86/include/asm/pgtable_32.h    | 18 ++++++------------
 arch/x86/kernel/head_64.S            | 20 +++++++++-----------
 arch/x86/kernel/vmlinux.lds.S        | 11 ++---------
 5 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
index f462895a33e4..faf9cc1c14bb 100644
--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -53,7 +53,13 @@
 #define STACK_TOP_MAX		STACK_TOP
 
 /*
- * Kernel image size is limited to 512 MB (see in arch/x86/kernel/head_32.S)
+ * In spite of the name, KERNEL_IMAGE_SIZE is a limit on the maximum virtual
+ * address for the kernel image, rather than the limit on the size itself. On
+ * 32-bit, this is not a strict limit, but this value is used to limit the
+ * link-time virtual address range of the kernel, and by KASLR to limit the
+ * randomized address from which the kernel is executed. A relocatable kernel
+ * can be loaded somewhat higher than KERNEL_IMAGE_SIZE as long as enough space
+ * remains for the vmalloc area.
  */
 #define KERNEL_IMAGE_SIZE	(512 * 1024 * 1024)
 
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 3f49dac03617..645bd1d0ee07 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -98,8 +98,10 @@
 #define STACK_TOP_MAX		TASK_SIZE_MAX
 
 /*
- * Maximum kernel image size is limited to 1 GiB, due to the fixmap living
- * in the next 1 GiB (see level2_kernel_pgt in arch/x86/kernel/head_64.S).
+ * In spite of the name, KERNEL_IMAGE_SIZE is a limit on the maximum virtual
+ * address for the kernel image, rather than the limit on the size itself.
+ * This can be at most 1 GiB, due to the fixmap living in the next 1 GiB (see
+ * level2_kernel_pgt in arch/x86/kernel/head_64.S).
  *
  * On KASLR use 1 GiB by default, leaving 1 GiB for modules once the
  * page tables are fully set up.
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index d7acae4120d5..7c9c968a42ef 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -57,19 +57,13 @@ do {						\
 #endif
 
 /*
- * This is how much memory in addition to the memory covered up to
- * and including _end we need mapped initially.
- * We need:
- *     (KERNEL_IMAGE_SIZE/4096) / 1024 pages (worst case, non PAE)
- *     (KERNEL_IMAGE_SIZE/4096) / 512 + 4 pages (worst case for PAE)
+ * This is used to calculate the .brk reservation for initial pagetables.
+ * Enough space is reserved to allocate pagetables sufficient to cover all
+ * of LOWMEM_PAGES, which is an upper bound on the size of the direct map of
+ * lowmem.
  *
- * Modulo rounding, each megabyte assigned here requires a kilobyte of
- * memory, which is currently unreclaimed.
- *
- * This should be a multiple of a page.
- *
- * KERNEL_IMAGE_SIZE should be greater than pa(_end)
- * and small than max_low_pfn, otherwise will waste some page table entries
+ * With PAE paging (PTRS_PER_PMD > 1), we allocate PTRS_PER_PGD == 4 pages for
+ * the PMD's in addition to the pages required for the last level pagetables.
  */
 #if PTRS_PER_PMD > 1
 #define PAGE_TABLE_SIZE(pages) (((pages) / PTRS_PER_PMD) + PTRS_PER_PGD)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 7eb2a1c87969..d41fa5bb77fe 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -524,21 +524,19 @@ SYM_DATA_END(level3_kernel_pgt)
 
 SYM_DATA_START_PAGE_ALIGNED(level2_kernel_pgt)
 	/*
-	 * 512 MB kernel mapping. We spend a full page on this pagetable
-	 * anyway.
+	 * Kernel high mapping.
 	 *
-	 * The kernel code+data+bss must not be bigger than that.
+	 * The kernel code+data+bss must be located below KERNEL_IMAGE_SIZE in
+	 * virtual address space, which is 1 GiB if RANDOMIZE_BASE is enabled,
+	 * 512 MiB otherwise.
 	 *
-	 * (NOTE: at +512MB starts the module area, see MODULES_VADDR.
-	 *  If you want to increase this then increase MODULES_VADDR
-	 *  too.)
+	 * (NOTE: after that starts the module area, see MODULES_VADDR.)
 	 *
-	 *  This table is eventually used by the kernel during normal
-	 *  runtime.  Care must be taken to clear out undesired bits
-	 *  later, like _PAGE_RW or _PAGE_GLOBAL in some cases.
+	 * This table is eventually used by the kernel during normal runtime.
+	 * Care must be taken to clear out undesired bits later, like _PAGE_RW
+	 * or _PAGE_GLOBAL in some cases.
 	 */
-	PMDS(0, __PAGE_KERNEL_LARGE_EXEC,
-		KERNEL_IMAGE_SIZE/PMD_SIZE)
+	PMDS(0, __PAGE_KERNEL_LARGE_EXEC, KERNEL_IMAGE_SIZE/PMD_SIZE)
 SYM_DATA_END(level2_kernel_pgt)
 
 SYM_DATA_START_PAGE_ALIGNED(level2_fixmap_pgt)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index bf9e0adb5b7e..b38832821b98 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -454,13 +454,12 @@ SECTIONS
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
 
-#ifdef CONFIG_X86_32
 /*
  * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
  */
 . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
-#else
+#ifdef CONFIG_X86_64
 /*
  * Per-cpu symbols which need to be offset from __per_cpu_load
  * for the boot processor.
@@ -470,18 +469,12 @@ INIT_PER_CPU(gdt_page);
 INIT_PER_CPU(fixed_percpu_data);
 INIT_PER_CPU(irq_stack_backing_store);
 
-/*
- * Build-time check on the image size:
- */
-. = ASSERT((_end - _text <= KERNEL_IMAGE_SIZE),
-	   "kernel image bigger than KERNEL_IMAGE_SIZE");
-
 #ifdef CONFIG_SMP
 . = ASSERT((fixed_percpu_data == 0),
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
-#endif /* CONFIG_X86_32 */
+#endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_KEXEC_CORE
 #include <asm/kexec.h>
-- 
2.26.2

