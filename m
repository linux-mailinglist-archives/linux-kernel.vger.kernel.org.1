Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC74290C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 22:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393316AbgJPUEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 16:04:07 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35268 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393309AbgJPUEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 16:04:07 -0400
Received: by mail-il1-f195.google.com with SMTP id j17so4056482ilr.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 13:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSe2oE2EcJMZ2q2g9lbAlfmtda5uIsfsRQrbLON3NK0=;
        b=nWo/URvtIZ9PCVQsvG1jErss9SHN02J9FZrJUFL5Y2eIlakPjhf2ipH+DfUavEFz8w
         DyRl1vY/iFjIpR/Kr0IDweUWFHFRDapNGD1XiYaXeNIYsueHRKoUnxNwg1PjtQPhuFbp
         l2umbbAE8I1459F9QCTnNbtdT05FepiPA2bqmqG/YZIOULdbbo4oNARnLUQN6h4TLxUa
         75RyjEVubi67lLL6jRNpqVWFqit9oab51c7Uon9K02K2tWSa1zkwtZKG1wpe6V3uPOFc
         1Q/heDzqPlXDKCsZmhjcLYN7tfrkEamVLwdsveFzvjlKUqtAiQ/WgoGZNSl9JK1pIQaQ
         8hjA==
X-Gm-Message-State: AOAM530/JbJ4R06+YdueJlD3IcUuua/XdAO4MRIvT9D5JisIL6B+k4Sa
        /uDyeoVaQYvjvHDokREZl+w=
X-Google-Smtp-Source: ABdhPJyYuEDlKlwULdZLtNgyacYksMaozKWslcIGpyg15pLqfjsokHihj9uo3Yk+v9vQWwLV112Czw==
X-Received: by 2002:a92:98c5:: with SMTP id a66mr4197296ill.50.1602878646265;
        Fri, 16 Oct 2020 13:04:06 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r2sm2886961ile.1.2020.10.16.13.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 13:04:05 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] x86/boot/64: Explicitly map boot_params and command line
Date:   Fri, 16 Oct 2020 16:04:01 -0400
Message-Id: <20201016200404.1615994-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201016173232.GI8483@zn.tnic>
References: <20201016173232.GI8483@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commits

  ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
  8570978ea030 ("x86/boot/compressed/64: Don't pre-map memory in KASLR code")

set up a new page table in the decompressor stub, but without explicit
mappings for boot_params and the kernel command line, relying on the #PF
handler instead.

This is fragile, as boot_params and the command line mappings are
required for the main kernel. If EARLY_PRINTK and RANDOMIZE_BASE are
disabled, a QEMU/OVMF boot never accesses the command line in the
decompressor stub, and so it never gets mapped. The main kernel accesses
it from the identity mapping if AMD_MEM_ENCRYPT is enabled, and will
crash.

Fix this by adding back the explicit mapping of boot_params and the
command line.

Note: the changes also removed the explicit mapping of the main kernel,
with the result that .bss and .brk may not be in the identity mapping,
but those don't get accessed by the main kernel before it switches to
its own page tables.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/compressed/head_64.S      |  3 +++
 arch/x86/boot/compressed/ident_map_64.c | 24 +++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1c80f1738fd9..3976b4e92e1b 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -544,6 +544,9 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	pushq	%rsi
 	call	set_sev_encryption_mask
 	call	load_stage2_idt
+	/* Pass boot_params to initialize_identity_maps */
+	popq	%rdi
+	pushq	%rdi
 	call	initialize_identity_maps
 	popq	%rsi
 
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index c6f7aef7e85a..bf61581277c2 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -33,6 +33,12 @@
 #define __PAGE_OFFSET __PAGE_OFFSET_BASE
 #include "../../mm/ident_map.c"
 
+#define _SETUP
+#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
+#undef _SETUP
+
+extern unsigned long get_cmd_line_ptr(void);
+
 /* Used by PAGE_KERN* macros: */
 pteval_t __default_kernel_pte_mask __read_mostly = ~0;
 
@@ -101,8 +107,10 @@ static void add_identity_map(unsigned long start, unsigned long end)
 }
 
 /* Locates and clears a region for a new top level page table. */
-void initialize_identity_maps(void)
+void initialize_identity_maps(void *rmode)
 {
+	unsigned long cmdline;
+
 	/* Exclude the encryption mask from __PHYSICAL_MASK */
 	physical_mask &= ~sme_me_mask;
 
@@ -143,10 +151,20 @@ void initialize_identity_maps(void)
 	}
 
 	/*
-	 * New page-table is set up - map the kernel image and load it
-	 * into cr3.
+	 * New page-table is set up - map the kernel image, boot_params and the
+	 * command line.
+	 * The uncompressed kernel requires boot_params and the command line to
+	 * be mapped in the identity mapping.
+	 * Map them explicitly here in case the compressed kernel does not
+	 * touch them, or does not touch all the pages covering them.
 	 */
 	add_identity_map((unsigned long)_head, (unsigned long)_end);
+	boot_params = rmode;
+	add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
+	cmdline = get_cmd_line_ptr();
+	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
+
+	/* Load the new page-table. */
 	write_cr3(top_level_pgt);
 }
 
-- 
2.26.2

