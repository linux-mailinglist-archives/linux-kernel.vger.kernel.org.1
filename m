Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF4A3039F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403914AbhAZKO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731732AbhAYTV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:21:26 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51A0C061793
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:38 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id x81so10761854qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yxqxdjcYeXzHRYJR2uL7fg5YfMG49Nqr7zKyoy7ZCso=;
        b=B+qQeHZmm1nCpaer5jGR+2XL6vSG8oc6ubxBiW55/ZEpjT2ip14JUJefspWFfBQ6rt
         iBqlLQCI3KgXOUvLw0zhTVAQK5uxX/UjiKR/MkioK7T2r12lNsCoQBZbQn+9NVQ2oNuT
         YK+uko972boltBWppWe8whrFOtZ2Mhtqv/iP9xoIMVV3NqgpyuNg2c2fwqeyz4qeD/o3
         ktZpoUs8f9jp3HUc1a5pQ/Utk2SPkmBTyIeWR5osMkCLaaoOXqGVKy3KDgzs4me7BHgM
         zboESC1tS7LywP8+X1Y0VNi5CfUjDoofhhyY29oDe1fIrxlNrkHZWRfJADOUB+qVFZGG
         qrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxqxdjcYeXzHRYJR2uL7fg5YfMG49Nqr7zKyoy7ZCso=;
        b=PD4zT7IGfj2e60ExzkFdCkgjyLn8Yk/VONlkzzIZeGTyyVxSXgxnxqI26Jk8cal5Of
         IyFPmlhpzzGOVIOaCTuBPBaiWPoH/X0hANja6Iq54DDwJnqIgoYObZH8k1mxrtARIk+A
         Nr+6Lykp6eCBckL1xTrtwFfNEAEA98m5HTb2B0JuxHqFuk9fFOH6zcxJDk1p/Ql9GsTA
         RDxLv3XwNoK/GvWXeXvEWDWL8Vpj99AQWVb7Kl2ckKctKqntspBbAl+l8JCNsLGRw54q
         5WPwSeagtXm6zzfUt1DRG1Pn3G1RTrOX3XuumCFGm0xGKgwWAS1pOr5pUjoOZZY+X9ks
         X2+g==
X-Gm-Message-State: AOAM531tgMr637JD25/PLZHKfMdZ8x1i/pJi2S17H26Qw78v9yQzHddi
        ACWeKVW+ygmhm2cUXPqkkUvRNA==
X-Google-Smtp-Source: ABdhPJzSy2uQ+VCegZg1vz7vlssjTu7VocHSaS3LdXt5GoYDFqUz9exkpacYbL1y/NfjKgTESmOAjQ==
X-Received: by 2002:a05:620a:1406:: with SMTP id d6mr2217884qkj.312.1611602377878;
        Mon, 25 Jan 2021 11:19:37 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:37 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v10 08/18] arm64: trans_pgd: hibernate: idmap the single page that holds the copy page routines
Date:   Mon, 25 Jan 2021 14:19:13 -0500
Message-Id: <20210125191923.1060122-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

To resume from hibernate, the contents of memory are restored from
the swap image. This may overwrite any page, including the running
kernel and its page tables.

Hibernate copies the code it uses to do the restore into a single
page that it knows won't be overwritten, and maps it with page tables
built from pages that won't be overwritten.

Today the address it uses for this mapping is arbitrary, but to allow
kexec to reuse this code, it needs to be idmapped. To idmap the page
we must avoid the kernel helpers that have VA_BITS baked in.

Convert create_single_mapping() to take a single PA, and idmap it.
The page tables are built in the reverse order to normal using
pfn_pte() to stir in any bits between 52:48. T0SZ is always increased
to cover 48bits, or 52 if the copy code has bits 52:48 in its PA.

Signed-off-by: James Morse <james.morse@arm.com>

[Adopted the original patch from James to trans_pgd interface, so it can be
commonly used by both Kexec and Hibernate. Some minor clean-ups.]

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Link: https://lore.kernel.org/linux-arm-kernel/20200115143322.214247-4-james.morse@arm.com/
---
 arch/arm64/include/asm/trans_pgd.h |  3 ++
 arch/arm64/kernel/hibernate.c      | 32 +++++++------------
 arch/arm64/mm/trans_pgd.c          | 49 ++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index 7fbf6a3ccff7..5d08e5adf3d5 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -33,4 +33,7 @@ int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
 int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		       void *page, unsigned long dst_addr, pgprot_t pgprot);
 
+int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
+			 unsigned long *t0sz, void *page);
+
 #endif /* _ASM_TRANS_TABLE_H */
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 94fc275cdd21..9df32ba0d574 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -194,7 +194,6 @@ static void *hibernate_page_alloc(void *arg)
  * page system.
  */
 static int create_safe_exec_page(void *src_start, size_t length,
-				 unsigned long dst_addr,
 				 phys_addr_t *phys_dst_addr)
 {
 	struct trans_pgd_info trans_info = {
@@ -203,7 +202,8 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	};
 
 	void *page = (void *)get_safe_page(GFP_ATOMIC);
-	pgd_t *trans_pgd;
+	phys_addr_t trans_ttbr0;
+	unsigned long t0sz;
 	int rc;
 
 	if (!page)
@@ -211,13 +211,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 	memcpy(page, src_start, length);
 	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
-
-	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
-	if (!trans_pgd)
-		return -ENOMEM;
-
-	rc = trans_pgd_map_page(&trans_info, trans_pgd, page, dst_addr,
-				PAGE_KERNEL_EXEC);
+	rc = trans_pgd_idmap_page(&trans_info, &trans_ttbr0, &t0sz, page);
 	if (rc)
 		return rc;
 
@@ -230,12 +224,15 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	 * page, but TLBs may contain stale ASID-tagged entries (e.g. for EFI
 	 * runtime services), while for a userspace-driven test_resume cycle it
 	 * points to userspace page tables (and we must point it at a zero page
-	 * ourselves). Elsewhere we only (un)install the idmap with preemption
-	 * disabled, so T0SZ should be as required regardless.
+	 * ourselves).
+	 *
+	 * We change T0SZ as part of installing the idmap. This is undone by
+	 * cpu_uninstall_idmap() in __cpu_suspend_exit().
 	 */
 	cpu_set_reserved_ttbr0();
 	local_flush_tlb_all();
-	write_sysreg(phys_to_ttbr(virt_to_phys(trans_pgd)), ttbr0_el1);
+	__cpu_set_tcr_t0sz(t0sz);
+	write_sysreg(trans_ttbr0, ttbr0_el1);
 	isb();
 
 	*phys_dst_addr = virt_to_phys(page);
@@ -434,7 +431,6 @@ int swsusp_arch_resume(void)
 	void *zero_page;
 	size_t exit_size;
 	pgd_t *tmp_pg_dir;
-	phys_addr_t phys_hibernate_exit;
 	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
 					  void *, phys_addr_t, phys_addr_t);
 	struct trans_pgd_info trans_info = {
@@ -462,19 +458,13 @@ int swsusp_arch_resume(void)
 		return -ENOMEM;
 	}
 
-	/*
-	 * Locate the exit code in the bottom-but-one page, so that *NULL
-	 * still has disastrous affects.
-	 */
-	hibernate_exit = (void *)PAGE_SIZE;
 	exit_size = __hibernate_exit_text_end - __hibernate_exit_text_start;
 	/*
 	 * Copy swsusp_arch_suspend_exit() to a safe page. This will generate
 	 * a new set of ttbr0 page tables and load them.
 	 */
 	rc = create_safe_exec_page(__hibernate_exit_text_start, exit_size,
-				   (unsigned long)hibernate_exit,
-				   &phys_hibernate_exit);
+				   (phys_addr_t *)&hibernate_exit);
 	if (rc) {
 		pr_err("Failed to create safe executable page for hibernate_exit code.\n");
 		return rc;
@@ -493,7 +483,7 @@ int swsusp_arch_resume(void)
 	 * We can skip this step if we booted at EL1, or are running with VHE.
 	 */
 	if (el2_reset_needed()) {
-		phys_addr_t el2_vectors = phys_hibernate_exit;  /* base */
+		phys_addr_t el2_vectors = (phys_addr_t)hibernate_exit;
 		el2_vectors += hibernate_el2_vectors -
 			       __hibernate_exit_text_start;     /* offset */
 
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index ded8e2ba0308..527f0a39c3da 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -273,3 +273,52 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 
 	return 0;
 }
+
+/*
+ * The page we want to idmap may be outside the range covered by VA_BITS that
+ * can be built using the kernel's p?d_populate() helpers. As a one off, for a
+ * single page, we build these page tables bottom up and just assume that will
+ * need the maximum T0SZ.
+ *
+ * Returns 0 on success, and -ENOMEM on failure.
+ * On success trans_ttbr0 contains page table with idmapped page, t0sz is set to
+ * maximum T0SZ for this page.
+ */
+int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
+			 unsigned long *t0sz, void *page)
+{
+	phys_addr_t dst_addr = virt_to_phys(page);
+	unsigned long pfn = __phys_to_pfn(dst_addr);
+	int max_msb = (dst_addr & GENMASK(52, 48)) ? 51 : 47;
+	int bits_mapped = PAGE_SHIFT - 4;
+	unsigned long level_mask, prev_level_entry, *levels[4];
+	int this_level, index, level_lsb, level_msb;
+
+	dst_addr &= PAGE_MASK;
+	prev_level_entry = pte_val(pfn_pte(pfn, PAGE_KERNEL_EXEC));
+
+	for (this_level = 3; this_level >= 0; this_level--) {
+		levels[this_level] = trans_alloc(info);
+		if (!levels[this_level])
+			return -ENOMEM;
+
+		level_lsb = ARM64_HW_PGTABLE_LEVEL_SHIFT(this_level);
+		level_msb = min(level_lsb + bits_mapped, max_msb);
+		level_mask = GENMASK_ULL(level_msb, level_lsb);
+
+		index = (dst_addr & level_mask) >> level_lsb;
+		*(levels[this_level] + index) = prev_level_entry;
+
+		pfn = virt_to_pfn(levels[this_level]);
+		prev_level_entry = pte_val(pfn_pte(pfn,
+						   __pgprot(PMD_TYPE_TABLE)));
+
+		if (level_msb == max_msb)
+			break;
+	}
+
+	*trans_ttbr0 = phys_to_ttbr(__pfn_to_phys(pfn));
+	*t0sz = TCR_T0SZ(max_msb + 1);
+
+	return 0;
+}
-- 
2.25.1

