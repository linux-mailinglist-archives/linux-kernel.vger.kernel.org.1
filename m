Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1D029E24E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbgJ2CM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:12:28 -0400
Received: from 8bytes.org ([81.169.241.247]:36968 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbgJ1Vg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:36:26 -0400
Received: from cap.home.8bytes.org (p5b006b35.dip0.t-ipconnect.de [91.0.107.53])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id E9E31434;
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
Subject: [PATCH v4 2/5] x86/boot/compressed/64: Add CPUID sanity check to early #VC handler
Date:   Wed, 28 Oct 2020 17:46:56 +0100
Message-Id: <20201028164659.27002-3-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028164659.27002-1-joro@8bytes.org>
References: <20201028164659.27002-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The early #VC handler which doesn't have a GHCB can only handle CPUID
exit codes. It is needed by the early boot code to handle #VC
exceptions raised in verify_cpu() and to get the position of the C
bit.

But the CPUID information comes from the hypervisor, which is untrusted
and might return results which trick the guest into the no-SEV boot path
with no C bit set in the page-tables. All data written to memory would
then be unencrypted and could leak sensitive data to the hypervisor.

Add sanity checks to the early #VC handlers to make sure the hypervisor
can not pretend that SEV is disabled.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es-shared.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 5f83ccaab877..56d16c405b03 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -178,6 +178,32 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 		goto fail;
 	regs->dx = val >> 32;
 
+	/*
+	 * This is a VC handler and the #VC is only raised when SEV-ES is
+	 * active, which means SEV must be active too. Do sanity checks on the
+	 * CPUID results to make sure the hypervisor does not trick the kernel
+	 * into the no-sev path. This could map sensitive data unencrypted and
+	 * make it accessible to the hypervisor.
+	 *
+	 * In particular, check for:
+	 *	- Hypervisor CPUID bit
+	 *	- Availability of CPUID leaf 0x8000001f
+	 *	- SEV CPUID bit.
+	 *
+	 * The hypervisor might still report the wrong C-bit position, but this
+	 * can't be checked here.
+	 */
+
+	if ((fn == 1 && !(regs->cx & BIT(31))))
+		/* Hypervisor bit */
+		goto fail;
+	else if (fn == 0x80000000 && (regs->ax < 0x8000001f))
+		/* SEV Leaf check */
+		goto fail;
+	else if ((fn == 0x8000001f && !(regs->ax & BIT(1))))
+		/* SEV Bit */
+		goto fail;
+
 	/* Skip over the CPUID two-byte opcode */
 	regs->ip += 2;
 
-- 
2.28.0

