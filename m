Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381D42868A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgJGTx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:53:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42400 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgJGTx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:53:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id v123so4357069qkd.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 12:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJ7RrIUvSlLg/WhJlZrvtotCPigPq1dafFKE89dMTMA=;
        b=L4y86FqB0L4LiN/iyeyGuH5PxbVO2Bn0lFyk7G1SmRliXUiO47ovDpJ/TK4Xad7sJ2
         Q7ENji90IPoSL7Jx7kyq4H4XCGpWXNUBnR2AyIFtsIOGBFLgI8SjuTn+HzyAa6hgnAO/
         YfIC10Cnh1NxRaYX8DVvEplHMY0DJHtkOv82obXjvwKmpIBLhhyjGsX8Don7lSQ5X0wI
         hqj2hXZUEnPTCdWugKxeP1lycM3PEEntciq/aSl85kbPGG2fABI5UEO6OhI1PHA09Tfb
         GSNGMWVUwrIC+6rJ/yA4csnfnDNaGn7WRKgjzDP80bSLFlfEgR5ebse6ZK+DuAlcxccH
         kb7Q==
X-Gm-Message-State: AOAM531lh5zVisSZEjqQEjtTELR5dQq4SYYWViROcio+V6fwmsaIDSCk
        DYWnxDBBMFecsQ4oyWcn9HU=
X-Google-Smtp-Source: ABdhPJwULeZvyRels5wbTPaqjKejSAM0IGQndgtT1D9if8hp7hcgf9t2AIp9445FvCVUacPs0Kpf1Q==
X-Received: by 2002:a37:84f:: with SMTP id 76mr4693175qki.251.1602100436321;
        Wed, 07 Oct 2020 12:53:56 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k20sm2287658qtm.44.2020.10.07.12.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 12:53:55 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] x86/boot/64: Explicitly map boot_params and command line
Date:   Wed,  7 Oct 2020 15:53:50 -0400
Message-Id: <20201007195351.776555-5-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007195351.776555-1-nivedita@alum.mit.edu>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
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
 arch/x86/boot/compressed/ident_map_64.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 070cda70aef3..8edeff0d9324 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -150,10 +150,13 @@ void initialize_identity_maps(void)
 	}
 
 	/*
-	 * New page-table is set up - map the kernel image and load it
-	 * into cr3.
+	 * New page-table is set up - map the kernel image, boot_params and the
+	 * command line, and load the new page-table into cr3.
 	 */
 	add_identity_map((unsigned long)_head, (unsigned long)_end - (unsigned long)_head);
+	add_identity_map((unsigned long)boot_params, sizeof(*boot_params));
+	add_identity_map(get_cmd_line_ptr(), COMMAND_LINE_SIZE);
+
 	write_cr3(top_level_pgt);
 }
 
-- 
2.26.2

