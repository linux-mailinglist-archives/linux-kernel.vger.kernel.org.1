Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97202E333C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 00:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgL0Xzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 18:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgL0Xzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 18:55:43 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F79C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 15:55:02 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s26so20472391lfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 15:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xmJNI249gAw1eNUFrWj2VxwAMyqsP7VUbzENqHLIkiE=;
        b=eGrz+3G3ldRHpwYfQWS1aIBCX7zp0kn6kgXPCgf50roRjpcIsG4QBLH588+FKyj1XZ
         6/UCFHHk0ZiM+UCZuBSfqUrc7M0ef/GldoI+PytyYDhcXg8tmHj15ghREV00nXAflS4I
         ENpM+YEjdvnXIZeV2wXD7eAdlkuiJQH9pDZG5q369NTjB55N+9HeJmiGB5gGSFtQ4ZvX
         GxNwrOZvPl8jF/RXfDuuOvYvf7cbP5aJ6ZBr6Ju695bQV7SgXXkCqB+NOPhvjhz/Pni2
         5XNQ8Av65MzvDtMm0kvJwk6LqR8jLGSsPl9tKab+kmSvJMpeFE+OxxbkWhIXGXGg9RwS
         zdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xmJNI249gAw1eNUFrWj2VxwAMyqsP7VUbzENqHLIkiE=;
        b=TGL5fkt1icXCW4nyqoKwLu+vr07e5/y1Wz6QhJzdJXQvCwCOEmhQpk0lDsiLODaZeW
         ZAqxBmC7oyE9Yn27ZqcFckqOHXH6nef/TloMZohUSjWHuMxvAWqfwA8CZ6hEsHcii502
         12gBQeGLqDJlXg2sRfdgFqsRPk0ElYdWEXVuuycQNYXg9j0ciDZ+0gNQu3UZaEyVyiO/
         OcV1yIBRAQ5CIfFM6lkzcekRm1oe+NF94R7HcJjnv101nYsRHgVYbKyAQTmYX0KoU+/6
         xkyUfxPxilEEtw45eUbALx4qALH18LwBuibbBgQgzCglHVcvKGQKigRSslWF7I7Qck39
         vU0Q==
X-Gm-Message-State: AOAM530mLqi1xtyzXlfVeYN1OrtwFYo9ACa0qDNewfZeN05T8bqZYHVg
        THIJS5gVd8HIfb+Ee4aUYqYczA==
X-Google-Smtp-Source: ABdhPJxzVAWk+JyIAR1+Z2ujWOHCKfHWqw4n3I4zu0nU3Ufl6Q51u+KV6NVYyEBmSAqD0TgWVUCWJw==
X-Received: by 2002:a2e:8685:: with SMTP id l5mr21458558lji.261.1609113300832;
        Sun, 27 Dec 2020 15:55:00 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f26sm6222491ljg.137.2020.12.27.15.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 15:55:00 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2447B102712; Mon, 28 Dec 2020 02:55:00 +0300 (+03)
Date:   Mon, 28 Dec 2020 02:55:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Damian Tometzki <linux@tometzki.de>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries
 when prefaulting
Message-ID: <20201227235500.mkiixkgnukywd7sf@box>
References: <alpine.LSU.2.11.2012261246450.1629@eggly.anvils>
 <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
 <20201226224016.dxjmordcfj75xgte@box>
 <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
 <alpine.LSU.2.11.2012261816520.1071@eggly.anvils>
 <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
 <X+jvZchuTptrxkCH@fedora.tometzki.de>
 <alpine.LSU.2.11.2012271418460.1091@eggly.anvils>
 <CAHk-=whykpz1RfBZ8Cqk=80_d6BWsppGYBJXoWuWB9n+uUKxVA@mail.gmail.com>
 <CAHk-=wjvHxQDet0=DTkqmYni_fgDsG=2_-idECFxnd+ECKdg_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjvHxQDet0=DTkqmYni_fgDsG=2_-idECFxnd+ECKdg_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 03:40:36PM -0800, Linus Torvalds wrote:
> I think Kirill was intending to move the "if (ret)" up into the path
> that sets it, IOW something like
> 
> +       if (!(vma->vm_flags & VM_SHARED)) {
> +               ret = check_stable_address_space(vma->vm_mm);
> +               if (ret)
> +                       return ret;
> +       }
> 
> instead. But that patch as-is is broken.
> 
> Kirill?

Right. Once again, patch is below.

From d50eff470de025f602711ef546aa87d0da1727f5 Mon Sep 17 00:00:00 2001
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
 fs/xfs/xfs_file.c       |   7 +-
 include/linux/mm.h      |  12 +--
 include/linux/pgtable.h |  11 +++
 mm/filemap.c            | 172 ++++++++++++++++++++++++++---------
 mm/memory.c             | 192 +++++++++++-----------------------------
 5 files changed, 207 insertions(+), 187 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5b0f93f73837..040fa64291ed 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1319,17 +1319,20 @@ xfs_filemap_pfn_mkwrite(
 	return __xfs_filemap_fault(vmf, PE_SIZE_PTE, true);
 }
 
-static void
+static vm_fault_t
 xfs_filemap_map_pages(
 	struct vm_fault		*vmf,
+	unsigned long		address,
 	pgoff_t			start_pgoff,
 	pgoff_t			end_pgoff)
 {
 	struct inode		*inode = file_inode(vmf->vma->vm_file);
+	vm_fault_t ret;
 
 	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
-	filemap_map_pages(vmf, start_pgoff, end_pgoff);
+	ret = filemap_map_pages(vmf, address, start_pgoff, end_pgoff);
 	xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
+	return ret;
 }
 
 static const struct vm_operations_struct xfs_file_vm_ops = {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d3fb4e..4e1d2945a71a 100644
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
@@ -562,7 +562,7 @@ struct vm_operations_struct {
 	vm_fault_t (*fault)(struct vm_fault *vmf);
 	vm_fault_t (*huge_fault)(struct vm_fault *vmf,
 			enum page_entry_size pe_size);
-	void (*map_pages)(struct vm_fault *vmf,
+	vm_fault_t (*map_pages)(struct vm_fault *vmf, unsigned long address,
 			pgoff_t start_pgoff, pgoff_t end_pgoff);
 	unsigned long (*pagesize)(struct vm_area_struct * area);
 
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
@@ -2621,7 +2623,7 @@ extern void truncate_inode_pages_final(struct address_space *);
 
 /* generic vm_area_ops exported for stackable file systems */
 extern vm_fault_t filemap_fault(struct vm_fault *vmf);
-extern void filemap_map_pages(struct vm_fault *vmf,
+extern vm_fault_t filemap_map_pages(struct vm_fault *vmf, unsigned long address,
 		pgoff_t start_pgoff, pgoff_t end_pgoff);
 extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
 
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
index 0b2067b3c328..c5da09f3f363 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -42,6 +42,7 @@
 #include <linux/psi.h>
 #include <linux/ramfs.h>
 #include <linux/page_idle.h>
+#include <asm/pgalloc.h>
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
@@ -2831,50 +2832,134 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 }
 EXPORT_SYMBOL(filemap_fault);
 
-void filemap_map_pages(struct vm_fault *vmf,
+static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
+{
+	struct mm_struct *mm = vmf->vma->vm_mm;
+
+	/* Huge page is mapped? No need to proceed. */
+	if (pmd_trans_huge(*vmf->pmd)) {
+		unlock_page(page);
+		put_page(page);
+		return true;
+	}
+
+	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
+	    vm_fault_t ret = do_set_pmd(vmf, page);
+	    if (!ret) {
+		    /* The page is mapped successfully, reference consumed. */
+		    unlock_page(page);
+		    return true;
+	    }
+	}
+
+	if (pmd_none(*vmf->pmd)) {
+		vmf->ptl = pmd_lock(mm, vmf->pmd);
+		if (likely(pmd_none(*vmf->pmd))) {
+			mm_inc_nr_ptes(mm);
+			pmd_populate(mm, vmf->pmd, vmf->prealloc_pte);
+			vmf->prealloc_pte = NULL;
+		}
+		spin_unlock(vmf->ptl);
+	}
+
+	/* See comment in handle_pte_fault() */
+	if (pmd_devmap_trans_unstable(vmf->pmd)) {
+		unlock_page(page);
+		put_page(page);
+		return true;
+	}
+
+	return false;
+}
+
+static struct page *next_uptodate_page(struct page *page, struct vm_fault *vmf,
+				     struct xa_state *xas, pgoff_t end_pgoff)
+{
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	unsigned long max_idx;
+
+	do {
+		if (!page)
+			return NULL;
+		if (xas_retry(xas, page))
+			continue;
+		if (xa_is_value(page))
+			continue;
+		if (PageLocked(page))
+			continue;
+		if (!page_cache_get_speculative(page))
+			continue;
+		/* Has the page moved or been split? */
+		if (unlikely(page != xas_reload(xas)))
+			goto skip;
+		if (!PageUptodate(page) || PageReadahead(page))
+			goto skip;
+		if (PageHWPoison(page))
+			goto skip;
+		if (!trylock_page(page))
+			goto skip;
+		if (page->mapping != mapping)
+			goto unlock;
+		if (!PageUptodate(page))
+			goto unlock;
+		max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
+		if (xas->xa_index >= max_idx)
+			goto unlock;
+		return page;
+unlock:
+		unlock_page(page);
+skip:
+		put_page(page);
+	} while ((page = xas_next_entry(xas, end_pgoff)) != NULL);
+
+	return NULL;
+}
+
+static inline struct page *first_map_page(struct vm_fault *vmf,
+					  struct xa_state *xas,
+					  pgoff_t end_pgoff)
+{
+	return next_uptodate_page(xas_find(xas, end_pgoff),
+				  vmf, xas, end_pgoff);
+}
+
+static inline struct page *next_map_page(struct vm_fault *vmf,
+					  struct xa_state *xas,
+					  pgoff_t end_pgoff)
+{
+	return next_uptodate_page(xas_next_entry(xas, end_pgoff),
+				  vmf, xas, end_pgoff);
+}
+
+vm_fault_t filemap_map_pages(struct vm_fault *vmf, unsigned long address,
 		pgoff_t start_pgoff, pgoff_t end_pgoff)
 {
-	struct file *file = vmf->vma->vm_file;
+	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
 	pgoff_t last_pgoff = start_pgoff;
-	unsigned long max_idx;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct page *head, *page;
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
+	vm_fault_t ret = 0;
 
 	rcu_read_lock();
-	xas_for_each(&xas, head, end_pgoff) {
-		if (xas_retry(&xas, head))
-			continue;
-		if (xa_is_value(head))
-			goto next;
+	head = first_map_page(vmf, &xas, end_pgoff);
+	if (!head) {
+		rcu_read_unlock();
+		return 0;
+	}
 
-		/*
-		 * Check for a locked page first, as a speculative
-		 * reference may adversely influence page migration.
-		 */
-		if (PageLocked(head))
-			goto next;
-		if (!page_cache_get_speculative(head))
-			goto next;
+	if (filemap_map_pmd(vmf, head)) {
+		rcu_read_unlock();
+		return VM_FAULT_NOPAGE;
+	}
 
-		/* Has the page moved or been split? */
-		if (unlikely(head != xas_reload(&xas)))
-			goto skip;
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				       vmf->address, &vmf->ptl);
+	do {
 		page = find_subpage(head, xas.xa_index);
-
-		if (!PageUptodate(head) ||
-				PageReadahead(page) ||
-				PageHWPoison(page))
-			goto skip;
-		if (!trylock_page(head))
-			goto skip;
-
-		if (head->mapping != mapping || !PageUptodate(head))
-			goto unlock;
-
-		max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
-		if (xas.xa_index >= max_idx)
+		if (PageHWPoison(page))
 			goto unlock;
 
 		if (mmap_miss > 0)
@@ -2884,21 +2969,28 @@ void filemap_map_pages(struct vm_fault *vmf,
 		if (vmf->pte)
 			vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;
-		if (alloc_set_pte(vmf, page))
+
+		if (!pte_none(*vmf->pte))
 			goto unlock;
+
+		do_set_pte(vmf, page);
+		/* no need to invalidate: a not-present page won't be cached */
+		update_mmu_cache(vma, vmf->address, vmf->pte);
 		unlock_page(head);
-		goto next;
+
+		/* The fault is handled */
+		if (vmf->address == address)
+			ret = VM_FAULT_NOPAGE;
+		continue;
 unlock:
 		unlock_page(head);
-skip:
 		put_page(head);
-next:
-		/* Huge page is mapped? No need to proceed. */
-		if (pmd_trans_huge(*vmf->pmd))
-			break;
-	}
+	} while ((head = next_map_page(vmf, &xas, end_pgoff)) != NULL);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	rcu_read_unlock();
 	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
+
+	return ret;
 }
 EXPORT_SYMBOL(filemap_map_pages);
 
diff --git a/mm/memory.c b/mm/memory.c
index c48f8df6e502..e51638b92e7c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3490,7 +3490,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (pte_alloc(vma->vm_mm, vmf->pmd))
 		return VM_FAULT_OOM;
 
-	/* See the comment in pte_alloc_one_map() */
+	/* See comment in handle_pte_fault() */
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
@@ -3762,52 +3702,17 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	return ret;
 }
 #else
-static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 {
-	BUILD_BUG();
-	return 0;
+	return VM_FAULT_FALLBACK;
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
@@ -3824,14 +3729,8 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
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
@@ -3849,12 +3748,12 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
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
@@ -3863,13 +3762,36 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
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
+	if (!(vma->vm_flags & VM_SHARED)) {
+		ret = check_stable_address_space(vma->vm_mm);
+		if (ret)
+			return ret;
+	}
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
@@ -3938,7 +3860,6 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	pgoff_t start_pgoff = vmf->pgoff;
 	pgoff_t end_pgoff;
 	int off;
-	vm_fault_t ret = 0;
 
 	nr_pages = READ_ONCE(fault_around_bytes) >> PAGE_SHIFT;
 	mask = ~(nr_pages * PAGE_SIZE - 1) & PAGE_MASK;
@@ -3960,31 +3881,11 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	if (pmd_none(*vmf->pmd)) {
 		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm);
 		if (!vmf->prealloc_pte)
-			goto out;
+			return VM_FAULT_OOM;
 		smp_wmb(); /* See comment in __pte_alloc() */
 	}
 
-	vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
-
-	/* Huge page is mapped? Page fault is solved */
-	if (pmd_trans_huge(*vmf->pmd)) {
-		ret = VM_FAULT_NOPAGE;
-		goto out;
-	}
-
-	/* ->map_pages() haven't done anything useful. Cold page cache? */
-	if (!vmf->pte)
-		goto out;
-
-	/* check if the page fault is solved */
-	vmf->pte -= (vmf->address >> PAGE_SHIFT) - (address >> PAGE_SHIFT);
-	if (!pte_none(*vmf->pte))
-		ret = VM_FAULT_NOPAGE;
-	pte_unmap_unlock(vmf->pte, vmf->ptl);
-out:
-	vmf->address = address;
-	vmf->pte = NULL;
-	return ret;
+	return vmf->vma->vm_ops->map_pages(vmf, address, start_pgoff, end_pgoff);
 }
 
 static vm_fault_t do_read_fault(struct vm_fault *vmf)
@@ -4340,7 +4241,18 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
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
2.26.2

-- 
 Kirill A. Shutemov
