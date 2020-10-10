Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2175428A210
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbgJJWyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:54:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39130 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731351AbgJJTLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:11:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id w12so14106591qki.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 12:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NUbUkTRREx+PjiF00QjT8cbgbNV3OaCOjufHzqKs7do=;
        b=JQzw085EnvVFeBMbSjWsqRMY2lqoDPQLAelgqo/tC7P/ZXlVDaCqeGQAWbEE+/WSaf
         5FY+0VxVit613Yhv5BCKMNSyU7uGGGuUSFG301XMM6OP8ZVvYcGM/hXjzHxSq2FIvCpT
         6qoNgJZc3F3skQUr3s7ezxJEAfHxbeExUaTr7wl6rtz90mVT/bQSAo+VzLLJ2J0CxiWp
         c9994cxZvKJEsXcy9kNKiurKfrbnCqVMnpK1tTlnahDh+DYNmaIcYmu44l6kORsKr4fG
         axZG2LZIu1vpyLlH9M5Sj/JXS6cx5mLsmPRWQhdnwfkyaiKCk8dPu9azz3vBfNmapqnI
         osfA==
X-Gm-Message-State: AOAM5303bXNr8KSNsrT+lc+YR5rbREVAHarr7ykazI15tJlXWchpuoKS
        sa0OMtfsBqou0dbBsgWtUAs=
X-Google-Smtp-Source: ABdhPJw9834ECABkejeFmGTtDHHvZrzDsYrJhPhoEbweilPTyVN8caLuN25aVOeNBX706YiikB+QcQ==
X-Received: by 2002:a37:aa10:: with SMTP id t16mr3561819qke.320.1602357072078;
        Sat, 10 Oct 2020 12:11:12 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r64sm9132278qkf.119.2020.10.10.12.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 12:11:11 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/boot/64: Initialize 5-level paging variables earlier
Date:   Sat, 10 Oct 2020 15:11:10 -0400
Message-Id: <20201010191110.4060905-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201008191623.2881677-1-nivedita@alum.mit.edu>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit
  ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
started using a new set of pagetables even without KASLR.

After that commit, initialize_identity_maps() is called before the
5-level paging variables are setup in choose_random_location(), which
will not work if 5-level paging is actually enabled.

Fix this by moving the initialization of __pgtable_l5_enabled,
pgdir_shift and ptrs_per_p4d into cleanup_trampoline(), which is called
immediately after the finalization of whether the kernel is executing
with 4- or 5-level paging. This will be earlier than anything that might
require those variables, and keeps the 4- vs 5-level paging code all in
one place.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/ident_map_64.c |  6 ------
 arch/x86/boot/compressed/kaslr.c        |  8 --------
 arch/x86/boot/compressed/pgtable_64.c   | 16 ++++++++++++++++
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index a3613857c532..505d6299b76e 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -34,12 +34,6 @@
 #define __PAGE_OFFSET __PAGE_OFFSET_BASE
 #include "../../mm/ident_map.c"
 
-#ifdef CONFIG_X86_5LEVEL
-unsigned int __pgtable_l5_enabled;
-unsigned int pgdir_shift = 39;
-unsigned int ptrs_per_p4d = 1;
-#endif
-
 /* Used by PAGE_KERN* macros: */
 pteval_t __default_kernel_pte_mask __read_mostly = ~0;
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 489fabc051d7..9eabd8bc7673 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -835,14 +835,6 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
-#ifdef CONFIG_X86_5LEVEL
-	if (__read_cr4() & X86_CR4_LA57) {
-		__pgtable_l5_enabled = 1;
-		pgdir_shift = 48;
-		ptrs_per_p4d = 512;
-	}
-#endif
-
 	boot_params->hdr.loadflags |= KASLR_FLAG;
 
 	if (IS_ENABLED(CONFIG_X86_32))
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 46d761f7faa6..0976c2d2ab2f 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -9,6 +9,13 @@
 #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
 #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
 
+#ifdef CONFIG_X86_5LEVEL
+/* __pgtable_l5_enabled needs to be in .data to avoid being cleared along with .bss */
+unsigned int __section(.data) __pgtable_l5_enabled;
+unsigned int __section(.data) pgdir_shift = 39;
+unsigned int __section(.data) ptrs_per_p4d = 1;
+#endif
+
 struct paging_config {
 	unsigned long trampoline_start;
 	unsigned long l5_required;
@@ -195,4 +202,13 @@ void cleanup_trampoline(void *pgtable)
 
 	/* Restore trampoline memory */
 	memcpy(trampoline_32bit, trampoline_save, TRAMPOLINE_32BIT_SIZE);
+
+	/* Initialize variables for 5-level paging */
+#ifdef CONFIG_X86_5LEVEL
+	if (__read_cr4() & X86_CR4_LA57) {
+		__pgtable_l5_enabled = 1;
+		pgdir_shift = 48;
+		ptrs_per_p4d = 512;
+	}
+#endif
 }
-- 
2.26.2

