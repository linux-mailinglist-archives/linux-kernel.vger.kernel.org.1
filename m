Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FF72FF771
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbhAUVjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:39:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726286AbhAUVcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611264639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+p8P2DTHRbkVLpPLGQBG59BZIX2VMhiBD+mRgRYmlFk=;
        b=FP283ZF/u2YqW5i0ksv0Kp7d0SEdw2sVWncubrdoNsvapt2AAUx4Nx5SdEqxdYDsuVDvBh
        66rgQoyoiPpvLrHB/ugK4BSA9EvVz0kDN7EjOM9lhkAUKjKT6o7GCtH9FLO3crnYjN7pEa
        yzUVO3zrqT4DlPYb5yC8Dn7PN6H/PAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-K1buBGpePFeVOWImmcFRnQ-1; Thu, 21 Jan 2021 16:30:35 -0500
X-MC-Unique: K1buBGpePFeVOWImmcFRnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6D66107ACE3;
        Thu, 21 Jan 2021 21:30:33 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DA8E19C59;
        Thu, 21 Jan 2021 21:30:31 +0000 (UTC)
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
Subject: [PATCH v2 19/20] x86/power: Move restore_registers() to top of the file
Date:   Thu, 21 Jan 2021 15:29:35 -0600
Message-Id: <8c7f634201d26453d73fe55032cbbdc05d004387.1611263462.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1611263461.git.jpoimboe@redhat.com>
References: <cover.1611263461.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
index 715509d94fa3..91c4602d2b5d 100644
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
@@ -102,49 +148,3 @@ SYM_CODE_START(core_restore_code)
 	ANNOTATE_RETPOLINE_SAFE
 	jmpq	*%r8
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

