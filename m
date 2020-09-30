Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B05027F5F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbgI3X0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:26:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:25937 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731339AbgI3X0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:26:21 -0400
IronPort-SDR: gglKY07DKkjJXxDcMF4KCx551bHFlPwQmc/AStqiXV4/mS+oQEqsxkfM/qfzh0c77vV0yIYpHM
 XMqi2nZSoJgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="159975252"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="159975252"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:26:18 -0700
IronPort-SDR: Qly2IdgSlAUT/1UUIp4Me5iai1Tvl/+ai47u8QjHDBok0rfQHxEqzHVmSyUsjMEvzy951rC4sD
 vIUbJtr2AI2g==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="457857975"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:26:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] x86/mce: Add _ASM_EXTABLE_CPY for copy user access
Date:   Wed, 30 Sep 2020 16:26:07 -0700
Message-Id: <20200930232611.15355-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200930232611.15355-1-tony.luck@intel.com>
References: <20200921113144.GD5901@zn.tnic>
 <20200930232611.15355-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

_ASM_EXTABLE_UA is a general exception entry to record the exception fixup
for all exception spots between kernel and user space access.

To enable recovery from machine checks while coping data from user
addresses we need to be able to distinguish the places that are
looping copying data from those that copy a single byte/word/etc.

Add a new macro _ASM_EXTABLE_CPY and use it in place of _ASM_EXTABLE_UA
in the copy functions.

Record the exception reason number to regs->ax at
ex_handler_uaccess which is used to check MCE triggered.

The new fixup routine ex_handler_copy() is almost an exact copy of
ex_handler_uaccess() The difference is that it sets regs->ax to the trap
number. Following patches use this to avoid trying to copy remaining
bytes from the tail of the copy and possibly hitting the poison again.

New mce.kflags bit MCE_IN_KERNEL_COPYIN will be used by mce_severity()
calculation to indicate that a machine check is recoverable because the
kernel was copying from user space.

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/asm.h  |  6 +++
 arch/x86/include/asm/mce.h  | 15 ++++++
 arch/x86/lib/copy_user_64.S | 96 ++++++++++++++++++-------------------
 arch/x86/mm/extable.c       | 14 +++++-
 4 files changed, 82 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 5c15f95b1ba7..0359cbbd0f50 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -135,6 +135,9 @@
 # define _ASM_EXTABLE_UA(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
 
+# define _ASM_EXTABLE_CPY(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
+
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
@@ -160,6 +163,9 @@
 # define _ASM_EXTABLE_UA(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
 
+# define _ASM_EXTABLE_CPY(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
+
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 109af5c7f515..a9bf34bd4457 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -136,8 +136,23 @@
 #define	MCE_HANDLED_NFIT	BIT_ULL(3)
 #define	MCE_HANDLED_EDAC	BIT_ULL(4)
 #define	MCE_HANDLED_MCELOG	BIT_ULL(5)
+
+/*
+ * Indicates an MCE which has happened in kernel space but from
+ * which the kernel can recover simply by executing fixup_exception()
+ * so that an error is returned to the caller of the function that
+ * hit the machine check.
+ */
 #define MCE_IN_KERNEL_RECOV	BIT_ULL(6)
 
+/*
+ * Indicates an MCE that happened in kernel space while copying data
+ * from user. In this case fixup_exception() gets the kernel to the
+ * error exit for the copy function. Machine check handler can then
+ * treat it like a fault taken in user mode.
+ */
+#define MCE_IN_KERNEL_COPYIN	BIT_ULL(7)
+
 /*
  * This structure contains all data related to the MCE log.  Also
  * carries a signature to make it easier to find from external
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 816f128a6d52..5b68e945bf65 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -36,8 +36,8 @@
 	jmp .Lcopy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE_UA(100b, 103b)
-	_ASM_EXTABLE_UA(101b, 103b)
+	_ASM_EXTABLE_CPY(100b, 103b)
+	_ASM_EXTABLE_CPY(101b, 103b)
 	.endm
 
 /*
@@ -116,26 +116,26 @@ SYM_FUNC_START(copy_user_generic_unrolled)
 60:	jmp .Lcopy_user_handle_tail /* ecx is zerorest also */
 	.previous
 
-	_ASM_EXTABLE_UA(1b, 30b)
-	_ASM_EXTABLE_UA(2b, 30b)
-	_ASM_EXTABLE_UA(3b, 30b)
-	_ASM_EXTABLE_UA(4b, 30b)
-	_ASM_EXTABLE_UA(5b, 30b)
-	_ASM_EXTABLE_UA(6b, 30b)
-	_ASM_EXTABLE_UA(7b, 30b)
-	_ASM_EXTABLE_UA(8b, 30b)
-	_ASM_EXTABLE_UA(9b, 30b)
-	_ASM_EXTABLE_UA(10b, 30b)
-	_ASM_EXTABLE_UA(11b, 30b)
-	_ASM_EXTABLE_UA(12b, 30b)
-	_ASM_EXTABLE_UA(13b, 30b)
-	_ASM_EXTABLE_UA(14b, 30b)
-	_ASM_EXTABLE_UA(15b, 30b)
-	_ASM_EXTABLE_UA(16b, 30b)
-	_ASM_EXTABLE_UA(18b, 40b)
-	_ASM_EXTABLE_UA(19b, 40b)
-	_ASM_EXTABLE_UA(21b, 50b)
-	_ASM_EXTABLE_UA(22b, 50b)
+	_ASM_EXTABLE_CPY(1b, 30b)
+	_ASM_EXTABLE_CPY(2b, 30b)
+	_ASM_EXTABLE_CPY(3b, 30b)
+	_ASM_EXTABLE_CPY(4b, 30b)
+	_ASM_EXTABLE_CPY(5b, 30b)
+	_ASM_EXTABLE_CPY(6b, 30b)
+	_ASM_EXTABLE_CPY(7b, 30b)
+	_ASM_EXTABLE_CPY(8b, 30b)
+	_ASM_EXTABLE_CPY(9b, 30b)
+	_ASM_EXTABLE_CPY(10b, 30b)
+	_ASM_EXTABLE_CPY(11b, 30b)
+	_ASM_EXTABLE_CPY(12b, 30b)
+	_ASM_EXTABLE_CPY(13b, 30b)
+	_ASM_EXTABLE_CPY(14b, 30b)
+	_ASM_EXTABLE_CPY(15b, 30b)
+	_ASM_EXTABLE_CPY(16b, 30b)
+	_ASM_EXTABLE_CPY(18b, 40b)
+	_ASM_EXTABLE_CPY(19b, 40b)
+	_ASM_EXTABLE_CPY(21b, 50b)
+	_ASM_EXTABLE_CPY(22b, 50b)
 SYM_FUNC_END(copy_user_generic_unrolled)
 EXPORT_SYMBOL(copy_user_generic_unrolled)
 
@@ -180,8 +180,8 @@ SYM_FUNC_START(copy_user_generic_string)
 	jmp .Lcopy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE_UA(1b, 11b)
-	_ASM_EXTABLE_UA(3b, 12b)
+	_ASM_EXTABLE_CPY(1b, 11b)
+	_ASM_EXTABLE_CPY(3b, 12b)
 SYM_FUNC_END(copy_user_generic_string)
 EXPORT_SYMBOL(copy_user_generic_string)
 
@@ -213,7 +213,7 @@ SYM_FUNC_START(copy_user_enhanced_fast_string)
 	jmp .Lcopy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE_UA(1b, 12b)
+	_ASM_EXTABLE_CPY(1b, 12b)
 SYM_FUNC_END(copy_user_enhanced_fast_string)
 EXPORT_SYMBOL(copy_user_enhanced_fast_string)
 
@@ -237,7 +237,7 @@ SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 	ASM_CLAC
 	ret
 
-	_ASM_EXTABLE_UA(1b, 2b)
+	_ASM_EXTABLE_CPY(1b, 2b)
 SYM_CODE_END(.Lcopy_user_handle_tail)
 
 /*
@@ -366,27 +366,27 @@ SYM_FUNC_START(__copy_user_nocache)
 	jmp .Lcopy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE_UA(1b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(2b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(3b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(4b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(5b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(6b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(7b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(8b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(9b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(10b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(11b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(12b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(13b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(14b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(15b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(16b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(20b, .L_fixup_8b_copy)
-	_ASM_EXTABLE_UA(21b, .L_fixup_8b_copy)
-	_ASM_EXTABLE_UA(30b, .L_fixup_4b_copy)
-	_ASM_EXTABLE_UA(31b, .L_fixup_4b_copy)
-	_ASM_EXTABLE_UA(40b, .L_fixup_1b_copy)
-	_ASM_EXTABLE_UA(41b, .L_fixup_1b_copy)
+	_ASM_EXTABLE_CPY(1b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(2b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(3b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(4b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(5b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(6b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(7b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(8b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(9b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(10b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(11b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(12b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(13b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(14b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(15b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(16b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(20b, .L_fixup_8b_copy)
+	_ASM_EXTABLE_CPY(21b, .L_fixup_8b_copy)
+	_ASM_EXTABLE_CPY(30b, .L_fixup_4b_copy)
+	_ASM_EXTABLE_CPY(31b, .L_fixup_4b_copy)
+	_ASM_EXTABLE_CPY(40b, .L_fixup_1b_copy)
+	_ASM_EXTABLE_CPY(41b, .L_fixup_1b_copy)
 SYM_FUNC_END(__copy_user_nocache)
 EXPORT_SYMBOL(__copy_user_nocache)
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index de869665309e..45d7026eda6a 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -80,6 +80,18 @@ __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL(ex_handler_uaccess);
 
+__visible bool ex_handler_copy(const struct exception_table_entry *fixup,
+			       struct pt_regs *regs, int trapnr,
+			       unsigned long error_code,
+			       unsigned long fault_addr)
+{
+	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
+	regs->ip = ex_fixup_addr(fixup);
+	regs->ax = trapnr;
+	return true;
+}
+EXPORT_SYMBOL(ex_handler_copy);
+
 __visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
 				       struct pt_regs *regs, int trapnr,
 				       unsigned long error_code,
@@ -136,7 +148,7 @@ enum handler_type ex_fault_handler_type(unsigned long ip)
 	handler = ex_fixup_handler(e);
 	if (handler == ex_handler_fault)
 		return EX_HANDLER_FAULT;
-	else if (handler == ex_handler_uaccess)
+	else if (handler == ex_handler_uaccess || handler == ex_handler_copy)
 		return EX_HANDLER_UACCESS;
 	else
 		return EX_HANDLER_OTHER;
-- 
2.21.1

