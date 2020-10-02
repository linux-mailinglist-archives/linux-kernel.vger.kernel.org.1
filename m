Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB14281BF2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 21:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbgJBT04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 15:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbgJBT04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 15:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601666810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6cF3SgzuvOIRZj3w94/msXN6CI56hZ4X2dxSFR9vd+k=;
        b=Yp7+nVfhWc+/5tnUtm4PJnbJVe5rN5jVw5s8CCW7i3SamuYU352Dlh7TJMDD6WW6cdzZkx
        bt3degXRJTcjndCj8otYz28p1+JP7u+omHdYltCxvS1IxSJ9X7dzTRWhDl+KkGR2TQi/16
        fSk9EMC6mhjZOAvf7oSlzdEpt5xR8p0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-CchblOdTPuqG4SxS_qamjg-1; Fri, 02 Oct 2020 15:26:48 -0400
X-MC-Unique: CchblOdTPuqG4SxS_qamjg-1
Received: by mail-qt1-f197.google.com with SMTP id h31so1784031qtd.14
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 12:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6cF3SgzuvOIRZj3w94/msXN6CI56hZ4X2dxSFR9vd+k=;
        b=Y7XQdQ/8FvE2TcQUirofhwYMg+oSWNp3gO+6qVjh5QiYHta0Da9Qjd3+3uvkZ5Nhte
         DotX8lezSysR05zR52D2jZ7f/hmouGZREZ238v76pVP/9O6ONcacp8RDAfdeEJVdy5KM
         rASwRBMyu906ToTsNjvsUUAc1Y0jDVrq/GCetZLKzpHHwc7T5HY9SpvM7EtfzRLn7tGp
         FxwHNJZ2njK80vWhVTsr6ogzgIjNvUGEYgqUntkOS4ItihisnFUY0VFwUpmEyDvviIgi
         mj82gKFgwkjVzYAkEOmKImomg/wdJEwHW3x0NCZA3/cOGIP75wPZG7f4DPqrAeNYl4jG
         zZOw==
X-Gm-Message-State: AOAM532HnOVjugoi5dRXyoAPYXMNAucecTMNS6mUHFmn+u+hzprREquF
        PKl+H6dFg99tYWdCxxMq1OZMU+4XqL5uspgRJPPbQjPM92oqZKH3QJiuBnC8kDno3v87QSf+Ab+
        d6SCFg969EvW+j2La8LbSbriS
X-Received: by 2002:ac8:bc9:: with SMTP id p9mr3993657qti.50.1601666808318;
        Fri, 02 Oct 2020 12:26:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlLlKbJozevapkbP1NSaJIub/Tra+6blf+F5KS20vS0EjxdmqJiwzSPiJYMOy9iovbujil3w==
X-Received: by 2002:ac8:bc9:: with SMTP id p9mr3993626qti.50.1601666807905;
        Fri, 02 Oct 2020 12:26:47 -0700 (PDT)
Received: from localhost.localdomain (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id t140sm1704842qke.125.2020.10.02.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 12:26:47 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] mm: Remove src/dst mm parameter in copy_page_range()
Date:   Fri,  2 Oct 2020 15:26:47 -0400
Message-Id: <20201002192647.7161-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both of the mm pointers are not needed after commit 7a4830c380f3 ("mm/fork:
Pass new vma pointer into copy_page_range()").

Jason Gunthorpe also reported that the ordering of copy_page_range() is odd.
Since working at it, reorder the parameters to be logical, by (1) always put
the dst_* fields to be before src_* fields, and (2) keep the same type of
parameters together.

CC: Jason Gunthorpe <jgg@ziepe.ca>
CC: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- further reorder some parameters and line format [Jason]
---
 include/linux/mm.h |   4 +-
 kernel/fork.c      |   2 +-
 mm/memory.c        | 139 ++++++++++++++++++++++++---------------------
 3 files changed, 76 insertions(+), 69 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 16b799a0522c..a26e9f706b25 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1645,8 +1645,8 @@ struct mmu_notifier_range;
 
 void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 		unsigned long end, unsigned long floor, unsigned long ceiling);
-int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
-		    struct vm_area_struct *vma, struct vm_area_struct *new);
+int
+copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
 int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 		   struct mmu_notifier_range *range,
 		   pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp);
diff --git a/kernel/fork.c b/kernel/fork.c
index da8d360fb032..a7671f5cb3e1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -589,7 +589,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
-			retval = copy_page_range(mm, oldmm, mpnt, tmp);
+			retval = copy_page_range(tmp, mpnt);
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
diff --git a/mm/memory.c b/mm/memory.c
index fcfc4ca36eba..8ade87e8600a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -794,15 +794,15 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
  * lock.
  */
 static inline int
-copy_present_page(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		pte_t *dst_pte, pte_t *src_pte,
-		struct vm_area_struct *vma, struct vm_area_struct *new,
-		unsigned long addr, int *rss, struct page **prealloc,
-		pte_t pte, struct page *page)
+copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+		  pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
+		  struct page **prealloc, pte_t pte, struct page *page)
 {
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	struct mm_struct *src_mm = src_vma->vm_mm;
 	struct page *new_page;
 
-	if (!is_cow_mapping(vma->vm_flags))
+	if (!is_cow_mapping(src_vma->vm_flags))
 		return 1;
 
 	/*
@@ -865,15 +865,15 @@ copy_present_page(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 * over and copy the page & arm it.
 	 */
 	*prealloc = NULL;
-	copy_user_highpage(new_page, page, addr, vma);
+	copy_user_highpage(new_page, page, addr, src_vma);
 	__SetPageUptodate(new_page);
-	page_add_new_anon_rmap(new_page, new, addr, false);
-	lru_cache_add_inactive_or_unevictable(new_page, new);
+	page_add_new_anon_rmap(new_page, dst_vma, addr, false);
+	lru_cache_add_inactive_or_unevictable(new_page, dst_vma);
 	rss[mm_counter(new_page)]++;
 
 	/* All done, just insert the new page copy in the child */
-	pte = mk_pte(new_page, new->vm_page_prot);
-	pte = maybe_mkwrite(pte_mkdirty(pte), new);
+	pte = mk_pte(new_page, dst_vma->vm_page_prot);
+	pte = maybe_mkwrite(pte_mkdirty(pte), dst_vma);
 	set_pte_at(dst_mm, addr, dst_pte, pte);
 	return 0;
 }
@@ -883,24 +883,22 @@ copy_present_page(struct mm_struct *dst_mm, struct mm_struct *src_mm,
  * is required to copy this pte.
  */
 static inline int
-copy_present_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
-		struct vm_area_struct *new,
-		unsigned long addr, int *rss, struct page **prealloc)
+copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
+		 struct page **prealloc)
 {
-	unsigned long vm_flags = vma->vm_flags;
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	struct mm_struct *src_mm = src_vma->vm_mm;
+	unsigned long vm_flags = src_vma->vm_flags;
 	pte_t pte = *src_pte;
 	struct page *page;
 
-	page = vm_normal_page(vma, addr, pte);
+	page = vm_normal_page(src_vma, addr, pte);
 	if (page) {
 		int retval;
 
-		retval = copy_present_page(dst_mm, src_mm,
-			dst_pte, src_pte,
-			vma, new,
-			addr, rss, prealloc,
-			pte, page);
+		retval = copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
+					   addr, rss, prealloc, pte, page);
 		if (retval <= 0)
 			return retval;
 
@@ -957,11 +955,13 @@ page_copy_prealloc(struct mm_struct *src_mm, struct vm_area_struct *vma,
 	return new_page;
 }
 
-static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		   pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
-		   struct vm_area_struct *new,
-		   unsigned long addr, unsigned long end)
+static int
+copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+	       pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
+	       unsigned long end)
 {
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	struct mm_struct *src_mm = src_vma->vm_mm;
 	pte_t *orig_src_pte, *orig_dst_pte;
 	pte_t *src_pte, *dst_pte;
 	spinlock_t *src_ptl, *dst_ptl;
@@ -1004,15 +1004,15 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		if (unlikely(!pte_present(*src_pte))) {
 			entry.val = copy_nonpresent_pte(dst_mm, src_mm,
 							dst_pte, src_pte,
-							vma, addr, rss);
+							src_vma, addr, rss);
 			if (entry.val)
 				break;
 			progress += 8;
 			continue;
 		}
 		/* copy_present_pte() will clear `*prealloc' if consumed */
-		ret = copy_present_pte(dst_mm, src_mm, dst_pte, src_pte,
-				       vma, new, addr, rss, &prealloc);
+		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
+				       addr, rss, &prealloc);
 		/*
 		 * If we need a pre-allocated page for this pte, drop the
 		 * locks, allocate, and try again.
@@ -1047,7 +1047,7 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		entry.val = 0;
 	} else if (ret) {
 		WARN_ON_ONCE(ret != -EAGAIN);
-		prealloc = page_copy_prealloc(src_mm, vma, addr);
+		prealloc = page_copy_prealloc(src_mm, src_vma, addr);
 		if (!prealloc)
 			return -ENOMEM;
 		/* We've captured and resolved the error. Reset, try again. */
@@ -1061,11 +1061,13 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	return ret;
 }
 
-static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		pud_t *dst_pud, pud_t *src_pud, struct vm_area_struct *vma,
-		struct vm_area_struct *new,
-		unsigned long addr, unsigned long end)
+static inline int
+copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+	       pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
+	       unsigned long end)
 {
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	struct mm_struct *src_mm = src_vma->vm_mm;
 	pmd_t *src_pmd, *dst_pmd;
 	unsigned long next;
 
@@ -1078,9 +1080,9 @@ static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src
 		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)
 			|| pmd_devmap(*src_pmd)) {
 			int err;
-			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, vma);
+			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm,
-					    dst_pmd, src_pmd, addr, vma);
+					    dst_pmd, src_pmd, addr, src_vma);
 			if (err == -ENOMEM)
 				return -ENOMEM;
 			if (!err)
@@ -1089,18 +1091,20 @@ static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src
 		}
 		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
-		if (copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
-				   vma, new, addr, next))
+		if (copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd,
+				   addr, next))
 			return -ENOMEM;
 	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
 	return 0;
 }
 
-static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		p4d_t *dst_p4d, p4d_t *src_p4d, struct vm_area_struct *vma,
-		struct vm_area_struct *new,
-		unsigned long addr, unsigned long end)
+static inline int
+copy_pud_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+	       p4d_t *dst_p4d, p4d_t *src_p4d, unsigned long addr,
+	       unsigned long end)
 {
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	struct mm_struct *src_mm = src_vma->vm_mm;
 	pud_t *src_pud, *dst_pud;
 	unsigned long next;
 
@@ -1113,9 +1117,9 @@ static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src
 		if (pud_trans_huge(*src_pud) || pud_devmap(*src_pud)) {
 			int err;
 
-			VM_BUG_ON_VMA(next-addr != HPAGE_PUD_SIZE, vma);
+			VM_BUG_ON_VMA(next-addr != HPAGE_PUD_SIZE, src_vma);
 			err = copy_huge_pud(dst_mm, src_mm,
-					    dst_pud, src_pud, addr, vma);
+					    dst_pud, src_pud, addr, src_vma);
 			if (err == -ENOMEM)
 				return -ENOMEM;
 			if (!err)
@@ -1124,18 +1128,19 @@ static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src
 		}
 		if (pud_none_or_clear_bad(src_pud))
 			continue;
-		if (copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
-				   vma, new, addr, next))
+		if (copy_pmd_range(dst_vma, src_vma, dst_pud, src_pud,
+				   addr, next))
 			return -ENOMEM;
 	} while (dst_pud++, src_pud++, addr = next, addr != end);
 	return 0;
 }
 
-static inline int copy_p4d_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		pgd_t *dst_pgd, pgd_t *src_pgd, struct vm_area_struct *vma,
-		struct vm_area_struct *new,
-		unsigned long addr, unsigned long end)
+static inline int
+copy_p4d_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+	       pgd_t *dst_pgd, pgd_t *src_pgd, unsigned long addr,
+	       unsigned long end)
 {
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	p4d_t *src_p4d, *dst_p4d;
 	unsigned long next;
 
@@ -1147,20 +1152,22 @@ static inline int copy_p4d_range(struct mm_struct *dst_mm, struct mm_struct *src
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(src_p4d))
 			continue;
-		if (copy_pud_range(dst_mm, src_mm, dst_p4d, src_p4d,
-				   vma, new, addr, next))
+		if (copy_pud_range(dst_vma, src_vma, dst_p4d, src_p4d,
+				   addr, next))
 			return -ENOMEM;
 	} while (dst_p4d++, src_p4d++, addr = next, addr != end);
 	return 0;
 }
 
-int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		    struct vm_area_struct *vma, struct vm_area_struct *new)
+int
+copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
 	pgd_t *src_pgd, *dst_pgd;
 	unsigned long next;
-	unsigned long addr = vma->vm_start;
-	unsigned long end = vma->vm_end;
+	unsigned long addr = src_vma->vm_start;
+	unsigned long end = src_vma->vm_end;
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	struct mm_struct *src_mm = src_vma->vm_mm;
 	struct mmu_notifier_range range;
 	bool is_cow;
 	int ret;
@@ -1171,19 +1178,19 @@ int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 * readonly mappings. The tradeoff is that copy_page_range is more
 	 * efficient than faulting.
 	 */
-	if (!(vma->vm_flags & (VM_HUGETLB | VM_PFNMAP | VM_MIXEDMAP)) &&
-			!vma->anon_vma)
+	if (!(src_vma->vm_flags & (VM_HUGETLB | VM_PFNMAP | VM_MIXEDMAP)) &&
+	    !src_vma->anon_vma)
 		return 0;
 
-	if (is_vm_hugetlb_page(vma))
-		return copy_hugetlb_page_range(dst_mm, src_mm, vma);
+	if (is_vm_hugetlb_page(src_vma))
+		return copy_hugetlb_page_range(dst_mm, src_mm, src_vma);
 
-	if (unlikely(vma->vm_flags & VM_PFNMAP)) {
+	if (unlikely(src_vma->vm_flags & VM_PFNMAP)) {
 		/*
 		 * We do not free on error cases below as remove_vma
 		 * gets called on error from higher level routine
 		 */
-		ret = track_pfn_copy(vma);
+		ret = track_pfn_copy(src_vma);
 		if (ret)
 			return ret;
 	}
@@ -1194,11 +1201,11 @@ int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 * parent mm. And a permission downgrade will only happen if
 	 * is_cow_mapping() returns true.
 	 */
-	is_cow = is_cow_mapping(vma->vm_flags);
+	is_cow = is_cow_mapping(src_vma->vm_flags);
 
 	if (is_cow) {
 		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
-					0, vma, src_mm, addr, end);
+					0, src_vma, src_mm, addr, end);
 		mmu_notifier_invalidate_range_start(&range);
 	}
 
@@ -1209,8 +1216,8 @@ int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(src_pgd))
 			continue;
-		if (unlikely(copy_p4d_range(dst_mm, src_mm, dst_pgd, src_pgd,
-					    vma, new, addr, next))) {
+		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
+					    addr, next))) {
 			ret = -ENOMEM;
 			break;
 		}
-- 
2.26.2

