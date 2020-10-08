Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A496F287C49
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgJHTQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:16:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41265 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgJHTQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:16:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id z33so2201877qth.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 12:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jf7/sXu13C7/A2uLR/OVVllZ2H5k6KMd8ftuswZOgz0=;
        b=Zvo6QFGtA0W2vnQhfB8hABqq2W2x8oDulifW/Nf/Gx7AfwMgQhAz6p28lLuYEztMLG
         dwRaGlS75x0nBSkVRl+UxAi7dZUhB8/02XWA9Vc9HXoOrsPJRbDqP8c738cu7kOU8GCF
         l/2nCgWhYuLj1h3cPLBD4seiRwvtMnMAlogCec/9jhSI4x9ZQ0/RaubcYjebN9gDxD1d
         JURZKTjqIJcRhyck+W5Z1SK3lDBadEhwXXJp+rz0T68bJxSfky8eUNmbbePg/sIVhuHX
         RK9b8jORbJSG5yud0074f9nqhNXFCD568P10lVvkpn6KnProLsTeSsQ0m/eRDdVwPFhQ
         9ZXg==
X-Gm-Message-State: AOAM532wPaUg6LGiOUJUh7ide93hN2rx+5iz2saDqfv7k69TsbG2LYm3
        Dq/EJN4IsZ41ovUq6HnDk8C6FrvDMiK0Tw==
X-Google-Smtp-Source: ABdhPJy4VD9n58sAi4vF3TbKoENMI6J07kY4TpR57g+EMnFbD6ZEU3++Oe+SKkMsA9MbRZFFROEeEA==
X-Received: by 2002:ac8:7c9b:: with SMTP id y27mr10369325qtv.55.1602184589052;
        Thu, 08 Oct 2020 12:16:29 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z37sm4726759qtz.67.2020.10.08.12.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 12:16:28 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] x86/boot/64: Explicitly map boot_params and command line
Date:   Thu,  8 Oct 2020 15:16:22 -0400
Message-Id: <20201008191623.2881677-5-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201008191623.2881677-1-nivedita@alum.mit.edu>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
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
---
 arch/x86/boot/compressed/ident_map_64.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index fd957b2625e9..a3613857c532 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -21,6 +21,7 @@
 
 #include "error.h"
 #include "misc.h"
+#include "cmdline.h"
 
 /* These actually do the work of building the kernel identity maps. */
 #include <linux/pgtable.h>
@@ -109,6 +110,8 @@ static void add_identity_map(unsigned long start, unsigned long end)
 /* Locates and clears a region for a new top level page table. */
 void initialize_identity_maps(void)
 {
+	unsigned long cmdline;
+
 	/* Exclude the encryption mask from __PHYSICAL_MASK */
 	physical_mask &= ~sme_me_mask;
 
@@ -149,10 +152,19 @@ void initialize_identity_maps(void)
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
+	add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
+	cmdline = get_cmd_line_ptr();
+	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
+
+	/* Load the new page-table. */
 	write_cr3(top_level_pgt);
 }
 
-- 
2.26.2

