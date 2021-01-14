Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BB82F6B66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbhANTmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:42:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730028AbhANTmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t21cAnb3L3Z7NhjIc+d58UvtfFBdyFuHHVl8QbIF49E=;
        b=eWUhf1Uzig6JY1Hqf+pjBprZzBzXOcFyConI2dgBsxVB64fKtprc1KvUgFkq1IYwlbXB+h
        CQFA7X7jnvXgcbjm+LozslK+INzzrZouwjuzAqfyaNkADNNSFh60y0tViJYedxmiUdJv28
        K4fCb89scMqEW2CSdY4ouzC7xnlTKuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-R5C5sLJ4Ph-ofH3mVLmZ0w-1; Thu, 14 Jan 2021 14:41:23 -0500
X-MC-Unique: R5C5sLJ4Ph-ofH3mVLmZ0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8329B806661;
        Thu, 14 Jan 2021 19:41:21 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E77B01001E73;
        Thu, 14 Jan 2021 19:41:18 +0000 (UTC)
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
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 13/21] x86/xen: Support objtool validation in xen-asm.S
Date:   Thu, 14 Jan 2021 13:40:09 -0600
Message-Id: <77629463ea258e47d8d53bc8947da24dd2923931.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OBJECT_FILES_NON_STANDARD annotation is used to tell objtool to
ignore a file.  File-level ignores won't work when validating vmlinux.o.

Tweak the ELF metadata and unwind hints to allow objtool to follow the
code.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/xen/Makefile  |  1 -
 arch/x86/xen/xen-asm.S | 29 +++++++++++++++++++----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index fc5c5ba4aacb..40b5779fce21 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-OBJECT_FILES_NON_STANDARD_xen-asm.o := y
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 1cb0e84b9161..a05e80b552c0 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -14,6 +14,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm.h>
 #include <asm/frame.h>
+#include <asm/unwind_hints.h>
 
 #include <xen/interface/xen.h>
 
@@ -146,6 +147,7 @@ SYM_FUNC_END(xen_read_cr2_direct);
 
 .macro xen_pv_trap name
 SYM_CODE_START(xen_\name)
+	UNWIND_HINT_EMPTY
 	pop %rcx
 	pop %r11
 	jmp  \name
@@ -184,6 +186,7 @@ xen_pv_trap asm_exc_xen_hypervisor_callback
 SYM_CODE_START(xen_early_idt_handler_array)
 	i = 0
 	.rept NUM_EXCEPTION_VECTORS
+	UNWIND_HINT_EMPTY
 	pop %rcx
 	pop %r11
 	jmp early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE
@@ -210,11 +213,13 @@ hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
  * rsp->rax		}
  */
 SYM_CODE_START(xen_iret)
+	UNWIND_HINT_EMPTY
 	pushq $0
 	jmp hypercall_iret
 SYM_CODE_END(xen_iret)
 
 SYM_CODE_START(xen_sysret64)
+	UNWIND_HINT_EMPTY
 	/*
 	 * We're already on the usermode stack at this point, but
 	 * still with the kernel gs, so we can easily switch back.
@@ -250,7 +255,8 @@ SYM_CODE_END(xen_sysret64)
  */
 
 /* Normal 64-bit system call target */
-SYM_FUNC_START(xen_syscall_target)
+SYM_CODE_START(xen_syscall_target)
+	UNWIND_HINT_EMPTY
 	popq %rcx
 	popq %r11
 
@@ -263,12 +269,13 @@ SYM_FUNC_START(xen_syscall_target)
 	movq $__USER_CS, 1*8(%rsp)
 
 	jmp entry_SYSCALL_64_after_hwframe
-SYM_FUNC_END(xen_syscall_target)
+SYM_CODE_END(xen_syscall_target)
 
 #ifdef CONFIG_IA32_EMULATION
 
 /* 32-bit compat syscall target */
-SYM_FUNC_START(xen_syscall32_target)
+SYM_CODE_START(xen_syscall32_target)
+	UNWIND_HINT_EMPTY
 	popq %rcx
 	popq %r11
 
@@ -281,10 +288,11 @@ SYM_FUNC_START(xen_syscall32_target)
 	movq $__USER32_CS, 1*8(%rsp)
 
 	jmp entry_SYSCALL_compat_after_hwframe
-SYM_FUNC_END(xen_syscall32_target)
+SYM_CODE_END(xen_syscall32_target)
 
 /* 32-bit compat sysenter target */
-SYM_FUNC_START(xen_sysenter_target)
+SYM_CODE_START(xen_sysenter_target)
+	UNWIND_HINT_EMPTY
 	/*
 	 * NB: Xen is polite and clears TF from EFLAGS for us.  This means
 	 * that we don't need to guard against single step exceptions here.
@@ -301,17 +309,18 @@ SYM_FUNC_START(xen_sysenter_target)
 	movq $__USER32_CS, 1*8(%rsp)
 
 	jmp entry_SYSENTER_compat_after_hwframe
-SYM_FUNC_END(xen_sysenter_target)
+SYM_CODE_END(xen_sysenter_target)
 
 #else /* !CONFIG_IA32_EMULATION */
 
-SYM_FUNC_START_ALIAS(xen_syscall32_target)
-SYM_FUNC_START(xen_sysenter_target)
+SYM_CODE_START(xen_syscall32_target)
+SYM_CODE_START(xen_sysenter_target)
+	UNWIND_HINT_EMPTY
 	lea 16(%rsp), %rsp	/* strip %rcx, %r11 */
 	mov $-ENOSYS, %rax
 	pushq $0
 	jmp hypercall_iret
-SYM_FUNC_END(xen_sysenter_target)
-SYM_FUNC_END_ALIAS(xen_syscall32_target)
+SYM_CODE_END(xen_sysenter_target)
+SYM_CODE_END(xen_syscall32_target)
 
 #endif	/* CONFIG_IA32_EMULATION */
-- 
2.29.2

