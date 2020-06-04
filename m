Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAC71EE560
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 15:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgFDNcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 09:32:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38150 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbgFDNcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:32:14 -0400
Received: from zn.tnic (p200300ec2f112d0098e027f4d433b155.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2d00:98e0:27f4:d433:b155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55CEE1EC0390;
        Thu,  4 Jun 2020 15:32:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591277533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=cKzOTjANxjf5KIgCFJRkHrKZbMh7bRF3C+zBu7WkOMw=;
        b=GxiViF8wh1msY64c3kCXgN52drWIl0dwik4z9iLIF8wgfhrx3a5Cva1Bn9zsvu/dgC0dR/
        F50ZifrnVSFAUxims3Ftpq9j+BvaV5FU0hkAZoeYeAMGVjY/hmAEWWuENMwZOMUC62eL8R
        dwGFFUbxpy5hL0YQNVK/NbSkHHrdY+4=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/asm: Unify __ASSEMBLY__ blocks
Date:   Thu,  4 Jun 2020 15:32:04 +0200
Message-Id: <20200604133204.7636-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Merge the two ifndef __ASSEMBLY__ blocks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/asm.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 0f63585edf5f..5c15f95b1ba7 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -144,7 +144,7 @@
 	_ASM_PTR (entry);					\
 	.popsection
 
-#else
+#else /* ! __ASSEMBLY__ */
 # define _EXPAND_EXTABLE_HANDLE(x) #x
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
 	" .pushsection \"__ex_table\",\"a\"\n"			\
@@ -164,9 +164,7 @@
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
 /* For C file, we already have NOKPROBE_SYMBOL macro */
-#endif
 
-#ifndef __ASSEMBLY__
 /*
  * This output constraint should be used for any inline asm which has a "call"
  * instruction.  Otherwise the asm may be inserted before the frame pointer
@@ -175,6 +173,6 @@
  */
 register unsigned long current_stack_pointer asm(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
-#endif
+#endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_ASM_H */
-- 
2.21.0

