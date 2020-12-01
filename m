Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FD62C9ADC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgLAJBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388594AbgLAJBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:01:44 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BCBC0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 01:00:58 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d3so1634563wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 01:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lg7/wzzyNccd4o9M3b2wuJGsFz5jftc3SFIFqCFutik=;
        b=swFV7DDsgM5W8tut0PcZ/Rh5qtlfX4uFO+3ZOYeNIL6SS3n2aJMYBC5MEo66p7jM5N
         pBK1sNp+96f41A9UrRZ15g6AP6YEegGsQVWsF01kmm7m51DgIEgybByC8ucqjhJtCTBD
         DsJr5bUmCS5dUH+S5qbIYoHcRiCNQmko+oidE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lg7/wzzyNccd4o9M3b2wuJGsFz5jftc3SFIFqCFutik=;
        b=prRtvI2ug2uvVBAiWb4t03ySAJdjSTUMAHycH1gMiK4aaCpAKKl9GflvDNXpp1bowo
         oxmZHOAkYv+u8eGaP7OPT4jVn0BryiAW3zB94oDahezzCBCX5Ht6sf8ZbHEymoGLH1rX
         RiqSS3xo0XoO4wcsdbVv9SwQPZJJKb38F+gIM+FRmOBCFtEbs68Z2ng7KK6p65I733wp
         P5hXA/dVlt1/8tyGFua357BXgtdH7ayogNURKZQaBsI2rzuh3snm52G/q8A4yyjHRuiF
         nbrtuGV3K8zq5K94XO5vTNXTYSz8anYfIp/8HFrahA4d1yPnVUz2m6pgLozXzByUzN0f
         q51Q==
X-Gm-Message-State: AOAM5306kmLDrge4f8Ob2Ev/SXiEeb6KBRVGROL7Ot9nhfpAS1ASzyfg
        82dtv4fdmNc42iZ/l9qK3vgXig==
X-Google-Smtp-Source: ABdhPJxyBTo+RPM7zhn4hUP/O5dZCH4wEp4+5eLlqexqIusPhFTF01xWbr6It3pIGZmVIUKQ+9O/7g==
X-Received: by 2002:a1c:b684:: with SMTP id g126mr1592306wmf.135.1606813257116;
        Tue, 01 Dec 2020 01:00:57 -0800 (PST)
Received: from lootbox.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id l8sm1959654wro.46.2020.12.01.01.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 01:00:56 -0800 (PST)
From:   vitaly.wool@konsulko.com
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH] riscv: toggle mmu_enabled flag in a precise manner
Date:   Tue,  1 Dec 2020 11:00:24 +0200
Message-Id: <20201201090023.2852-1-vitaly.wool@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Wool <vitaly.wool@konsulko.com>

Cuurently mmu_enabled flag is set to true way later than the actual
MMU enablement takes place. This leads to hard-to-track races in
e. g. SBI earlycon initialization taking wrong path configuring
fixmap.

To fix that, move mmu_enabled toggling to head.S and rename it to
_mmu_enabled to avoid possible name clashes since it's not a static
variable any more.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
 arch/riscv/kernel/head.S |  9 +++++++++
 arch/riscv/mm/init.c     | 13 +++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 0a4e81b8dc79..33cd57285be3 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -248,6 +248,10 @@ clear_bss_done:
 	call relocate
 #endif /* CONFIG_MMU */
 
+	la a0, _mmu_enabled
+	li a1, 1
+	sw a1, (a0)
+
 	call setup_trap_vector
 	/* Restore C environment */
 	la tp, init_task
@@ -370,6 +374,11 @@ ENTRY(reset_regs)
 END(reset_regs)
 #endif /* CONFIG_RISCV_M_MODE */
 
+.section ".data"
+	.global _mmu_enabled
+_mmu_enabled:
+	.word 0
+
 __PAGE_ALIGNED_BSS
 	/* Empty zero page */
 	.balign PAGE_SIZE
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 787c75f751a5..4038be635e25 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -211,7 +211,7 @@ EXPORT_SYMBOL(pfn_base);
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
-static bool mmu_enabled;
+extern bool _mmu_enabled;
 
 #define MAX_EARLY_MAPPING_SIZE	SZ_128M
 
@@ -236,7 +236,7 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 
 static pte_t *__init get_pte_virt(phys_addr_t pa)
 {
-	if (mmu_enabled) {
+	if (_mmu_enabled) {
 		clear_fixmap(FIX_PTE);
 		return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
 	} else {
@@ -250,7 +250,7 @@ static phys_addr_t __init alloc_pte(uintptr_t va)
 	 * We only create PMD or PGD early mappings so we
 	 * should never reach here with MMU disabled.
 	 */
-	BUG_ON(!mmu_enabled);
+	BUG_ON(!_mmu_enabled);
 
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
@@ -281,7 +281,7 @@ pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
 
 static pmd_t *__init get_pmd_virt(phys_addr_t pa)
 {
-	if (mmu_enabled) {
+	if (_mmu_enabled) {
 		clear_fixmap(FIX_PMD);
 		return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
 	} else {
@@ -293,7 +293,7 @@ static phys_addr_t __init alloc_pmd(uintptr_t va)
 {
 	uintptr_t pmd_num;
 
-	if (mmu_enabled)
+	if (_mmu_enabled)
 		return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 
 	pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
@@ -467,9 +467,6 @@ static void __init setup_vm_final(void)
 	phys_addr_t pa, start, end;
 	struct memblock_region *reg;
 
-	/* Set mmu_enabled flag */
-	mmu_enabled = true;
-
 	/* Setup swapper PGD for fixmap */
 	create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
 			   __pa_symbol(fixmap_pgd_next),
-- 
2.20.1

