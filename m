Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F4B2DEED2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 13:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgLSMlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 07:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgLSMln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 07:41:43 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E170DC0617B0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 04:41:02 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m25so12413734lfc.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 04:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ibhPe7RAKwhIb2pyfXgO/O6AvHLyQ66Q73EtDGE4PL0=;
        b=IFQvFP3An3AEe3Xc/rPL265j9oIjxWbcqsEOYilzdpIH7+S4AX+TfbcOcutMG+oNaR
         38H+v+35GxwFtgQw2AS4HgApDZtt0wXo0Fn/FbohDKTfSRrD/vCkGQ6fGB5gyaPmNQhF
         i2JxBjRrBv2nJRspyfj4McQXFapQwxEytJuSmHjzpLmlKyS8Py+XQxkLymXnf/dNXv4a
         IlfAGOJqhrVbBP+Fr5MHW4dJodqku0gs5TTU5iEu7PxB5lN3+5wUn/QIT9c/c9qdG0oJ
         z30ATFhgGHa/cVOqqaq0HM9Egcl5htLooG8Ir4q1ysc7U7P739MnYL2mh8Yu1+YIeMAn
         mqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ibhPe7RAKwhIb2pyfXgO/O6AvHLyQ66Q73EtDGE4PL0=;
        b=fjrtvct1VLGN1uC+Iq9KHMNYuOx6lWyjPlJaebVB3nYF+XUzpcu9PSpcF9JKrh83ce
         i5Ck/4GsuMNnUxyEWPnn8DJjxZMNZqE77lJpvFe42mp7LdyQZrGeplWxU17Lj9fJ4fos
         erJA4wwygsLznjCkcupRZWZUsExhLLkL9NvmN+sXYbnN+IY5gbRfdvzyEl9ZfiL3hhC9
         +usWMzyyIeMUKs08cdPa9Po6v6wrk4PEWHM2BNj6zQqkqpqosd5cZes5CBT6bj3t+eID
         uqTY/B6WT1vx7GL6VS4H/whAwgXlvuweKUtGv+CKxYuB7QgDF1dDFFpNVcbD8C/V6Wi8
         Kjmg==
X-Gm-Message-State: AOAM530mOFgu0FnCFNqkOgnlVz5MF7rj5RqodS0NxySBRjg3guNc/IO8
        OrfHAcbxj2En20Glg80ewtYrpw==
X-Google-Smtp-Source: ABdhPJxt+xo+4FkX65EjhO3DNlw4BYIdSe9yDzMLr2C29HZWcu0vyOHI/b/0Gv3X/Xfxt+Tg/W3Q3Q==
X-Received: by 2002:ac2:5f52:: with SMTP id 18mr3235494lfz.260.1608381661260;
        Sat, 19 Dec 2020 04:41:01 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k11sm1282633lfd.3.2020.12.19.04.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 04:41:00 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 80A6910138A; Sat, 19 Dec 2020 15:41:03 +0300 (+03)
Date:   Sat, 19 Dec 2020 15:41:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Message-ID: <20201219124103.w6isern3ywc7xbur@box>
References: <20201210150828.4b7pg5lx666r7l2u@black.fi.intel.com>
 <CAHk-=wiU8ktvak2hCj2TWJ6wMSwVsUSvi5Bjf4i1JGvpGmyUZw@mail.gmail.com>
 <20201214160724.ewhjqoi32chheone@box>
 <CAHk-=wi80Qp6nZC0yyewhnqvrmPx2h_yWvfq4A25ONb7z9BywQ@mail.gmail.com>
 <20201216170703.o5lpsnjfmoj7f3ml@box>
 <CAHk-=wiVRMADHC0qjTFAVx2Pp0DN-fT-VPC10boDdX0O4=h01w@mail.gmail.com>
 <20201217105409.2gacwgg7rco2ft3m@box>
 <CAHk-=wiyPTnQ9E1dT9LJtNxeVmLaykursk_MSecUqFjSb3gwAw@mail.gmail.com>
 <20201218110400.yve45r3zsv7qgfa3@box>
 <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 10:56:55AM -0800, Linus Torvalds wrote:
> No?

Okay, but we only win the NULL check. xas_retry() and xa_is_value() has to
be repeated in the beginning of the loop.

From b4f4c0d32e654b8459a1e439a453373499b8946a Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Sat, 19 Dec 2020 15:19:23 +0300
Subject: [PATCH] mm: Cleanup faultaround and finish_fault() codepaths

alloc_set_pte() has two users with different requirements: in the
faultaround code, it called from an atomic context and PTE page table
has to be preallocated. finish_fault() can sleep and allocate page table
as needed.

PTL locking rules are also strange, hard to follow and overkill for
finish_fault().

Let's untangle the mess. alloc_set_pte() has gone now. All locking is
explicit.

The price is some code duplication to handle huge pages in faultaround
path, but it should be fine, having overall improvement in readability.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/mm.h      |   8 +-
 include/linux/pgtable.h |  11 +++
 mm/filemap.c            | 109 +++++++++++++++++++++++----
 mm/memory.c             | 162 ++++++++++++----------------------------
 4 files changed, 158 insertions(+), 132 deletions(-)

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
index 0b2067b3c328..a9b21ec52e73 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -42,6 +42,7 @@
 #include <linux/psi.h>
 #include <linux/ramfs.h>
 #include <linux/page_idle.h>
+#include <asm/pgalloc.h>
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
@@ -2831,10 +2832,74 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 }
 EXPORT_SYMBOL(filemap_fault);
 
+static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page,
+				  struct xa_state *xas)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct address_space *mapping = vma->vm_file->f_mapping;
+
+	/* Huge page is mapped? No need to proceed. */
+	if (pmd_trans_huge(*vmf->pmd))
+		return true;
+
+	if (xa_is_value(page))
+		goto nohuge;
+
+	if (!pmd_none(*vmf->pmd))
+		goto nohuge;
+
+	if (!PageTransHuge(page) || PageLocked(page))
+		goto nohuge;
+
+	if (!page_cache_get_speculative(page))
+		goto nohuge;
+
+	if (page != xas_reload(xas))
+		goto unref;
+
+	if (!PageTransHuge(page))
+		goto unref;
+
+	if (!PageUptodate(page) || PageReadahead(page) || PageHWPoison(page))
+		goto unref;
+
+	if (!trylock_page(page))
+		goto unref;
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
+unref:
+	put_page(page);
+nohuge:
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
+		return true;
+
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
@@ -2843,20 +2908,37 @@ void filemap_map_pages(struct vm_fault *vmf,
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 
 	rcu_read_lock();
-	xas_for_each(&xas, head, end_pgoff) {
+	head = xas_find(&xas, end_pgoff);
+	for (; ; head = xas_next_entry(&xas, end_pgoff)) {
+		if (!head) {
+			rcu_read_unlock();
+			return;
+		}
+		if (likely(!xas_retry(&xas, head)))
+		    break;
+	}
+
+	if (filemap_map_pmd(vmf, head, &xas)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				       vmf->address, &vmf->ptl);
+
+	do {
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
@@ -2884,19 +2966,18 @@ void filemap_map_pages(struct vm_fault *vmf,
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
-	}
+	} while ((head = xas_next_entry(&xas, end_pgoff)) != NULL);
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
