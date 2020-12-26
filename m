Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775942E2F18
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 21:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgLZUoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 15:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLZUoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 15:44:19 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B137C061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 12:43:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s26so15841207lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 12:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DZziTjfR9wxuxJSERxuItKYeRF8DJCg4kK5zGhF0E+I=;
        b=q3uazC/Q7kSamynh2m4E4nZr6G4ibgqK10f/dFLP5cmhuwYwiInNkiye+NvGz4hWTv
         rV2mfpDADxMdpb6LO1NLodsTCNASU91/2Y4Z1la3BPSjwWJibUIJDurXFqKbhgjO5nI4
         Pe2istpl/Ec1Cja4frPJACoKYeToP+KdOL2Q0q8zL+/B/OPEvW3VW1tzI4O7TezfhWZS
         esHoCsBSoBn4mA6NnIF0HOuN6VA2i0H/WuRCjGOHCPb67rfbzwgAkyd9tjZK3p7CWTww
         GygDD3ens3oQG80aFO4ORLt34ccttVO90uSSEsqK/1xy+56P9dAM/Xg/kwJrHFtpdyA5
         Gllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DZziTjfR9wxuxJSERxuItKYeRF8DJCg4kK5zGhF0E+I=;
        b=rvPIlCkTuPGPLtfDp5rAAKvhG5MjSTS2ZtgIl/xbYVU5x9KUJ42N7dm1ORi8O4pI4U
         VdWIGqmE+fJAFKnUn/fykEaTM3lyWmI0EW/s/BwjzINxMy/MTx5QJX2P1KlydoKt9oXZ
         E/xaULIYp6sMZUX9OdhkMP7++PBuvdq6D2PFWMYMxhNj6DRMifiYEIZnfvbj298T7u6w
         vr+VJkDwTMDX+hI2IgdlBW7S0QzmJ7jKFROm3P9W2ubwUugXXZvSCnsJeR0yt0VZL5tG
         ZG5cyJIjpOylY33DOX4iTR0Ao4dB0LXUEVtuyT/QPEkyNVa10afzvDsGqAJ9U5wt4qJi
         18rA==
X-Gm-Message-State: AOAM532vFzY1zHA9vgPLlc8RrfAAAT2Jy707NY7wjhAZxFbv6OaY7jP3
        9bX2E2g6+9PRpCjm3VIBtpijZA==
X-Google-Smtp-Source: ABdhPJwH7c7KTesUbMk5/G3IqgjIvefZxCH2+bAq5mgCiFRffiDYqD5Uitfom3SQKM1omZ/A0fGsIQ==
X-Received: by 2002:a2e:898a:: with SMTP id c10mr17760805lji.241.1609015417097;
        Sat, 26 Dec 2020 12:43:37 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q17sm4703247lfa.32.2020.12.26.12.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 12:43:36 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 51E901026FA; Sat, 26 Dec 2020 23:43:35 +0300 (+03)
Date:   Sat, 26 Dec 2020 23:43:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20201226204335.dikqkrkezqet6oqf@box>
References: <20201217105409.2gacwgg7rco2ft3m@box>
 <CAHk-=wiyPTnQ9E1dT9LJtNxeVmLaykursk_MSecUqFjSb3gwAw@mail.gmail.com>
 <20201218110400.yve45r3zsv7qgfa3@box>
 <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com>
 <20201219124103.w6isern3ywc7xbur@box>
 <CAHk-=wifcVaxaTn_RbZ=idfYFazTPwm8t5cB1rY6xEBjbcfO5g@mail.gmail.com>
 <20201222100047.p5zdb4ghagncq2oe@box>
 <alpine.LSU.2.11.2012231905300.5723@eggly.anvils>
 <20201225113157.e7hmluffh56fszfc@box>
 <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 09:57:13AM -0800, Linus Torvalds wrote:
> Because not only does that get rid of the "if (page)" test, I think it
> would make things a bit clearer. When I read the patch first, the
> initial "next_page()" call confused me.

Agreed. Here we go:

From d12dea4abe94dbc24b7945329b191ad7d29e213a Mon Sep 17 00:00:00 2001
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
 mm/filemap.c            | 157 ++++++++++++++++++++++++++++----------
 mm/memory.c             | 162 ++++++++++++----------------------------
 4 files changed, 181 insertions(+), 157 deletions(-)

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
index 0b2067b3c328..3a92aaa59b9b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -42,6 +42,7 @@
 #include <linux/psi.h>
 #include <linux/ramfs.h>
 #include <linux/page_idle.h>
+#include <asm/pgalloc.h>
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
@@ -2831,50 +2832,127 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 }
 EXPORT_SYMBOL(filemap_fault);
 
+static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
+{
+	struct mm_struct *mm = vmf->vma->vm_mm;
+
+	/* Huge page is mapped? No need to proceed. */
+	if (pmd_trans_huge(*vmf->pmd))
+		return true;
+
+	if (pmd_none(*vmf->pmd) &&
+	    PageTransHuge(page) &&
+	    do_set_pmd(vmf, page)) {
+		unlock_page(page);
+		return true;
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
+static struct page *next_stable_page(struct page *page, struct vm_fault *vmf,
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
+	return next_stable_page(xas_find(xas, end_pgoff), vmf, xas, end_pgoff);
+}
+
+static inline struct page *next_map_page(struct vm_fault *vmf,
+					  struct xa_state *xas,
+					  pgoff_t end_pgoff)
+{
+	return next_stable_page(xas_next_entry(xas, end_pgoff),
+				vmf, xas, end_pgoff);
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
-	unsigned long max_idx;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct page *head, *page;
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 
 	rcu_read_lock();
-	xas_for_each(&xas, head, end_pgoff) {
-		if (xas_retry(&xas, head))
-			continue;
-		if (xa_is_value(head))
-			goto next;
+	head = first_map_page(vmf, &xas, end_pgoff);
+	if (!head) {
+		rcu_read_unlock();
+		return;
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
+		return;
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
@@ -2884,19 +2962,20 @@ void filemap_map_pages(struct vm_fault *vmf,
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
 }
diff --git a/mm/memory.c b/mm/memory.c
index c48f8df6e502..98d340b45557 100644
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
