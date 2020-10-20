Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0979293B15
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394318AbgJTMTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:19:11 -0400
Received: from 8bytes.org ([81.169.241.247]:34898 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394292AbgJTMTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:19:08 -0400
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de [84.154.221.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 326512A9;
        Tue, 20 Oct 2020 14:19:07 +0200 (CEST)
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
Subject: [PATCH v2 4/5] x86/head/64: Check SEV encryption before switching to kernel page-table
Date:   Tue, 20 Oct 2020 14:18:55 +0200
Message-Id: <20201020121856.19427-5-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020121856.19427-1-joro@8bytes.org>
References: <20201020121856.19427-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

When SEV is enabled the kernel requests the C-Bit position again from
the hypervisor to built its own page-table. Since the hypervisor is an
untrusted source the C-bit position needs to be verified before the
kernel page-table is used.

Call the sev_verify_cbit() function before writing the CR3.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/head_64.S | 14 +++++++++++++-
 arch/x86/mm/mem_encrypt.c |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 7eb2a1c87969..c6f4562359a5 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -161,7 +161,18 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 	/* Setup early boot stage 4-/5-level pagetables. */
 	addq	phys_base(%rip), %rax
-	movq	%rax, %cr3
+
+	/*
+	 * For SEV guests: Verify that the C-bit is correct. A malicious
+	 * hypervisor could lie about the C-bit position to perform a ROP
+	 * attack on the guest by writing to the unencrypted stack and wait for
+	 * the next RET instruction.
+	 */
+	movq	%rax, %rdi
+	call	sev_verify_cbit
+
+	/* Switch to new page-table */
+	movq	%rdi, %cr3
 
 	/* Ensure I am executing from virtual addresses */
 	movq	$1f, %rax
@@ -279,6 +290,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 SYM_CODE_END(secondary_startup_64)
 
 #include "verify_cpu.S"
+#include "sev_verify_cbit.S"
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index ebb7edc8bc0a..bd9b62af2e3d 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -39,6 +39,7 @@
  */
 u64 sme_me_mask __section(.data) = 0;
 u64 sev_status __section(.data) = 0;
+u64 sev_check_data __section(.data) = 0;
 EXPORT_SYMBOL(sme_me_mask);
 DEFINE_STATIC_KEY_FALSE(sev_enable_key);
 EXPORT_SYMBOL_GPL(sev_enable_key);
-- 
2.28.0

