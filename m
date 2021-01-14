Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EBC2F6B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbhANTnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:43:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729175AbhANTnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=360o/x4ZqeVu5+7Na9DmtSZt0qDu3O3xdQF63jJIqdA=;
        b=JPN8VzBWi36gHxuq5Lhl++tNAT1u24ujciY5Hj62N1TxtrRFqi8AeQYyZC1udsB5QTe24e
        3EOsMzq7/Z4o4UGkFiVil6NxQnh/+i3Jtkmc5m3twBD/xnVy7aw1Fn4dbtb9BC9iFsaTG9
        UhYAHiw4RdDSH1o7k3oXCNnsdPGZzCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-U7vjDBHAN9mB124vVQYirw-1; Thu, 14 Jan 2021 14:41:51 -0500
X-MC-Unique: U7vjDBHAN9mB124vVQYirw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7628A107ACF8;
        Thu, 14 Jan 2021 19:41:49 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1E9210023B4;
        Thu, 14 Jan 2021 19:41:46 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Miroslav Benes <mbenes@suse.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 20/21] x86/power: Move restore_registers() to top of the file
Date:   Thu, 14 Jan 2021 13:40:16 -0600
Message-Id: <66baa19ceda840fc89a3bed8e0549db1184685a5.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because restore_registers() is page-aligned, the assembler inexplicably
adds an unreachable jump from after the end of the previous function to
the beginning of restore_registers().

That confuses objtool, understandably.  It also creates significant text
fragmentation.  As a result, most of the object file is wasted text
(nops).

Move restore_registers() to the beginning of the file to both prevent
the text fragmentation and avoid the dead jump instruction.

$ size /tmp/hibernate_asm_64.before.o /tmp/hibernate_asm_64.after.o
   text	   data	    bss	    dec	    hex	filename
   4415	      0	      0	   4415	   113f	/tmp/hibernate_asm_64.before.o
    524	      0	      0	    524	    20c	/tmp/hibernate_asm_64.after.o

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/power/hibernate_asm_64.S | 92 +++++++++++++++----------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 24d971911c9d..4ca6d68b0293 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -23,6 +23,52 @@
 #include <asm/frame.h>
 #include <asm/nospec-branch.h>
 
+	 /* code below belongs to the image kernel */
+	.align PAGE_SIZE
+SYM_FUNC_START(restore_registers)
+	/* go back to the original page tables */
+	movq    %r9, %cr3
+
+	/* Flush TLB, including "global" things (vmalloc) */
+	movq	mmu_cr4_features(%rip), %rax
+	movq	%rax, %rdx
+	andq	$~(X86_CR4_PGE), %rdx
+	movq	%rdx, %cr4;  # turn off PGE
+	movq	%cr3, %rcx;  # flush TLB
+	movq	%rcx, %cr3
+	movq	%rax, %cr4;  # turn PGE back on
+
+	/* We don't restore %rax, it must be 0 anyway */
+	movq	$saved_context, %rax
+	movq	pt_regs_sp(%rax), %rsp
+	movq	pt_regs_bp(%rax), %rbp
+	movq	pt_regs_si(%rax), %rsi
+	movq	pt_regs_di(%rax), %rdi
+	movq	pt_regs_bx(%rax), %rbx
+	movq	pt_regs_cx(%rax), %rcx
+	movq	pt_regs_dx(%rax), %rdx
+	movq	pt_regs_r8(%rax), %r8
+	movq	pt_regs_r9(%rax), %r9
+	movq	pt_regs_r10(%rax), %r10
+	movq	pt_regs_r11(%rax), %r11
+	movq	pt_regs_r12(%rax), %r12
+	movq	pt_regs_r13(%rax), %r13
+	movq	pt_regs_r14(%rax), %r14
+	movq	pt_regs_r15(%rax), %r15
+	pushq	pt_regs_flags(%rax)
+	popfq
+
+	/* Saved in save_processor_state. */
+	lgdt	saved_context_gdt_desc(%rax)
+
+	xorl	%eax, %eax
+
+	/* tell the hibernation core that we've just restored the memory */
+	movq	%rax, in_suspend(%rip)
+
+	ret
+SYM_FUNC_END(restore_registers)
+
 SYM_FUNC_START(swsusp_arch_suspend)
 	movq	$saved_context, %rax
 	movq	%rsp, pt_regs_sp(%rax)
@@ -100,49 +146,3 @@ SYM_CODE_START(core_restore_code)
 	/* jump to the restore_registers address from the image header */
 	JMP_NOSPEC r8
 SYM_CODE_END(core_restore_code)
-
-	 /* code below belongs to the image kernel */
-	.align PAGE_SIZE
-SYM_FUNC_START(restore_registers)
-	/* go back to the original page tables */
-	movq    %r9, %cr3
-
-	/* Flush TLB, including "global" things (vmalloc) */
-	movq	mmu_cr4_features(%rip), %rax
-	movq	%rax, %rdx
-	andq	$~(X86_CR4_PGE), %rdx
-	movq	%rdx, %cr4;  # turn off PGE
-	movq	%cr3, %rcx;  # flush TLB
-	movq	%rcx, %cr3
-	movq	%rax, %cr4;  # turn PGE back on
-
-	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
-	movq	pt_regs_sp(%rax), %rsp
-	movq	pt_regs_bp(%rax), %rbp
-	movq	pt_regs_si(%rax), %rsi
-	movq	pt_regs_di(%rax), %rdi
-	movq	pt_regs_bx(%rax), %rbx
-	movq	pt_regs_cx(%rax), %rcx
-	movq	pt_regs_dx(%rax), %rdx
-	movq	pt_regs_r8(%rax), %r8
-	movq	pt_regs_r9(%rax), %r9
-	movq	pt_regs_r10(%rax), %r10
-	movq	pt_regs_r11(%rax), %r11
-	movq	pt_regs_r12(%rax), %r12
-	movq	pt_regs_r13(%rax), %r13
-	movq	pt_regs_r14(%rax), %r14
-	movq	pt_regs_r15(%rax), %r15
-	pushq	pt_regs_flags(%rax)
-	popfq
-
-	/* Saved in save_processor_state. */
-	lgdt	saved_context_gdt_desc(%rax)
-
-	xorl	%eax, %eax
-
-	/* tell the hibernation core that we've just restored the memory */
-	movq	%rax, in_suspend(%rip)
-
-	ret
-SYM_FUNC_END(restore_registers)
-- 
2.29.2

