Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FBF2D46F0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbgLIQkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730364AbgLIQkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:40:39 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        kernel-team@android.com
Subject: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
Date:   Wed,  9 Dec 2020 16:39:49 +0000
Message-Id: <20201209163950.8494-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201209163950.8494-1-will@kernel.org>
References: <20201209163950.8494-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5c0a85fad949 ("mm: make faultaround produce old ptes") changed
the "faultaround" behaviour to initialise prefaulted PTEs as 'old',
since this avoids vmscan wrongly assuming that they are hot, despite
having never been explicitly accessed by userspace. The change has been
shown to benefit numerous arm64 micro-architectures (with hardware
access flag) running Android, where both application launch latency and
direct reclaim time are significantly reduced.

Unfortunately, commit 315d09bf30c2 ("Revert "mm: make faultaround produce
old ptes"") reverted the change to it being identified as the cause of a
~6% regression in unixbench on x86. Experiments on a variety of recent
arm64 micro-architectures indicate that unixbench is not affected by
the original commit, yielding a 0-1% performance improvement.

Since one size does not fit all for the initial state of prefaulted PTEs,
introduce arch_wants_old_faultaround_pte(), which allows an architecture
to opt-in to 'old' prefaulted PTEs at runtime based on whatever criteria
it may have.

Cc: Jan Kara <jack@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Vinayak Menon <vinmenon@codeaurora.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/mm.h |  5 ++++-
 mm/memory.c        | 31 ++++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d3fb4e..932886554586 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -426,6 +426,7 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_PREFAULT_OLD: Initialise pre-faulted PTEs in the 'old' state.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -456,6 +457,7 @@ extern pgprot_t protection_map[16];
 #define FAULT_FLAG_REMOTE			0x80
 #define FAULT_FLAG_INSTRUCTION  		0x100
 #define FAULT_FLAG_INTERRUPTIBLE		0x200
+#define FAULT_FLAG_PREFAULT_OLD			0x400
 
 /*
  * The default fault flags that should be used by most of the
@@ -493,7 +495,8 @@ static inline bool fault_flag_allow_retry_first(unsigned int flags)
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
 	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
-	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
+	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
+	{ FAULT_FLAG_PREFAULT_OLD,	"PREFAULT_OLD" }
 
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
diff --git a/mm/memory.c b/mm/memory.c
index c48f8df6e502..6b30c15120e7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -134,6 +134,18 @@ static inline bool arch_faults_on_old_pte(void)
 }
 #endif
 
+#ifndef arch_wants_old_faultaround_pte
+static inline bool arch_wants_old_faultaround_pte(void)
+{
+	/*
+	 * Transitioning a PTE from 'old' to 'young' can be expensive on
+	 * some architectures, even if it's performed in hardware. By
+	 * default, "false" means prefaulted entries will be 'young'.
+	 */
+	return false;
+}
+#endif
+
 static int __init disable_randmaps(char *s)
 {
 	randomize_va_space = 0;
@@ -3788,6 +3800,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
+	bool old = vmf->flags & FAULT_FLAG_PREFAULT_OLD;
 	pte_t entry;
 	vm_fault_t ret;
 
@@ -3811,7 +3824,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, vma->vm_page_prot);
-	entry = pte_sw_mkyoung(entry);
+	entry = old ? pte_mkold(entry) : pte_sw_mkyoung(entry);
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	/* copy-on-write page */
@@ -3964,6 +3977,9 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 		smp_wmb(); /* See comment in __pte_alloc() */
 	}
 
+	if (arch_wants_old_faultaround_pte())
+		vmf->flags |= FAULT_FLAG_PREFAULT_OLD;
+
 	vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
 
 	/* Huge page is mapped? Page fault is solved */
@@ -3978,8 +3994,17 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 
 	/* check if the page fault is solved */
 	vmf->pte -= (vmf->address >> PAGE_SHIFT) - (address >> PAGE_SHIFT);
-	if (!pte_none(*vmf->pte))
-		ret = VM_FAULT_NOPAGE;
+	if (pte_none(*vmf->pte))
+		goto out_unlock;
+
+	if (vmf->flags & FAULT_FLAG_PREFAULT_OLD) {
+		pte_t pte = pte_mkyoung(*vmf->pte);
+		if (ptep_set_access_flags(vmf->vma, address, vmf->pte, pte, 0))
+			update_mmu_cache(vmf->vma, address, vmf->pte);
+	}
+
+	ret = VM_FAULT_NOPAGE;
+out_unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	vmf->address = address;
-- 
2.29.2.576.ga3fc446d84-goog

