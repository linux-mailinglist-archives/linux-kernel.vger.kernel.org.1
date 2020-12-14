Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141FC2D9BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 17:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440105AbgLNQIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 11:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439331AbgLNQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 11:08:11 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA26C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 08:07:26 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id r24so31426206lfm.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 08:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kIkB8RU25mkcS2abqWtz8FvQNXXTmNPlNnjFJGYmvzk=;
        b=Dqya92hN4bs/D2QpUzSLspLAXuzmndLqiGUR2+60LRiArmSrOinBsN+copzes25Fre
         Jsy0oEwXiiPNrIul1MNq7cZQ391uhc7CrzmFZaxLxcn+KQgSrMYwGtpS6fZcc0W7w2lH
         vi962LT7sfUkxTKn/J3UXiyHbW90lDaMiH1CEaURTZw3yJz1E2Dj7B9M1n3NC3EosrKs
         zxfnMqqzSqYwV52fM1FJgrDYWEcgnXdUTOJjXZXUKdb9pNYJXz/ZPkOIqvNyHJ+poFpN
         sRveljEjdj7q5GbzXSS4dlrzunEfCnKUsWUM+qEcpr6YSSM9EsM1E9RGLpdO0IUqvdWg
         rI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kIkB8RU25mkcS2abqWtz8FvQNXXTmNPlNnjFJGYmvzk=;
        b=skfYr9Y+d4SPhfkMkMvhzvdhtEM7B3Wl3TiJN+t6WMkoZLZ/VZhDSvm9//x4ui2dN6
         HVx2ndPY6orwBWGFRGHzCSlmZtQFVLRW9Bem15UUBVDtcpjVXovE2ofy0AI68AG7apV9
         Bjj9WpoeOSLK3zErOloE3MnHu8mJFeeZeModBlqaoV8Upgg2/gXiasYEIqr5VNPsfaxv
         5bqrHXTOhrK8O8YZlOF/CpRutf+H6vdhnZHQD6r0nwEj/wxbIPxT/uUQdeQoiWHtPqFa
         3Du8junIYuH+krV7mlza0v0KFVzLxQlEGzoS3j9OrMniSg98MeVoW9sIKruj9XDPLPLb
         RYTw==
X-Gm-Message-State: AOAM531zUWKPg9VAMhlepUT/nXgRfTzP3ftOecxSwZ6BY8rSl3Uj6363
        vz9wcJeHpR/DTuSsfVFB8pBuxg==
X-Google-Smtp-Source: ABdhPJyt+PmMxzUe3Av2DFyMvUtRwjQSJJg5/S3zz00d+aGhZQDk49Rrsej8QsHp/30GeuGGch/oyQ==
X-Received: by 2002:a2e:8e94:: with SMTP id z20mr7426041ljk.450.1607962044025;
        Mon, 14 Dec 2020 08:07:24 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w6sm2248334lji.74.2020.12.14.08.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:07:23 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7D0E710301C; Mon, 14 Dec 2020 19:07:24 +0300 (+03)
Date:   Mon, 14 Dec 2020 19:07:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries
 when prefaulting
Message-ID: <20201214160724.ewhjqoi32chheone@box>
References: <20201209163950.8494-1-will@kernel.org>
 <20201209163950.8494-2-will@kernel.org>
 <CAHk-=wgos=vgteG52=J=rVSeq6-Y2g2+Kn1=xV=wYjVzM6O9UQ@mail.gmail.com>
 <20201209184049.GA8778@willie-the-truck>
 <CAHk-=wgVqGh402dxfhR=bx2QSH=+4kq9doarNmD77baqDKdiUg@mail.gmail.com>
 <20201210150828.4b7pg5lx666r7l2u@black.fi.intel.com>
 <CAHk-=wiU8ktvak2hCj2TWJ6wMSwVsUSvi5Bjf4i1JGvpGmyUZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiU8ktvak2hCj2TWJ6wMSwVsUSvi5Bjf4i1JGvpGmyUZw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 09:23:53AM -0800, Linus Torvalds wrote:
> Can we please move that part to the callers too - possibly with a
> separate helper function?

Here it is. Still barely tested.

I expected to hate it more, but it looks reasonable. Opencoded
xas_for_each() smells bad, but...

And diffstat is fine:

 4 files changed, 153 insertions(+), 131 deletions(-)

Any comments?

diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d3fb4e..2825153ad0d6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -534,8 +534,8 @@ struct vm_fault {
 					 * is not NULL, otherwise pmd.
 					 */
 	pgtable_t prealloc_pte;		/* Pre-allocated pte page table.
-					 * vm_ops->map_pages() calls
-					 * alloc_set_pte() from atomic context.
+					 * vm_ops->map_pages() sets up a page
+					 * table from from atomic context.
 					 * do_fault_around() pre-allocates
 					 * page table to avoid allocation from
 					 * atomic context.
@@ -972,7 +972,9 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 	return pte;
 }
 
-vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page);
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
+void do_set_pte(struct vm_fault *vmf, struct page *page);
+
 vm_fault_t finish_fault(struct vm_fault *vmf);
 vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
 #endif
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e237004d498d..869c1921ceda 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1259,6 +1259,17 @@ static inline int pmd_trans_unstable(pmd_t *pmd)
 #endif
 }
 
+/*
+ * the ordering of these checks is important for pmds with _page_devmap set.
+ * if we check pmd_trans_unstable() first we will trip the bad_pmd() check
+ * inside of pmd_none_or_trans_huge_or_clear_bad(). this will end up correctly
+ * returning 1 but not before it spams dmesg with the pmd_clear_bad() output.
+ */
+static inline int pmd_devmap_trans_unstable(pmd_t *pmd)
+{
+	return pmd_devmap(*pmd) || pmd_trans_unstable(pmd);
+}
+
 #ifndef CONFIG_NUMA_BALANCING
 /*
  * Technically a PTE can be PROTNONE even when not doing NUMA balancing but
diff --git a/mm/filemap.c b/mm/filemap.c
index 0b2067b3c328..8fa2183ce10c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -42,6 +42,7 @@
 #include <linux/psi.h>
 #include <linux/ramfs.h>
 #include <linux/page_idle.h>
+#include <asm/pgalloc.h>
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
@@ -2831,10 +2832,53 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 }
 EXPORT_SYMBOL(filemap_fault);
 
+static bool filemap_map_pages_pmd(struct vm_fault *vmf, struct page *page,
+				  struct xa_state *xas)
+{
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+
+	if (xa_is_value(page))
+		return false;
+
+	if (!PageTransHuge(page) || PageLocked(page))
+		return false;
+
+	if (!page_cache_get_speculative(page))
+		return false;
+
+	if (page != xas_reload(xas))
+		goto skip;
+
+	if (!PageTransHuge(page))
+		goto skip;
+
+	if (!PageUptodate(page) || PageReadahead(page) || PageHWPoison(page))
+		goto skip;
+
+	if (!trylock_page(page))
+		goto skip;
+
+	if (page->mapping != mapping || !PageUptodate(page))
+		goto unlock;
+
+	if (xas->xa_index >= DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE))
+		goto unlock;
+
+	do_set_pmd(vmf, page);
+	unlock_page(page);
+	return true;
+unlock:
+	unlock_page(page);
+skip:
+	put_page(page);
+	return false;
+}
+
 void filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff)
 {
-	struct file *file = vmf->vma->vm_file;
+	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
 	pgoff_t last_pgoff = start_pgoff;
 	unsigned long max_idx;
@@ -2843,20 +2887,54 @@ void filemap_map_pages(struct vm_fault *vmf,
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 
 	rcu_read_lock();
-	xas_for_each(&xas, head, end_pgoff) {
+	head = xas_find(&xas, end_pgoff);
+	if (!head) {
+		rcu_read_unlock();
+		return;
+	}
+
+	while (xas_retry(&xas, head))
+		head = xas_next_entry(&xas, end_pgoff);
+
+	if (pmd_none(*vmf->pmd) && filemap_map_pages_pmd(vmf, head, &xas)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	/* Huge page is mapped? No need to proceed. */
+	if (pmd_trans_huge(*vmf->pmd)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+	if (likely(pmd_none(*vmf->pmd))) {
+		mm_inc_nr_ptes(vma->vm_mm);
+		pmd_populate(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
+		vmf->prealloc_pte = NULL;
+	}
+	spin_unlock(vmf->ptl);
+
+	/* See comment in handle_pte_fault() */
+	if (pmd_devmap_trans_unstable(vmf->pmd))
+		return rcu_read_unlock();
+
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				       vmf->address, &vmf->ptl);
+
+	for (; head; head = xas_next_entry(&xas, end_pgoff)) {
 		if (xas_retry(&xas, head))
 			continue;
 		if (xa_is_value(head))
-			goto next;
-
+			continue;
 		/*
 		 * Check for a locked page first, as a speculative
 		 * reference may adversely influence page migration.
 		 */
 		if (PageLocked(head))
-			goto next;
+			continue;
 		if (!page_cache_get_speculative(head))
-			goto next;
+			continue;
 
 		/* Has the page moved or been split? */
 		if (unlikely(head != xas_reload(&xas)))
@@ -2884,19 +2962,18 @@ void filemap_map_pages(struct vm_fault *vmf,
 		if (vmf->pte)
 			vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;
-		if (alloc_set_pte(vmf, page))
-			goto unlock;
+		if (pte_none(*vmf->pte))
+			do_set_pte(vmf, page);
+		/* no need to invalidate: a not-present page won't be cached */
+		update_mmu_cache(vma, vmf->address, vmf->pte);
 		unlock_page(head);
-		goto next;
+		continue;
 unlock:
 		unlock_page(head);
 skip:
 		put_page(head);
-next:
-		/* Huge page is mapped? No need to proceed. */
-		if (pmd_trans_huge(*vmf->pmd))
-			break;
 	}
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	rcu_read_unlock();
 	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
 }
diff --git a/mm/memory.c b/mm/memory.c
index c48f8df6e502..96d62774096a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3490,7 +3490,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (pte_alloc(vma->vm_mm, vmf->pmd))
 		return VM_FAULT_OOM;
 
-	/* See the comment in pte_alloc_one_map() */
+	/* See the comment in map_set_pte() */
 	if (unlikely(pmd_trans_unstable(vmf->pmd)))
 		return 0;
 
@@ -3630,66 +3630,6 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-/*
- * The ordering of these checks is important for pmds with _PAGE_DEVMAP set.
- * If we check pmd_trans_unstable() first we will trip the bad_pmd() check
- * inside of pmd_none_or_trans_huge_or_clear_bad(). This will end up correctly
- * returning 1 but not before it spams dmesg with the pmd_clear_bad() output.
- */
-static int pmd_devmap_trans_unstable(pmd_t *pmd)
-{
-	return pmd_devmap(*pmd) || pmd_trans_unstable(pmd);
-}
-
-static vm_fault_t pte_alloc_one_map(struct vm_fault *vmf)
-{
-	struct vm_area_struct *vma = vmf->vma;
-
-	if (!pmd_none(*vmf->pmd))
-		goto map_pte;
-	if (vmf->prealloc_pte) {
-		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-		if (unlikely(!pmd_none(*vmf->pmd))) {
-			spin_unlock(vmf->ptl);
-			goto map_pte;
-		}
-
-		mm_inc_nr_ptes(vma->vm_mm);
-		pmd_populate(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
-		spin_unlock(vmf->ptl);
-		vmf->prealloc_pte = NULL;
-	} else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd))) {
-		return VM_FAULT_OOM;
-	}
-map_pte:
-	/*
-	 * If a huge pmd materialized under us just retry later.  Use
-	 * pmd_trans_unstable() via pmd_devmap_trans_unstable() instead of
-	 * pmd_trans_huge() to ensure the pmd didn't become pmd_trans_huge
-	 * under us and then back to pmd_none, as a result of MADV_DONTNEED
-	 * running immediately after a huge pmd fault in a different thread of
-	 * this mm, in turn leading to a misleading pmd_trans_huge() retval.
-	 * All we have to ensure is that it is a regular pmd that we can walk
-	 * with pte_offset_map() and we can do that through an atomic read in
-	 * C, which is what pmd_trans_unstable() provides.
-	 */
-	if (pmd_devmap_trans_unstable(vmf->pmd))
-		return VM_FAULT_NOPAGE;
-
-	/*
-	 * At this point we know that our vmf->pmd points to a page of ptes
-	 * and it cannot become pmd_none(), pmd_devmap() or pmd_trans_huge()
-	 * for the duration of the fault.  If a racing MADV_DONTNEED runs and
-	 * we zap the ptes pointed to by our vmf->pmd, the vmf->ptl will still
-	 * be valid and we will re-check to make sure the vmf->pte isn't
-	 * pte_none() under vmf->ptl protection when we return to
-	 * alloc_set_pte().
-	 */
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
-			&vmf->ptl);
-	return 0;
-}
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void deposit_prealloc_pte(struct vm_fault *vmf)
 {
@@ -3704,7 +3644,7 @@ static void deposit_prealloc_pte(struct vm_fault *vmf)
 	vmf->prealloc_pte = NULL;
 }
 
-static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
@@ -3769,45 +3709,11 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 }
 #endif
 
-/**
- * alloc_set_pte - setup new PTE entry for given page and add reverse page
- * mapping. If needed, the function allocates page table or use pre-allocated.
- *
- * @vmf: fault environment
- * @page: page to map
- *
- * Caller must take care of unlocking vmf->ptl, if vmf->pte is non-NULL on
- * return.
- *
- * Target users are page handler itself and implementations of
- * vm_ops->map_pages.
- *
- * Return: %0 on success, %VM_FAULT_ code in case of error.
- */
-vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
+void do_set_pte(struct vm_fault *vmf, struct page *page)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	pte_t entry;
-	vm_fault_t ret;
-
-	if (pmd_none(*vmf->pmd) && PageTransCompound(page)) {
-		ret = do_set_pmd(vmf, page);
-		if (ret != VM_FAULT_FALLBACK)
-			return ret;
-	}
-
-	if (!vmf->pte) {
-		ret = pte_alloc_one_map(vmf);
-		if (ret)
-			return ret;
-	}
-
-	/* Re-check under ptl */
-	if (unlikely(!pte_none(*vmf->pte))) {
-		update_mmu_tlb(vma, vmf->address, vmf->pte);
-		return VM_FAULT_NOPAGE;
-	}
 
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, vma->vm_page_prot);
@@ -3824,14 +3730,8 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 		page_add_file_rmap(page, false);
 	}
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
-
-	/* no need to invalidate: a not-present page won't be cached */
-	update_mmu_cache(vma, vmf->address, vmf->pte);
-
-	return 0;
 }
 
-
 /**
  * finish_fault - finish page fault once we have prepared the page to fault
  *
@@ -3849,12 +3749,12 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
  */
 vm_fault_t finish_fault(struct vm_fault *vmf)
 {
+	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
-	vm_fault_t ret = 0;
+	vm_fault_t ret;
 
 	/* Did we COW the page? */
-	if ((vmf->flags & FAULT_FLAG_WRITE) &&
-	    !(vmf->vma->vm_flags & VM_SHARED))
+	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED))
 		page = vmf->cow_page;
 	else
 		page = vmf->page;
@@ -3863,13 +3763,35 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	 * check even for read faults because we might have lost our CoWed
 	 * page
 	 */
-	if (!(vmf->vma->vm_flags & VM_SHARED))
-		ret = check_stable_address_space(vmf->vma->vm_mm);
-	if (!ret)
-		ret = alloc_set_pte(vmf, page);
-	if (vmf->pte)
-		pte_unmap_unlock(vmf->pte, vmf->ptl);
-	return ret;
+	if (!(vma->vm_flags & VM_SHARED))
+		ret = check_stable_address_space(vma->vm_mm);
+	if (ret)
+		return ret;
+
+	if (pmd_none(*vmf->pmd)) {
+		if (PageTransCompound(page)) {
+			ret = do_set_pmd(vmf, page);
+			if (ret != VM_FAULT_FALLBACK)
+				return ret;
+		}
+
+		if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
+			return VM_FAULT_OOM;
+	}
+
+	/* See comment in handle_pte_fault() */
+	if (pmd_devmap_trans_unstable(vmf->pmd))
+		return 0;
+
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				      vmf->address, &vmf->ptl);
+	/* Re-check under ptl */
+	if (likely(pte_none(*vmf->pte)))
+		do_set_pte(vmf, page);
+
+	update_mmu_tlb(vma, vmf->address, vmf->pte);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	return 0;
 }
 
 static unsigned long fault_around_bytes __read_mostly =
@@ -3980,7 +3902,6 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	vmf->pte -= (vmf->address >> PAGE_SHIFT) - (address >> PAGE_SHIFT);
 	if (!pte_none(*vmf->pte))
 		ret = VM_FAULT_NOPAGE;
-	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	vmf->address = address;
 	vmf->pte = NULL;
@@ -4340,7 +4261,18 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 */
 		vmf->pte = NULL;
 	} else {
-		/* See comment in pte_alloc_one_map() */
+		/*
+		 * If a huge pmd materialized under us just retry later.  Use
+		 * pmd_trans_unstable() via pmd_devmap_trans_unstable() instead
+		 * of pmd_trans_huge() to ensure the pmd didn't become
+		 * pmd_trans_huge under us and then back to pmd_none, as a
+		 * result of MADV_DONTNEED running immediately after a huge pmd
+		 * fault in a different thread of this mm, in turn leading to a
+		 * misleading pmd_trans_huge() retval. All we have to ensure is
+		 * that it is a regular pmd that we can walk with
+		 * pte_offset_map() and we can do that through an atomic read
+		 * in C, which is what pmd_trans_unstable() provides.
+		 */
 		if (pmd_devmap_trans_unstable(vmf->pmd))
 			return 0;
 		/*
-- 
 Kirill A. Shutemov
