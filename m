Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22939292A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgJSPLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:11:30 -0400
Received: from 8bytes.org ([81.169.241.247]:33492 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbgJSPL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:11:26 -0400
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de [84.154.221.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 44C324C3;
        Mon, 19 Oct 2020 17:11:24 +0200 (CEST)
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
Subject: [PATCH 3/5] x86/boot/compressed/64: Check SEV encryption in 64-bit boot-path
Date:   Mon, 19 Oct 2020 17:11:19 +0200
Message-Id: <20201019151121.826-4-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019151121.826-1-joro@8bytes.org>
References: <20201019151121.826-1-joro@8bytes.org>
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
 arch/x86/kernel/sev_verify_cbit.S       | 77 +++++++++++++++++++++++++
 4 files changed, 84 insertions(+)
 create mode 100644 arch/x86/kernel/sev_verify_cbit.S

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 063a60edcf99..73abba3312a7 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -153,6 +153,7 @@ void initialize_identity_maps(void)
 	 * into cr3.
 	 */
 	add_identity_map((unsigned long)_head, (unsigned long)_end);
+	sev_verify_cbit(top_level_pgt);
 	write_cr3(top_level_pgt);
 }
 
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index 0effd58f0095..1786d5f02825 100644
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
@@ -109,4 +112,5 @@ SYM_FUNC_END(set_sev_encryption_mask)
 	.balign	8
 SYM_DATA(sme_me_mask,		.quad 0)
 SYM_DATA(sev_status,		.quad 0)
+SYM_DATA(sev_check_data,	.quad 0)
 #endif
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 6d31f1b4c4d1..53f4848ad392 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -159,4 +159,6 @@ void boot_page_fault(void);
 void boot_stage1_vc(void);
 void boot_stage2_vc(void);
 
+void sev_verify_cbit(unsigned long cr3);
+
 #endif /* BOOT_COMPRESSED_MISC_H */
diff --git a/arch/x86/kernel/sev_verify_cbit.S b/arch/x86/kernel/sev_verify_cbit.S
new file mode 100644
index 000000000000..5b6f61465437
--- /dev/null
+++ b/arch/x86/kernel/sev_verify_cbit.S
@@ -0,0 +1,77 @@
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
+	movq	sme_me_mask(%rip), %r10
+	testq	%r10, %r10
+	jz	3f
+
+	/* sme_me_mask != 0 could mean SME or SEV - Check also for SEV */
+	movq	sev_status(%rip), %r10
+	testq	%r10, %r10
+	jz	3f
+
+	/*
+	 * Verified that running under SEV - now get a random value using
+	 * RDRAND. This instruction is mandatory when running as an SEV guest.
+	 *
+	 * Don't bail out of the loop if RDRAND returns errors. It is better to
+	 * prevent forward progress than to work with a non-random value here.
+	 */
+1:	rdrand	%r10
+	jnc	1b
+
+	/* Store value to memory and keep it in %r10 */
+	movq	%r10, sev_check_data(%rip)
+
+	/* Backup current %cr3 value to restore it later */
+	movq	%cr3, %r11
+
+	/* Switch to new %cr3 - This might unmap the stack */
+	movq	%rdi, %cr3
+
+	/*
+	 * Compare value in %r10 with memory location - If C-Bit is incorrect
+	 * this would read the encrypted data and make the check fail.
+	 */
+	cmpq	%r10, sev_check_data(%rip)
+
+	/* Restore old %cr3 */
+	movq	%r11, %cr3
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
+	ret
+SYM_FUNC_END(sev_verify_cbit)
+
-- 
2.28.0

