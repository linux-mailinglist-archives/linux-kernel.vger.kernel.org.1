Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5334C29E24B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgJ2CM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgJ1Vg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:36:27 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755CAC0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:36:27 -0700 (PDT)
Received: from cap.home.8bytes.org (p5b006b35.dip0.t-ipconnect.de [91.0.107.53])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 8A73933E;
        Wed, 28 Oct 2020 17:47:05 +0100 (CET)
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
Subject: [PATCH v4 1/5] x86/boot/compressed/64: Introduce sev_status
Date:   Wed, 28 Oct 2020 17:46:55 +0100
Message-Id: <20201028164659.27002-2-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028164659.27002-1-joro@8bytes.org>
References: <20201028164659.27002-1-joro@8bytes.org>
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
 arch/x86/boot/compressed/mem_encrypt.S | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index dd07e7b41b11..0bae1ca658d9 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -81,6 +81,19 @@ SYM_FUNC_START(set_sev_encryption_mask)
 
 	bts	%rax, sme_me_mask(%rip)	/* Create the encryption mask */
 
+	/*
+	 * Read MSR_AMD64_SEV again and store it to sev_status. Can't do this in
+	 * get_sev_encryption_bit() because this function is 32 bit code and
+	 * shared between 64 bit and 32 bit boot path.
+	 */
+	movl	$MSR_AMD64_SEV, %ecx	/* Read the SEV MSR */
+	rdmsr
+
+	/* Store MSR value in sev_status */
+	shlq	$32, %rdx
+	orq	%rdx, %rax
+	movq	%rax, sev_status(%rip)
+
 .Lno_sev_mask:
 	movq	%rbp, %rsp		/* Restore original stack pointer */
 
@@ -96,5 +109,6 @@ SYM_FUNC_END(set_sev_encryption_mask)
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	.balign	8
-SYM_DATA(sme_me_mask, .quad 0)
+SYM_DATA(sme_me_mask,		.quad 0)
+SYM_DATA(sev_status,		.quad 0)
 #endif
-- 
2.28.0

