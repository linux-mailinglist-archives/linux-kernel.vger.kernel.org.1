Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EA42F68C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbhANSCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:02:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbhANSCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:02:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00F0423B79;
        Thu, 14 Jan 2021 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610647258;
        bh=CLWZyv41YTti7pvhWRzPDEtPLCfiI6EClMAI6/Ld1fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJMrbnzspRpeSRI7dZBjnZ0vGXNbgelPRQ1K5SowwdgLjb6Vuif4UOT3zVV3RR7ab
         cgTKsAdOBlJEfCGucCtw5XWH44gUYwkELgXj/F7tnFepyUncIsA6tx3br7+arGAeLG
         KSCv7OEbFWA3JdVu0ypf5NI8RT1iuZCjwaSVMXFDMo3LvRxTIiul+l/c1HH3uA2Bq5
         bU4PNuJclHUe+1+gAbpMGDmqj4SppPRNKSb9HELTjtAyiu3n6rm6kmA3iZe43UyRYP
         DZim5okUpwJtJwgkzmOVd4QwG7O8R2KUBg/BHl7H9HT7YPVzrbieEQ0NaW1/Bf6nkP
         gz9u72h/vB4QQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
Subject: [RFC PATCH 5/8] mm: Pass 'address' to map to do_set_pte() and drop FAULT_FLAG_PREFAULT
Date:   Thu, 14 Jan 2021 17:59:31 +0000
Message-Id: <20210114175934.13070-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114175934.13070-1-will@kernel.org>
References: <20210114175934.13070-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than modifying the 'address' field of the 'struct vm_fault_info'
passed to do_set_pte(), leave that to identify the real faulting address
and pass in the virtual address to be mapped by the new pte as a
separate argument.

This makes FAULT_FLAG_PREFAULT redundant, as a prefault entry can be
identified simply by comparing the new address parameter with the
faulting address, so remove the redundant flag at the same time.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/mm.h |  7 ++-----
 mm/filemap.c       | 22 +++++++---------------
 mm/memory.c        | 10 +++++-----
 3 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 15e8dd77b8ff..c24dd17b32c5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -434,7 +434,6 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
- * @FAULT_FLAG_PREFAULT: Fault was a prefault.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -465,7 +464,6 @@ extern pgprot_t protection_map[16];
 #define FAULT_FLAG_REMOTE			0x80
 #define FAULT_FLAG_INSTRUCTION  		0x100
 #define FAULT_FLAG_INTERRUPTIBLE		0x200
-#define FAULT_FLAG_PREFAULT			0x400
 
 /*
  * The default fault flags that should be used by most of the
@@ -503,8 +501,7 @@ static inline bool fault_flag_allow_retry_first(unsigned int flags)
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
 	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
-	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
-	{ FAULT_FLAG_PREFAULT,		"PREFAULT" }
+	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
 
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
@@ -997,7 +994,7 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 }
 
 vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
-void do_set_pte(struct vm_fault *vmf, struct page *page);
+void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr);
 
 vm_fault_t finish_fault(struct vm_fault *vmf);
 vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
diff --git a/mm/filemap.c b/mm/filemap.c
index c192e103843f..46ca16bf1372 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3018,8 +3018,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
 	pgoff_t last_pgoff = start_pgoff;
-	unsigned long address = vmf->info.address;
-	unsigned long flags = vmf->flags;
+	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct page *head, *page;
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
@@ -3035,9 +3034,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
-	vmf->info.address = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-				       vmf->info.address, &vmf->ptl);
+	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
 	do {
 		page = find_subpage(head, xas.xa_index);
 		if (PageHWPoison(page))
@@ -3046,7 +3044,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		if (mmap_miss > 0)
 			mmap_miss--;
 
-		vmf->info.address += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
+		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
 		vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;
 
@@ -3054,16 +3052,12 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 			goto unlock;
 
 		/* We're about to handle the fault */
-		if (vmf->info.address == address) {
-			vmf->flags &= ~FAULT_FLAG_PREFAULT;
+		if (vmf->info.address == addr)
 			ret = VM_FAULT_NOPAGE;
-		} else {
-			vmf->flags |= FAULT_FLAG_PREFAULT;
-		}
 
-		do_set_pte(vmf, page);
+		do_set_pte(vmf, page, addr);
 		/* no need to invalidate: a not-present page won't be cached */
-		update_mmu_cache(vma, vmf->info.address, vmf->pte);
+		update_mmu_cache(vma, addr, vmf->pte);
 		unlock_page(head);
 		continue;
 unlock:
@@ -3073,8 +3067,6 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	rcu_read_unlock();
-	vmf->flags = flags;
-	vmf->info.address = address;
 	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
 	return ret;
 }
diff --git a/mm/memory.c b/mm/memory.c
index ffb7598046fc..f19184542974 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3741,11 +3741,11 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 }
 #endif
 
-void do_set_pte(struct vm_fault *vmf, struct page *page)
+void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 {
 	struct vm_area_struct *vma = vmf->info.vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
-	bool prefault = vmf->flags & FAULT_FLAG_PREFAULT;
+	bool prefault = vmf->info.address != addr;
 	pte_t entry;
 
 	flush_icache_page(vma, page);
@@ -3761,13 +3761,13 @@ void do_set_pte(struct vm_fault *vmf, struct page *page)
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-		page_add_new_anon_rmap(page, vma, vmf->info.address, false);
+		page_add_new_anon_rmap(page, vma, addr, false);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
 		page_add_file_rmap(page, false);
 	}
-	set_pte_at(vma->vm_mm, vmf->info.address, vmf->pte, entry);
+	set_pte_at(vma->vm_mm, addr, vmf->pte, entry);
 }
 
 /**
@@ -3827,7 +3827,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	ret = 0;
 	/* Re-check under ptl */
 	if (likely(pte_none(*vmf->pte)))
-		do_set_pte(vmf, page);
+		do_set_pte(vmf, page, vmf->info.address);
 	else
 		ret = VM_FAULT_NOPAGE;
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

