Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA06290C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 22:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393344AbgJPUEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 16:04:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43592 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393318AbgJPUEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 16:04:09 -0400
Received: by mail-io1-f65.google.com with SMTP id d20so5357198iop.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 13:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9kJ1tg3aSERgg5SGuHrK0w7ibt9o9ZuvSpdRW+CCIT0=;
        b=WUoIgibe5leplhk7htloTdbLPowR+eNXH3MkGnb7HVxtt+NcaF6+Y3irgzdFehIMPJ
         +ngH+tmCc8JysfIzcf2lXOXpBCHXXOxK1KCqfeurZPsCw4J1lZuAWloU87LacR931fm0
         nup6QwxQTurq74QtLjqkPlGPNYcF2crE48K9hrk6Hdb2IQTZ+PNhwoQoXksimVRn62Bh
         /iLlgPOYpPYDSdw+ItB/enGnr3bfrtFTxUH+rg8bF+0qOEt0nblRbULpMFVVoxqL5Q+D
         ZvVcVFTSw6OovQbDbFSuNr4MSgC+JPnCQ9vRBboyHsd5Kj+fChJTQC9fZnn8/V4ioxw6
         J7PQ==
X-Gm-Message-State: AOAM533EKU5nFXJhpfoT9pMSDBpNwpzsFAvZCqiJg4GZNH8wbI/5vrUf
        3PU0jFA8FJ2do1PiYZcXAMk=
X-Google-Smtp-Source: ABdhPJw0rm2I6IFbarOw4mBayJVg1YpUL6az8IzD3+kMCu59HbCInNSWYW8F2v8jM6tO6o7p/mXPYw==
X-Received: by 2002:a5d:9243:: with SMTP id e3mr3769756iol.193.1602878647257;
        Fri, 16 Oct 2020 13:04:07 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r2sm2886961ile.1.2020.10.16.13.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 13:04:06 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] x86/boot: Initialize boot_params in startup code
Date:   Fri, 16 Oct 2020 16:04:02 -0400
Message-Id: <20201016200404.1615994-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201016200404.1615994-1-nivedita@alum.mit.edu>
References: <20201016173232.GI8483@zn.tnic>
 <20201016200404.1615994-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save the boot_params pointer passed in by the bootloader in
startup_32/64. This avoids having to initialize it in multiple places in
C code, and having to preserve SI through the early assembly code.

Move boot_params from .bss to .data, since .bss will be cleared after
the kernel is relocated.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/compressed/head_32.S      | 12 ++++----
 arch/x86/boot/compressed/head_64.S      | 38 ++++++++-----------------
 arch/x86/boot/compressed/ident_map_64.c |  3 +-
 arch/x86/boot/compressed/misc.c         | 10 +------
 arch/x86/boot/compressed/pgtable_64.c   |  5 +---
 5 files changed, 22 insertions(+), 46 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 659fad53ca82..9b5c88d8b290 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -113,6 +113,9 @@ SYM_FUNC_START(startup_32)
 	addl    BP_init_size(%esi), %ebx
 	subl    $_end@GOTOFF, %ebx
 
+	/* Initialize boot_params */
+	movl	%esi, boot_params@GOTOFF(%edx)
+
 	/* Set up the stack */
 	leal	boot_stack_end@GOTOFF(%ebx), %esp
 
@@ -124,7 +127,6 @@ SYM_FUNC_START(startup_32)
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
  */
-	pushl	%esi
 	leal	(_bss@GOTOFF-4)(%edx), %esi
 	leal	(_bss@GOTOFF-4)(%ebx), %edi
 	movl	$(_bss - startup_32), %ecx
@@ -132,7 +134,6 @@ SYM_FUNC_START(startup_32)
 	std
 	rep	movsl
 	cld
-	popl	%esi
 
 	/*
 	 * The GDT may get overwritten either during the copy we just did or
@@ -187,14 +188,12 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	pushl	%eax			/* input_data */
 	leal	boot_heap@GOTOFF(%ebx), %eax
 	pushl	%eax			/* heap area */
-	pushl	%esi			/* real mode pointer */
 	call	extract_kernel		/* returns kernel location in %eax */
-	addl	$24, %esp
 
 /*
  * Jump to the extracted kernel.
  */
-	xorl	%ebx, %ebx
+	movl	boot_params@GOTOFF(%ebx), %esi
 	jmp	*%eax
 SYM_FUNC_END(.Lrelocated)
 
@@ -209,6 +208,9 @@ SYM_DATA_START_LOCAL(gdt)
 	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
+/* boot_params must be in .data because .bss is cleared after the kernel is relocated */
+SYM_DATA(boot_params, .long 0)
+
 #ifdef CONFIG_EFI_STUB
 SYM_DATA(image_offset, .long 0)
 #endif
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 3976b4e92e1b..521b41ca14fe 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -375,6 +375,9 @@ SYM_CODE_START(startup_64)
 	subl	$ rva(_end), %ebx
 	addq	%rbp, %rbx
 
+	/* Initialize boot_params */
+	movq	%rsi, boot_params(%rip)
+
 	/* Set up the stack */
 	leaq	rva(boot_stack_end)(%rbx), %rsp
 
@@ -429,14 +432,8 @@ SYM_CODE_START(startup_64)
 	 *   - Address of the trampoline is returned in RAX.
 	 *   - Non zero RDX means trampoline needs to enable 5-level
 	 *     paging.
-	 *
-	 * RSI holds real mode data and needs to be preserved across
-	 * this function call.
 	 */
-	pushq	%rsi
-	movq	%rsi, %rdi		/* real mode address */
 	call	paging_prepare
-	popq	%rsi
 
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
@@ -461,14 +458,9 @@ trampoline_return:
 	 *
 	 * RDI is address of the page table to use instead of page table
 	 * in trampoline memory (if required).
-	 *
-	 * RSI holds real mode data and needs to be preserved across
-	 * this function call.
 	 */
-	pushq	%rsi
 	leaq	rva(top_pgtable)(%rbx), %rdi
 	call	cleanup_trampoline
-	popq	%rsi
 
 	/* Zero EFLAGS */
 	pushq	$0
@@ -478,7 +470,6 @@ trampoline_return:
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
  */
-	pushq	%rsi
 	leaq	(_bss-8)(%rip), %rsi
 	leaq	rva(_bss-8)(%rbx), %rdi
 	movl	$(_bss - startup_32), %ecx
@@ -486,7 +477,6 @@ trampoline_return:
 	std
 	rep	movsq
 	cld
-	popq	%rsi
 
 	/*
 	 * The GDT may get overwritten either during the copy we just did or
@@ -541,31 +531,24 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
  * handler. Then load stage2 IDT and switch to the kernel's own
  * page-table.
  */
-	pushq	%rsi
 	call	set_sev_encryption_mask
 	call	load_stage2_idt
-	/* Pass boot_params to initialize_identity_maps */
-	popq	%rdi
-	pushq	%rdi
 	call	initialize_identity_maps
-	popq	%rsi
 
 /*
  * Do the extraction, and jump to the new kernel..
  */
-	pushq	%rsi			/* Save the real mode argument */
-	movq	%rsi, %rdi		/* real mode address */
-	leaq	boot_heap(%rip), %rsi	/* malloc area for uncompression */
-	leaq	input_data(%rip), %rdx  /* input_data */
-	movl	input_len(%rip), %ecx	/* input_len */
-	movq	%rbp, %r8		/* output target address */
-	movl	output_len(%rip), %r9d	/* decompressed length, end of relocs */
+	leaq	boot_heap(%rip), %rdi	/* malloc area for uncompression */
+	leaq	input_data(%rip), %rsi  /* input_data */
+	movl	input_len(%rip), %edx	/* input_len */
+	movq	%rbp, %rcx		/* output target address */
+	movl	output_len(%rip), %r8d	/* decompressed length, end of relocs */
 	call	extract_kernel		/* returns kernel location in %rax */
-	popq	%rsi
 
 /*
  * Jump to the decompressed kernel.
  */
+	movq	boot_params(%rip), %rsi
 	jmp	*%rax
 SYM_FUNC_END(.Lrelocated)
 
@@ -694,6 +677,9 @@ SYM_DATA_START(boot_idt)
 	.endr
 SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
 
+/* boot_params must be in .data because .bss is cleared after the kernel is relocated */
+SYM_DATA(boot_params, .quad 0)
+
 #ifdef CONFIG_EFI_STUB
 SYM_DATA(image_offset, .long 0)
 #endif
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index bf61581277c2..b679908c120e 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -107,7 +107,7 @@ static void add_identity_map(unsigned long start, unsigned long end)
 }
 
 /* Locates and clears a region for a new top level page table. */
-void initialize_identity_maps(void *rmode)
+void initialize_identity_maps(void)
 {
 	unsigned long cmdline;
 
@@ -159,7 +159,6 @@ void initialize_identity_maps(void *rmode)
 	 * touch them, or does not touch all the pages covering them.
 	 */
 	add_identity_map((unsigned long)_head, (unsigned long)_end);
-	boot_params = rmode;
 	add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
 	cmdline = get_cmd_line_ptr();
 	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 267e7f93050e..279631650bd8 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -39,11 +39,6 @@
 /* Functions used by the included decompressor code below. */
 void *memmove(void *dest, const void *src, size_t n);
 
-/*
- * This is set up by the setup-routine at boot-time
- */
-struct boot_params *boot_params;
-
 memptr free_mem_ptr;
 memptr free_mem_end_ptr;
 
@@ -338,7 +333,7 @@ static void parse_elf(void *output)
  *             |-------uncompressed kernel image---------|
  *
  */
-asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
+asmlinkage __visible void *extract_kernel(memptr heap,
 				  unsigned char *input_data,
 				  unsigned long input_len,
 				  unsigned char *output,
@@ -348,9 +343,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
 	unsigned long needed_size;
 
-	/* Retain x86 boot parameters pointer passed from startup_32/64. */
-	boot_params = rmode;
-
 	/* Clear flags intended for solely in-kernel use. */
 	boot_params->hdr.loadflags &= ~KASLR_FLAG;
 
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 5def1674d6f1..25add5510edc 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -105,13 +105,10 @@ static unsigned long find_trampoline_placement(void)
 	return bios_start - TRAMPOLINE_32BIT_SIZE;
 }
 
-struct paging_config paging_prepare(void *rmode)
+struct paging_config paging_prepare(void)
 {
 	struct paging_config paging_config = {};
 
-	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
-	boot_params = rmode;
-
 	/*
 	 * Check if LA57 is desired and supported.
 	 *
-- 
2.26.2

