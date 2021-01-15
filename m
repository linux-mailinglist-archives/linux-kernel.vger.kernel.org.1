Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8542F89B2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 00:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbhAOX62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 18:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbhAOX61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 18:58:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1248BC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:57:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a9so7442179wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MoPtjiXICTHSPG1bOGTrCCNZTOSTe5/uvK3NlSNpsME=;
        b=P6c5VHbPJHhV3m5glbcNs1X4ni0LaxJ0aJvGxTIZiHbF62g7Yk9LYnegO8LLFLeSW4
         zY4c7kGUxjrMvYUe1Wtt0J6ecKqZiMnr3Q9vNGOgfggz9M18srY84FBSlstqxD3MST8O
         2NTfIyRlO2St4c857jF8StbkAbOeklFU2L0eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MoPtjiXICTHSPG1bOGTrCCNZTOSTe5/uvK3NlSNpsME=;
        b=rq1h8o0Q3JD2HFTvrk+cMaB+bAaGg6CLxXUVDFLmLgMKREB/LWc3MhSSCiJFilLwAI
         M75etKYP8yXXsAUGt3EFGJ0rp3YPb32X1ijQ4G5Kvy99dxEPTljlccQOk/tcKRGfbOmH
         VjDS9y19aTLcfgfx50JYJt22mGHdXBfhBeTSUiQDBl6isfftpGY9JQAocHcbJ8o+W1Wl
         3BLMg8HOLwWHCPCYH/v2atWBDk/yabm2elhT0knMgs6HhutiLWZtQ0Gh1ldXlGXtJjHs
         p9+MGYlUKryNOp9j++J3JIko1LQTGvIRl7Rnyiz50U2eSyIyVl2FIPGrbuLa9G752/+9
         5qCQ==
X-Gm-Message-State: AOAM5302gwNV2EzKnDU2GnJVvvF7u6y9cFe46GyhHr7wLrRBr/FbYsYr
        9b3499L8J4Kq+NHQkzwfgD4dgQ==
X-Google-Smtp-Source: ABdhPJyzaAoIhOk/GMqgKLaMgQVcJWC5+f3xqU3qia1R871iR9aXyDcVTmXzmwp+jgMVzzeLhj+Pag==
X-Received: by 2002:a5d:5147:: with SMTP id u7mr15852760wrt.114.1610755065729;
        Fri, 15 Jan 2021 15:57:45 -0800 (PST)
Received: from lootbox.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id l7sm13736464wme.4.2021.01.15.15.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 15:57:45 -0800 (PST)
From:   Vitaly Wool <vitaly.wool@konsulko.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        damien.lemoal@wdc.com, devicetree@vger.kernel.org,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH v3] riscv: add BUILTIN_DTB support for MMU-enabled targets
Date:   Sat, 16 Jan 2021 01:49:48 +0200
Message-Id: <20210115234947.44014-1-vitaly.wool@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, especially in a production system we may not want to
use a "smart bootloader" like u-boot to load kernel, ramdisk and
device tree from a filesystem on eMMC, but rather load the kernel
from a NAND partition and just run it as soon as we can, and in
this case it is convenient to have device tree compiled into the
kernel binary. Since this case is not limited to MMU-less systems,
let's support it for these which have MMU enabled too.

While at it, provide __dtb_start as a parameter to setup_vm() in
BUILTIN_DTB case, so we don't have to duplicate BUILTIN_DTB specific
processing in MMU-enabled and MMU-disabled versions of setup_vm().

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
Changes from v2:
* folded "RISC-V: simplify BUILTIN_DTB processing" patch
[http://lists.infradead.org/pipermail/linux-riscv/2021-January/004153.html]
Changes from v1:
* no direct initial_boot_params assignment
* skips the temporary mapping for DT if BUILTIN_DTB=y

 arch/riscv/Kconfig       |  1 -
 arch/riscv/kernel/head.S |  4 ++++
 arch/riscv/mm/init.c     | 19 +++++++++++++------
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2ef05ef921b5..444a1ed1e847 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -445,7 +445,6 @@ endmenu
 
 config BUILTIN_DTB
 	def_bool n
-	depends on RISCV_M_MODE
 	depends on OF
 
 menu "Power management options"
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 16e9941900c4..f5a9bad86e58 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -260,7 +260,11 @@ clear_bss_done:
 
 	/* Initialize page tables and relocate to virtual addresses */
 	la sp, init_thread_union + THREAD_SIZE
+#ifdef CONFIG_BUILTIN_DTB
+	la a0, __dtb_start
+#else
 	mv a0, s1
+#endif /* CONFIG_BUILTIN_DTB */
 	call setup_vm
 #ifdef CONFIG_MMU
 	la a0, early_pg_dir
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 30b61f2c6b87..45faad7c4291 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -192,10 +192,13 @@ void __init setup_bootmem(void)
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 	/*
-	 * Avoid using early_init_fdt_reserve_self() since __pa() does
+	 * If DTB is built in, no need to reserve its memblock.
+	 * Otherwise, do reserve it but avoid using
+	 * early_init_fdt_reserve_self() since __pa() does
 	 * not work for DTB pointers that are fixmap addresses
 	 */
-	memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
+	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
+		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
 
 	early_init_fdt_scan_reserved_mem();
 	dma_contiguous_reserve(dma32_phys_limit);
@@ -499,6 +502,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	/* Setup early PMD for DTB */
 	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
 			   (uintptr_t)early_dtb_pmd, PGDIR_SIZE, PAGE_TABLE);
+#ifndef CONFIG_BUILTIN_DTB
 	/* Create two consecutive PMD mappings for FDT early scan */
 	pa = dtb_pa & ~(PMD_SIZE - 1);
 	create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
@@ -506,7 +510,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
 			   pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
 	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
+#else /* CONFIG_BUILTIN_DTB */
+	dtb_early_va = __va(dtb_pa);
+#endif /* CONFIG_BUILTIN_DTB */
 #else
+#ifndef CONFIG_BUILTIN_DTB
 	/* Create two consecutive PGD mappings for FDT early scan */
 	pa = dtb_pa & ~(PGDIR_SIZE - 1);
 	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
@@ -514,6 +522,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA + PGDIR_SIZE,
 			   pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
 	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
+#else /* CONFIG_BUILTIN_DTB */
+	dtb_early_va = __va(dtb_pa);
+#endif /* CONFIG_BUILTIN_DTB */
 #endif
 	dtb_early_pa = dtb_pa;
 
@@ -604,11 +615,7 @@ static void __init setup_vm_final(void)
 #else
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
-#ifdef CONFIG_BUILTIN_DTB
-	dtb_early_va = (void *) __dtb_start;
-#else
 	dtb_early_va = (void *)dtb_pa;
-#endif
 	dtb_early_pa = dtb_pa;
 }
 
-- 
2.20.1

