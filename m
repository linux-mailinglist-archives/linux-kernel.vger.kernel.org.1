Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767722BC53B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 12:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgKVLB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 06:01:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:48804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbgKVLB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 06:01:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79C96ABE4;
        Sun, 22 Nov 2020 11:01:55 +0000 (UTC)
Date:   Sun, 22 Nov 2020 12:01:55 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] efi/urgent for v5.10-rc5
Message-ID: <20201122110155.GB20595@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the (forwarded) EFI urgent fixes for -rc5.

Thx.

--
The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-urgent-for-v5.10-rc3

for you to fetch changes up to c2fe61d8be491ff8188edaf22e838f819999146b:

  efi/x86: Free efi_pgd with free_pages() (2020-11-10 19:18:11 +0100)

----------------------------------------------------------------
Couple of EFI fixes for v5.10:
- fix memory leak in efivarfs driver
- fix HYP mode issue in 32-bit ARM version of the EFI stub when built in
  Thumb2 mode
- avoid leaking EFI pgd pages on allocation failure

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi/arm: set HSCTLR Thumb2 bit correctly for HVC calls from HYP

Arvind Sankar (1):
      efi/x86: Free efi_pgd with free_pages()

Vamshi K Sthambamkadi (1):
      efivarfs: fix memory leak in efivarfs_create()

 arch/arm/boot/compressed/head.S |  3 +++
 arch/x86/platform/efi/efi_64.c  | 24 +++++++++++++-----------
 fs/efivarfs/super.c             |  1 +
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 2e04ec5b5446..caa27322a0ab 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1472,6 +1472,9 @@ ENTRY(efi_enter_kernel)
 		@ issued from HYP mode take us to the correct handler code. We
 		@ will disable the MMU before jumping to the kernel proper.
 		@
+ ARM(		bic	r1, r1, #(1 << 30)	) @ clear HSCTLR.TE
+ THUMB(		orr	r1, r1, #(1 << 30)	) @ set HSCTLR.TE
+		mcr	p15, 4, r1, c1, c0, 0
 		adr	r0, __hyp_reentry_vectors
 		mcr	p15, 4, r0, c12, c0, 0	@ set HYP vector base (HVBAR)
 		isb
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 8f5759df7776..e1e8d4e3a213 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -78,28 +78,30 @@ int __init efi_alloc_page_tables(void)
 	gfp_mask = GFP_KERNEL | __GFP_ZERO;
 	efi_pgd = (pgd_t *)__get_free_pages(gfp_mask, PGD_ALLOCATION_ORDER);
 	if (!efi_pgd)
-		return -ENOMEM;
+		goto fail;
 
 	pgd = efi_pgd + pgd_index(EFI_VA_END);
 	p4d = p4d_alloc(&init_mm, pgd, EFI_VA_END);
-	if (!p4d) {
-		free_page((unsigned long)efi_pgd);
-		return -ENOMEM;
-	}
+	if (!p4d)
+		goto free_pgd;
 
 	pud = pud_alloc(&init_mm, p4d, EFI_VA_END);
-	if (!pud) {
-		if (pgtable_l5_enabled())
-			free_page((unsigned long) pgd_page_vaddr(*pgd));
-		free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
-		return -ENOMEM;
-	}
+	if (!pud)
+		goto free_p4d;
 
 	efi_mm.pgd = efi_pgd;
 	mm_init_cpumask(&efi_mm);
 	init_new_context(NULL, &efi_mm);
 
 	return 0;
+
+free_p4d:
+	if (pgtable_l5_enabled())
+		free_page((unsigned long)pgd_page_vaddr(*pgd));
+free_pgd:
+	free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
+fail:
+	return -ENOMEM;
 }
 
 /*
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 15880a68faad..f943fd0b0699 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -21,6 +21,7 @@ LIST_HEAD(efivarfs_list);
 static void efivarfs_evict_inode(struct inode *inode)
 {
 	clear_inode(inode);
+	kfree(inode->i_private);
 }
 
 static const struct super_operations efivarfs_ops = {
-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
