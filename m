Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767072FE35B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbhAUHDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:03:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbhAUG7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:59:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1BE32396F;
        Thu, 21 Jan 2021 06:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212253;
        bh=hbNE0RDP/uJ9ruJ7WUn51MzYitbuJM5Vhd2LkF6TEww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFiPyerx5iDVTIrPZeWQ4XSmSPiCuA1W59GnnfUE/k/rkMpfizV2fjEE1PPNMFavn
         BQSzRt2QJwZGUOjgFoJny95lKNe9Z7favlsQyQNoP6MuKymLX+jBk+7Gkb+C08IPym
         m4608GjvxY5EmH68w6RpjbP5WYaNgzYzWk8nWkWEewr+Txpb6XTwZpxL3/pY62+rhv
         SfDU4ft9fdtmT8W5ukbqaeEMIntG6hxRD8LpZElknwu8k5hnr1/JGsE9p22COulYO8
         ieHlx8nLKxErsoSSxJFOeIHMDhQP1kR3JjvBlGNZHEyFU97ussry5dbWLAC0sgrrzx
         lr/K+s4A3B4Xw==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Xu Kai <xukai@nationalchip.com>
Subject: [PATCH 23/29] csky: Fixup _PAGE_ACCESSED for default pgprot
Date:   Thu, 21 Jan 2021 14:53:43 +0800
Message-Id: <20210121065349.3188251-23-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

When the system memory is exhausted, linux will trigger kswapd to
shrink memory page cache. We found the csky's .text file mapping
pages would be reclaimed earlier than arm's elf. Because csky
doesn't give _PAGE_ACCESSED for default pgprot and in zap_pte_range

if (pte_young(ptent) &&
    likely(!(vma->vm_flags & VM_SEQ_READ)))
        mark_page_accessed(page);

mark_page_accessed will put the pages into active lru list.

[    3.652722] delete busybox page from inactive file list
Call Trace:
[<9012a376>] dump_stack+0xe/0x24
[<9012a370>] dump_stack+0x8/0x24
[<9005b780>] activate_page+0x2b4/0x2d4
[<90132502>] vsnprintf+0x2c6/0x374
[<9005b880>] mark_page_accessed+0xe0/0x150
[<9006903e>] unmap_page_range+0x166/0x33c
[<90021844>] get_signal+0x98/0x3b4
[<90069232>] unmap_single_vma+0x1e/0x24
[<90069462>] unmap_vmas+0x26/0x40
[<9006d3d8>] exit_mmap+0x60/0xbc
[<9006a140>] handle_mm_fault+0x700/0xcec
[<900426b2>] ktime_get_with_offset+0x86/0x130
[<90017566>] mmput+0x2e/0x90
[<9001a30a>] do_exit+0x13e/0x6f0
[<90015448>] page_fault_end+0x14/0x74
[<9001b4bc>] SyS_exit_group+0x0/0xc
[<9001b47c>] do_group_exit+0x2c/0x6c
[<9001b4c8>] __wake_up_parent+0x0/0x20
[<9001399e>] csky_systemcall+0x6e/0x72

csky will throw the pages at first and keep them in active lru
list later after real accessed, but arm would keep them in active
lru list at the beginning.

The following are statistics of different architecture styles:

Default _PAGE_ACCESSED: alpha, arm, arm64, ia64, m68k, microblaze,
			openrisc, powerpc, riscv, sh, um, x86,
			xtensa
Not def _PAGE_ACCESSED: arc, c6x, h8300, hexgon, mips, s390, nds32,
			nios2, parisc, sparc

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-developed-by: Xu Kai <xukai@nationalchip.com>
Signed-off-by: Xu Kai <xukai@nationalchip.com>
---
 arch/csky/include/asm/pgtable.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 2485db84dba8..429d96f66620 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -63,18 +63,20 @@
  * read. Also, write permissions imply read permissions. This is the closest
  * we can get by reasonable means..
  */
-#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHED)
-#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
+#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED)
+
+#define PAGE_NONE	__pgprot(_PAGE_BASE | _CACHE_CACHED)
+#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_WRITE | \
 				_CACHE_CACHED)
-#define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_READ | _CACHE_CACHED)
-#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | _PAGE_READ | _CACHE_CACHED)
-#define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
+#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_READ | _CACHE_CACHED)
+#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_READ | _CACHE_CACHED)
+#define PAGE_KERNEL	__pgprot(_PAGE_BASE | __READABLE | __WRITEABLE | \
 				_PAGE_GLOBAL | _CACHE_CACHED)
-#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
+#define PAGE_USERIO	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_WRITE | \
 				_CACHE_CACHED)
 
 #define _PAGE_IOREMAP \
-	(_PAGE_PRESENT | __READABLE | __WRITEABLE | _PAGE_GLOBAL | \
+	(_PAGE_BASE | __READABLE | __WRITEABLE | _PAGE_GLOBAL | \
 	 _CACHE_UNCACHED | _PAGE_SO)
 
 #define __P000	PAGE_NONE
-- 
2.17.1

