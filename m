Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FEE292A11
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgJSPL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:11:28 -0400
Received: from 8bytes.org ([81.169.241.247]:33448 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729852AbgJSPLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:11:25 -0400
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de [84.154.221.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 8228A3A5;
        Mon, 19 Oct 2020 17:11:23 +0200 (CEST)
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
Subject: [PATCH 1/5] x86/boot/compressed/64: Introduce sev_status
Date:   Mon, 19 Oct 2020 17:11:17 +0200
Message-Id: <20201019151121.826-2-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019151121.826-1-joro@8bytes.org>
References: <20201019151121.826-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Introduce sev_status and initialize it together with sme_me_mask to have
an indicator which SEV features are enabled.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/compressed/mem_encrypt.S | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index dd07e7b41b11..0effd58f0095 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -71,6 +71,8 @@ SYM_FUNC_END(get_sev_encryption_bit)
 SYM_FUNC_START(set_sev_encryption_mask)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	push	%rbp
+	push	%rax
+	push	%rcx
 	push	%rdx
 
 	movq	%rsp, %rbp		/* Save current stack pointer */
@@ -81,10 +83,19 @@ SYM_FUNC_START(set_sev_encryption_mask)
 
 	bts	%rax, sme_me_mask(%rip)	/* Create the encryption mask */
 
+	/* Read sev_status */
+	movl	$MSR_AMD64_SEV, %ecx
+	rdmsr
+	shlq	$32, %rdx
+	orq	%rdx, %rax
+	movq	%rax, sev_status(%rip)
+
 .Lno_sev_mask:
 	movq	%rbp, %rsp		/* Restore original stack pointer */
 
 	pop	%rdx
+	pop	%rcx
+	pop	%rax
 	pop	%rbp
 #endif
 
@@ -96,5 +107,6 @@ SYM_FUNC_END(set_sev_encryption_mask)
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	.balign	8
-SYM_DATA(sme_me_mask, .quad 0)
+SYM_DATA(sme_me_mask,		.quad 0)
+SYM_DATA(sev_status,		.quad 0)
 #endif
-- 
2.28.0

