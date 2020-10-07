Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5CB2868A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgJGTyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:54:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35797 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgJGTxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:53:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id 140so2640491qko.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 12:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KiOHhy5KKUz7TQszn/GYAoV1U9/vcQvqqlRKJqatrIE=;
        b=Z3srxTmxizr6jaL5RqK8h4m5p/FbCkwlhGk4KA2pBZMvWfZAOrovSxz23k24ZfKX3L
         V0K4aho5nbs6Mi65JnY5gpoFtSR9Bi5UkTEjShuL6CPxYaVTmio9ifOjgU/1yo2KjSNN
         iygZwmvtSkWtg2lOzAqRfclHaRUrRkrb2ttjs2ZaFtjBoA36MoWwo5CdxK8MPocuGVtU
         zE0aFl5X7h5kQEKo6u9XTY+UtiymSGZx8v4rWnETfynNrfl+/WAGiiaeperep3lAuu+n
         GG2JnAMtrOpL4H/G22Z5BqTXXkOeYeGXPyxpA3gMTUibgfRFUW+PlQ2iL+6P6wjmyFwd
         5DVQ==
X-Gm-Message-State: AOAM532E2XH3Lb85EoE3UWcXPwORZCQz/T9wO+dkRitu1hsHzs3v1jAB
        8NpYDyABGHlx0NbkT+/xyU0=
X-Google-Smtp-Source: ABdhPJwZ6ZXLEKxpDQcEaMX22gIvXL46eUQCKlsA7BAJSB4cX4GeAzFqobaZEAknrbCSZgZ/hcqbRQ==
X-Received: by 2002:ae9:dcc7:: with SMTP id q190mr4548227qkf.448.1602100433690;
        Wed, 07 Oct 2020 12:53:53 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k20sm2287658qtm.44.2020.10.07.12.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 12:53:53 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] x86/boot: Initialize boot_params in startup code
Date:   Wed,  7 Oct 2020 15:53:47 -0400
Message-Id: <20201007195351.776555-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007195351.776555-1-nivedita@alum.mit.edu>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save the boot_params pointer passed in by the bootloader in
startup_32/64. This avoids having to initialize it in two different
places in C code, and having to preserve SI through the early assembly
code.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_32.S    | 11 +++++----
 arch/x86/boot/compressed/head_64.S    | 34 +++++++++------------------
 arch/x86/boot/compressed/misc.c       | 10 +-------
 arch/x86/boot/compressed/pgtable_64.c |  5 +---
 4 files changed, 19 insertions(+), 41 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 659fad53ca82..c2b014ca92f7 100644
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
 
@@ -209,6 +208,8 @@ SYM_DATA_START_LOCAL(gdt)
 	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
+SYM_DATA(boot_params, .long 0)
+
 #ifdef CONFIG_EFI_STUB
 SYM_DATA(image_offset, .long 0)
 #endif
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1c80f1738fd9..78f873f76579 100644
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
@@ -541,28 +531,24 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
  * handler. Then load stage2 IDT and switch to the kernel's own
  * page-table.
  */
-	pushq	%rsi
 	call	set_sev_encryption_mask
 	call	load_stage2_idt
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
 
@@ -691,6 +677,8 @@ SYM_DATA_START(boot_idt)
 	.endr
 SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
 
+SYM_DATA(boot_params, .quad 0)
+
 #ifdef CONFIG_EFI_STUB
 SYM_DATA(image_offset, .long 0)
 #endif
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
index 7d0394f4ebf9..0fb948c0c8b4 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -98,13 +98,10 @@ static unsigned long find_trampoline_placement(void)
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

