Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E70F2DB580
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgLOU5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgLOU5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:57:43 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3281C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:57:02 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m5so21178273wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q/JZoDnd4VWmMKpTeWm4RJeijsmR1MpS2uBIZZMAs4k=;
        b=TtB6OQtUvFKa0VaCNy1Tvm7kRDJ76KQeJQgEpZpGjY4jZvrq3cofIz8om7XEhtUjIy
         zeTFetV8ObseJg4rr6XVx9M5mwwS4v26UVotVdSKpa9XQjvDQKE2m5VpGkv8OQv+J2SD
         KGLhRxv1TLpKODtkUpz/ge9B4E3YiIxuZVSJ+NoBrAb0XE8i1ITu3Dvh9meMAE/jxGwF
         lrGJUkPocAhRN/bnc7Mzl0dWJQ5gbTDQk9kO6HsZ9H4kiSMjPq7dlMDffHHIPTyI9ZNJ
         WQdXbp6mERRyQ8Ay3Nk/dxJmuNEqpCQZQCtYyRB1aNmBtqfjSEOrFLtU/ZzbtY8ltEj2
         7F3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q/JZoDnd4VWmMKpTeWm4RJeijsmR1MpS2uBIZZMAs4k=;
        b=RYuYZOI0gn0AyJwVe6uOQ1BLJj/hQJzYPlZeT/B8iOvx7zHH2ApdeQn4GA1/JyBbzk
         MJ01RpTurYL+0ms8e7CT1gaQWgqfDJKPP9H6k93FMGUGOGpO80a4QpSy1TbJZYcUArYT
         SoP6TC161G7rZa0oBT5lABp1Mg1kHATgKnwj3qyeWW4GaSY/0moSpvU3ysKWNGmQyNBZ
         ownmBbF71lf4ADLQOqbZ34Jnf57Td5jaiciDCx5pvvj73HIbz58Ms/uixVltM8gD9XKg
         JN/KFSs443laOp8Hw21Exy/n6VxQK4Mzop2FQKAm+LAUP4CxTa2FV1GS02GYSGQUMCv9
         tswQ==
X-Gm-Message-State: AOAM531LkcOjhM5iDDXX3BUwduN2LnyFoYDijP9BikuX95rWnzvxEjvV
        TkjP8AeVgRW6oIvb55WkZr4=
X-Google-Smtp-Source: ABdhPJzyFU+s4CU7i+gZXfdMxuoCa1ikGwJj+veSyloY30lG024UOLBzqNLj1vGxsbYZFdpdA2ZZ6A==
X-Received: by 2002:adf:dd90:: with SMTP id x16mr35148276wrl.85.1608065821548;
        Tue, 15 Dec 2020 12:57:01 -0800 (PST)
Received: from unjustified.home ([2a00:23c5:31b:1:320d:9008:393b:5754])
        by smtp.gmail.com with ESMTPSA id h15sm37739219wru.4.2020.12.15.12.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:57:00 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] x86/mm: increase pgt_buf size for 5-level page tables
Date:   Tue, 15 Dec 2020 20:56:41 +0000
Message-Id: <20201215205641.34096-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pgt_buf is used to allocate page tables on initial direct page mapping
bootstrapping us into being able to allocate these before the direct
mapping makes further pages available.

INIT_PGD_PAGE_COUNT is set to 6 pages (doubled for KASLR) - 3 (PUD, PMD,
PTE) for the 1 MiB ISA mapping and 3 more for the first direct mapping
assignment in each case providing 2 MiB of address space.

This has not been updated for 5-level page tables which additionally has a
P4D page table level above PUD.

In most instances this will not have a material impact as the first 4 page
levels allocated for the ISA mapping will provide sufficient address space
to encompass all further address mappings. If the first direct mapping is
within 512 GiB of the ISA mapping we need only add a PMD and PTE in the
instance where we are using 4 KiB page tables (e.g. CONFIG_DEBUG_PAGEALLOC
is enabled) and only a PMD if we can use 2 MiB pages (the first allocation
is limited to PMD_SIZE so we can't use a GiB page there).

However if we have more than 512 GiB of RAM and are allocating 4 KiB page
size we require 3 further page tables and if we have more than 256 TiB of
RAM at 4 KiB or 2 MiB page size we require a further 3 or 4 page tables
respectively.

This patch updates INIT_PGD_PAGE_COUNT to reflect this.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 arch/x86/mm/init.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index e26f5c5c6565..0ee7dc9a5a65 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -157,16 +157,25 @@ __ref void *alloc_low_pages(unsigned int num)
 }
 
 /*
- * By default need 3 4k for initial PMD_SIZE,  3 4k for 0-ISA_END_ADDRESS.
- * With KASLR memory randomization, depending on the machine e820 memory
- * and the PUD alignment. We may need twice more pages when KASLR memory
+ * By default we need to be able to allocate page tables below PGD firstly for
+ * the 0-ISA_END_ADDRESS range and secondly for the initial PMD_SIZE mapping.
+ * With KASLR memory randomization, depending on the machine e820 memory and the
+ * PUD alignment, we may need twice that many pages when KASLR memory
  * randomization is enabled.
  */
+
+#ifndef CONFIG_X86_5LEVEL
+#define INIT_PGD_PAGE_TABLES    3
+#else
+#define INIT_PGD_PAGE_TABLES    4
+#endif
+
 #ifndef CONFIG_RANDOMIZE_MEMORY
-#define INIT_PGD_PAGE_COUNT      6
+#define INIT_PGD_PAGE_COUNT      (2 * INIT_PGD_PAGE_TABLES)
 #else
-#define INIT_PGD_PAGE_COUNT      12
+#define INIT_PGD_PAGE_COUNT      (4 * INIT_PGD_PAGE_TABLES)
 #endif
+
 #define INIT_PGT_BUF_SIZE	(INIT_PGD_PAGE_COUNT * PAGE_SIZE)
 RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE);
 void  __init early_alloc_pgt_buf(void)
-- 
2.29.2

