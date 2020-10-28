Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23ABE29E244
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387799AbgJ2CMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgJ1Vg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:36:27 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4E2C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:36:27 -0700 (PDT)
Received: from cap.home.8bytes.org (p5b006b35.dip0.t-ipconnect.de [91.0.107.53])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 4F555452;
        Wed, 28 Oct 2020 17:47:06 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] x86/boot/compressed/64: Check SEV encryption in 64-bit boot-path
Date:   Wed, 28 Oct 2020 17:46:57 +0100
Message-Id: <20201028164659.27002-4-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028164659.27002-1-joro@8bytes.org>
References: <20201028164659.27002-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Check whether the hypervisor reported the correct C-bit when running as
an SEV guest. Using a wrong C-bit position could be used to leak
sensitive data from the guest to the hypervisor.

The check function is in arch/x86/kernel/sev_verify_cbit.S so that it
can be re-used in the running kernel image.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/compressed/ident_map_64.c |  1 +
 arch/x86/boot/compressed/mem_encrypt.S  |  4 ++
 arch/x86/boot/compressed/misc.h         |  2 +
 arch/x86/kernel/sev_verify_cbit.S       | 90 +++++++++++++++++++++++++
 4 files changed, 97 insertions(+)
 create mode 100644 arch/x86/kernel/sev_verify_cbit.S

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index a5e5db6ada3c..39b2eded7bc2 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -164,6 +164,7 @@ void initialize_identity_maps(void *rmode)
 	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
 	/* Load the new page-table. */
+	sev_verify_cbit(top_level_pgt);
 	write_cr3(top_level_pgt);
 }
 
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index 0bae1ca658d9..3275dbab085d 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -68,6 +68,9 @@ SYM_FUNC_START(get_sev_encryption_bit)
 SYM_FUNC_END(get_sev_encryption_bit)
 
 	.code64
+
+#include "../../kernel/sev_verify_cbit.S"
+
 SYM_FUNC_START(set_sev_encryption_mask)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	push	%rbp
@@ -111,4 +114,5 @@ SYM_FUNC_END(set_sev_encryption_mask)
 	.balign	8
 SYM_DATA(sme_me_mask,		.quad 0)
 SYM_DATA(sev_status,		.quad 0)
+SYM_DATA(sev_check_data,	.quad 0)
 #endif
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 6d31f1b4c4d1..d9a631c5973c 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -159,4 +159,6 @@ void boot_page_fault(void);
 void boot_stage1_vc(void);
 void boot_stage2_vc(void);
 
+unsigned long sev_verify_cbit(unsigned long cr3);
+
 #endif /* BOOT_COMPRESSED_MISC_H */
diff --git a/arch/x86/kernel/sev_verify_cbit.S b/arch/x86/kernel/sev_verify_cbit.S
new file mode 100644
index 000000000000..b96f0573f8af
--- /dev/null
+++ b/arch/x86/kernel/sev_verify_cbit.S
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *	sev_verify_cbit.S - Code for verification of the C-bit position reported
+ *			    by the Hypervisor when running with SEV enabled.
+ *
+ *	Copyright (c) 2020  Joerg Roedel (jroedel@suse.de)
+ *
+ * Implements sev_verify_cbit() which is called before switching to a new
+ * long-mode page-table at boot.
+ *
+ * It verifies that the C-bit position is correct by writing a random value to
+ * an encrypted memory location while on the current page-table. Then it
+ * switches to the new page-table to verify the memory content is still the
+ * same. After that it switches back to the current page-table and when the
+ * check succeeded it returns. If the check failed the code invalidates the
+ * stack pointer and goes into a hlt loop. The stack-pointer is invalidated to
+ * make sure no interrupt or exception can get the CPU out of the hlt loop.
+ *
+ * New page-table pointer is expected in %rdi (first parameter)
+ *
+ */
+SYM_FUNC_START(sev_verify_cbit)
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/* First check if a C-bit was detected */
+	movq	sme_me_mask(%rip), %rsi
+	testq	%rsi, %rsi
+	jz	3f
+
+	/* sme_me_mask != 0 could mean SME or SEV - Check also for SEV */
+	movq	sev_status(%rip), %rsi
+	testq	%rsi, %rsi
+	jz	3f
+
+	/* Save CR4 in %rsi */
+	movq	%cr4, %rsi
+
+	/* Disable Global Pages */
+	movq	%rsi, %rdx
+	andq	$(~X86_CR4_PGE), %rdx
+	movq	%rdx, %cr4
+
+	/*
+	 * Verified that running under SEV - now get a random value using
+	 * RDRAND. This instruction is mandatory when running as an SEV guest.
+	 *
+	 * Don't bail out of the loop if RDRAND returns errors. It is better to
+	 * prevent forward progress than to work with a non-random value here.
+	 */
+1:	rdrand	%rdx
+	jnc	1b
+
+	/* Store value to memory and keep it in %r10 */
+	movq	%rdx, sev_check_data(%rip)
+
+	/* Backup current %cr3 value to restore it later */
+	movq	%cr3, %rcx
+
+	/* Switch to new %cr3 - This might unmap the stack */
+	movq	%rdi, %cr3
+
+	/*
+	 * Compare value in %rdx with memory location - If C-Bit is incorrect
+	 * this would read the encrypted data and make the check fail.
+	 */
+	cmpq	%rdx, sev_check_data(%rip)
+
+	/* Restore old %cr3 */
+	movq	%rcx, %cr3
+
+	/* Restore previous CR4 */
+	movq	%rsi, %cr4
+
+	/* Check CMPQ result */
+	je	3f
+
+	/*
+	 * The check failed - Prevent any forward progress to prevent ROP
+	 * attacks, invalidate the stack and go into a hlt loop.
+	 */
+	xorq	%rsp, %rsp
+	subq	$0x1000, %rsp
+2:	hlt
+	jmp 2b
+3:
+#endif
+	/* Return page-table pointer */
+	movq	%rdi, %rax
+	ret
+SYM_FUNC_END(sev_verify_cbit)
+
-- 
2.28.0

