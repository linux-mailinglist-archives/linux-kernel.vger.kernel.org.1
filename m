Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFA9294CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442468AbgJUMkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442460AbgJUMkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:40:08 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D5FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:40:08 -0700 (PDT)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de [84.154.221.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 8849E295;
        Wed, 21 Oct 2020 14:40:04 +0200 (CEST)
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
Subject: [PATCH v3 4/5] x86/head/64: Check SEV encryption before switching to kernel page-table
Date:   Wed, 21 Oct 2020 14:39:37 +0200
Message-Id: <20201021123938.3696-5-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021123938.3696-1-joro@8bytes.org>
References: <20201021123938.3696-1-joro@8bytes.org>
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
 arch/x86/kernel/head_64.S | 12 ++++++++++++
 arch/x86/mm/mem_encrypt.c |  1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 7eb2a1c87969..cf295ff1ae00 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -161,6 +161,17 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 	/* Setup early boot stage 4-/5-level pagetables. */
 	addq	phys_base(%rip), %rax
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
 	movq	%rax, %cr3
 
 	/* Ensure I am executing from virtual addresses */
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

