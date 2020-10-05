Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A3B283FA8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgJETaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729388AbgJETaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:30:10 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11D6F207BC;
        Mon,  5 Oct 2020 19:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601926210;
        bh=cbVGVH5sddafW2g6ejTyN5cLRHTWb7bqOweP2u+vS+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRDpSd7uflsyvv061IWiaELt7lG7hpA/hFmHU7aiSYCoczyn4O2DSuK2n6dlyveAD
         5qNCoa8quVexrZEuX3coBdocSQdAFaGl9OdwoDvQKDuey2XZO3YWEAaHEe8XC3kUWz
         E/nexItdDhNBIGIUAg0C/T87tCwNnHCoeoA6Tf4g=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/2] x86/entry/32: Remove leftover macros after stackprotector cleanups
Date:   Mon,  5 Oct 2020 12:30:04 -0700
Message-Id: <1469babd36eb342aaa5e274a73a49293fad75272.1601925251.git.luto@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601925251.git.luto@kernel.org>
References: <cover.1601925251.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that nonlazy-GS mode is gone, remove the macros from entry_32.S
that obfuscated^Wabstracted GS handling.  The assembled output is
identical before and after this patch.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_32.S | 43 ++-------------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index ce6c3768ff65..58835e5ec866 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -53,35 +53,6 @@
 
 #define PTI_SWITCH_MASK         (1 << PAGE_SHIFT)
 
-/*
- * User gs save/restore
- *
- * This is leftover junk from CONFIG_X86_32_LAZY_GS.  A subsequent patch
- * will remove it entirely.
- */
- /* unfortunately push/pop can't be no-op */
-.macro PUSH_GS
-	pushl	$0
-.endm
-.macro POP_GS pop=0
-	addl	$(4 + \pop), %esp
-.endm
-.macro POP_GS_EX
-.endm
-
- /* all the rest are no-op */
-.macro PTGS_TO_GS
-.endm
-.macro PTGS_TO_GS_EX
-.endm
-.macro GS_TO_REG reg
-.endm
-.macro REG_TO_PTGS reg
-.endm
-.macro SET_KERNEL_GS reg
-.endm
-
-
 /* Unconditionally switch to user cr3 */
 .macro SWITCH_TO_USER_CR3 scratch_reg:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
@@ -234,7 +205,7 @@
 .macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0 unwind_espfix=0
 	cld
 .if \skip_gs == 0
-	PUSH_GS
+	pushl	$0
 .endif
 	pushl	%fs
 
@@ -259,9 +230,6 @@
 	movl	$(__USER_DS), %edx
 	movl	%edx, %ds
 	movl	%edx, %es
-.if \skip_gs == 0
-	SET_KERNEL_GS %edx
-.endif
 	/* Switch to kernel stack if necessary */
 .if \switch_stacks > 0
 	SWITCH_TO_KERNEL_STACK
@@ -300,7 +268,7 @@
 1:	popl	%ds
 2:	popl	%es
 3:	popl	%fs
-	POP_GS \pop
+	addl	$(4 + \pop), %esp	/* pop the unused "gs" slot */
 	IRET_FRAME
 .pushsection .fixup, "ax"
 4:	movl	$0, (%esp)
@@ -313,7 +281,6 @@
 	_ASM_EXTABLE(1b, 4b)
 	_ASM_EXTABLE(2b, 5b)
 	_ASM_EXTABLE(3b, 6b)
-	POP_GS_EX
 .endm
 
 .macro RESTORE_ALL_NMI cr3_reg:req pop=0
@@ -928,7 +895,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	movl	PT_EIP(%esp), %edx	/* pt_regs->ip */
 	movl	PT_OLDESP(%esp), %ecx	/* pt_regs->sp */
 1:	mov	PT_FS(%esp), %fs
-	PTGS_TO_GS
 
 	popl	%ebx			/* pt_regs->bx */
 	addl	$2*4, %esp		/* skip pt_regs->cx and pt_regs->dx */
@@ -964,7 +930,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	jmp	1b
 .popsection
 	_ASM_EXTABLE(1b, 2b)
-	PTGS_TO_GS_EX
 
 .Lsysenter_fix_flags:
 	pushl	$X86_EFLAGS_FIXED
@@ -1106,11 +1071,7 @@ SYM_CODE_START_LOCAL_NOALIGN(handle_exception)
 	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
 	ENCODE_FRAME_POINTER
 
-	/* fixup %gs */
-	GS_TO_REG %ecx
 	movl	PT_GS(%esp), %edi		# get the function address
-	REG_TO_PTGS %ecx
-	SET_KERNEL_GS %ecx
 
 	/* fixup orig %eax */
 	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
-- 
2.26.2

